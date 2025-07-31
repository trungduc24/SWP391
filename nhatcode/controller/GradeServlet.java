/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.GradeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet("/lecture/grade")
public class GradeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        try {
            int assignmentId = Integer.parseInt(req.getParameter("assignmentId"));
            int studentId = Integer.parseInt(req.getParameter("studentId"));
            double score = Double.parseDouble(req.getParameter("score"));
            String comment = req.getParameter("comment");

            GradeDAO dao = new GradeDAO();
            dao.addGrade(assignmentId, studentId, score, comment);
            resp.sendRedirect("grading.jsp");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}