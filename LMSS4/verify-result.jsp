<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác thực Email</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            padding-top: 50px;
            background-color: #f9f9f9;
        }
        .message {
            padding: 20px;
            margin: auto;
            width: 60%;
            max-width: 600px;
            border-radius: 8px;
            font-size: 18px;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>

<%-- Hiển thị thông báo nếu có --%>
<%
    String msg = (String) request.getAttribute("message");
    String err = (String) request.getAttribute("error");
    if (msg != null) {
%>
    <div class="message success"><%= msg %></div>
<%
    } else if (err != null) {
%>
    <div class="message error"><%= err %></div>
<%
    } else {
%>
    <div class="message">Không có thông tin xác thực để hiển thị.</div>
<%
    }
%>

<br><br>
<a href="login.jsp">⬅ Quay lại trang đăng nhập</a>

</body>
</html>
