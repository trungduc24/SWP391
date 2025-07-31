package controller;

import dao.UsersDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

public class VerifyEmailServlet extends HttpServlet {
    private UsersDAO userDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("DBConnection");
        userDAO = new UsersDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String token = req.getParameter("token");
        if (token == null || token.isEmpty()) {
            req.setAttribute("error", "Token xác nhận không hợp lệ.");
            req.getRequestDispatcher("verify-result.jsp").forward(req, resp);
            return;
        }

        try {
            boolean verified = userDAO.verifyEmail(token);
            if (verified) {
                req.setAttribute("message", "Xác nhận email thành công! Bạn có thể đăng nhập.");
            } else {
                req.setAttribute("error", "Token xác nhận không tồn tại hoặc đã hết hạn.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        }

        req.getRequestDispatcher("verify-result.jsp").forward(req, resp);
    }
}
