package controller;

import dao.UsersDAO;
import model.User;
import utils.BCryptUtil;
import utils.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

public class LoginServlet extends HttpServlet {
    private UsersDAO userDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = DBConnection.getConnection();
        userDAO = new UsersDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String LOGIN_PAGE = "/login.jsp";

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String roleInput = req.getParameter("role");

        try {
            User user = userDAO.getUserByUsername(username);

            if (user == null) {
                req.setAttribute("error", "Tên đăng nhập không tồn tại.");
                req.getRequestDispatcher(LOGIN_PAGE).forward(req, resp);
                return;
            }

            String userRole = user.getRole() != null ? user.getRole().trim().toLowerCase() : "";
            boolean passwordMatches = BCryptUtil.checkPassword(password, user.getPassword());
            boolean roleMatches = roleInput != null && roleInput.trim().equalsIgnoreCase(userRole);

            System.out.println("[LOGIN] Username: " + username + " | Role input: " + roleInput + " | Actual role: " + userRole);

            if (!passwordMatches) {
                req.setAttribute("error", "Mật khẩu không đúng.");
                req.getRequestDispatcher(LOGIN_PAGE).forward(req, resp);
                return;
            }

            if (!roleMatches) {
                req.setAttribute("error", "Vai trò không đúng.");
                req.getRequestDispatcher(LOGIN_PAGE).forward(req, resp);
                return;
            }

            if (!user.isEmailVerified()) {
                req.setAttribute("error", "Email chưa được xác thực. Vui lòng kiểm tra hộp thư.");
                req.getRequestDispatcher(LOGIN_PAGE).forward(req, resp);
                return;
            }

            // Đăng nhập thành công
            HttpSession session = req.getSession();
            session.setAttribute("user", user);

            System.out.println("[LOGIN SUCCESS] User: " + username + " | Role: " + userRole);

            switch (userRole) {
                case "student":
                    resp.sendRedirect(req.getContextPath() + "/student/dashboard.html");
                    break;
                case "lecturer":
                    resp.sendRedirect(req.getContextPath() + "/lecturer/dashboard.html");
                    break;
                case "admin":
                    resp.sendRedirect(req.getContextPath() + "/admin/dashboard.html");
                    break;
                default:
                    req.setAttribute("error", "Vai trò không hợp lệ.");
                    req.getRequestDispatcher(LOGIN_PAGE).forward(req, resp);
                    break;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi cơ sở dữ liệu.");
            req.getRequestDispatcher(LOGIN_PAGE).forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi hệ thống.");
            req.getRequestDispatcher(LOGIN_PAGE).forward(req, resp);
        }
    }
}
