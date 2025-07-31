<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Đăng ký tài khoản</title>
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    html, body { height: 100%; font-family: Arial, sans-serif; }
    body {
      display: flex; flex-direction: column;
      background: url('https://daihoc.fpt.edu.vn/wp-content/uploads/2024/02/dai-hoc-fpt-da-nang-12.jpeg') no-repeat center center fixed;
      background-size: cover;
    }
    .main { flex: 1; display: flex; justify-content: center; align-items: center; padding: 20px; }
    .container {
      display: flex; width: 900px; max-width: 100%; height: 550px;
      background: rgba(0, 0, 0, 0.6); border-radius: 10px; overflow: hidden;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.5); flex-wrap: wrap;
    }
    .left {
      width: 50%; min-width: 280px; background-color: white;
      display: flex; flex-direction: column; justify-content: center; align-items: center; padding: 30px;
    }
    .left .logo { display: block; max-width: 150px; margin-bottom: 20px; }
    .left h1 { font-size: 28px; color: #333; }
    .left p { margin-top: 10px; color: #666; }
    .right {
      width: 50%; min-width: 280px; padding: 40px;
      display: flex; flex-direction: column; justify-content: center; background-color: #444;
    }
    .right form { display: flex; flex-direction: column; }
    .right input, .right select {
      padding: 10px; margin-bottom: 20px; border: none;
      border-radius: 4px; background-color: #ddd; font-size: 16px;
    }
    .right select option { color: black; }
    .right button {
      padding: 12px; border: none; border-radius: 4px;
      background-color: #28a745; color: white; cursor: pointer;
      font-size: 16px; margin-bottom: 10px; transition: background-color 0.3s ease;
    }
    .right button:hover { background-color: #1e7e34; }
    .btn-login {
      background-color: #007bff;
      margin-bottom: 20px;
    }
    .btn-login:hover { background-color: #0056b3; }
    .error-message {
      color: #ff8080;
      background-color: #330000;
      padding: 10px;
      border-radius: 4px;
      text-align: center;
      margin-bottom: 20px;
    }
    footer {
      text-align: center; color: white; padding: 15px 0;
      font-size: 14px; background-color: rgba(0, 0, 0, 0.5);
    }
  </style>
</head>
<body>

  <div class="main">
    <div class="container">
      <div class="left">
        <img class="logo" src="https://static.vecteezy.com/system/resources/previews/028/207/989/non_2x/edu-logo-design-inspiration-for-a-unique-identity-modern-elegance-and-creative-design-watermark-your-success-with-the-striking-this-logo-vector.jpg" alt="FPT Edu Logo" />
        <h1>ĐĂNG KÝ</h1>
        <p>Chào mừng bạn đến với hệ thống</p>
      </div>
      <div class="right">

        <!-- ✅ Hiển thị lỗi nếu có -->
        <c:if test="${not empty error}">
          <div class="error-message">${error}</div>
        </c:if>

        <form action="register" method="post">
          <input name="username" type="text" placeholder="Tên đăng nhập" required />
          <input name="password" type="password" placeholder="Mật khẩu" required />
          <input name="confirmPassword" type="password" placeholder="Xác nhận mật khẩu" required />
          <input name="email" type="email" placeholder="Email" required />
          <select name="role" required>
            <option value="" disabled selected>-- Vai trò của bạn --</option>
            <option value="student">Sinh Viên</option>
            <option value="lecturer">Giảng Viên</option>
          </select>
          <button type="submit">Đăng ký</button>
        </form>

        <button class="btn-login" onclick="window.location.href='${pageContext.request.contextPath}/login.jsp'">
          Quay lại trang đăng nhập
        </button>

      </div>
    </div>
  </div>

  <footer>
    © 2025 Hệ thống đăng ký. Thiết kế Group2.
  </footer>

</body>
</html>
