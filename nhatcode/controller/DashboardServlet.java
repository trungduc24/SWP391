/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CourseDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Course;
import model.User;

/**
 *
 * @author Admin
 */
@WebServlet("/lecture/dashboard")
public class DashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            User lecturer = (User) req.getSession().getAttribute("user");
            CourseDAO dao = new CourseDAO();
            List<Course> list = dao.getCoursesByLecturer(lecturer.getId());
            req.setAttribute("courses", list);
            req.getRequestDispatcher("/views/lecture/dashboard.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}