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
    
    Map<String, Object> statistics = (Map<String, Object>) request.getAttribute("statistics");
    if (statistics == null) {
        statistics = new HashMap<>();
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê - LMSS Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .chart-container {
            position: relative;
            margin: auto;
            height: 300px;
        }
        .stats-card {
            transition: transform 0.2s;
            border: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .stats-card:hover {
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
                            <a class="nav-link text-light" href="<%= request.getContextPath() %>/admin/reports">
                                <i class="fas fa-chart-bar me-2"></i>Báo cáo & Thống kê
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light active" href="<%= request.getContextPath() %>/admin/reports?action=stats">
                                <i class="fas fa-chart-pie me-2"></i>Biểu đồ thống kê
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
                    <h1 class="h2">Biểu đồ thống kê</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <button type="button" class="btn btn-sm btn-outline-secondary" onclick="window.print()">
                            <i class="fas fa-print me-1"></i>In biểu đồ
                        </button>
                    </div>
                </div>

                <!-- Tổng quan thống kê -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="card stats-card bg-primary text-white h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h3 class="mb-0">${statistics.totalUsers}</h3>
                                        <p class="mb-0">Tổng người dùng</p>
                                    </div>
                                    <div>
                                        <i class="fas fa-users fa-3x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stats-card bg-success text-white h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h3 class="mb-0">${statistics.totalCourses}</h3>
                                        <p class="mb-0">Tổng khóa học</p>
                                    </div>
                                    <div>
                                        <i class="fas fa-book fa-3x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stats-card bg-warning text-white h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h3 class="mb-0">${statistics.studentCount}</h3>
                                        <p class="mb-0">Tổng sinh viên</p>
                                    </div>
                                    <div>
                                        <i class="fas fa-user-graduate fa-3x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stats-card bg-info text-white h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h3 class="mb-0">${statistics.lecturerCount}</h3>
                                        <p class="mb-0">Tổng giảng viên</p>
                                    </div>
                                    <div>
                                        <i class="fas fa-chalkboard-teacher fa-3x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Các biểu đồ thống kê -->
                <div class="row mb-4">
                    <!-- Biểu đồ phân bố người dùng -->
                    <div class="col-md-6 mb-4">
                        <div class="card stats-card h-100">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0">Phân bố người dùng</h5>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="userPieChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Biểu đồ phân bố khóa học -->
                    <div class="col-md-6 mb-4">
                        <div class="card stats-card h-100">
                            <div class="card-header bg-success text-white">
                                <h5 class="mb-0">Trạng thái khóa học</h5>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="coursePieChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Biểu đồ phân bố điểm -->
                <div class="card stats-card mb-4">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0">Phân bố điểm số</h5>
                    </div>
                    <div class="card-body">
                        <div class="chart-container">
                            <canvas id="gradeBarChart"></canvas>
                        </div>
                    </div>
                </div>
                
                <!-- Biểu đồ thống kê theo thời gian -->
                <div class="card stats-card">
                    <div class="card-header bg-warning text-white">
                        <h5 class="mb-0">Thống kê theo thời gian</h5>
                    </div>
                    <div class="card-body">
                        <div class="chart-container">
                            <canvas id="timelineChart"></canvas>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Biểu đồ phân bố người dùng
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
                        '#28a745', // Xanh lá
                        '#17a2b8', // Xanh dương
                        '#6f42c1'  // Tím
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false
            }
        });
        
        // Biểu đồ trạng thái khóa học
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
                        '#28a745', // Xanh lá
                        '#6c757d'  // Xám
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false
            }
        });
        
        // Biểu đồ phân bố điểm
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
                labels: gradeLabels.length > 0 ? gradeLabels : ['A (8.5-10.0)', 'B (7.0-8.4)', 'C (5.5-6.9)', 'D (4.0-5.4)', 'F (0-3.9)'],
                datasets: [{
                    label: 'Số lượng sinh viên',
                    data: gradeData.length > 0 ? gradeData : [0, 0, 0, 0, 0],
                    backgroundColor: [
                        '#28a745', // Xanh lá
                        '#20c997', // Ngọc
                        '#ffc107', // Vàng
                        '#fd7e14', // Cam
                        '#dc3545'  // Đỏ
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
        
        // Biểu đồ thống kê theo thời gian
        const timelineCtx = document.getElementById('timelineChart').getContext('2d');
        const months = ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'];
        const timelineChart = new Chart(timelineCtx, {
            type: 'line',
            data: {
                labels: months,
                datasets: [
                    {
                        label: 'Sinh viên mới',
                        data: [5, 8, 12, 15, 10, 7, 20, 25, 18, 15, 12, 10],
                        borderColor: '#28a745',
                        backgroundColor: 'rgba(40, 167, 69, 0.2)',
                        fill: true,
                        tension: 0.4
                    },
                    {
                        label: 'Khóa học mới',
                        data: [2, 5, 8, 10, 7, 5, 12, 15, 10, 8, 6, 4],
                        borderColor: '#17a2b8',
                        backgroundColor: 'rgba(23, 162, 184, 0.2)',
                        fill: true,
                        tension: 0.4
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</body>
</html> 