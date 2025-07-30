<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--
    This JSP page serves as the lecturer's dashboard, providing an overview of courses,
    students, tests, materials, and recent activities. It's designed to be integrated
    with a sidebar for consistent navigation.
--%>

<div class="main-content container-fluid py-4">
    <div class="row mb-4">
        <div class="col-12">
            <div class="card shadow-sm border-0 welcome-card">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h2 class="mb-1 text-primary">Xin chào, ${lecturer.fullName}</h2>
                            <p class="mb-0 text-muted-dark">Chào mừng bạn quay trở lại với hệ thống quản lý học tập LMSS</p>
                        </div>
                        <div>
                            <span class="text-muted fs-5"><i class="fas fa-calendar-alt me-2"></i><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date()) %></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row mb-4">
        <div class="col-lg-3 col-md-6 mb-3">
            <div class="card h-100 shadow-sm border-0 metric-card">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-muted mb-1 text-uppercase">Khóa học</h6>
                            <h3 class="mb-0 text-primary">${totalCourses}</h3>
                        </div>
                        <div class="rounded-circle bg-primary-soft p-3 icon-circle">
                            <i class="fas fa-book fa-2x text-primary"></i>
                        </div>
                    </div>
                    <div class="mt-3">
                        <span class="badge bg-success-soft text-success"><i class="fas fa-check-circle me-1"></i>${activeCourses} đang hoạt động</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-3 col-md-6 mb-3">
            <div class="card h-100 shadow-sm border-0 metric-card">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-muted mb-1 text-uppercase">Sinh viên</h6>
                            <h3 class="mb-0 text-success">${totalStudents}</h3>
                        </div>
                        <div class="rounded-circle bg-success-soft p-3 icon-circle">
                            <i class="fas fa-users fa-2x text-success"></i>
                        </div>
                    </div>
                    <div class="mt-3">
                        <a href="${pageContext.request.contextPath}/lecturer/students" class="text-decoration-none text-primary fw-bold action-link">
                            Xem danh sách <i class="fas fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-3 col-md-6 mb-3">
            <div class="card h-100 shadow-sm border-0 metric-card">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-muted mb-1 text-uppercase">Bài kiểm tra</h6>
                            <h3 class="mb-0 text-warning">${totalTests}</h3>
                        </div>
                        <div class="rounded-circle bg-warning-soft p-3 icon-circle">
                            <i class="fas fa-clipboard-check fa-2x text-warning"></i>
                        </div>
                    </div>
                    <div class="mt-3">
                        <a href="${pageContext.request.contextPath}/lecturer/tests" class="text-decoration-none text-primary fw-bold action-link">
                            Tạo bài kiểm tra <i class="fas fa-plus ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-3 col-md-6 mb-3">
            <div class="card h-100 shadow-sm border-0 metric-card">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-muted mb-1 text-uppercase">Tài liệu</h6>
                            <h3 class="mb-0 text-info">${totalMaterials}</h3>
                        </div>
                        <div class="rounded-circle bg-info-soft p-3 icon-circle">
                            <i class="fas fa-file-alt fa-2x text-info"></i>
                        </div>
                    </div>
                    <div class="mt-3">
                        <a href="${pageContext.request.contextPath}/lecturer/materials" class="text-decoration-none text-primary fw-bold action-link">
                            Tải lên tài liệu <i class="fas fa-upload ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row mb-4">
        <div class="col-lg-8 mb-4 mb-lg-0">
            <div class="card h-100 shadow-sm border-0">
                <div class="card-header bg-light d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 text-secondary">Khóa học của tôi</h5>
                    <a href="${pageContext.request.contextPath}/lecturer/courses" class="btn btn-sm btn-outline-primary">
                        Xem tất cả <i class="fas fa-arrow-right ms-1"></i>
                    </a>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty recentCourses}">
                            <div class="text-center py-5 text-muted">
                                <i class="fas fa-book fa-3x mb-3"></i>
                                <h5 class="mt-3">Bạn chưa có khóa học nào</h5>
                                <a href="${pageContext.request.contextPath}/lecturer/courses/create" class="btn btn-primary mt-3">
                                    <i class="fas fa-plus me-2"></i>Tạo khóa học mới
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-hover align-middle">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Tên khóa học</th>
                                            <th>Mã khóa học</th>
                                            <th>Học kỳ</th>
                                            <th>Sinh viên</th>
                                            <th>Trạng thái</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="course" items="${recentCourses}">
                                            <tr>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/lecturer/courses/${course.courseId}" class="text-decoration-none text-dark fw-bold">
                                                        ${course.name}
                                                    </a>
                                                </td>
                                                <td>${course.code}</td>
                                                <td>${course.semesterId}</td>
                                                <td><span class="badge bg-secondary">${studentCount}</span></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${course.active}">
                                                            <span class="badge bg-success"><i class="fas fa-check-circle me-1"></i>Đang hoạt động</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary"><i class="fas fa-pause-circle me-1"></i>Không hoạt động</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="text-center mt-3">
                                <a href="${pageContext.request.contextPath}/lecturer/courses/create" class="btn btn-outline-primary">
                                    <i class="fas fa-plus me-2"></i>Tạo khóa học mới
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card h-100 shadow-sm border-0">
                <div class="card-header bg-light">
                    <h5 class="mb-0 text-secondary">Lịch học kỳ</h5>
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="mb-0 text-primary">${currentSemester.name}</h6>
                        <span class="badge bg-info-soft text-info fs-6">${currentSemester.year}</span>
                    </div>
                    <div class="mb-3">
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Bắt đầu:</span>
                            <span class="fw-bold text-dark"><fmt:formatDate value="${currentSemester.startDate}" pattern="dd/MM/yyyy" /></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Kết thúc:</span>
                            <span class="fw-bold text-dark"><fmt:formatDate value="${currentSemester.endDate}" pattern="dd/MM/yyyy" /></span>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span class="text-muted">Trạng thái:</span>
                            <span class="badge bg-success">Đang diễn ra</span>
                        </div>
                    </div>
                    <hr class="my-4">
                    <h6 class="mb-3 text-secondary">Sắp tới</h6>
                    <c:choose>
                        <c:when test="${empty upcomingTests}">
                            <p class="text-muted text-center py-3">Không có bài kiểm tra nào sắp tới.</p>
                        </c:when>
                        <c:otherwise>
                            <ul class="list-group list-group-flush">
                                <c:forEach var="test" items="${upcomingTests}">
                                    <li class="list-group-item px-0 border-bottom">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <h6 class="mb-1 text-dark">${test.title}</h6>
                                                <small class="text-muted"><i class="fas fa-tag me-1"></i>${test.courseName}</small>
                                            </div>
                                            <div class="text-end">
                                                <span class="badge bg-warning text-dark">
                                                    <fmt:formatDate value="${test.startTime}" pattern="dd/MM HH:mm" />
                                                </span>
                                            </div>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-6 mb-4 mb-lg-0">
            <div class="card h-100 shadow-sm border-0">
                <div class="card-header bg-light d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 text-secondary">Thông báo gần đây</h5>
                    <a href="${pageContext.request.contextPath}/lecturer/announcements" class="btn btn-sm btn-outline-primary">
                        Xem tất cả <i class="fas fa-arrow-right ms-1"></i>
                    </a>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty recentAnnouncements}">
                            <div class="text-center py-4 text-muted">
                                <i class="fas fa-bullhorn fa-3x mb-3"></i>
                                <p class="mt-3">Không có thông báo nào.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="list-group list-group-flush">
                                <c:forEach var="announcement" items="${recentAnnouncements}">
                                    <a href="${pageContext.request.contextPath}/lecturer/announcements/${announcement.announcementId}" class="list-group-item list-group-item-action px-0 border-bottom-dashed">
                                        <div class="d-flex w-100 justify-content-between align-items-center">
                                            <h6 class="mb-1 text-dark">${announcement.title}</h6>
                                            <small class="text-muted">
                                                <fmt:formatDate value="${announcement.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                            </small>
                                        </div>
                                        <p class="mb-1 text-truncate text-muted-dark"><i class="fas fa-info-circle me-1"></i>${announcement.content}</p>
                                        <small>
                                            <c:choose>
                                                <c:when test="${not empty announcement.courseId}">
                                                    <span class="badge bg-primary-soft text-primary"><i class="fas fa-book-open me-1"></i>${announcement.courseId}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary-soft text-secondary"><i class="fas fa-globe me-1"></i>Thông báo chung</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </small>
                                    </a>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="card-footer text-center bg-light">
                    <button type="button" class="btn btn-primary btn-hover-shadow" data-bs-toggle="modal" data-bs-target="#createAnnouncementModal">
                        <i class="fas fa-plus me-2"></i>Tạo thông báo mới
                    </button>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="card h-100 shadow-sm border-0">
                <div class="card-header bg-light">
                    <h5 class="mb-0 text-secondary">Thao tác nhanh</h5>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <a href="${pageContext.request.contextPath}/lecturer/courses/create" class="card text-decoration-none h-100 text-center quick-action-card">
                                <div class="card-body">
                                    <div class="rounded-circle bg-primary-soft p-3 mx-auto mb-3 circle-icon">
                                        <i class="fas fa-book fa-2x text-primary"></i>
                                    </div>
                                    <h6 class="card-title text-dark">Tạo khóa học</h6>
                                    <p class="card-text small text-muted">Tạo khóa học mới cho học kỳ</p>
                                </div>
                            </a>
                        </div>
                        <div class="col-md-6">
                            <a href="${pageContext.request.contextPath}/lecturer/tests/create" class="card text-decoration-none h-100 text-center quick-action-card">
                                <div class="card-body">
                                    <div class="rounded-circle bg-warning-soft p-3 mx-auto mb-3 circle-icon">
                                        <i class="fas fa-clipboard-check fa-2x text-warning"></i>
                                    </div>
                                    <h6 class="card-title text-dark">Tạo bài kiểm tra</h6>
                                    <p class="card-text small text-muted">Tạo bài kiểm tra mới</p>
                                </div>
                            </a>
                        </div>
                        <div class="col-md-6">
                            <a href="${pageContext.request.contextPath}/lecturer/materials" class="card text-decoration-none h-100 text-center quick-action-card">
                                <div class="card-body">
                                    <div class="rounded-circle bg-info-soft p-3 mx-auto mb-3 circle-icon">
                                        <i class="fas fa-file-upload fa-2x text-info"></i>
                                    </div>
                                    <h6 class="card-title text-dark">Tải lên tài liệu</h6>
                                    <p class="card-text small text-muted">Tải lên tài liệu học tập</p>
                                </div>
                            </a>
                        </div>
                        <div class="col-md-6">
                            <a href="${pageContext.request.contextPath}/lecturer/grades" class="card text-decoration-none h-100 text-center quick-action-card">
                                <div class="card-body">
                                    <div class="rounded-circle bg-success-soft p-3 mx-auto mb-3 circle-icon">
                                        <i class="fas fa-chart-line fa-2x text-success"></i>
                                    </div>
                                    <h6 class="card-title text-dark">Quản lý điểm</h6>
                                    <p class="card-text small text-muted">Nhập và quản lý điểm số</p>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="createAnnouncementModal" tabindex="-1" aria-labelledby="createAnnouncementModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="createAnnouncementModalLabel"><i class="fas fa-bullhorn me-2"></i>Tạo thông báo mới</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/lecturer/announcements/create" method="post" id="createAnnouncementForm">
                    <div class="mb-3">
                        <label for="title" class="form-label fw-bold">Tiêu đề <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="title" name="title" placeholder="Nhập tiêu đề thông báo" required>
                    </div>
                    <div class="mb-3">
                        <label for="content" class="form-label fw-bold">Nội dung <span class="text-danger">*</span></label>
                        <textarea class="form-control" id="content" name="content" rows="6" placeholder="Nhập nội dung thông báo chi tiết" required></textarea>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="courseId" class="form-label fw-bold">Khóa học</label>
                            <select class="form-select" id="courseId" name="courseId">
                                <option value="">Thông báo chung (áp dụng cho tất cả khóa học)</option>
                                <c:forEach var="course" items="${courses}">
                                    <option value="${course.courseId}">${course.name} (${course.code})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="type" class="form-label fw-bold">Loại thông báo</label>
                            <select class="form-select" id="type" name="type">
                                <option value="general">Thông báo chung</option>
                                <option value="course">Thông báo khóa học cụ thể</option>
                                <option value="urgent">Thông báo khẩn cấp</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="checkbox" id="sendEmail" name="sendEmail" checked>
                        <label class="form-check-label" for="sendEmail">
                            Gửi email thông báo cho tất cả sinh viên liên quan
                        </label>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"><i class="fas fa-times me-1"></i>Hủy</button>
                <button type="button" class="btn btn-primary" onclick="document.getElementById('createAnnouncementForm').submit()"><i class="fas fa-paper-plane me-1"></i>Đăng thông báo</button>
            </div>
        </div>
    </div>
