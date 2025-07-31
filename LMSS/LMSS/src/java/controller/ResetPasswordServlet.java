package controller;

import dao.UsersDAO;
import model.User;
import utils.BCryptUtil;
import utils.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

public class ResetPasswordServlet extends HttpServlet {
    private UsersDAO usersDAO;

    @Override
    public void init() throws ServletException {
        usersDAO = new UsersDAO(DBConnection.getConnection());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String token = req.getParameter("token");
        if (token == null || token.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/forgot-password.jsp?error=Token không hợp lệ");
            return;
        }

        try {
            User user = usersDAO.getUserByResetToken(token);
            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/forgot-password.jsp?error=Token đã hết hạn hoặc không hợp lệ");
                return;
            }
            req.setAttribute("token", token);
            req.getRequestDispatcher("/reset-password.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/forgot-password.jsp?error=Lỗi hệ thống");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String token = req.getParameter("token");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        if (token == null || token.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/forgot-password.jsp?error=Token không hợp lệ");
            return;
        }

        if (password == null || confirmPassword == null || !password.equals(confirmPassword)) {
            req.setAttribute("token", token);
            req.setAttribute("error", "Mật khẩu và xác nhận mật khẩu không khớp");
            req.getRequestDispatcher("/reset-password.jsp").forward(req, resp);
            return;
        }

        if (password.length() < 6) {
            req.setAttribute("token", token);
            req.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự");
            req.getRequestDispatcher("/reset-password.jsp").forward(req, resp);
            return;
        }

        try {
            User user = usersDAO.getUserByResetToken(token);
            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/forgot-password.jsp?error=Token đã hết hạn hoặc không hợp lệ");
                return;
            }

            String hashedPassword = BCryptUtil.hashPassword(password);

            boolean updated = usersDAO.updatePassword(user.getUserId(), hashedPassword);
            if (!updated) {
                req.setAttribute("token", token);
                req.setAttribute("error", "Cập nhật mật khẩu thất bại");
                req.getRequestDispatcher("/reset-password.jsp").forward(req, resp);
                return;
            }

            usersDAO.markTokenAsUsed(token);

            resp.sendRedirect(req.getContextPath() + "/login.jsp?success=Đặt lại mật khẩu thành công, vui lòng đăng nhập lại");
        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("token", token);
            req.setAttribute("error", "Lỗi hệ thống");
            req.getRequestDispatcher("/reset-password.jsp").forward(req, resp);
        }
    }
}
