<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Quên mật khẩu</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f4f6f8;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }
    .container {
      background: white;
      padding: 30px 40px;
      border-radius: 8px;
      box-shadow: 0 0 15px rgba(0,0,0,0.1);
      width: 400px;
      text-align: center;
    }
    h2 {
      margin-bottom: 20px;
      color: #333;
    }
    input[type="email"] {
      width: 100%;
      padding: 12px;
      margin-bottom: 20px;
      border-radius: 4px;
      border: 1px solid #ccc;
      font-size: 16px;
    }
    button {
      width: 100%;
      padding: 12px;
      background-color: #007bff;
      border: none;
      border-radius: 4px;
      color: white;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }
    button:hover {
      background-color: #0056b3;
    }
    .message {
      margin-bottom: 15px;
      font-weight: bold;
      padding: 10px;
      border-radius: 4px;
      text-align: center;
    }
    .error {
      background-color: #e74c3c;
      color: white;
    }
    .success {
      background-color: #2ecc71;
      color: white;
    }
    a {
      display: inline-block;
      margin-top: 15px;
      color: #007bff;
      text-decoration: none;
    }
    a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

<div class="container">
  <h2>Quên mật khẩu</h2>

  <% 
    String error = request.getParameter("error");
    String success = request.getParameter("success");
    if (error != null) {
  %>
    <div class="message error"><%= error %></div>
  <% } else if (success != null) { %>
    <div class="message success"><%= success %></div>
  <% } %>

  <form action="<%= request.getContextPath() %>/forgot-password" method="post">
    <input type="email" name="email" placeholder="Nhập email của bạn" required />
    <button type="submit">Gửi liên kết đặt lại mật khẩu</button>
  </form>

  <a href="<%= request.getContextPath() %>/login.jsp">Quay lại đăng nhập</a>
</div>

</body>
</html>
