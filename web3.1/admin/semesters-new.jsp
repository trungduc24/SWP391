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
    <title>Quản lý Học kỳ - LMSS Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .semester-card {
            transition: transform 0.2s;
            border: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .semester-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }
        .status-badge {
            font-size: 0.75rem;
            padding: 0.25rem 0.5rem;
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
                            <a class="nav-link text-light" href="<%= request.getContextPath() %>/admin/users.jsp">
                                <i class="fas fa-users me-2"></i>Quản lý người dùng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="<%= request.getContextPath() %>/courses">
                                <i class="fas fa-book me-2"></i>Quản lý khóa học
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light active" href="<%= request.getContextPath() %>/semesters">
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
            </nav>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Quản lý Học kỳ</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createSemesterModal">
                            <i class="fas fa-plus me-2"></i>Tạo học kỳ mới
                        </button>
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

                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="card text-white bg-primary">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h4><%= semesters.size() %></h4>
                                        <p class="mb-0">Tổng học kỳ</p>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-calendar fa-2x"></i>
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
                                        <h4><%= semesters.stream().mapToInt(s -> s.isActive() ? 1 : 0).sum() %></h4>
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
                                        <h4><%= semesters.stream().mapToInt(s -> !s.isActive() ? 1 : 0).sum() %></h4>
                                        <p class="mb-0">Không hoạt động</p>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-pause-circle fa-2x"></i>
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
                                        <h4><%= java.time.LocalDate.now().getYear() %></h4>
                                        <p class="mb-0">Năm hiện tại</p>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-calendar-alt fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Semesters Grid -->
                <div class="row" id="semestersContainer">
                    <% if (semesters.isEmpty()) { %>
                        <div class="col-12">
                            <div class="text-center py-5">
                                <i class="fas fa-calendar fa-3x text-muted mb-3"></i>
                                <h4 class="text-muted">Chưa có học kỳ nào</h4>
                                <p class="text-muted">Hãy tạo học kỳ đầu tiên của bạn!</p>
                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createSemesterModal">
                                    <i class="fas fa-plus me-2"></i>Tạo học kỳ mới
                                </button>
                            </div>
                        </div>
                    <% } else { %>
                        <% for (Semester semester : semesters) { %>
                            <div class="col-md-6 col-lg-4 mb-4">
                                <div class="card semester-card h-100">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <h6 class="mb-0 text-primary"><%= semester.getCode() %></h6>
                                        <span class="badge <%= semester.isActive() ? "bg-success" : "bg-secondary" %> status-badge">
                                            <%= semester.isActive() ? "Hoạt động" : "Không hoạt động" %>
                                        </span>
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title"><%= semester.getName() %></h5>
                                        <div class="row text-center">
                                            <div class="col-6">
                                                <small class="text-muted">Ngày bắt đầu</small>
                                                <div class="fw-bold"><%= semester.getStartDate() %></div>
                                            </div>
                                            <div class="col-6">
                                                <small class="text-muted">Ngày kết thúc</small>
                                                <div class="fw-bold"><%= semester.getEndDate() %></div>
                                            </div>
                                        </div>
                                        <% if (semester.getCreatedAt() != null) { %>
                                            <div class="mt-2">
                                                <small class="text-muted">
                                                    <i class="fas fa-clock me-1"></i>
                                                    Tạo: <%= semester.getCreatedAt() %>
                                                </small>
                                            </div>
                                        <% } %>
                                    </div>
                                    <div class="card-footer bg-transparent">
                                        <div class="btn-group w-100" role="group">
                                            <button type="button" class="btn btn-outline-warning btn-sm" 
                                                    onclick="editSemester(<%= semester.getSemesterId() %>)">
                                                <i class="fas fa-edit"></i> Sửa
                                            </button>
                                            <button type="button" class="btn btn-outline-danger btn-sm" 
                                                    onclick="deleteSemester(<%= semester.getSemesterId() %>, '<%= semester.getName() %>')">
                                                <i class="fas fa-trash"></i> Xóa
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <% } %>
                    <% } %>
                </div>
            </main>
        </div>
    </div>

    <!-- Create Semester Modal -->
    <div class="modal fade" id="createSemesterModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Tạo học kỳ mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="<%= request.getContextPath() %>/semesters" method="post" id="createSemesterForm">
                    <input type="hidden" name="action" value="create">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="semesterName" class="form-label">Tên học kỳ *</label>
                                    <input type="text" class="form-control" id="semesterName" name="name" required
                                           placeholder="VD: Học kỳ 1 năm 2024-2025">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="semesterCode" class="form-label">Mã học kỳ *</label>
                                    <input type="text" class="form-control" id="semesterCode" name="code" required
                                           placeholder="VD: HK1_2024-2025">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="startDate" class="form-label">Ngày bắt đầu *</label>
                                    <input type="date" class="form-control" id="startDate" name="startDate" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="endDate" class="form-label">Ngày kết thúc *</label>
                                    <input type="date" class="form-control" id="endDate" name="endDate" required>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="isActive" name="isActive" checked>
                                <label class="form-check-label" for="isActive">
                                    Học kỳ đang hoạt động
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Tạo học kỳ</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Validate form
        document.getElementById('createSemesterForm').addEventListener('submit', function(e) {
            const startDate = document.getElementById('startDate').value;
            const endDate = document.getElementById('endDate').value;
            
            if (startDate && endDate && new Date(endDate) <= new Date(startDate)) {
                e.preventDefault();
                alert('Ngày kết thúc phải sau ngày bắt đầu!');
                return false;
            }
        });

        // Auto-generate semester code based on name
        document.getElementById('semesterName').addEventListener('input', function() {
            const name = this.value;
            const codeField = document.getElementById('semesterCode');
            
            if (name && !codeField.value) {
                // Generate code from name
                let code = name.replace(/\s+/g, '_').toUpperCase();
                codeField.value = code;
            }
        });

        function editSemester(semesterId) {
            window.location.href = '<%= request.getContextPath() %>/semesters?action=edit&id=' + semesterId;
        }

        function deleteSemester(semesterId, semesterName) {
            if (confirm(`Bạn có chắc chắn muốn xóa học kỳ "${semesterName}"?`)) {
                fetch('<%= request.getContextPath() %>/semesters', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'action=delete&semesterId=' + semesterId
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        location.reload();
                    } else {
                        alert('Lỗi: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Có lỗi xảy ra khi xóa học kỳ!');
                });
            }
        }
    </script>
</body>
</html>
