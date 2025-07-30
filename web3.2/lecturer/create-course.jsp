<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // Kiểm tra quyền lecturer
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"lecturer".equals(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    // Lấy đường dẫn hiện tại để highlight menu
    String currentURI = request.getRequestURI();
    String contextPath = request.getContextPath();
    String baseUrl = contextPath + "/lecturer";
    
    List<Semester> semesters = (List<Semester>) request.getAttribute("semesters");
    if (semesters == null) {
        semesters = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo Khóa học mới - LMSS Lecturer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2980b9;
            --accent-color: #e74c3c;
            --light-bg: #f8f9fa;
            --dark-bg: #343a40;
            --success-color: #2ecc71;
            --warning-color: #f39c12;
            --danger-color: #e74c3c;
            --info-color: #3498db;
            --sidebar-width: 280px;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            color: #333;
        }
        
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: var(--sidebar-width);
            height: 100vh;
            background: linear-gradient(to bottom, #3498db, #2980b9);
            color: #fff;
            z-index: 1000;
            transition: all 0.3s;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            overflow-y: auto;
        }
        
        .sidebar-header {
            padding: 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .sidebar-header h3 {
            margin: 0;
            font-weight: 700;
        }
        
        .sidebar-menu {
            padding: 20px 0;
        }
        
        .sidebar-menu ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .sidebar-menu li {
            margin-bottom: 5px;
        }
        
        .sidebar-menu a {
            display: block;
            padding: 12px 20px;
            color: #fff;
            text-decoration: none;
            transition: all 0.3s;
            border-left: 4px solid transparent;
        }
        
        .sidebar-menu a:hover, .sidebar-menu a.active {
            background-color: rgba(255, 255, 255, 0.1);
            border-left-color: #fff;
        }
        
        .sidebar-menu a i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        
        .content-wrapper {
            margin-left: var(--sidebar-width);
            padding: 20px;
            transition: all 0.3s;
        }
        
        .main-content {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.05);
            padding: 25px;
            min-height: calc(100vh - 40px);
        }
        
        .form-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 30px;
        }
        
        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
            }
            
            .content-wrapper {
                margin-left: 0;
            }
            
            .sidebar.active {
                transform: translateX(0);
            }
            
            .content-wrapper.active {
                margin-left: var(--sidebar-width);
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <%@ include file="sidebar.jsp" %>

    <!-- Content -->
    <div class="content-wrapper">
        <!-- Top Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-white mb-4 rounded">
            <div class="container-fluid">
                <button id="sidebarToggle" class="btn btn-light d-lg-none me-3">
                    <i class="fas fa-bars"></i>
                </button>
                <span class="navbar-brand">Tạo Khóa học mới</span>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                <i class="fas fa-bell me-2"></i>
                                <span class="badge bg-danger">3</span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><h6 class="dropdown-header">Thông báo</h6></li>
                                <li><a class="dropdown-item" href="#">Thông báo 1</a></li>
                                <li><a class="dropdown-item" href="#">Thông báo 2</a></li>
                                <li><a class="dropdown-item" href="#">Thông báo 3</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-center" href="#">Xem tất cả</a></li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                                <i class="fas fa-user-circle me-2"></i>
                                <%= currentUser.getUsername() %>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="<%= baseUrl %>/profile"><i class="fas fa-user me-2"></i>Hồ sơ</a></li>
                                <li><a class="dropdown-item" href="<%= baseUrl %>/settings"><i class="fas fa-cog me-2"></i>Cài đặt</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="<%= contextPath %>/logout"><i class="fas fa-sign-out-alt me-2"></i>Đăng xuất</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="main-content">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Tạo Khóa học mới</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="<%= request.getContextPath() %>/lecturer/courses" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left me-2"></i>Quay lại
                        </a>
                    </div>
                </div>

                <!-- Hiển thị thông báo -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Form tạo khóa học -->
                <div class="form-container">
                    <form action="<%= request.getContextPath() %>/lecturer/courses" method="post" id="createCourseForm" class="needs-validation" novalidate>
                        <input type="hidden" name="action" value="create-course">
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="courseName" class="form-label">Tên khóa học <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="courseName" name="courseName" required>
                                    <div class="invalid-feedback">
                                        Vui lòng nhập tên khóa học
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="courseCode" class="form-label">Mã khóa học <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="courseCode" name="courseCode" required>
                                    <div class="invalid-feedback">
                                        Vui lòng nhập mã khóa học
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="description" class="form-label">Mô tả khóa học</label>
                            <textarea class="form-control" id="description" name="description" rows="4" 
                                      placeholder="Nhập mô tả chi tiết về khóa học..."></textarea>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="semesterId" class="form-label">Học kỳ <span class="text-danger">*</span></label>
                                    <select class="form-select" id="semesterId" name="semesterId" required>
                                        <option value="">Chọn học kỳ</option>
                                        <% for (Semester semester : semesters) { %>
                                            <option value="<%= semester.getSemesterId() %>">
                                                <%= semester.getName() %> (<%= semester.getCode() %>)
                                            </option>
                                        <% } %>
                                    </select>
                                    <div class="invalid-feedback">
                                        Vui lòng chọn học kỳ
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="credits" class="form-label">Số tín chỉ <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="credits" name="credits" 
                                           min="1" max="10" required>
                                    <div class="invalid-feedback">
                                        Vui lòng nhập số tín chỉ hợp lệ (1-10)
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label for="room" class="form-label">Phòng học</label>
                                    <input type="text" class="form-control" id="room" name="room" 
                                           placeholder="VD: A101, B205...">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label for="maxStudents" class="form-label">Sĩ số tối đa</label>
                                    <input type="number" class="form-control" id="maxStudents" name="maxStudents" 
                                           min="1" max="200" placeholder="VD: 50">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label for="totalSessions" class="form-label">Tổng số buổi học</label>
                                    <input type="number" class="form-control" id="totalSessions" name="totalSessions" 
                                           min="1" max="100" placeholder="VD: 15">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="schedule" class="form-label">Lịch học</label>
                                    <input type="text" class="form-control" id="schedule" name="schedule" 
                                           placeholder="VD: Thứ 2, 4, 6 - 7:30-9:30">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="active" class="form-label">Trạng thái</label>
                                    <div class="form-check form-switch mt-2">
                                        <input class="form-check-input" type="checkbox" id="active" name="active" checked>
                                        <label class="form-check-label" for="active">Kích hoạt khóa học</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end gap-2">
                            <a href="<%= request.getContextPath() %>/lecturer/courses" class="btn btn-outline-secondary">Hủy</a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-2"></i>Tạo khóa học
                            </button>
                        </div>
                    </form>
                </div>
        </div>
    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Sidebar Toggle
            const sidebarToggle = document.getElementById('sidebarToggle');
            const sidebar = document.querySelector('.sidebar');
            const contentWrapper = document.querySelector('.content-wrapper');
            
            if (sidebarToggle) {
                sidebarToggle.addEventListener('click', function() {
                    sidebar.classList.toggle('active');
                    contentWrapper.classList.toggle('active');
                });
            }
        });
    </script>
    <script>
        // Form validation
        (function() {
            'use strict';
            
            // Fetch all forms that need validation
            var forms = document.querySelectorAll('.needs-validation');
            
            // Loop over them and prevent submission
            Array.prototype.slice.call(forms).forEach(function(form) {
                form.addEventListener('submit', function(event) {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    
                    form.classList.add('was-validated');
                }, false);
            });
        })();

        // Auto-generate course code based on name
        document.getElementById('courseName').addEventListener('input', function() {
            const name = this.value;
            const codeField = document.getElementById('courseCode');
            
            if (name && !codeField.value) {
                // Generate code from first letters of words
                const words = name.split(' ');
                let code = '';
                words.forEach(word => {
                    if (word.length > 0) {
                        code += word.charAt(0).toUpperCase();
                    }
                });
                codeField.value = code;
            }
        });
    </script>
</body>
</html>
