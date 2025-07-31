/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.MaterialDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Material;

/**
 *
 * @author Admin
 */
@WebServlet("/lecture/materials")
public class MaterialServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int courseId = Integer.parseInt(req.getParameter("courseId"));
            MaterialDAO dao = new MaterialDAO();
            List<Material> list = dao.getMaterialsByCourse(courseId);
            req.setAttribute("materials", list);
            req.getRequestDispatcher("/views/lecture/materials.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}