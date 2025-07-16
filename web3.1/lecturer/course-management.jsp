<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Course" %>
<%@ page import="model.Semester" %>
<%@ page import="model.Lecturer" %>
<%@ page import="model.User" %>

<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"lecturer".equals(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Course> courses = (List<Course>) request.getAttribute("courses");
    List<Semester> semesters = (List<Semester>) request.getAttribute("semesters");
    Lecturer lecturer = (Lecturer) request.getAttribute("lecturer");
    
    String successMessage = (String) session.getAttribute("success");
    String errorMessage = (String) session.getAttribute("error");
    session.removeAttribute("success");
    session.removeAttribute("error");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Khóa học - LMSS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .course-card {
            border-left: 4px solid #28a745;
            transition: transform 0.2s;
        }
        .course-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .status-active {
            color: #28a745;
        }
        .status-inactive {
            color: #dc3545;
        }
        .action-buttons .btn {
            margin: 0 2px;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/lecturer">
                <i class="fas fa-graduation-cap me-2"></i>LMSS - Lecturer
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="${pageContext.request.contextPath}/lecturer">
                    <i class="fas fa-home me-1"></i>Dashboard
                </a>
                <a class="nav-link active" href="${pageContext.request.contextPath}/lecturer/course-management">
                    <i class="fas fa-book me-1"></i>Quản lý Khóa học
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                    <i class="fas fa-sign-out-alt me-1"></i>Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <!-- Header -->
        <div class="row mb-4">
            <div class="col-md-8">
                <h2><i class="fas fa-book me-2"></i>Quản lý Khóa học</h2>
                <p class="text-muted">Quản lý tất cả khóa học của bạn</p>
            </div>
            <div class="col-md-4 text-end">
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createCourseModal">
                    <i class="fas fa-plus me-2"></i>Tạo khóa học mới
                </button>
            </div>
        </div>

        <!-- Success/Error Messages -->
        <% if (successMessage != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle me-2"></i><%= successMessage %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } %>
        
        <% if (errorMessage != null) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-circle me-2"></i><%= errorMessage %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } %>

        <!-- Course Statistics -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="card bg-primary text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h4><%= courses != null ? courses.size() : 0 %></h4>
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
                <div class="card bg-success text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h4><%= courses != null ? courses.stream().mapToInt(c -> c.isActive() ? 1 : 0).sum() : 0 %></h4>
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
                <div class="card bg-warning text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h4><%= courses != null ? courses.stream().mapToInt(c -> !c.isActive() ? 1 : 0).sum() : 0 %></h4>
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
                <div class="card bg-info text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h4><%= courses != null ? courses.stream().mapToInt(Course::getMaxStudents).sum() : 0 %></h4>
                                <p class="mb-0">Tổng chỗ ngồi</p>
                            </div>
                            <div class="align-self-center">
                                <i class="fas fa-users fa-2x"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Course List -->
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0"><i class="fas fa-list me-2"></i>Danh sách Khóa học</h5>
            </div>
            <div class="card-body">
                <% if (courses == null || courses.isEmpty()) { %>
                <div class="text-center py-5">
                    <i class="fas fa-book fa-4x text-muted mb-4"></i>
                    <h4 class="text-muted">Chưa có khóa học nào</h4>
                    <p class="text-muted">Hãy tạo khóa học đầu tiên của bạn</p>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createCourseModal">
                        <i class="fas fa-plus me-2"></i>Tạo khóa học mới
                    </button>
                </div>
                <% } else { %>
                <div class="row">
                    <% for (Course course : courses) { %>
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="card course-card h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <h5 class="card-title mb-0"><%= course.getName() %></h5>
                                    <span class="badge bg-<%= course.isActive() ? "success" : "secondary" %>">
                                        <%= course.isActive() ? "Hoạt động" : "Tạm dừng" %>
                                    </span>
                                </div>
                                <p class="text-muted small mb-2"><strong>Mã:</strong> <%= course.getCode() %></p>
                                <p class="card-text small mb-2"><%= course.getDescription() != null && !course.getDescription().isEmpty() ? course.getDescription() : "Không có mô tả" %></p>
                                
                                <div class="row text-center small mb-3">
                                    <div class="col-4">
                                        <i class="fas fa-credit-card text-primary"></i><br>
                                        <strong><%= course.getCredits() %></strong><br>
                                        <small class="text-muted">Tín chỉ</small>
                                    </div>
                                    <div class="col-4">
                                        <i class="fas fa-users text-success"></i><br>
                                        <strong><%= course.getMaxStudents() %></strong><br>
                                        <small class="text-muted">Sinh viên</small>
                                    </div>
                                    <div class="col-4">
                                        <i class="fas fa-calendar text-warning"></i><br>
                                        <strong><%= course.getTotalSessions() %></strong><br>
                                        <small class="text-muted">Buổi học</small>
                                    </div>
                                </div>

                                <% if (course.getRoom() != null && !course.getRoom().isEmpty()) { %>
                                <p class="small mb-2"><i class="fas fa-map-marker-alt text-danger me-1"></i><%= course.getRoom() %></p>
                                <% } %>
                                
                                <% if (course.getSchedule() != null && !course.getSchedule().isEmpty()) { %>
                                <p class="small mb-3"><i class="fas fa-clock text-info me-1"></i><%= course.getSchedule() %></p>
                                <% } %>

                                <div class="action-buttons d-flex justify-content-between">
                                    <a href="${pageContext.request.contextPath}/lecturer/course-management?action=view&id=<%= course.getCourseId() %>" 
                                       class="btn btn-sm btn-outline-primary">
                                        <i class="fas fa-eye"></i> Xem
                                    </a>
                                    <a href="${pageContext.request.contextPath}/lecturer/course-management?action=edit&id=<%= course.getCourseId() %>" 
                                       class="btn btn-sm btn-outline-warning">
                                        <i class="fas fa-edit"></i> Sửa
                                    </a>
                                    <button class="btn btn-sm btn-outline-danger" 
                                            onclick="confirmDelete(<%= course.getCourseId() %>, '<%= course.getName() %>')">
                                        <i class="fas fa-trash"></i> Xóa
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Create Course Modal -->
    <div class="modal fade" id="createCourseModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-plus me-2"></i>Tạo Khóa học Mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/lecturer/course-management" method="post">
                    <input type="hidden" name="action" value="create">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Tên khóa học *</label>
                                <input type="text" class="form-control" name="name" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Mã khóa học *</label>
                                <input type="text" class="form-control" name="code" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Học kỳ *</label>
                                <select class="form-control" name="semesterId" required>
                                    <option value="">Chọn học kỳ</option>
                                    <% if (semesters != null) {
                                        for (Semester semester : semesters) { %>
                                    <option value="<%= semester.getSemesterId() %>"><%= semester.getName() %></option>
                                    <% }
                                    } %>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Phòng học</label>
                                <input type="text" class="form-control" name="room">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Số tín chỉ</label>
                                <input type="number" class="form-control" name="credits" min="1" max="10" value="3">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Số sinh viên tối đa</label>
                                <input type="number" class="form-control" name="maxStudents" min="1" value="50">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Tổng số buổi học</label>
                                <input type="number" class="form-control" name="totalSessions" min="1" value="15">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mô tả</label>
                            <textarea class="form-control" name="description" rows="3"></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Lịch học</label>
                            <input type="text" class="form-control" name="schedule" placeholder="VD: Thứ 2, 4, 6 - 7:00-9:00">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Tạo khóa học</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(courseId, courseName) {
            if (confirm('Bạn có chắc chắn muốn xóa khóa học "' + courseName + '"?\n\nHành động này không thể hoàn tác!')) {
                window.location.href = '${pageContext.request.contextPath}/lecturer/course-management?action=delete&id=' + courseId;
            }
        }

        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    </script>
</body>
</html>
