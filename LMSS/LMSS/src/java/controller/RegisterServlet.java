package controller;

import dao.UsersDAO;
import utils.BCryptUtil;
import utils.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigInteger;
import java.security.SecureRandom;
import java.sql.Connection;


public class RegisterServlet extends HttpServlet {

    private UsersDAO userDAO;

    @Override
    public void init() throws ServletException {
        // Lấy kết nối từ context
        Connection conn = (Connection) getServletContext().getAttribute("DBConnection");
        userDAO = new UsersDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Chuyển hướng về trang đăng ký
        req.getRequestDispatcher("register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy dữ liệu từ form
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        String role = req.getParameter("role");
        String email = req.getParameter("email");
        String avatarUrl = req.getParameter("avatarUrl");

        // Kiểm tra dữ liệu đầu vào
        if (isEmpty(username) || isEmpty(password) || isEmpty(confirmPassword) || isEmpty(role) || isEmpty(email)) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ thông tin, bao gồm email");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }

        if (!isValidEmail(email)) {
            req.setAttribute("error", "Email không hợp lệ");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }

        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }

        try {
            // Kiểm tra tài khoản hoặc email đã tồn tại
            if (userDAO.getUserByUsername(username) != null) {
                req.setAttribute("error", "Tên đăng nhập đã tồn tại");
                req.getRequestDispatcher("register.jsp").forward(req, resp);
                return;
            }

            if (userDAO.isEmailExists(email)) {
                req.setAttribute("error", "Email đã được sử dụng");
                req.getRequestDispatcher("register.jsp").forward(req, resp);
                return;
            }

            // Mã hóa mật khẩu
            String hashedPassword = BCryptUtil.hashPassword(password);

            // Gán avatar mặc định nếu rỗng
            if (isEmpty(avatarUrl)) {
                avatarUrl = "default-avatar.png";
            }

            // Tạo mã xác minh
            String token = generateToken();

            // Lưu thông tin người dùng
            boolean created = userDAO.registerUserWithToken(username, hashedPassword, role, email, avatarUrl, token);

            if (created) {
                // Gửi email xác nhận
                String baseURL = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + req.getContextPath();
                String verifyLink = baseURL + "/verify?token=" + token;

                EmailUtil.sendVerificationEmail(email, username, verifyLink);

                req.setAttribute("message", "Đăng ký thành công! Vui lòng kiểm tra email để xác nhận tài khoản.");
                req.getRequestDispatcher("register.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Đăng ký thất bại, vui lòng thử lại");
                req.getRequestDispatcher("register.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            req.getRequestDispatcher("register.jsp").forward(req, resp);
        }
    }

    private boolean isEmpty(String s) {
        return s == null || s.trim().isEmpty();
    }

    private boolean isValidEmail(String email) {
        // Regex kiểm tra định dạng email
        String emailRegex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
        return email.matches(emailRegex);
    }

    private String generateToken() {
        SecureRandom random = new SecureRandom();
        return new BigInteger(130, random).toString(32); // Tạo token ngẫu nhiên 130-bit
    }
}
