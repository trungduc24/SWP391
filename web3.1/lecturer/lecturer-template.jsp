<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // Kiểm tra quyền lecturer
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !currentUser.getRole().equals("lecturer")) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    // Lấy đường dẫn hiện tại để highlight menu
    String currentURI = request.getRequestURI();
    String contextPath = request.getContextPath();
    String baseUrl = contextPath + "/lecturer";
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LMSS - ${param.pageTitle}</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Custom CSS -->
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
        
        .profile-header {
            background-color: #fff;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
        }
        
        .card {
            border: none;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 20px;
        }
        
        .card-header {
            background-color: #fff;
            border-bottom: 1px solid #eee;
            padding: 15px 20px;
        }
        
        .card-body {
            padding: 20px;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .btn-primary:hover {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
        }
        
        .btn-light {
            background-color: #f8f9fa;
            border-color: #eee;
        }
        
        .avatar {
            width: 40px;
            height: 40px;
            background-color: var(--primary-color);
            color: #fff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }
        
        .navbar {
            background-color: #fff;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.05);
        }
        
        .navbar-brand {
            font-weight: 700;
            color: var(--primary-color);
        }
        
        .dropdown-menu {
            border: none;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        
        .table {
            border-collapse: separate;
            border-spacing: 0;
        }
        
        .table th {
            background-color: #f8f9fa;
            border-bottom: 2px solid #eee;
        }
        
        .table td {
            vertical-align: middle;
        }
        
        .badge {
            padding: 6px 10px;
            font-weight: 500;
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
        
        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 6px;
        }
        
        ::-webkit-scrollbar-track {
            background: #f1f1f1;
        }
        
        ::-webkit-scrollbar-thumb {
            background: #888;
            border-radius: 3px;
        }
        
        ::-webkit-scrollbar-thumb:hover {
            background: #555;
        }
        
        /* Loader */
        .loader {
            border: 4px solid #f3f3f3;
            border-radius: 50%;
            border-top: 4px solid var(--primary-color);
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
            margin: 20px auto;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        /* Toast Notification */
        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
        }
        
        .toast {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 10px;
            min-width: 300px;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h3>LMSS</h3>
            <p class="mb-0">Hệ thống quản lý học tập</p>
        </div>
        <div class="sidebar-menu">
            <ul>
                <li>
                    <a href="<%= baseUrl %>/dashboard" class="<%= currentURI.contains("/dashboard") ? "active" : "" %>">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </a>
                </li>
                <li>
                    <a href="<%= baseUrl %>/courses" class="<%= currentURI.contains("/courses") ? "active" : "" %>">
                        <i class="fas fa-book"></i> Khóa học
                    </a>
                </li>
                <li>
                    <a href="<%= baseUrl %>/students" class="<%= currentURI.contains("/students") ? "active" : "" %>">
                        <i class="fas fa-users"></i> Sinh viên
                    </a>
                </li>
                <li>
                    <a href="<%= baseUrl %>/tests" class="<%= currentURI.contains("/tests") ? "active" : "" %>">
                        <i class="fas fa-clipboard-check"></i> Bài kiểm tra
                    </a>
                </li>
                <li>
                    <a href="<%= baseUrl %>/grades" class="<%= currentURI.contains("/grades") ? "active" : "" %>">
                        <i class="fas fa-chart-line"></i> Điểm số
                    </a>
                </li>
                <li>
                    <a href="<%= baseUrl %>/materials" class="<%= currentURI.contains("/materials") ? "active" : "" %>">
                        <i class="fas fa-file-alt"></i> Tài liệu
                    </a>
                </li>
                <li>
                    <a href="<%= baseUrl %>/announcements" class="<%= currentURI.contains("/announcements") ? "active" : "" %>">
                        <i class="fas fa-bullhorn"></i> Thông báo
                    </a>
                </li>
                <li>
                    <a href="<%= baseUrl %>/profile" class="<%= currentURI.contains("/profile") ? "active" : "" %>">
                        <i class="fas fa-user"></i> Hồ sơ cá nhân
                    </a>
                </li>
            
            </ul>
        </div>
        <div class="sidebar-footer p-3 mt-auto border-top border-light">
            <a href="<%= contextPath %>/logout" class="btn btn-danger w-100">
                <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
            </a>
        </div>
    </div>

    <!-- Content -->
    <div class="content-wrapper">
        <!-- Top Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-white mb-4 rounded">
            <div class="container-fluid">
                <button id="sidebarToggle" class="btn btn-light d-lg-none me-3">
                    <i class="fas fa-bars"></i>
                </button>
                <span class="navbar-brand">${param.pageTitle}</span>
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
            <jsp:include page="${param.contentPage}" />
        </div>
    </div>

    <!-- Toast Container -->
    <div class="toast-container"></div>

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
            
            // Show Toast Function
            window.showToast = function(message, type = 'info') {
                const toastContainer = document.querySelector('.toast-container');
                
                const toast = document.createElement('div');
                toast.className = 'toast show';
                toast.setAttribute('role', 'alert');
                toast.setAttribute('aria-live', 'assertive');
                toast.setAttribute('aria-atomic', 'true');
                
                let bgClass = 'bg-info text-white';
                let icon = 'info-circle';
                
                switch(type) {
                    case 'success':
                        bgClass = 'bg-success text-white';
                        icon = 'check-circle';
                        break;
                    case 'error':
                        bgClass = 'bg-danger text-white';
                        icon = 'exclamation-circle';
                        break;
                    case 'warning':
                        bgClass = 'bg-warning';
                        icon = 'exclamation-triangle';
                        break;
                }
                
                toast.innerHTML = `
                    <div class="toast-header ${bgClass}">
                        <i class="fas fa-${icon} me-2"></i>
                        <strong class="me-auto">Thông báo</strong>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                    <div class="toast-body">
                        ${message}
                    </div>
                `;
                
                toastContainer.appendChild(toast);
                
                setTimeout(() => {
                    toast.classList.remove('show');
                    setTimeout(() => {
                        toastContainer.removeChild(toast);
                    }, 300);
                }, 5000);
            }
            
            // Check for success message in URL
            const urlParams = new URLSearchParams(window.location.search);
            const successMsg = urlParams.get('success');
            const errorMsg = urlParams.get('error');
            
            if (successMsg) {
                let message = '';
                switch(successMsg) {
                    case 'course_created':
                        message = 'Khóa học đã được tạo thành công!';
                        break;
                    case 'course_updated':
                        message = 'Khóa học đã được cập nhật thành công!';
                        break;
                    case 'profile_updated':
                        message = 'Hồ sơ đã được cập nhật thành công!';
                        break;
                    default:
                        message = 'Thao tác thành công!';
                }
                showToast(message, 'success');
            }
            
            if (errorMsg) {
                let message = '';
                switch(errorMsg) {
                    case 'access_denied':
                        message = 'Bạn không có quyền truy cập trang này!';
                        break;
                    case 'course_not_found':
                        message = 'Không tìm thấy khóa học!';
                        break;
                    default:
                        message = 'Đã xảy ra lỗi!';
                }
                showToast(message, 'error');
            }
        });
    </script>
</body>
</html> 