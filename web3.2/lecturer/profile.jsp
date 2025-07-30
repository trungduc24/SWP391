<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ Giảng viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <style>
        body {
            font-family: 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background-color: #f0f2f5; /* Nền xám nhạt */
            color: #333;
        }

        .container.mt-5 {
            padding-top: 3rem !important;
            padding-bottom: 3rem !important;
        }

        /* General Card Styling */
        .card {
            border: none;
            border-radius: 1rem; /* Bo góc nhiều hơn */
            box-shadow: 0 0 25px rgba(0,0,0,0.08); /* Đổ bóng mềm mại hơn */
            margin-bottom: 1.5rem; /* Khoảng cách giữa các card */
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
        }

        .card:hover {
            transform: translateY(-3px); /* Hiệu ứng nhấc nhẹ khi di chuột qua */
            box-shadow: 0 8px 20px rgba(0,0,0,0.12); /* Đổ bóng nổi bật hơn khi hover */
        }

        .card-header {
            background-color: #0d6efd; /* Màu xanh chủ đạo của Bootstrap Primary */
            color: white;
            font-weight: 600;
            padding: 1.25rem 1.5rem;
            border-top-left-radius: 1rem;
            border-top-right-radius: 1rem;
            border-bottom: none; /* Bỏ đường viền dưới của header */
            font-size: 1.1rem;
        }

        .card-body {
            padding: 1.5rem;
        }

        /* Profile Card Specific */
        .card.text-center .card-body {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .rounded-circle {
            border: 4px solid #ffffff; /* Viền trắng quanh avatar */
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            object-fit: cover; /* Đảm bảo ảnh không bị biến dạng */
        }

        .card.text-center h4 {
            color: #212529;
            margin-top: 1rem;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }

        .card.text-center p {
            color: #6c757d;
            margin-bottom: 0.25rem;
            font-size: 0.95rem;
        }

        /* Form Styling */
        .form-control {
            border-radius: 0.5rem; /* Bo góc input fields */
            padding: 0.75rem 1rem;
            border: 1px solid #ced4da;
            transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
        }

        .form-control:focus {
            border-color: #86b7fe;
            box-shadow: 0 0 0 0.25rem rgba(13,110,253,.25);
        }

        label {
            font-weight: 500;
            color: #495057;
            margin-bottom: 0.5rem;
            display: block; /* Đảm bảo label đứng riêng một dòng */
        }

        .input-group-sm .form-control, .input-group-sm .btn {
            padding: 0.5rem 0.75rem;
            font-size: 0.875rem;
            border-radius: 0.5rem;
        }

        /* Buttons */
        .btn-primary {
            background-color: #0d6efd;
            border-color: #0d6efd;
            border-radius: 0.75rem; /* Bo góc nút */
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            transition: background-color 0.2s ease-in-out, border-color 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
        }

        .btn-primary:hover {
            background-color: #0a58ca;
            border-color: #0a53be;
            box-shadow: 0 4px 10px rgba(13,110,253,.3);
        }

        .btn-warning {
            background-color: #ffc107;
            border-color: #ffc107;
            border-radius: 0.75rem;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            transition: background-color 0.2s ease-in-out, border-color 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
        }

        .btn-warning:hover {
            background-color: #e0a800;
            border-color: #d39e00;
            box-shadow: 0 4px 10px rgba(255,193,7,.3);
        }

        .btn-outline-primary {
            border-radius: 0.5rem;
            font-weight: 500;
        }

        /* Alert Messages */
        .alert {
            border-radius: 0.75rem;
            padding: 1rem 1.5rem;
            font-size: 0.95rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }

        .alert-success {
            background-color: #d1e7dd;
            color: #0f5132;
            border-color: #badbcc;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #842029;
            border-color: #f5c2c7;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <c:if test="${not empty sessionScope.success}">
        <div class="alert alert-success">${sessionScope.success}</div>
        <c:remove var="success" scope="session"/>
    </c:if>
    <c:if test="${not empty sessionScope.error}">
        <div class="alert alert-danger">${sessionScope.error}</div>
        <c:remove var="error" scope="session"/>
    </c:if>

    <div class="row">
        <div class="col-md-4">
            <div class="card text-center">
                <div class="card-header">
                    Hồ sơ Giảng viên
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty lecturer.avatarUrl}">
                            <img src="${pageContext.request.contextPath}/${lecturer.avatarUrl}" alt="Avatar" class="rounded-circle mb-3" width="150" height="150">
                        </c:when>
                        <c:otherwise>
                            <img src="https://via.placeholder.com/150/ADB5BD/FFFFFF?text=AVATAR" alt="Default Avatar" class="rounded-circle mb-3" width="150" height="150">
                        </c:otherwise>
                    </c:choose>

                    <form action="${pageContext.request.contextPath}/lecturer/profile" method="post" enctype="multipart/form-data" class="w-100">
                        <input type="hidden" name="action" value="upload-avatar"/>
                        <div class="input-group input-group-sm mb-3">
                            <input type="file" name="avatar" class="form-control" accept=".png,.jpg,.jpeg" required>
                            <button class="btn btn-outline-primary" type="submit">Tải lên</button>
                        </div>
                    </form>

                    <h4>${lecturer.fullName}</h4>
                    <p class="mb-1"><i class="fas fa-envelope me-2 text-muted"></i>${lecturer.email}</p>
                    <p class="mb-1"><i class="fas fa-phone me-2 text-muted"></i>${lecturer.phone}</p>
                    <p class="mb-0"><strong>Mã giảng viên:</strong> ${lecturer.lecturerCode}</p>
                </div>
            </div>
        </div>

        <div class="col-md-8">
            <form action="${pageContext.request.contextPath}/lecturer/profile" method="post">
                <input type="hidden" name="action" value="update-profile"/>
                <div class="card mb-3">
                    <div class="card-header">Cập nhật thông tin</div>
                    <div class="card-body">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="fullName">Họ và tên</label>
                                <input type="text" id="fullName" name="fullName" class="form-control" value="${lecturer.fullName}" required/>
                            </div>
                            <div class="col-md-6">
                                <label for="email">Email</label>
                                <input type="email" id="email" name="email" class="form-control" value="${lecturer.email}" required/>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="phone">Số điện thoại</label>
                                <input type="text" id="phone" name="phone" class="form-control" value="${lecturer.phone}" />
                            </div>
                            <div class="col-md-6">
                                <label for="department">Khoa</label>
                                <input type="text" id="department" name="department" class="form-control" value="${lecturer.department}" />
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="specialization">Chuyên ngành</label>
                                <input type="text" id="specialization" name="specialization" class="form-control" value="${lecturer.specialization}" />
                            </div>
                            <div class="col-md-6">
                                <label for="degree">Bằng cấp</label>
                                <input type="text" id="degree" name="degree" class="form-control" value="${lecturer.degree}" />
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary mt-3">Lưu thay đổi</button>
                    </div>
                </div>
            </form>

            <form action="${pageContext.request.contextPath}/lecturer/profile" method="post">
                <input type="hidden" name="action" value="change-password"/>
                <div class="card">
                    <div class="card-header">Đổi mật khẩu</div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label for="currentPassword">Mật khẩu hiện tại</label>
                            <input type="password" id="currentPassword" name="currentPassword" class="form-control" required/>
                        </div>
                        <div class="mb-3">
                            <label for="newPassword">Mật khẩu mới</label>
                            <input type="password" id="newPassword" name="newPassword" class="form-control" required/>
                        </div>
                        <div class="mb-3">
                            <label for="confirmPassword">Xác nhận mật khẩu mới</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required/>
                        </div>
                        <button type="submit" class="btn btn-warning mt-3">Đổi mật khẩu</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Kiểm tra mật khẩu khớp trước khi gửi form đổi mật khẩu
    document.querySelector('form[action$="change-password"]').addEventListener('submit', function(e) {
        const newPass = document.getElementById('newPassword').value;
        const confirmPass = document.getElementById('confirmPassword').value;
        if (newPass !== confirmPass) {
            e.preventDefault();
            alert("Mật khẩu mới và mật khẩu xác nhận không khớp!");
        }
    });
</script>
</body>
</html>