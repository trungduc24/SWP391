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
    List<Lecturer> lecturers = (List<Lecturer>) request.getAttribute("lecturers");
    List<Semester> semesters = (List<Semester>) request.getAttribute("semesters");
    
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
    <title>Chỉnh sửa Khóa học - LMSS Admin</title>
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
                    <h2>Chỉnh sửa Khóa học</h2>
                    <a href="<%= request.getContextPath() %>/courses" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại
                    </a>
                </div>

                <!-- Edit Course Form -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">Thông tin khóa học</h5>
                    </div>
                    <div class="card-body">
                        <form action="<%= request.getContextPath() %>/courses" method="post">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="courseId" value="<%= course.getCourseId() %>">
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="name" class="form-label">Tên khóa học *</label>
                                        <input type="text" class="form-control" id="name" name="name" 
                                               value="<%= course.getName() %>" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="code" class="form-label">Mã khóa học *</label>
                                        <input type="text" class="form-control" id="code" name="code" 
                                               value="<%= course.getCode() %>" required>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label">Mô tả</label>
                                <textarea class="form-control" id="description" name="description" rows="3"><%= course.getDescription() != null ? course.getDescription() : "" %></textarea>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="room" class="form-label">Phòng học *</label>
                                        <input type="text" class="form-control" id="room" name="room" 
                                               value="<%= course.getRoom() %>" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="lecturerId" class="form-label">Giảng viên phụ trách *</label>
                                        <select class="form-select" id="lecturerId" name="lecturerId" required>
                                            <option value="">Chọn giảng viên</option>
                                            <% if (lecturers != null) {
                                                for (Lecturer lecturer : lecturers) { %>
                                                <option value="<%= lecturer.getLecturerId() %>" 
                                                        <%= course.getLecturerId() == lecturer.getLecturerId() ? "selected" : "" %>>
                                                    <%= lecturer.getFullName() %> - <%= lecturer.getDepartment() != null ? lecturer.getDepartment() : "N/A" %>
                                                </option>
                                            <% }
                                            } %>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="semesterId" class="form-label">Học kỳ *</label>
                                        <select class="form-select" id="semesterId" name="semester_id" required>
                                            <option value="">Chọn học kỳ</option>
                                            <% if (semesters != null) {
                                                for (Semester semester : semesters) { %>
                                                <option value="<%= semester.getSemesterId() %>" 
                                                        <%= course.getSemesterId() == semester.getSemesterId() ? "selected" : "" %>>
                                                    <%= semester.getName() %> (<%= semester.getCode() %>)
                                                </option>
                                            <% }
                                            } %>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="schedule" class="form-label">Lịch học</label>
                                        <input type="text" class="form-control" id="schedule" name="schedule" 
                                               value="<%= course.getSchedule() != null ? course.getSchedule() : "" %>"
                                               placeholder="VD: Thứ 2, 4, 6 - 7:00-9:00">
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="credits" class="form-label">Số tín chỉ *</label>
                                        <input type="number" class="form-control" id="credits" name="credits" 
                                               value="<%= course.getCredits() %>" min="1" max="10" required>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="maxStudents" class="form-label">Sĩ số tối đa *</label>
                                        <input type="number" class="form-control" id="maxStudents" name="maxStudents" 
                                               value="<%= course.getMaxStudents() %>" min="1" max="200" required>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="totalSessions" class="form-label">Số buổi học *</label>
                                        <input type="number" class="form-control" id="totalSessions" name="totalSessions" 
                                               value="<%= course.getTotalSessions() %>" min="1" max="50" required>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="isActive" name="isActive" 
                                           <%= course.isActive() ? "checked" : "" %>>
                                    <label class="form-check-label" for="isActive">
                                        Khóa học đang hoạt động
                                    </label>
                                </div>
                            </div>

                            <div class="d-flex justify-content-end">
                                <a href="<%= request.getContextPath() %>/courses" class="btn btn-secondary me-2">Hủy</a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>Cập nhật khóa học
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
