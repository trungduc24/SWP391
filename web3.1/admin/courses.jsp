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
    
    List<Course> courses = (List<Course>) request.getAttribute("courses");
    if (courses == null) {
        courses = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Khóa học - LMSS Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            </nav>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Quản lý Khóa học</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createCourseModal">
                            <i class="fas fa-plus me-2"></i>Tạo khóa học mới
                        </button>
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
                                        <h4><%= courses.size() %></h4>
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
                                        <h4><%= courses.stream().mapToInt(c -> c.getMaxStudents()).sum() %></h4>
                                        <p class="mb-0">Tổng chỗ ngồi</p>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-users fa-2x"></i>
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
                                        <h4><%= courses.stream().mapToInt(Course::getCredits).sum() %></h4>
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
                                        <h4><%= courses.stream().mapToInt(Course::getTotalSessions).sum() %></h4>
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
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-search"></i></span>
                            <input type="text" class="form-control" id="searchInput" placeholder="Tìm kiếm khóa học...">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" id="statusFilter">
                            <option value="">Tất cả trạng thái</option>
                            <option value="active">Đang hoạt động</option>
                            <option value="inactive">Không hoạt động</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" id="sortBy">
                            <option value="name">Sắp xếp theo tên</option>
                            <option value="code">Sắp xếp theo mã</option>
                            <option value="credits">Sắp xếp theo tín chỉ</option>
                        </select>
                    </div>
                </div>

                <!-- Courses Grid -->
                <div class="row" id="coursesContainer">
                    <% if (courses.isEmpty()) { %>
                        <div class="col-12">
                            <div class="text-center py-5">
                                <i class="fas fa-book fa-3x text-muted mb-3"></i>
                                <h4 class="text-muted">Chưa có khóa học nào</h4>
                                <p class="text-muted">Hãy tạo khóa học đầu tiên của bạn!</p>
                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createCourseModal">
                                    <i class="fas fa-plus me-2"></i>Tạo khóa học mới
                                </button>
                            </div>
                        </div>
                    <% } else { %>
                        <% for (Course course : courses) { %>
                            <div class="col-md-6 col-lg-4 mb-4 course-item" 
                                 data-name="<%= course.getName().toLowerCase() %>" 
                                 data-code="<%= course.getCode().toLowerCase() %>"
                                 data-status="active">
                                <div class="card course-card h-100">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <h6 class="mb-0 text-primary"><%= course.getCode() %></h6>
                                        <span class="badge bg-success status-badge">Hoạt động</span>
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title"><%= course.getName() %></h5>
                                        <p class="card-text text-muted">
                                            <%= course.getDescription() != null ? course.getDescription() : "Chưa có mô tả" %>
                                        </p>
                                        <div class="row text-center">
                                            <div class="col-4">
                                                <small class="text-muted">Tín chỉ</small>
                                                <div class="fw-bold"><%= course.getCredits() %></div>
                                            </div>
                                            <div class="col-4">
                                                <small class="text-muted">Sĩ số</small>
                                                <div class="fw-bold"><%= course.getMaxStudents() %></div>
                                            </div>
                                            <div class="col-4">
                                                <small class="text-muted">Buổi học</small>
                                                <div class="fw-bold"><%= course.getTotalSessions() %></div>
                                            </div>
                                        </div>
                                        <% if (course.getRoom() != null && !course.getRoom().isEmpty()) { %>
                                            <div class="mt-2">
                                                <small class="text-muted"><i class="fas fa-map-marker-alt me-1"></i><%= course.getRoom() %></small>
                                            </div>
                                        <% } %>
                                    </div>
                                    <div class="card-footer bg-transparent">
                                        <div class="btn-group w-100" role="group">
                                            <button type="button" class="btn btn-outline-primary btn-sm" onclick="viewCourse(<%= course.getCourseId() %>)">
                                                <i class="fas fa-eye"></i> Xem
                                            </button>
                                            <button type="button" class="btn btn-outline-warning btn-sm" onclick="editCourse(<%= course.getCourseId() %>)">
                                                <i class="fas fa-edit"></i> Sửa
                                            </button>
                                            <button type="button" class="btn btn-outline-danger btn-sm" onclick="deleteCourse(<%= course.getCourseId() %>, '<%= course.getName() %>')">
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

    <!-- Create Course Modal -->
    <div class="modal fade" id="createCourseModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Tạo khóa học mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="<%= request.getContextPath() %>/create-course" method="post" id="createCourseForm">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="courseName" class="form-label">Tên khóa học *</label>
                                    <input type="text" class="form-control" id="courseName" name="name" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="courseCode" class="form-label">Mã khóa học *</label>
                                    <input type="text" class="form-control" id="courseCode" name="code" required>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="courseDescription" class="form-label">Mô tả</label>
                            <textarea class="form-control" id="courseDescription" name="description" rows="3"></textarea>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="courseRoom" class="form-label">Phòng học</label>
                                    <input type="text" class="form-control" id="courseRoom" name="room">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="lecturerId" class="form-label">Giảng viên *</label>
                                    <select class="form-select" id="lecturerId" name="lecturer_id" required>
                                        <option value="">Chọn giảng viên</option>
                                        <%
                                            List<Lecturer> lecturers = (List<Lecturer>) request.getAttribute("lecturers");
                                            if (lecturers != null) {
                                                for (Lecturer lecturer : lecturers) {
                                        %>
                                        <option value="<%= lecturer.getLecturerId() %>">
                                            <%= lecturer.getFullName() %> (<%= lecturer.getLecturerCode() %>)
                                        </option>
                                        <%
                                                }
                                            }
                                        %>
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
                                        <%
                                            List<Semester> semesters = (List<Semester>) request.getAttribute("semesters");
                                            if (semesters != null) {
                                                for (Semester semester : semesters) {
                                        %>
                                        <option value="<%= semester.getSemesterId() %>">
                                            <%= semester.getName() %> (<%= semester.getCode() %>)
                                        </option>
                                        <%
                                                }
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="schedule" class="form-label">Lịch học</label>
                                    <input type="text" class="form-control" id="schedule" name="schedule" placeholder="VD: Thứ 2, 4, 6 - 7:00-9:00">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label for="credits" class="form-label">Số tín chỉ *</label>
                                    <input type="number" class="form-control" id="credits" name="credits" min="1" max="10" required>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label for="maxStudents" class="form-label">Sĩ số tối đa *</label>
                                    <input type="number" class="form-control" id="maxStudents" name="maxStudents" min="1" max="200" required>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label for="totalSessions" class="form-label">Số buổi học *</label>
                                    <input type="number" class="form-control" id="totalSessions" name="totalSessions" min="1" max="100" required>
                                </div>
                            </div>
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
        // Form validation
        document.addEventListener('DOMContentLoaded', function() {
            // Form is ready
        });

        // Search and filter functionality
        document.getElementById('searchInput').addEventListener('input', filterCourses);
        document.getElementById('statusFilter').addEventListener('change', filterCourses);
        document.getElementById('sortBy').addEventListener('change', sortCourses);

        function filterCourses() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const statusFilter = document.getElementById('statusFilter').value;
            const courseItems = document.querySelectorAll('.course-item');

            courseItems.forEach(item => {
                const name = item.dataset.name;
                const code = item.dataset.code;
                const status = item.dataset.status;

                const matchesSearch = name.includes(searchTerm) || code.includes(searchTerm);
                const matchesStatus = !statusFilter || status === statusFilter;

                item.style.display = matchesSearch && matchesStatus ? 'block' : 'none';
            });
        }

        function sortCourses() {
            const sortBy = document.getElementById('sortBy').value;
            const container = document.getElementById('coursesContainer');
            const items = Array.from(container.querySelectorAll('.course-item'));

            items.sort((a, b) => {
                let aValue, bValue;
                switch(sortBy) {
                    case 'name':
                        aValue = a.dataset.name;
                        bValue = b.dataset.name;
                        break;
                    case 'code':
                        aValue = a.dataset.code;
                        bValue = b.dataset.code;
                        break;
                    default:
                        return 0;
                }
                return aValue.localeCompare(bValue);
            });

            items.forEach(item => container.appendChild(item));
        }

        function viewCourse(courseId) {
            window.location.href = '<%= request.getContextPath() %>/courses?action=view&id=' + courseId;
        }

        function editCourse(courseId) {
            window.location.href = '<%= request.getContextPath() %>/courses?action=edit&id=' + courseId;
        }

        function deleteCourse(courseId, courseName) {
            if (confirm('Bạn có chắc chắn muốn xóa khóa học "' + courseName + '"?')) {
                // Redirect trực tiếp đến URL xóa
                window.location.href = '<%= request.getContextPath() %>/courses?action=delete&id=' + courseId;
            }
        }
    </script>
</body>
</html>
