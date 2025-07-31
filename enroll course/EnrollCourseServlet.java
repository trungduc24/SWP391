package controller;

import dao.CourseDAO;
import dao.StudentDAO;
import model.User;
import model.Student;
import utils.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.util.logging.Logger;
import java.util.logging.Level;

public class EnrollCourseServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(EnrollCourseServlet.class.getName());
    private CourseDAO courseDAO;
    private StudentDAO studentDAO;

    @Override
    public void init() throws ServletException {
        try {
            courseDAO = new CourseDAO();
            studentDAO = new StudentDAO();
            logger.info("EnrollCourseServlet initialized successfully");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Failed to initialize EnrollCourseServlet", e);
            throw new ServletException("Failed to initialize EnrollCourseServlet", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra quyền sinh viên
        User currentUser = (User) req.getAttribute("currentUser");
        if (currentUser == null || !"student".equals(currentUser.getRole())) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Chỉ sinh viên mới có quyền đăng ký khóa học!");
            return;
        }

        String courseIdStr = req.getParameter("courseId");

        if (courseIdStr == null || courseIdStr.trim().isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID khóa học không hợp lệ!");
            return;
        }

        try {
            int courseId = Integer.parseInt(courseIdStr);

            // Lấy thông tin sinh viên
            Student student = getStudentByUserId(currentUser.getUserId());
            if (student == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy thông tin sinh viên!");
                return;
            }

            // Sử dụng stored procedure để đăng ký khóa học
            EnrollmentResult result = enrollCourseWithStoredProcedure(student.getStudentId(), courseId);

            // Trả về JSON response
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");

            if ("SUCCESS".equals(result.status)) {
                // Log hoạt động đăng ký
                logEnrollment(currentUser.getUserId(), courseId, "SUCCESS",
                        getClientIP(req), req.getHeader("User-Agent"));

                logger.info("Student enrolled successfully: " + currentUser.getUsername() +
                        " - Course ID: " + courseId);

                resp.getWriter().write("{\"success\": true, \"message\": \"" + result.message + "\"}");
            } else {
                // Log hoạt động đăng ký thất bại
                logEnrollment(currentUser.getUserId(), courseId, "FAILED",
                        getClientIP(req), req.getHeader("User-Agent"));

                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("{\"success\": false, \"message\": \"" + result.message + "\"}");
            }

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID khóa học không hợp lệ!");
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error while enrolling course", e);
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write("{\"success\": false, \"message\": \"Lỗi cơ sở dữ liệu: " + e.getMessage() + "\"}");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "System error while enrolling course", e);
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write("{\"success\": false, \"message\": \"Lỗi hệ thống: " + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Chuyển hướng GET requests thành POST để bảo mật
        resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Phương thức GET không được hỗ trợ!");
    }

    /**
     * Lấy thông tin sinh viên theo user ID
     */
    private Student getStudentByUserId(int userId) throws SQLException {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM students WHERE user_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, userId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        return new Student(
                                rs.getInt("student_id"),
                                rs.getInt("user_id"),
                                rs.getString("full_name"),
                                rs.getString("student_code"),
                                rs.getString("email"),
                                rs.getString("avatar_url"));
                    }
                }
            }
        }
        return null;
    }

    /**
     * Đăng ký khóa học bằng stored procedure
     */
    private EnrollmentResult enrollCourseWithStoredProcedure(int studentId, int courseId) throws SQLException {
        String sql = "{CALL EnrollCourse(?, ?)}";
        try (Connection conn = DBConnection.getConnection();
                CallableStatement stmt = conn.prepareCall(sql)) {

            stmt.setInt(1, studentId);
            stmt.setInt(2, courseId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new EnrollmentResult(
                            rs.getString("status"),
                            rs.getString("message"));
                }
            }
        }
        return new EnrollmentResult("ERROR", "Không thể thực hiện đăng ký");
    }

    /**
     * Ghi log đăng ký khóa học
     */
    private void logEnrollment(int userId, int courseId, String status, String ip, String userAgent) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO system_logs (user_id, action, table_name, record_id, new_values, ip_address, user_agent) VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, userId);
                stmt.setString(2, "ENROLL_COURSE_" + status);
                stmt.setString(3, "enrollments");
                stmt.setInt(4, courseId);
                stmt.setString(5, "Course enrollment attempt - Status: " + status);
                stmt.setString(6, ip);
                stmt.setString(7, userAgent);
                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            logger.log(Level.WARNING, "Failed to log enrollment", e);
        }
    }

    /**
     * Lấy IP của client
     */
    private String getClientIP(HttpServletRequest request) {
        String xForwardedFor = request.getHeader("X-Forwarded-For");
        if (xForwardedFor != null && !xForwardedFor.isEmpty()) {
            return xForwardedFor.split(",")[0].trim();
        }

        String xRealIP = request.getHeader("X-Real-IP");
        if (xRealIP != null && !xRealIP.isEmpty()) {
            return xRealIP;
        }

        return request.getRemoteAddr();
    }

    /**
     * Class để lưu kết quả đăng ký
     */
    private static class EnrollmentResult {
        public final String status;
        public final String message;

        public EnrollmentResult(String status, String message) {
            this.status = status;
            this.message = message;
        }
    }
}
