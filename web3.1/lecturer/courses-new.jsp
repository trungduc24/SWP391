<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý khóa học - LMSS Lecturer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .main-content {
            background-color: #f8f9fa;
            min-height: 100vh;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            transition: transform 0.2s;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
        }
        .course-card {
            border-left: 4px solid #667eea;
        }
        .course-status {
            font-size: 0.8em;
            padding: 0.3em 0.8em;
        }
        .stats-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-2 sidebar text-white p-0">
                <div class="p-3">
                    <h4><i class="fas fa-graduation-cap"></i> LMSS Lecturer</h4>
                    <p class="small">Xin chào, ${sessionScope.user.username}</p>
                </div>
                <nav class="nav flex-column">
                    <a class="nav-link text-white" href="${pageContext.request.contextPath}/lecturer">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </a>
                    <a class="nav-link text-white active" href="${pageContext.request.contextPath}/lecturer/courses">
                        <i class="fas fa-book"></i> Quản lý khóa học
                    </a>
                    <a class="nav-link text-white" href="${pageContext.request.contextPath}/lecturer/tests">
                        <i class="fas fa-clipboard-list"></i> Quản lý bài kiểm tra
                    </a>
                    <a class="nav-link text-white" href="${pageContext.request.contextPath}/lecturer/grades">
                        <i class="fas fa-chart-line"></i> Chấm điểm
                    </a>
                    <a class="nav-link text-white" href="${pageContext.request.contextPath}/lecturer/materials">
                        <i class="fas fa-folder"></i> Tài liệu
                    </a>
                    <a class="nav-link text-white" href="${pageContext.request.contextPath}/lecturer/announcements">
                        <i class="fas fa-bullhorn"></i> Thông báo
                    </a>
                    <hr class="text-white">
                    <a class="nav-link text-white" href="${pageContext.request.contextPath}/logout">
                        <i class="fas fa-sign-out-alt"></i> Đăng xuất
                    </a>
                </nav>
            </div>

            <!-- Main Content -->
            <div class="col-md-10 main-content p-4">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2><i class="fas fa-book"></i> Quản lý khóa học</h2>
                        <p class="text-muted">Danh sách các khóa học bạn đang giảng dạy</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/lecturer/courses?action=create" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Tạo khóa học mới
                    </a>
                </div>

                <!-- Alert Messages -->
                <c:if test="${param.success == 'course_created'}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> Tạo khóa học thành công!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${param.success == 'course_updated'}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> Cập nhật khóa học thành công!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${param.success == 'course_deleted'}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> Xóa khóa học thành công!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${param.error == 'access_denied'}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle"></i> Bạn không có quyền truy cập khóa học này!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="card stats-card text-center">
                            <div class="card-body">
                                <h5 class="card-title">Tổng khóa học</h5>
                                <h3>${myCourses.size()}</h3>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-center">
                            <div class="card-body">
                                <h5 class="card-title text-success">Đang hoạt động</h5>
                                <h3 class="text-success">
                                    <c:set var="activeCount" value="0"/>
                                    <c:forEach var="course" items="${myCourses}">
                                        <c:if test="${course.active}">
                                            <c:set var="activeCount" value="${activeCount + 1}"/>
                                        </c:if>
                                    </c:forEach>
                                    ${activeCount}
                                </h3>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-center">
                            <div class="card-body">
                                <h5 class="card-title text-warning">Không hoạt động</h5>
                                <h3 class="text-warning">${myCourses.size() - activeCount}</h3>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-center">
                            <div class="card-body">
                                <h5 class="card-title text-info">Học kỳ</h5>
                                <h3 class="text-info">${semesters.size()}</h3>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Courses Grid -->
                <div class="row">
                    <c:forEach var="course" items="${myCourses}">
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="card course-card h-100">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h6 class="mb-0 text-primary">${course.code}</h6>
                                    <c:choose>
                                        <c:when test="${course.active}">
                                            <span class="badge bg-success course-status">Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary course-status">Không hoạt động</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="card-body">
                                    <h5 class="card-title">${course.name}</h5>
                                    <p class="card-text text-muted">${course.description}</p>
                                    
                                    <div class="row text-center mb-3">
                                        <div class="col-4">
                                            <small class="text-muted">Tín chỉ</small>
                                            <div class="fw-bold">${course.credits}</div>
                                        </div>
                                        <div class="col-4">
                                            <small class="text-muted">Phòng</small>
                                            <div class="fw-bold">${course.room}</div>
                                        </div>
                                        <div class="col-4">
                                            <small class="text-muted">Buổi học</small>
                                            <div class="fw-bold">${course.totalSessions}</div>
                                        </div>
                                    </div>
                                    
                                    <c:if test="${not empty course.schedule}">
                                        <p class="small text-muted">
                                            <i class="fas fa-clock"></i> ${course.schedule}
                                        </p>
                                    </c:if>
                                </div>
                                <div class="card-footer bg-transparent">
                                    <div class="btn-group w-100" role="group">
                                        <a href="${pageContext.request.contextPath}/lecturer/courses?action=view&id=${course.courseId}" 
                                           class="btn btn-outline-primary btn-sm">
                                            <i class="fas fa-eye"></i> Xem
                                        </a>
                                        <a href="${pageContext.request.contextPath}/lecturer/courses?action=edit&id=${course.courseId}" 
                                           class="btn btn-outline-warning btn-sm">
                                            <i class="fas fa-edit"></i> Sửa
                                        </a>
                                        <button type="button" class="btn btn-outline-danger btn-sm" 
                                                onclick="confirmDelete(${course.courseId}, '${course.name}')">
                                            <i class="fas fa-trash"></i> Xóa
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    
                    <c:if test="${empty myCourses}">
                        <div class="col-12">
                            <div class="card text-center">
                                <div class="card-body py-5">
                                    <i class="fas fa-book fa-3x text-muted mb-3"></i>
                                    <h5 class="text-muted">Chưa có khóa học nào</h5>
                                    <p class="text-muted">Bạn chưa tạo khóa học nào. Hãy tạo khóa học đầu tiên!</p>
                                    <a href="${pageContext.request.contextPath}/lecturer/courses?action=create" class="btn btn-primary">
                                        <i class="fas fa-plus"></i> Tạo khóa học mới
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Xác nhận xóa</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xóa khóa học <strong id="deleteCourseTitle"></strong>?</p>
                    <p class="text-danger"><i class="fas fa-exclamation-triangle"></i> Hành động này không thể hoàn tác!</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <form id="deleteForm" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="courseId" id="deleteCourseId">
                        <button type="submit" class="btn btn-danger">Xóa</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(courseId, courseName) {
            document.getElementById('deleteCourseId').value = courseId;
            document.getElementById('deleteCourseTitle').textContent = courseName;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
    </script>
</body>
</html>
