<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
    
    Course course = (Course) request.getAttribute("course");
    Semester semester = (Semester) request.getAttribute("semester");
    List<Student> enrolledStudents = (List<Student>) request.getAttribute("enrolledStudents");
    if (course == null) {
        response.sendRedirect(request.getContextPath() + "/lecturer/courses");
        return;
    }
    if (enrolledStudents == null) {
        enrolledStudents = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Khóa học - LMSS Lecturer</title>
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
        
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
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
                <span class="navbar-brand">Chi tiết Khóa học</span>
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
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2><i class="fas fa-book"></i> <%= course.getName() %></h2>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="<%= request.getContextPath() %>/lecturer/dashboard">Dashboard</a></li>
                                <li class="breadcrumb-item"><a href="<%= request.getContextPath() %>/lecturer/courses">Quản lý khóa học</a></li>
                                <li class="breadcrumb-item active">Chi tiết khóa học</li>
                            </ol>
                        </nav>
                    </div>
                    <div class="btn-group">
                        <a href="<%= request.getContextPath() %>/lecturer/courses" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Quay lại
                        </a>
                        <a href="<%= request.getContextPath() %>/lecturer/courses/edit/<%= course.getCourseId() %>" class="btn btn-warning">
                            <i class="fas fa-edit"></i> Chỉnh sửa
                        </a>
                    </div>
                </div>

                <!-- Course Status -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <span class="badge <%= course.isActive() ? "bg-success" : "bg-secondary" %> status-badge">
                                            <i class="fas <%= course.isActive() ? "fa-check-circle" : "fa-pause-circle" %> me-1"></i>
                                            <%= course.isActive() ? "Đang hoạt động" : "Không hoạt động" %>
                                        </span>
                                        <span class="badge bg-info status-badge ms-2">
                                            <i class="fas fa-calendar-alt me-1"></i>
                                            <%= semester != null ? semester.getName() : "N/A" %>
                                        </span>
                                    </div>
                                    <div>
                                        <button type="button" class="btn btn-sm btn-danger delete-btn" 
                                                data-course-id="<%= course.getCourseId() %>" 
                                                data-course-name="<%= course.getName() %>">
                                            <i class="fas fa-trash me-2"></i>Xóa khóa học
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <!-- Course Information -->
                    <div class="col-md-8">
                        <div class="card mb-4">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Thông tin khóa học</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <div class="info-label">ID khóa học</div>
                                        <div class="info-value">#<%= course.getCourseId() %></div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div class="info-label">Mã khóa học</div>
                                        <div class="info-value"><%= course.getCode() %></div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div class="info-label">Tên khóa học</div>
                                        <div class="info-value"><%= course.getName() %></div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div class="info-label">Phòng học</div>
                                        <div class="info-value"><%= course.getRoom() != null ? course.getRoom() : "Chưa xác định" %></div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div class="info-label">Số tín chỉ</div>
                                        <div class="info-value"><%= course.getCredits() %></div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div class="info-label">Số sinh viên tối đa</div>
                                        <div class="info-value"><%= course.getMaxStudents() > 0 ? course.getMaxStudents() : "Không giới hạn" %></div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div class="info-label">Lịch học</div>
                                        <div class="info-value"><%= course.getSchedule() != null ? course.getSchedule() : "Chưa xác định" %></div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div class="info-label">Số sinh viên đã đăng ký</div>
                                        <div class="info-value"><%= enrolledStudents.size() %> sinh viên</div>
                                    </div>
                                </div>
                                
                                <% if (course.getDescription() != null && !course.getDescription().isEmpty()) { %>
                                    <div class="mb-3">
                                        <div class="info-label">Mô tả khóa học</div>
                                        <div class="mt-2"><%= course.getDescription() %></div>
                                    </div>
                                <% } %>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Actions -->
                    <div class="col-md-4">
                        <div class="card mb-4">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-bolt me-2"></i>Thao tác nhanh</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                                    <a href="<%= request.getContextPath() %>/lecturer/courses/edit/<%= course.getCourseId() %>" class="btn btn-warning">
                                        <i class="fas fa-edit me-2"></i>Chỉnh sửa khóa học
                                    </a>
                                    <a href="<%= request.getContextPath() %>/lecturer/tests?courseId=<%= course.getCourseId() %>" class="btn btn-info">
                                        <i class="fas fa-clipboard-list me-2"></i>Quản lý bài kiểm tra
                                    </a>
                                    <a href="<%= request.getContextPath() %>/lecturer/grades?courseId=<%= course.getCourseId() %>" class="btn btn-success">
                                        <i class="fas fa-chart-line me-2"></i>Chấm điểm
                                    </a>
                                    <a href="<%= request.getContextPath() %>/lecturer/materials?courseId=<%= course.getCourseId() %>" class="btn btn-secondary">
                                        <i class="fas fa-folder me-2"></i>Tài liệu khóa học
                                    </a>
                                    <a href="<%= request.getContextPath() %>/lecturer/students/course/<%= course.getCourseId() %>" class="btn btn-dark">
                                        <i class="fas fa-users me-2"></i>Danh sách sinh viên
                                    </a>
                                    <a href="<%= request.getContextPath() %>/lecturer/announcements?courseId=<%= course.getCourseId() %>" class="btn btn-primary">
                                        <i class="fas fa-bullhorn me-2"></i>Thông báo
                                    </a>
                                </div>
                            </div>
                        </div>

                        <!-- Statistics -->
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-chart-bar me-2"></i>Thống kê</h5>
                            </div>
                            <div class="card-body">
                                <div class="row text-center">
                                    <div class="col-6 mb-3">
                                        <div class="fw-bold text-muted">Sinh viên đăng ký</div>
                                        <div class="fs-4 text-primary"><%= enrolledStudents.size() %></div>
                                    </div>
                                    <div class="col-6 mb-3">
                                        <div class="fw-bold text-muted">Bài kiểm tra</div>
                                        <div class="fs-4 text-info">0</div>
                                    </div>
                                    <div class="col-6 mb-3">
                                        <div class="fw-bold text-muted">Tài liệu</div>
                                        <div class="fs-4 text-success">0</div>
                                    </div>
                                    <div class="col-6 mb-3">
                                        <div class="fw-bold text-muted">Thông báo</div>
                                        <div class="fs-4 text-warning">0</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
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
