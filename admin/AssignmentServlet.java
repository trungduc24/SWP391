package controller;

import dao.AssignmentDAO;
import dao.CourseDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import model.Assignment;
import model.Course;

@WebServlet("/AssignmentServlet") // Map servlet này tới URL "/AssignmentServlet"
public class AssignmentServlet extends HttpServlet {
    private AssignmentDAO assignmentDAO;
    private CourseDAO courseDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        assignmentDAO = new AssignmentDAO();
        courseDAO = new CourseDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) { // Mặc định là hiển thị danh sách bài tập
            List<Assignment> assignments = assignmentDAO.getAllAssignments();
            List<Course> courses = courseDAO.getAllCourses(); // Lấy danh sách khóa học cho dropdown
            
            request.setAttribute("assignments", assignments);
            request.setAttribute("courses", courses); // Đặt courses vào request scope
            
            request.getRequestDispatcher("/assignments.jsp").forward(request, response);
        } 
        // Sau này có thể thêm các action khác như "edit", "delete", "view"
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // Đảm bảo nhận tiếng Việt
        String action = request.getParameter("action");

        if ("createAssignment".equals(action)) {
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            int courseId = Integer.parseInt(request.getParameter("course_id"));
            String dueDateStr = request.getParameter("due_date"); // Format: yyyy-MM-ddTHH:mm
            String type = request.getParameter("type");

            LocalDateTime dueDate = null;
            if (dueDateStr != null && !dueDateStr.isEmpty()) {
                // Định dạng input type="datetime-local" là "yyyy-MM-ddTHH:mm"
                dueDate = LocalDateTime.parse(dueDateStr, DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"));
            }

            Assignment newAssignment = new Assignment();
            newAssignment.setTitle(title);
            newAssignment.setDescription(description);
            newAssignment.setCourseId(courseId);
            newAssignment.setDueDate(dueDate);
            newAssignment.setType(type);

            boolean success = assignmentDAO.createAssignment(newAssignment);

            if (success) {
                request.getSession().setAttribute("message", "Assignment created successfully!");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Failed to create assignment.");
                request.getSession().setAttribute("messageType", "error");
            }
            
            // Chuyển hướng về trang assignments.jsp để hiển thị danh sách cập nhật
            // Sử dụng response.sendRedirect để tránh gửi lại form khi refresh
            response.sendRedirect(request.getContextPath() + "/AssignmentServlet"); 
        }
    }
}