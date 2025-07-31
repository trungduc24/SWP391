/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AssignmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Assignment;
import model.User;


import java.io.IOException;
import java.util.List;

@WebServlet("/lecture/assignments")
public class AssignmentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            User lecturer = (User) req.getSession().getAttribute("user");
            int courseId = Integer.parseInt(req.getParameter("courseId")); // passed via URL or dropdown
            AssignmentDAO dao = new AssignmentDAO();
            List<Assignment> list = dao.getAssignmentsByCourse(courseId);
            req.setAttribute("assignments", list);
            req.getRequestDispatcher("/views/lecture/assignments.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
