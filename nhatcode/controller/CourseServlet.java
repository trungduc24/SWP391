/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CourseDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Course;

@WebServlet("/lecture/courses")
public class CourseServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int lecturerId = ((model.User) req.getSession().getAttribute("user")).getId();
            CourseDAO dao = new CourseDAO();
            List<Course> courses = dao.getCoursesByLecturer(lecturerId);
            req.setAttribute("courses", courses);
            req.getRequestDispatcher("/views/lecture/courses.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}