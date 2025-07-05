package controller;

import dao.CourseDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import model.Course;

@WebServlet("/CourseServlet") // This mapping makes the servlet accessible at /YourWebApp/CourseServlet
public class CourseServlet extends HttpServlet {
    private CourseDAO courseDAO;

    public void init() {
        courseDAO = new CourseDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "listCourses"; // Default action
        }

        try {
            switch (action) {
                case "listCourses":
                    listCourses(request, response);
                    break;
                case "showAddForm":
                    showAddForm(request, response);
                    break;
                case "showEditForm":
                    showEditForm(request, response);
                    break;
                case "deleteCourse":
                    deleteCourse(request, response);
                    break;
                default:
                    listCourses(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException("Database error in CourseServlet doGet: " + ex.getMessage(), ex);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // Ensure proper character encoding for incoming data

        String action = request.getParameter("action");
        if (action == null) {
            action = "listCourses";
        }

        try {
            switch (action) {
                case "addCourse":
                    addCourse(request, response);
                    break;
                case "updateCourse":
                    updateCourse(request, response);
                    break;
                default:
                    listCourses(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException("Database error in CourseServlet doPost: " + ex.getMessage(), ex);
        }
    }

    private void listCourses(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        List<Course> listCourses = courseDAO.getAllCourses();
        request.setAttribute("listCourses", listCourses);
        // Forward to a dedicated courses.jsp page
        request.getRequestDispatcher("courses.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // No specific data needed for an empty add form, just forward to the JSP
        request.getRequestDispatcher("courses.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int courseId = Integer.parseInt(request.getParameter("id"));
        Course existingCourse = courseDAO.getCourseById(courseId);
        request.setAttribute("course", existingCourse);
        request.getRequestDispatcher("courses.jsp").forward(request, response); // Reuse courses.jsp for edit
    }

    private void addCourse(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String name = request.getParameter("name");
        String code = request.getParameter("code");

        Course newCourse = new Course();
        newCourse.setName(name);
        newCourse.setCode(code);
        // Add other fields if your Course POJO has them and they are sent from the form

        courseDAO.addCourse(newCourse);
        response.sendRedirect(request.getContextPath() + "/CourseServlet?action=listCourses");
    }

    private void updateCourse(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int courseId = Integer.parseInt(request.getParameter("course_id"));
        String name = request.getParameter("name");
        String code = request.getParameter("code");

        Course courseToUpdate = new Course(courseId, name, code);
        // Set other fields if they are part of the update form

        courseDAO.updateCourse(courseToUpdate);
        response.sendRedirect(request.getContextPath() + "/CourseServlet?action=listCourses");
    }

    private void deleteCourse(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int courseId = Integer.parseInt(request.getParameter("id"));
        courseDAO.deleteCourse(courseId);
        response.sendRedirect(request.getContextPath() + "/CourseServlet?action=listCourses");
    }
}