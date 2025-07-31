/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.SemesterDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Semester;


import java.io.IOException;
import java.sql.*;
import utils.DBConnection;

public class SemesterServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String start = request.getParameter("start");
        String end = request.getParameter("end");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO semesters (name, start_date, end_date) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, start);
            stmt.setString(3, end);
            stmt.executeUpdate();

            // Sau khi tạo xong → chuyển về lại trang danh sách
            response.sendRedirect("semesters.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tạo học kỳ: " + e.getMessage());
            request.getRequestDispatcher("semesters.jsp").forward(request, response);
        }
    }
}
