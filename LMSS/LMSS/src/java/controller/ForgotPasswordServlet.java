package controller;

import dao.UsersDAO;
import utils.DBConnection;
import utils.EmailUtil;
import utils.TokenUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

public class ForgotPasswordServlet extends HttpServlet {
    private UsersDAO usersDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        usersDAO = new UsersDAO(DBConnection.getConnection());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");

        try {
            // Kiểm tra email có tồn tại không
            if (!usersDAO.isEmailExists(email)) {
                resp.sendRedirect("forgot-password.jsp?error=Email not found");
                return;
            }

            // Lấy user theo email để lấy user_id
            var user = usersDAO.getUserByEmail(email);
            if (user == null) {
                resp.sendRedirect("forgot-password.jsp?error=Email not found");
                return;
            }

            // Tạo token reset password mới
            String token = TokenUtil.generateToken();

            // Lưu token vào bảng password_resets (user_id, token)
            boolean saved = usersDAO.savePasswordResetToken(user.getUserId(), token);
            if (!saved) {
                resp.sendRedirect("forgot-password.jsp?error=Failed to generate reset link");
                return;
            }

            // Tạo link reset password
            String resetLink = req.getRequestURL().toString().replace("forgot-password", "reset-password") + "?token=" + token;

            // Nội dung email dạng HTML
            String subject = "LMS - Reset Your Password";
            String content = "<p>Hello " + user.getUsername() + ",</p>"
                    + "<p>You requested to reset your password. Please click the link below to reset your password:</p>"
                    + "<p><a href='" + resetLink + "'>Reset Password</a></p>"
                    + "<p><i>Note: This link will expire in 15 minutes.</i></p>"
                    + "<p>If you did not request this, please ignore this email.</p>"
                    + "<p>Best regards,<br/>LMS Team</p>";

            EmailUtil.sendEmail(email, subject, content, true);

            resp.sendRedirect("forgot-password.jsp?success=Reset link has been sent to your email");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("forgot-password.jsp?error=Internal server error");
        }
    }
}