</div>

<style>
    /* Custom Styles for a more professional look */
    body {
        background-color: #f0f2f5; /* Lighter background for a modern feel */
        font-family: 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif; /* Modern font stack */
    }

    /* Adjust main content padding to make space for a potential fixed sidebar */
    /* This value should be tailored to the exact width of your sidebar. */
    /* For example, if sidebar.jsp generates a fixed sidebar of 250px width: */
    /* @media (min-width: 992px) { /* Apply on large screens and up */
    /* .main-content {
            padding-left: 250px;
        }
    } */

    .card {
        border-radius: 0.75rem; /* Consistent rounded corners */
        overflow: hidden; /* Ensure content stays within borders */
        transition: all 0.3s ease-in-out; /* Smooth transitions for hover effects */
        border: none; /* Remove default border for cleaner look */
        box-shadow: 0 0.25rem 0.75rem rgba(0, 0, 0, 0.05); /* Subtle shadow for depth */
    }

    .card:hover.metric-card, .card:hover.quick-action-card {
        transform: translateY(-5px); /* Lift effect on hover for interactive cards */
        box-shadow: 0 0.75rem 1.5rem rgba(0, 0, 0, 0.1);
    }

    .card-header {
        border-bottom: 1px solid rgba(0, 0, 0, 0.08); /* Slightly darker border for header */
        padding: 1.25rem 1.5rem;
        background-color: #fcfcfc; /* Very light background for headers */
        font-weight: 600; /* Bolder header text */
        color: #343a40; /* Darker text for headers */
    }

    .welcome-card {
        background-image: linear-gradient(to right, #e0f2f7, #ffffff); /* Gentle gradient for welcome card */
        border-left: 5px solid #007bff; /* Accent border */
    }

    .text-primary {
        color: #007bff !important; /* Bootstrap primary blue */
    }

    .text-success {
        color: #28a745 !important; /* Bootstrap success green */
    }

    .text-warning {
        color: #ffc107 !important; /* Bootstrap warning yellow */
    }

    .text-info {
        color: #17a2b8 !important; /* Bootstrap info cyan */
    }

    /* Soft background colors for icons and badges */
    .bg-primary-soft {
        background-color: rgba(0, 123, 255, 0.1) !important;
    }
    .bg-success-soft {
        background-color: rgba(40, 167, 69, 0.1) !important;
    }
    .bg-warning-soft {
        background-color: rgba(255, 193, 7, 0.1) !important;
    }
    .bg-info-soft {
        background-color: rgba(23, 162, 184, 0.1) !important;
    }
    .bg-secondary-soft {
        background-color: rgba(108, 117, 125, 0.1) !important;
    }

    /* Badge styling */
    .badge {
        font-weight: 500; /* Slightly lighter font weight for badges */
        padding: 0.4em 0.7em;
        border-radius: 0.375rem;
        font-size: 0.85em; /* Slightly smaller text for badges */
    }

    .table th, .table td {
        padding: 1rem;
        vertical-align: middle; /* Align text vertically in the middle */
    }

    .table thead th {
        border-bottom: 2px solid rgba(0, 0, 0, 0.1); /* Clearer separation for table header */
    }

    .list-group-item.border-bottom-dashed {
        border-bottom: 1px dashed rgba(0, 0, 0, 0.1); /* Subtle dashed border */
        margin-bottom: 0.5rem; /* Space between list items */
        padding-bottom: 0.5rem;
    }

    .list-group-item:last-child.border-bottom-dashed {
        border-bottom: none;
        margin-bottom: 0;
        padding-bottom: 0;
    }

    .btn-hover-shadow:hover {
        box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15) !important;
        transform: translateY(-2px);
        transition: all 0.3s ease-in-out;
    }

    .quick-action-card {
        border: 1px solid rgba(0, 0, 0, 0.08); /* Light border for quick action cards */
        box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075); /* Default subtle shadow */
    }

    .quick-action-card .circle-icon {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 60px;
        height: 60px;
        font-size: 1.5rem; /* Slightly larger icon size */
    }

    .modal-header.bg-primary {
        background-color: #007bff !important;
        border-bottom: none; /* Remove border for a cleaner header */
        padding: 1.5rem; /* More padding for modal header */
    }
    .modal-header .modal-title {
        color: white; /* White title for primary header */
    }
    .modal-header .btn-close-white {
        filter: invert(1) grayscale(100%) brightness(200%);
        opacity: 0.8; /* Slightly less opaque for close button */
    }

    .modal-content {
        border-radius: 1rem; /* More rounded modal corners */
        overflow: hidden;
    }

    .modal-footer {
        border-top: 1px solid rgba(0, 0, 0, 0.08); /* Consistent border for footer */
        background-color: #fcfcfc; /* Light background for footer */
        padding: 1rem 1.5rem;
    }

    .text-muted-dark {
        color: #495057 !important; /* Slightly darker muted text for better readability */
    }

    .action-link {
        font-weight: 600; /* Bolder action links */
        transition: color 0.2s ease-in-out;
    }
    .action-link:hover {
        color: #0056b3 !important; /* Darker blue on hover */
    }
</style>