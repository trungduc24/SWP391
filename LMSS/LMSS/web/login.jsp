<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Đăng nhập hệ thống</title>
  <style>
    /* --- CSS như bạn đã có --- */
    * { box-sizing: border-box; margin: 0; padding: 0; }
    html, body { height: 100%; font-family: Arial, sans-serif; }
    body {
      display: flex; flex-direction: column;
      background: url('https://daihoc.fpt.edu.vn/wp-content/uploads/2024/02/dai-hoc-fpt-da-nang-12.jpeg') no-repeat center center fixed;
      background-size: cover;
    }
    .main { flex: 1; display: flex; justify-content: center; align-items: center; padding: 20px; }
    .container {
      display: flex; width: 900px; max-width: 100%; height: 500px;
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
      background-color: #007bff; color: white; cursor: pointer;
      font-size: 16px; margin-bottom: 10px; transition: background-color 0.3s ease;
    }
    .right button:hover { background-color: #0056b3; }
    .btn-google { background-color: #db4437; margin-bottom: 10px; }
    .btn-google:hover { background-color: #a33224; }
    .btn-register { background-color: #28a745; margin-bottom: 20px; }
    .btn-register:hover { background-color: #1e7e34; }
    .forgot-password {
      color: #ccc; text-align: center; cursor: pointer;
      text-decoration: underline; font-size: 14px; margin-top: 10px;
    }
    .forgot-password:hover { color: white; }
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
        <h1>OFFICIAL</h1>
        <p>Chào mừng bạn đến với hệ thống đăng nhập</p>
      </div>
      <div class="right">

        <!-- ✅ Hiển thị thông báo lỗi nếu có -->
        <c:if test="${not empty error}">
          <div class="error-message">${error}</div>
        </c:if>

        <form action="login" method="post">
          <label for="username" class="visually-hidden">Tên đăng nhập</label>
          <input id="username" name="username" type="text" placeholder="Tên đăng nhập" required />

          <label for="password" class="visually-hidden">Mật khẩu</label>
          <input id="password" name="password" type="password" placeholder="Mật khẩu" required />

          <label for="role" class="visually-hidden">Vai trò</label>
          <select id="role" name="role" required>
            <option value="" disabled selected>-- Bạn là ai? --</option>
            <option value="student">Sinh Viên</option>
            <option value="lecturer">Giảng Viên</option>
            <option value="admin">Admin</option>
          </select>

          <button type="submit">Đăng nhập</button>
        </form>

        <button class="btn-google" onclick="window.location.href='${pageContext.request.contextPath}/GoogleLoginServlet'">
          Đăng nhập bằng Google
        </button>

        <button class="btn-register" onclick="window.location.href='${pageContext.request.contextPath}/register.jsp'">
          Đăng ký tài khoản
        </button>

        <div class="forgot-password" onclick="window.location.href='${pageContext.request.contextPath}/forgot-password.jsp'">
          Quên mật khẩu?
        </div>
      </div>
    </div>
  </div>

  <footer>
    © 2025 Hệ thống đăng nhập. Thiết kế Group2.
  </footer>

</body>
</html>
