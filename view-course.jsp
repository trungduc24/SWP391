<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // Kiểm tra quyền admin
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"admin".equals(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    Course course = (Course) request.getAttribute("course");
    if (course == null) {
        response.sendRedirect(request.getContextPath() + "/courses");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Khóa học - LMSS Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            z-index: 1000;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .info-row {
            border-bottom: 1px solid #eee;
            padding: 15px 0;
        }
        .info-row:last-child {
            border-bottom: none;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 sidebar">
                <div class="p-3">
                    <div class="text-center mb-4">
                        <h4 class="text-white">LMSS Admin</h4>
                        <p class="text-light">Xin chào, <%= currentUser.getUsername() %></p>
                    </div>
                    
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link text-light" href="<%= request.getContextPath() %>/courses">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="<%= request.getContextPath() %>/admin/users.jsp">
                                <i class="fas fa-users me-2"></i>Quản lý người dùng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light active" href="<%= request.getContextPath() %>/courses">
                                <i class="fas fa-book me-2"></i>Quản lý khóa học
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="<%= request.getContextPath() %>/semesters">
                                <i class="fas fa-calendar me-2"></i>Quản lý học kỳ
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="<%= request.getContextPath() %>/logout">
                                <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-9 col-lg-10 main-content">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>Chi tiết Khóa học</h2>
                    <div>
                        <a href="<%= request.getContextPath() %>/courses?action=edit&id=<%= course.getCourseId() %>" class="btn btn-warning me-2">
                            <i class="fas fa-edit me-2"></i>Chỉnh sửa
                        </a>
                        <a href="<%= request.getContextPath() %>/courses" class="btn btn-secondary">
                            <i class="fas fa-arrow-left me-2"></i>Quay lại
                        </a>
                    </div>
                </div>

                <!-- Course Details -->
                <div class="row">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">Thông tin khóa học</h5>
                            </div>
                            <div class="card-body">
                                <div class="info-row">
                                    <div class="row">
                                        <div class="col-md-3"><strong>Tên khóa học:</strong></div>
                                        <div class="col-md-9"><%= course.getName() %></div>
                                    </div>
                                </div>
                                <div class="info-row">
                                    <div class="row">
                                        <div class="col-md-3"><strong>Mã khóa học:</strong></div>
                                        <div class="col-md-9"><%= course.getCode() %></div>
                                    </div>
                                </div>
                                <div class="info-row">
                                    <div class="row">
                                        <div class="col-md-3"><strong>Mô tả:</strong></div>
                                        <div class="col-md-9"><%= course.getDescription() != null ? course.getDescription() : "Chưa có mô tả" %></div>
                                    </div>
                                </div>
                                <div class="info-row">
                                    <div class="row">
                                        <div class="col-md-3"><strong>Phòng học:</strong></div>
                                        <div class="col-md-9"><%= course.getRoom() %></div>
                                    </div>
                                </div>
                                <div class="info-row">
                                    <div class="row">
                                        <div class="col-md-3"><strong>Lịch học:</strong></div>
                                        <div class="col-md-9"><%= course.getSchedule() != null ? course.getSchedule() : "Chưa xác định" %></div>
                                    </div>
                                </div>
                                <div class="info-row">
                                    <div class="row">
                                        <div class="col-md-3"><strong>Số tín chỉ:</strong></div>
                                        <div class="col-md-9"><%= course.getCredits() %></div>
                                    </div>
                                </div>
                                <div class="info-row">
                                    <div class="row">
                                        <div class="col-md-3"><strong>Sĩ số tối đa:</strong></div>
                                        <div class="col-md-9"><%= course.getMaxStudents() %></div>
                                    </div>
                                </div>
                                <div class="info-row">
                                    <div class="row">
                                        <div class="col-md-3"><strong>Số buổi học:</strong></div>
                                        <div class="col-md-9"><%= course.getTotalSessions() %></div>
                                    </div>
                                </div>
                                <div class="info-row">
                                    <div class="row">
                                        <div class="col-md-3"><strong>Trạng thái:</strong></div>
                                        <div class="col-md-9">
                                            <span class="badge bg-<%= course.isActive() ? "success" : "danger" %>">
                                                <%= course.isActive() ? "Hoạt động" : "Không hoạt động" %>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">Thống kê</h5>
                            </div>
                            <div class="card-body">
                                <div class="text-center mb-3">
                                    <h3 class="text-primary">0/<%= course.getMaxStudents() %></h3>
                                    <p class="mb-0">Sinh viên đã đăng ký</p>
                                </div>
                                <div class="progress mb-3">
                                    <div class="progress-bar" role="progressbar" style="width: 0%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <div class="row text-center">
                                    <div class="col-6">
                                        <h5><%= course.getCredits() %></h5>
                                        <small class="text-muted">Tín chỉ</small>
                                    </div>
                                    <div class="col-6">
                                        <h5><%= course.getTotalSessions() %></h5>
                                        <small class="text-muted">Buổi học</small>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="card mt-3">
                            <div class="card-header">
                                <h5 class="mb-0">Thao tác</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                                    <a href="<%= request.getContextPath() %>/courses?action=edit&id=<%= course.getCourseId() %>" class="btn btn-warning">
                                        <i class="fas fa-edit me-2"></i>Chỉnh sửa khóa học
                                    </a>
                                    <button class="btn btn-danger" onclick="deleteCourse(<%= course.getCourseId() %>, '<%= course.getName() %>')">
                                        <i class="fas fa-trash me-2"></i>Xóa khóa học
                                    </button>
                                    <a href="#" class="btn btn-info">
                                        <i class="fas fa-users me-2"></i>Quản lý sinh viên
                                    </a>
                                    <a href="#" class="btn btn-success">
                                        <i class="fas fa-file-alt me-2"></i>Xem báo cáo
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function deleteCourse(courseId, courseName) {
            if (confirm(`Bạn có chắc chắn muốn xóa khóa học "${courseName}"?`)) {
                fetch('<%= request.getContextPath() %>/courses?action=delete&id=' + courseId, {
                    method: 'POST'
                })
                .then(response => {
                    if (response.ok) {
                        window.location.href = '<%= request.getContextPath() %>/courses';
                    } else {
                        alert('Có lỗi xảy ra khi xóa khóa học');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Có lỗi xảy ra khi xóa khóa học');
                });
            }
        }
    </script>
</body>
</html>
