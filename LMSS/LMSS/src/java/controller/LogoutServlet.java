package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;


public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy session hiện tại, nếu có thì xoá
        HttpSession session = req.getSession(false); // false: không tạo mới nếu chưa tồn tại
        if (session != null) {
            session.invalidate(); // Xoá session, đăng xuất user
        }

        // Redirect về trang login hoặc trang chủ
        resp.sendRedirect(req.getContextPath() + "/login.jsp");
    }

    // Nếu muốn logout qua POST cũng được
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
