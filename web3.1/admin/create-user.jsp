<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm người dùng mới - LMSS Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .main-content {
            background-color: #f8f9fa;
            min-height: 100vh;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .required {
            color: #dc3545;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-2 sidebar text-white p-0">
                <div class="p-3">
                    <h4><i class="fas fa-graduation-cap"></i> LMSS Admin</h4>
                </div>
                <nav class="nav flex-column">
                    <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/dashboard">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </a>
                    <a class="nav-link text-white active" href="${pageContext.request.contextPath}/admin/users">
                        <i class="fas fa-users"></i> Quản lý người dùng
                    </a>
                    <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/courses">
                        <i class="fas fa-book"></i> Quản lý khóa học
                    </a>
                    <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/semesters">
                        <i class="fas fa-calendar"></i> Quản lý học kỳ
                    </a>
                    <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/reports">
                        <i class="fas fa-chart-bar"></i> Báo cáo
                    </a>
                    <hr class="text-white">
                    <a class="nav-link text-white" href="${pageContext.request.contextPath}/logout">
                        <i class="fas fa-sign-out-alt"></i> Đăng xuất
                    </a>
                </nav>
            </div>

            <!-- Main Content -->
            <div class="col-md-10 main-content p-4">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2><i class="fas fa-user-plus"></i> Thêm người dùng mới</h2>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/users">Quản lý người dùng</a></li>
                                <li class="breadcrumb-item active">Thêm người dùng</li>
                            </ol>
                        </nav>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Quay lại
                    </a>
                </div>

                <!-- Error Messages -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Create User Form -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-user-plus"></i> Thông tin người dùng mới</h5>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/users" method="post" id="createUserForm">
                            <input type="hidden" name="action" value="create">
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="username" class="form-label">Tên đăng nhập <span class="required">*</span></label>
                                        <input type="text" class="form-control" id="username" name="username" required 
                                               placeholder="Nhập tên đăng nhập" value="${param.username}">
                                        <div class="form-text">Tên đăng nhập phải duy nhất trong hệ thống</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email <span class="required">*</span></label>
                                        <input type="email" class="form-control" id="email" name="email" required 
                                               placeholder="Nhập địa chỉ email" value="${param.email}">
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="password" class="form-label">Mật khẩu <span class="required">*</span></label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" id="password" name="password" required 
                                                   placeholder="Nhập mật khẩu" minlength="6">
                                            <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                        </div>
                                        <div class="form-text">Mật khẩu phải có ít nhất 6 ký tự</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="role" class="form-label">Vai trò <span class="required">*</span></label>
                                        <select class="form-select" id="role" name="role" required>
                                            <option value="">Chọn vai trò</option>
                                            <option value="student" ${param.role == 'student' ? 'selected' : ''}>Sinh viên</option>
                                            <option value="lecturer" ${param.role == 'lecturer' ? 'selected' : ''}>Giảng viên</option>
                                            <option value="admin" ${param.role == 'admin' ? 'selected' : ''}>Admin</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="fullName" class="form-label">Họ và tên <span class="required">*</span></label>
                                <input type="text" class="form-control" id="fullName" name="fullName" required 
                                       placeholder="Nhập họ và tên đầy đủ" value="${param.fullName}">
                            </div>

                            <div class="mb-3">
                                <label for="avatarUrl" class="form-label">URL Avatar</label>
                                <input type="url" class="form-control" id="avatarUrl" name="avatarUrl" 
                                       placeholder="https://example.com/avatar.jpg" value="${param.avatarUrl}">
                                <div class="form-text">Để trống nếu không có avatar</div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-check mb-3">
                                        <input class="form-check-input" type="checkbox" id="isActive" name="isActive" checked>
                                        <label class="form-check-label" for="isActive">
                                            Kích hoạt tài khoản ngay
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <div class="d-flex justify-content-end gap-2">
                                <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">
                                    <i class="fas fa-times"></i> Hủy
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Tạo người dùng
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordField = document.getElementById('password');
            const icon = this.querySelector('i');
            
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                passwordField.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });

        // Form validation
        document.getElementById('createUserForm').addEventListener('submit', function(e) {
            const username = document.getElementById('username').value.trim();
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value;
            const role = document.getElementById('role').value;
            const fullName = document.getElementById('fullName').value.trim();

            if (!username || !email || !password || !role || !fullName) {
                e.preventDefault();
                alert('Vui lòng điền đầy đủ thông tin bắt buộc!');
                return;
            }

            if (password.length < 6) {
                e.preventDefault();
                alert('Mật khẩu phải có ít nhất 6 ký tự!');
                return;
            }

            // Email validation
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                e.preventDefault();
                alert('Định dạng email không hợp lệ!');
                return;
            }
        });
    </script>
</body>
</html>
