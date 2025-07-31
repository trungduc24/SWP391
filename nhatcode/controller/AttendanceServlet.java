/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AttendanceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Attendance;

/**
 *
 * @author Admin
 */
@WebServlet("/lecture/attendance")
public class AttendanceServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int courseId = Integer.parseInt(req.getParameter("courseId"));
            AttendanceDAO dao = new AttendanceDAO();
            List<Attendance> list = dao.getAttendanceByCourse(courseId);
            req.setAttribute("attendanceList", list);
            req.getRequestDispatcher("/views/lecture/attendance.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}