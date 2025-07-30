<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
    
    List<Course> myCourses = (List<Course>) request.getAttribute("myCourses");
    List<Semester> semesters = (List<Semester>) request.getAttribute("semesters");
    if (myCourses == null) {
        myCourses = new ArrayList<>();
    }
    if (semesters == null) {
        semesters = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Khóa học - LMSS Lecturer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
        
        .course-card {
            transition: transform 0.2s;
            border: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }
        .status-badge {
            font-size: 0.75rem;
            padding: 0.25rem 0.5rem;
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
                <span class="navbar-brand">Quản lý Khóa học</span>
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
                    <h1 class="h2">Quản lý Khóa học</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="<%= request.getContextPath() %>/lecturer/courses/create" class="btn btn-primary">
                            <i class="fas fa-plus me-2"></i>Tạo khóa học mới
                        </a>
                    </div>
                </div>

                <!-- Hiển thị thông báo -->
                <%
                    String message = (String) session.getAttribute("message");
                    String messageType = (String) session.getAttribute("messageType");
                    if (message != null) {
                        session.removeAttribute("message");
                        session.removeAttribute("messageType");
                %>
                    <div class="alert alert-<%= "success".equals(messageType) ? "success" : "danger" %> alert-dismissible fade show" role="alert">
                        <i class="fas fa-<%= "success".equals(messageType) ? "check-circle" : "exclamation-circle" %> me-2"></i><%= message %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>

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

                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="card text-white bg-primary">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h4><%= myCourses.size() %></h4>
                                        <p class="mb-0">Tổng khóa học</p>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-book fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-success">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h4><%= myCourses.stream().filter(c -> c.isActive()).count() %></h4>
                                        <p class="mb-0">Đang hoạt động</p>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-check-circle fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-warning">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h4><%= myCourses.stream().mapToInt(Course::getCredits).sum() %></h4>
                                        <p class="mb-0">Tổng tín chỉ</p>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-graduation-cap fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-info">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h4><%= myCourses.stream().mapToInt(Course::getTotalSessions).sum() %></h4>
                                        <p class="mb-0">Tổng buổi học</p>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-clock fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Search and Filter -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <form action="<%= request.getContextPath() %>/lecturer/courses/search" method="get" class="d-flex">
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-search"></i></span>
                                <input type="text" class="form-control" name="keyword" placeholder="Tìm kiếm khóa học..." 
                                       value="${keyword}">
                                <button type="submit" class="btn btn-outline-secondary">Tìm kiếm</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-3">
                        <form action="<%= request.getContextPath() %>/lecturer/courses/search" method="get" class="d-flex">
                            <select class="form-select" name="semesterId">
                                <option value="">Tất cả học kỳ</option>
                                <% for (Semester semester : semesters) { %>
                                    <option value="<%= semester.getSemesterId() %>" 
                                            ${selectedSemesterId == semester.semesterId ? 'selected' : ''}>
                                        <%= semester.getName() %>
                                    </option>
                                <% } %>
                            </select>
                            <button type="submit" class="btn btn-outline-secondary ms-2">Lọc</button>
                        </form>
                    </div>
                    <div class="col-md-3 text-end">
                        <a href="<%= request.getContextPath() %>/lecturer/courses" class="btn btn-outline-primary">
                            <i class="fas fa-refresh me-2"></i>Làm mới
                        </a>
                    </div>
                </div>

                <!-- Courses Grid -->
                <div class="row">
                    <% if (myCourses.isEmpty()) { %>
                        <div class="col-12">
                            <div class="text-center py-5">
                                <i class="fas fa-book fa-4x text-muted mb-3"></i>
                                <h4 class="text-muted">Chưa có khóa học nào</h4>
                                <p class="text-muted">Bắt đầu tạo khóa học đầu tiên của bạn</p>
                                <a href="<%= request.getContextPath() %>/lecturer/courses/create" class="btn btn-primary">
                                    <i class="fas fa-plus me-2"></i>Tạo khóa học
                                </a>
                            </div>
                        </div>
                    <% } else { %>
                        <% for (Course course : myCourses) { %>
                            <div class="col-md-6 col-lg-4 mb-4">
                                <div class="card course-card h-100">
                                    <div class="card-header bg-transparent">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <div>
                                                <h6 class="card-title mb-1"><%= course.getName() %></h6>
                                                <small class="text-muted"><%= course.getCode() %></small>
                                            </div>
                                            <span class="badge <%= course.isActive() ? "bg-success" : "bg-secondary" %> status-badge">
                                                <%= course.isActive() ? "Đang hoạt động" : "Không hoạt động" %>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <p class="card-text text-muted small">
                                            <%= course.getDescription() != null && !course.getDescription().isEmpty() 
                                                ? course.getDescription().substring(0, Math.min(100, course.getDescription().length())) + "..." 
                                                : "Không có mô tả" %>
                                        </p>
                                        <div class="row text-center mb-3">
                                            <div class="col-4">
                                                <div class="fw-bold text-primary"><%= course.getCredits() %></div>
                                                <small class="text-muted">Tín chỉ</small>
                                            </div>
                                            <div class="col-4">
                                                <div class="fw-bold text-success"><%= course.getMaxStudents() %></div>
                                                <small class="text-muted">Sĩ số</small>
                                            </div>
                                            <div class="col-4">
                                                <div class="fw-bold text-info"><%= course.getTotalSessions() %></div>
                                                <small class="text-muted">Buổi học</small>
                                            </div>
                                        </div>
                                        <div class="mb-2">
                                            <small class="text-muted">
                                                <i class="fas fa-map-marker-alt me-1"></i>
                                                <%= course.getRoom() != null ? course.getRoom() : "Chưa xác định" %>
                                            </small>
                                        </div>
                                        <div class="mb-3">
                                            <small class="text-muted">
                                                <i class="fas fa-clock me-1"></i>
                                                <%= course.getSchedule() != null ? course.getSchedule() : "Chưa xác định" %>
                                            </small>
                                        </div>
                                    </div>
                                    <div class="card-footer bg-transparent">
                                        <div class="btn-group w-100" role="group">
                                            <a href="<%= request.getContextPath() %>/lecturer/courses/view/<%= course.getCourseId() %>" 
                                               class="btn btn-outline-primary btn-sm">
                                                <i class="fas fa-eye me-1"></i>Xem
                                            </a>
                                            <a href="<%= request.getContextPath() %>/lecturer/courses/edit/<%= course.getCourseId() %>" 
                                               class="btn btn-outline-warning btn-sm">
                                                <i class="fas fa-edit me-1"></i>Sửa
                                            </a>
                                            <button type="button" class="btn btn-outline-danger btn-sm delete-btn" 
                                                    data-course-id="<%= course.getCourseId() %>" 
                                                    data-course-name="<%= course.getName() %>">
                                                <i class="fas fa-trash me-1"></i>Xóa
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <% } %>
                    <% } %>
                </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Xác nhận xóa</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xóa khóa học <strong id="courseName"></strong>?</p>
                    <p class="text-danger">Lưu ý: Hành động này không thể hoàn tác và sẽ xóa tất cả dữ liệu liên quan đến khóa học này.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <form id="deleteForm" method="post" action="<%= request.getContextPath() %>/lecturer/courses">
                        <input type="hidden" name="action" value="delete-course">
                        <input type="hidden" name="courseId" id="courseId">
                        <button type="submit" class="btn btn-danger">Xóa</button>
                    </form>
                </div>
            </div>
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
            
            // Delete button functionality
            document.querySelectorAll('.delete-btn').forEach(function(btn) {
                btn.addEventListener('click', function() {
                    var courseId = this.getAttribute('data-course-id');
                    var courseName = this.getAttribute('data-course-name');
                    document.getElementById('courseId').value = courseId;
                    document.getElementById('courseName').textContent = courseName;
                    var deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
                    deleteModal.show();
                });
            });
        });
    </script>
</body>
</html>
