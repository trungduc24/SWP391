package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Course;
import model.Student;
import utils.DBConnection;

public class EnrollmentDAO {

    public EnrollmentDAO() {
    }

    // Đăng ký sinh viên vào khóa học
    public boolean enrollStudent(int studentId, int courseId) throws SQLException {
        String INSERT_ENROLLMENT_SQL = "INSERT INTO enrollments (student_id, course_id, enrollment_date, status) VALUES (?, ?, GETDATE(), 'active')";

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(INSERT_ENROLLMENT_SQL)) {

            preparedStatement.setInt(1, studentId);
            preparedStatement.setInt(2, courseId);

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Hủy đăng ký sinh viên khỏi khóa học
    public boolean unenrollStudent(int studentId, int courseId) throws SQLException {
        String DELETE_ENROLLMENT_SQL = "DELETE FROM enrollments WHERE student_id = ? AND course_id = ?";

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(DELETE_ENROLLMENT_SQL)) {

            preparedStatement.setInt(1, studentId);
            preparedStatement.setInt(2, courseId);

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Kiểm tra sinh viên đã đăng ký khóa học chưa
    public boolean isStudentEnrolled(int studentId, int courseId) throws SQLException {
        String CHECK_ENROLLMENT_SQL = "SELECT COUNT(*) FROM enrollments WHERE student_id = ? AND course_id = ? AND status = 'active'";

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(CHECK_ENROLLMENT_SQL)) {

            preparedStatement.setInt(1, studentId);
            preparedStatement.setInt(2, courseId);

            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    // Lấy danh sách sinh viên đã đăng ký khóa học
    public List<Student> getStudentsByCourseId(int courseId) throws SQLException {
        List<Student> students = new ArrayList<>();
        String SELECT_STUDENTS_SQL = "SELECT s.student_id, s.student_code, s.class_name, u.user_id, u.username, u.email, u.full_name, u.avatar_url "
                +
                "FROM enrollments e " +
                "INNER JOIN students s ON e.student_id = s.student_id " +
                "INNER JOIN users u ON s.user_id = u.user_id " +
                "WHERE e.course_id = ? AND e.status = 'active' " +
                "ORDER BY u.full_name";

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SELECT_STUDENTS_SQL)) {

            preparedStatement.setInt(1, courseId);

            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Student student = new Student();
                    student.setStudentId(rs.getInt("student_id"));
                    student.setStudentCode(rs.getString("student_code"));
                    student.setUserId(rs.getInt("user_id"));

                    // Set user information directly to student
                    student.setFullName(rs.getString("full_name"));
                    student.setEmail(rs.getString("email"));
                    student.setAvatarUrl(rs.getString("avatar_url"));

                    students.add(student);
                }
            }
        }
        return students;
    }

    // Lấy danh sách khóa học mà sinh viên đã đăng ký
    public List<Course> getCoursesByStudentId(int studentId) throws SQLException {
        List<Course> courses = new ArrayList<>();
        String SELECT_COURSES_SQL = "SELECT c.course_id, c.name, c.code, c.description, c.room, c.lecturer_id, c.semester_id, "
                +
                "c.total_sessions, c.credits, c.max_students, c.schedule, c.is_active " +
                "FROM enrollments e " +
                "INNER JOIN courses c ON e.course_id = c.course_id " +
                "WHERE e.student_id = ? AND e.status = 'active' " +
                "ORDER BY c.name";

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SELECT_COURSES_SQL)) {

            preparedStatement.setInt(1, studentId);

            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Course course = new Course();
                    course.setCourseId(rs.getInt("course_id"));
                    course.setName(rs.getString("name"));
                    course.setCode(rs.getString("code"));
                    course.setDescription(rs.getString("description"));
                    course.setRoom(rs.getString("room"));
                    course.setLecturerId(rs.getInt("lecturer_id"));
                    course.setSemesterId(rs.getInt("semester_id"));
                    course.setTotalSessions(rs.getInt("total_sessions"));
                    course.setCredits(rs.getInt("credits"));
                    course.setMaxStudents(rs.getInt("max_students"));
                    course.setSchedule(rs.getString("schedule"));
                    course.setActive(rs.getBoolean("is_active"));

                    courses.add(course);
                }
            }
        }
        return courses;
    }

    // Lấy số lượng sinh viên đã đăng ký khóa học
    public int getEnrollmentCount(int courseId) throws SQLException {
        String COUNT_ENROLLMENTS_SQL = "SELECT COUNT(*) FROM enrollments WHERE course_id = ? AND status = 'active'";

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(COUNT_ENROLLMENTS_SQL)) {

            preparedStatement.setInt(1, courseId);

            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    // Lấy danh sách tất cả enrollments
    public List<Object[]> getAllEnrollments() throws SQLException {
        List<Object[]> enrollments = new ArrayList<>();
        String SELECT_ALL_ENROLLMENTS_SQL = "SELECT e.enrollment_id, e.student_id, e.course_id, e.enrollment_date, e.status, "
                +
                "s.student_code, u.full_name as student_name, c.name as course_name, c.code as course_code " +
                "FROM enrollments e " +
                "INNER JOIN students s ON e.student_id = s.student_id " +
                "INNER JOIN users u ON s.user_id = u.user_id " +
                "INNER JOIN courses c ON e.course_id = c.course_id " +
                "ORDER BY e.enrollment_date DESC";

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_ENROLLMENTS_SQL)) {

            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Object[] enrollment = new Object[9];
                    enrollment[0] = rs.getInt("enrollment_id");
                    enrollment[1] = rs.getInt("student_id");
                    enrollment[2] = rs.getInt("course_id");
                    enrollment[3] = rs.getTimestamp("enrollment_date");
                    enrollment[4] = rs.getString("status");
                    enrollment[5] = rs.getString("student_code");
                    enrollment[6] = rs.getString("student_name");
                    enrollment[7] = rs.getString("course_name");
                    enrollment[8] = rs.getString("course_code");

                    enrollments.add(enrollment);
                }
            }
        }
        return enrollments;
    }

    // Cập nhật trạng thái enrollment
    public boolean updateEnrollmentStatus(int enrollmentId, String status) throws SQLException {
        String UPDATE_STATUS_SQL = "UPDATE enrollments SET status = ? WHERE enrollment_id = ?";

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_STATUS_SQL)) {

            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, enrollmentId);

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Xóa enrollment
    public boolean deleteEnrollment(int enrollmentId) throws SQLException {
        String DELETE_ENROLLMENT_SQL = "DELETE FROM enrollments WHERE enrollment_id = ?";

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(DELETE_ENROLLMENT_SQL)) {

            preparedStatement.setInt(1, enrollmentId);

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }
}
