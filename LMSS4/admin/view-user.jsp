<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết người dùng - LMSS Admin</title>
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
        .user-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #fff;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .info-label {
            font-weight: 600;
            color: #6c757d;
        }
        .info-value {
            font-size: 1.1em;
            color: #495057;
        }
        .status-badge {
            font-size: 0.9em;
            padding: 0.5em 1em;
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
                        <h2><i class="fas fa-user"></i> Chi tiết người dùng</h2>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/users">Quản lý người dùng</a></li>
                                <li class="breadcrumb-item active">Chi tiết người dùng</li>
                            </ol>
                        </nav>
                    </div>
                    <div class="btn-group">
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Quay lại
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/users?action=edit&id=${user.userId}" class="btn btn-warning">
                            <i class="fas fa-edit"></i> Chỉnh sửa
                        </a>
                    </div>
                </div>

                <!-- User Profile Card -->
                <div class="row">
                    <div class="col-md-4">
                        <div class="card text-center">
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${not empty user.avatarUrl}">
                                        <img src="${user.avatarUrl}" alt="Avatar" class="user-avatar mb-3">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="user-avatar bg-secondary d-flex align-items-center justify-content-center mx-auto mb-3">
                                            <i class="fas fa-user text-white fa-3x"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                
                                <h4 class="card-title">${user.fullName}</h4>
                                <p class="text-muted">@${user.username}</p>
                                
                                <div class="mb-3">
                                    <c:choose>
                                        <c:when test="${user.role == 'admin'}">
                                            <span class="badge bg-warning status-badge">
                                                <i class="fas fa-crown"></i> Admin
                                            </span>
                                        </c:when>
                                        <c:when test="${user.role == 'lecturer'}">
                                            <span class="badge bg-info status-badge">
                                                <i class="fas fa-chalkboard-teacher"></i> Giảng viên
                                            </span>
                                        </c:when>
                                        <c:when test="${user.role == 'student'}">
                                            <span class="badge bg-success status-badge">
                                                <i class="fas fa-user-graduate"></i> Sinh viên
                                            </span>
                                        </c:when>
                                    </c:choose>
                                </div>
                                
                                <div class="mb-3">
                                    <c:choose>
                                        <c:when test="${user.active}">
                                            <span class="badge bg-success status-badge">
                                                <i class="fas fa-check-circle"></i> Đang hoạt động
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger status-badge">
                                                <i class="fas fa-times-circle"></i> Không hoạt động
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <div class="mb-3">
                                    <c:choose>
                                        <c:when test="${user.emailVerified}">
                                            <span class="badge bg-primary status-badge">
                                                <i class="fas fa-envelope-check"></i> Email đã xác thực
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary status-badge">
                                                <i class="fas fa-envelope"></i> Email chưa xác thực
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-8">
                        <!-- Basic Information -->
                        <div class="card mb-4">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-info-circle"></i> Thông tin cơ bản</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <div class="info-label">ID người dùng</div>
                                        <div class="info-value">#${user.userId}</div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div class="info-label">Tên đăng nhập</div>
                                        <div class="info-value">${user.username}</div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div class="info-label">Họ và tên</div>
                                        <div class="info-value">${user.fullName}</div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div class="info-label">Email</div>
                                        <div class="info-value">
                                            <a href="mailto:${user.email}" class="text-decoration-none">
                                                <i class="fas fa-envelope"></i> ${user.email}
                                            </a>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div class="info-label">Vai trò</div>
                                        <div class="info-value">
                                            <c:choose>
                                                <c:when test="${user.role == 'admin'}">Quản trị viên</c:when>
                                                <c:when test="${user.role == 'lecturer'}">Giảng viên</c:when>
                                                <c:when test="${user.role == 'student'}">Sinh viên</c:when>
                                                <c:otherwise>${user.role}</c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div class="info-label">Trạng thái tài khoản</div>
                                        <div class="info-value">
                                            <c:choose>
                                                <c:when test="${user.active}">
                                                    <span class="text-success"><i class="fas fa-check-circle"></i> Đang hoạt động</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-danger"><i class="fas fa-times-circle"></i> Không hoạt động</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Role-specific Information -->
                        <c:if test="${user.role == 'student' && not empty student}">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h5 class="mb-0"><i class="fas fa-user-graduate"></i> Thông tin sinh viên</h5>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <div class="info-label">Mã sinh viên</div>
                                            <div class="info-value">${student.studentCode}</div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <div class="info-label">Lớp</div>
                                            <div class="info-value">${student.className}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${user.role == 'lecturer' && not empty lecturer}">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h5 class="mb-0"><i class="fas fa-chalkboard-teacher"></i> Thông tin giảng viên</h5>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <div class="info-label">Mã giảng viên</div>
                                            <div class="info-value">${lecturer.lecturerCode}</div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <div class="info-label">Khoa/Bộ môn</div>
                                            <div class="info-value">${lecturer.department}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <!-- Account Security -->
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-shield-alt"></i> Bảo mật tài khoản</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <div class="info-label">Xác thực email</div>
                                        <div class="info-value">
                                            <c:choose>
                                                <c:when test="${user.emailVerified}">
                                                    <span class="text-success"><i class="fas fa-check-circle"></i> Đã xác thực</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-warning"><i class="fas fa-exclamation-triangle"></i> Chưa xác thực</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div class="info-label">Mật khẩu</div>
                                        <div class="info-value">
                                            <span class="text-muted"><i class="fas fa-lock"></i> Đã được mã hóa</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
