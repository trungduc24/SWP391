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
    
    Map<String, Integer> stats = (Map<String, Integer>) request.getAttribute("stats");
    String reportType = (String) request.getAttribute("reportType");
    if (stats == null) {
        stats = new HashMap<>();
    }
    if (reportType == null) {
        reportType = "dashboard";
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Báo cáo & Thống kê - LMSS Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .report-card {
            transition: transform 0.2s;
            border: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .report-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse">
                <div class="position-sticky pt-3">
                    <div class="text-center mb-4">
                        <h4 class="text-white">LMSS Admin</h4>
                        <p class="text-light">Xin chào, <%= currentUser.getUsername() %></p>
                    </div>
                    
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link text-light" href="<%= request.getContextPath() %>/admin/dashboard">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="<%= request.getContextPath() %>/admin/users">
                                <i class="fas fa-users me-2"></i>Quản lý người dùng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="<%= request.getContextPath() %>/courses">
                                <i class="fas fa-book me-2"></i>Quản lý khóa học
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="<%= request.getContextPath() %>/semesters">
                                <i class="fas fa-calendar me-2"></i>Quản lý học kỳ
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light active" href="<%= request.getContextPath() %>/admin/reports">
                                <i class="fas fa-chart-bar me-2"></i>Báo cáo & Thống kê
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="<%= request.getContextPath() %>/logout">
                                <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Báo cáo & Thống kê</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="window.location.href='<%= request.getContextPath() %>/admin/reports?action=export&format=csv&type=users'">
                                <i class="fas fa-file-csv me-1"></i>Export CSV
                            </button>
                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="window.location.href='<%= request.getContextPath() %>/admin/reports?action=export&format=excel&type=users'">
                                <i class="fas fa-file-excel me-1"></i>Export Excel
                            </button>
                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="window.print()">
                                <i class="fas fa-print me-1"></i>In báo cáo
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Tab Navigation -->
                <ul class="nav nav-tabs mb-4">
                    <li class="nav-item">
                        <a class="nav-link <%= reportType.equals("dashboard") ? "active" : "" %>" 
                           href="<%= request.getContextPath() %>/admin/reports">
                            <i class="fas fa-tachometer-alt me-1"></i>Tổng quan
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= reportType.equals("users") ? "active" : "" %>" 
                           href="<%= request.getContextPath() %>/admin/reports?action=users">
                            <i class="fas fa-users me-1"></i>Người dùng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= reportType.equals("courses") ? "active" : "" %>" 
                           href="<%= request.getContextPath() %>/admin/reports?action=courses">
                            <i class="fas fa-book me-1"></i>Khóa học
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= reportType.equals("grades") ? "active" : "" %>" 
                           href="<%= request.getContextPath() %>/admin/reports?action=grades">
                            <i class="fas fa-graduation-cap me-1"></i>Điểm số
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= reportType.equals("stats") ? "active" : "" %>" 
                           href="<%= request.getContextPath() %>/admin/reports?action=stats">
                            <i class="fas fa-chart-pie me-1"></i>Biểu đồ thống kê
                        </a>
                    </li>
                </ul>

                <!-- Report Content -->
                <div class="report-content">
                    <c:choose>
                        <c:when test="${reportType eq 'users'}">
                            <!-- User Reports -->
                            <div class="user-reports">
                                <div class="row mb-4">
                                    <div class="col-md-3">
                                        <div class="card bg-primary text-white">
                                            <div class="card-body">
                                                <h5 class="card-title">Tổng người dùng</h5>
                                                <h2 class="mb-0">${userStats.totalUsers}</h2>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="card bg-success text-white">
                                            <div class="card-body">
                                                <h5 class="card-title">Sinh viên</h5>
                                                <h2 class="mb-0">${userStats.studentCount}</h2>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="card bg-info text-white">
                                            <div class="card-body">
                                                <h5 class="card-title">Giảng viên</h5>
                                                <h2 class="mb-0">${userStats.lecturerCount}</h2>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="card bg-dark text-white">
                                            <div class="card-body">
                                                <h5 class="card-title">Admin</h5>
                                                <h2 class="mb-0">${userStats.adminCount}</h2>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- User List -->
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <h5>Danh sách người dùng</h5>
                                    </div>
                                    <div class="card-body">
                                        <table class="table table-striped table-hover">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Username</th>
                                                    <th>Email</th>
                                                    <th>Vai trò</th>
                                                    <th>Trạng thái</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="user" items="${users}">
                                                    <tr>
                                                        <td>${user.userId}</td>
                                                        <td>${user.username}</td>
                                                        <td>${user.email}</td>
                                                        <td>${user.role}</td>
                                                        <td>
                                                            <c:if test="${user.emailVerified}">
                                                                <span class="badge bg-success">Đã xác thực</span>
                                                            </c:if>
                                                            <c:if test="${!user.emailVerified}">
                                                                <span class="badge bg-warning">Chưa xác thực</span>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                
                                <!-- User Graph -->
                                <div class="card">
                                    <div class="card-header">
                                        <h5>Biểu đồ phân bố người dùng</h5>
                                    </div>
                                    <div class="card-body">
                                        <canvas id="userDistributionChart"></canvas>
                                    </div>
                                </div>
                                
                                <script>
                                    // Render user distribution chart
                                    const userCtx = document.getElementById('userDistributionChart').getContext('2d');
                                    const userChart = new Chart(userCtx, {
                                        type: 'pie',
                                        data: {
                                            labels: ['Sinh viên', 'Giảng viên', 'Admin'],
                                            datasets: [{
                                                data: [
                                                    ${userStats.studentCount}, 
                                                    ${userStats.lecturerCount}, 
                                                    ${userStats.adminCount}
                                                ],
                                                backgroundColor: [
                                                    '#28a745',
                                                    '#17a2b8',
                                                    '#343a40'
                                                ]
                                            }]
                                        }
                                    });
                                </script>
                            </div>
                        </c:when>
                        
                        <c:when test="${reportType eq 'courses'}">
                            <!-- Course Reports -->
                            <div class="course-reports">
                                <div class="row mb-4">
                                    <div class="col-md-4">
                                        <div class="card bg-primary text-white">
                                            <div class="card-body">
                                                <h5 class="card-title">Tổng số khóa học</h5>
                                                <h2 class="mb-0">${courseStats.totalCourses}</h2>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="card bg-success text-white">
                                            <div class="card-body">
                                                <h5 class="card-title">Khóa học đang hoạt động</h5>
                                                <h2 class="mb-0">${courseStats.activeCourses}</h2>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="card bg-secondary text-white">
                                            <div class="card-body">
                                                <h5 class="card-title">Khóa học không hoạt động</h5>
                                                <h2 class="mb-0">${courseStats.inactiveCourses}</h2>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Course List -->
                                <div class="card">
                                    <div class="card-header">
                                        <h5>Danh sách khóa học</h5>
                                    </div>
                                    <div class="card-body">
                                        <table class="table table-striped table-hover">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Tên khóa học</th>
                                                    <th>Mã khóa học</th>
                                                    <th>Phòng học</th>
                                                    <th>Học kỳ</th>
                                                    <th>Trạng thái</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="course" items="${courses}">
                                                    <tr>
                                                        <td>${course.courseId}</td>
                                                        <td>${course.name}</td>
                                                        <td>${course.code}</td>
                                                        <td>${course.room}</td>
                                                        <td>${course.semesterId}</td>
                                                        <td>
                                                            <c:if test="${course.active}">
                                                                <span class="badge bg-success">Hoạt động</span>
                                                            </c:if>
                                                            <c:if test="${!course.active}">
                                                                <span class="badge bg-secondary">Không hoạt động</span>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        
                        <c:when test="${reportType eq 'grades'}">
                            <!-- Grade Reports -->
                            <div class="grade-reports">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <h5>Phân bố điểm số</h5>
                                    </div>
                                    <div class="card-body">
                                        <canvas id="gradeDistributionChart"></canvas>
                                    </div>
                                </div>
                                
                                <script>
                                    // Render grade distribution chart
                                    const gradeCtx = document.getElementById('gradeDistributionChart').getContext('2d');
                                    const gradeChart = new Chart(gradeCtx, {
                                        type: 'bar',
                                        data: {
                                            labels: [
                                                'A (8.5-10.0)', 
                                                'B (7.0-8.4)', 
                                                'C (5.5-6.9)', 
                                                'D (4.0-5.4)', 
                                                'F (0-3.9)'
                                            ],
                                            datasets: [{
                                                label: 'Số lượng sinh viên',
                                                data: [
                                                    ${gradeDistribution['A (8.5-10.0)']}, 
                                                    ${gradeDistribution['B (7.0-8.4)']}, 
                                                    ${gradeDistribution['C (5.5-6.9)']}, 
                                                    ${gradeDistribution['D (4.0-5.4)']}, 
                                                    ${gradeDistribution['F (0-3.9)']}
                                                ],
                                                backgroundColor: [
                                                    '#28a745',
                                                    '#20c997',
                                                    '#ffc107',
                                                    '#fd7e14',
                                                    '#dc3545'
                                                ]
                                            }]
                                        },
                                        options: {
                                            scales: {
                                                y: {
                                                    beginAtZero: true
                                                }
                                            }
                                        }
                                    });
                                </script>
                            </div>
                        </c:when>
                        
                        <c:when test="${reportType eq 'stats'}">
                            <!-- Statistics Dashboard -->
                            <div class="stats-dashboard">
                                <div class="row">
                                    <div class="col-md-6 mb-4">
                                        <div class="card">
                                            <div class="card-header">
                                                <h5>Phân bố người dùng</h5>
                                            </div>
                                            <div class="card-body">
                                                <canvas id="userPieChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-4">
                                        <div class="card">
                                            <div class="card-header">
                                                <h5>Phân bố khóa học</h5>
                                            </div>
                                            <div class="card-body">
                                                <canvas id="coursePieChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <h5>Phân bố điểm số</h5>
                                    </div>
                                    <div class="card-body">
                                        <canvas id="gradeBarChart"></canvas>
                                    </div>
                                </div>
                                
                                <script>
                                    // User distribution pie chart
                                    const userPieCtx = document.getElementById('userPieChart').getContext('2d');
                                    const userPieChart = new Chart(userPieCtx, {
                                        type: 'pie',
                                        data: {
                                            labels: ['Sinh viên', 'Giảng viên', 'Admin'],
                                            datasets: [{
                                                data: [
                                                    ${statistics.studentCount}, 
                                                    ${statistics.lecturerCount}, 
                                                    ${statistics.totalUsers - statistics.studentCount - statistics.lecturerCount}
                                                ],
                                                backgroundColor: [
                                                    '#28a745',
                                                    '#17a2b8',
                                                    '#343a40'
                                                ]
                                            }]
                                        }
                                    });
                                    
                                    // Course distribution pie chart
                                    const coursePieCtx = document.getElementById('coursePieChart').getContext('2d');
                                    const coursePieChart = new Chart(coursePieCtx, {
                                        type: 'pie',
                                        data: {
                                            labels: ['Hoạt động', 'Không hoạt động'],
                                            datasets: [{
                                                data: [
                                                    ${statistics.activeCourses}, 
                                                    ${statistics.totalCourses - statistics.activeCourses}
                                                ],
                                                backgroundColor: [
                                                    '#28a745',
                                                    '#6c757d'
                                                ]
                                            }]
                                        }
                                    });
                                    
                                    // Grade distribution bar chart
                                    const gradeBarCtx = document.getElementById('gradeBarChart').getContext('2d');
                                    const gradeLabels = [];
                                    const gradeData = [];
                                    
                                    <c:forEach var="entry" items="${statistics.gradeDistribution}">
                                        gradeLabels.push("${entry.key}");
                                        gradeData.push(${entry.value});
                                    </c:forEach>
                                    
                                    const gradeBarChart = new Chart(gradeBarCtx, {
                                        type: 'bar',
                                        data: {
                                            labels: gradeLabels,
                                            datasets: [{
                                                label: 'Số lượng sinh viên',
                                                data: gradeData,
                                                backgroundColor: [
                                                    '#28a745',
                                                    '#20c997',
                                                    '#ffc107',
                                                    '#fd7e14',
                                                    '#dc3545'
                                                ]
                                            }]
                                        },
                                        options: {
                                            scales: {
                                                y: {
                                                    beginAtZero: true
                                                }
                                            }
                                        }
                                    });
                                </script>
                            </div>
                        </c:when>
                        
                        <c:otherwise>
                            <!-- Dashboard Overview -->
                            <div class="dashboard-overview">
                                <!-- Statistics Cards -->
                                <div class="row mb-4">
                                    <div class="col-md-3">
                                        <div class="card bg-primary text-white">
                                            <div class="card-body">
                                                <h5 class="card-title">Tổng số sinh viên</h5>
                                                <h2 class="mb-0">${stats.studentCount}</h2>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="card bg-info text-white">
                                            <div class="card-body">
                                                <h5 class="card-title">Tổng số giảng viên</h5>
                                                <h2 class="mb-0">${stats.lecturerCount}</h2>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="card bg-success text-white">
                                            <div class="card-body">
                                                <h5 class="card-title">Tổng số khóa học</h5>
                                                <h2 class="mb-0">${stats.courseCount}</h2>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="card bg-warning text-white">
                                            <div class="card-body">
                                                <h5 class="card-title">Học kỳ hoạt động</h5>
                                                <h2 class="mb-0">${stats.activeSemesterCount}</h2>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Quick Links -->
                                <div class="row mb-4">
                                    <div class="col-md-6">
                                        <div class="card report-card h-100">
                                            <div class="card-header bg-primary text-white">
                                                <h5 class="mb-0">Báo cáo người dùng</h5>
                                            </div>
                                            <div class="card-body">
                                                <p>Xem thống kê chi tiết về người dùng trong hệ thống, bao gồm sinh viên, giảng viên và quản trị viên.</p>
                                                <a href="<%= request.getContextPath() %>/admin/reports?action=users" class="btn btn-primary">
                                                    <i class="fas fa-users me-1"></i>Xem báo cáo
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="card report-card h-100">
                                            <div class="card-header bg-success text-white">
                                                <h5 class="mb-0">Báo cáo khóa học</h5>
                                            </div>
                                            <div class="card-body">
                                                <p>Xem thống kê chi tiết về các khóa học, tình trạng hoạt động và phân bố theo học kỳ.</p>
                                                <a href="<%= request.getContextPath() %>/admin/reports?action=courses" class="btn btn-success">
                                                    <i class="fas fa-book me-1"></i>Xem báo cáo
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row mb-4">
                                    <div class="col-md-6">
                                        <div class="card report-card h-100">
                                            <div class="card-header bg-info text-white">
                                                <h5 class="mb-0">Báo cáo điểm số</h5>
                                            </div>
                                            <div class="card-body">
                                                <p>Xem thống kê chi tiết về điểm số sinh viên, phân bố điểm và kết quả học tập.</p>
                                                <a href="<%= request.getContextPath() %>/admin/reports?action=grades" class="btn btn-info">
                                                    <i class="fas fa-graduation-cap me-1"></i>Xem báo cáo
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="card report-card h-100">
                                            <div class="card-header bg-warning text-white">
                                                <h5 class="mb-0">Biểu đồ thống kê</h5>
                                            </div>
                                            <div class="card-body">
                                                <p>Xem biểu đồ thống kê tổng quan về người dùng, khóa học và điểm số.</p>
                                                <a href="<%= request.getContextPath() %>/admin/reports?action=stats" class="btn btn-warning">
                                                    <i class="fas fa-chart-pie me-1"></i>Xem biểu đồ
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Export Options -->
                                <div class="card">
                                    <div class="card-header">
                                        <h5>Xuất dữ liệu</h5>
                                    </div>
                                    <div class="card-body">
                                        <p>Xuất báo cáo ra định dạng CSV hoặc Excel để sử dụng bên ngoài hệ thống.</p>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="card mb-3">
                                                    <div class="card-header">Báo cáo người dùng</div>
                                                    <div class="card-body">
                                                        <div class="d-grid gap-2">
                                                            <a href="<%= request.getContextPath() %>/admin/reports?action=export&format=csv&type=users" class="btn btn-outline-primary btn-sm">
                                                                <i class="fas fa-file-csv me-1"></i>CSV
                                                            </a>
                                                            <a href="<%= request.getContextPath() %>/admin/reports?action=export&format=excel&type=users" class="btn btn-outline-success btn-sm">
                                                                <i class="fas fa-file-excel me-1"></i>Excel
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="card mb-3">
                                                    <div class="card-header">Báo cáo khóa học</div>
                                                    <div class="card-body">
                                                        <div class="d-grid gap-2">
                                                            <a href="<%= request.getContextPath() %>/admin/reports?action=export&format=csv&type=courses" class="btn btn-outline-primary btn-sm">
                                                                <i class="fas fa-file-csv me-1"></i>CSV
                                                            </a>
                                                            <a href="<%= request.getContextPath() %>/admin/reports?action=export&format=excel&type=courses" class="btn btn-outline-success btn-sm">
                                                                <i class="fas fa-file-excel me-1"></i>Excel
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="card mb-3">
                                                    <div class="card-header">Báo cáo điểm số</div>
                                                    <div class="card-body">
                                                        <div class="d-grid gap-2">
                                                            <a href="<%= request.getContextPath() %>/admin/reports?action=export&format=csv&type=grades" class="btn btn-outline-primary btn-sm">
                                                                <i class="fas fa-file-csv me-1"></i>CSV
                                                            </a>
                                                            <a href="<%= request.getContextPath() %>/admin/reports?action=export&format=excel&type=grades" class="btn btn-outline-success btn-sm">
                                                                <i class="fas fa-file-excel me-1"></i>Excel
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 