<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container-fluid">
    <!-- Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="profile-header">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h2 class="mb-1">Quản lý thông báo</h2>
                        <p class="mb-0">Tạo và quản lý thông báo cho sinh viên</p>
                    </div>
                    <div>
                        <button class="btn btn-light" data-bs-toggle="modal" data-bs-target="#createAnnouncementModal">
                            <i class="fas fa-plus me-2"></i>Tạo thông báo mới
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Filter and Search -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/lecturer/announcements" method="get" class="row g-3">
                        <div class="col-md-4">
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-search"></i></span>
                                <input type="text" class="form-control" name="keyword" placeholder="Tìm kiếm thông báo..." value="${param.keyword}">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <select class="form-select" name="courseId">
                                <option value="">Tất cả khóa học</option>
                                <c:forEach var="course" items="${myCourses}">
                                    <option value="${course.courseId}" ${param.courseId == course.courseId ? 'selected' : ''}>${course.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <select class="form-select" name="type">
                                <option value="">Tất cả loại</option>
                                <option value="general" ${param.type == 'general' ? 'selected' : ''}>Thông báo chung</option>
                                <option value="course" ${param.type == 'course' ? 'selected' : ''}>Thông báo khóa học</option>
                                <option value="urgent" ${param.type == 'urgent' ? 'selected' : ''}>Thông báo khẩn</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-primary w-100">Lọc</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Announcements List -->
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Danh sách thông báo</h5>
                    <div class="btn-group">
                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="sortDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                            Sắp xếp
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="sortDropdown">
                            <li><a class="dropdown-item" href="?sort=date&order=desc">Mới nhất</a></li>
                            <li><a class="dropdown-item" href="?sort=date&order=asc">Cũ nhất</a></li>
                            <li><a class="dropdown-item" href="?sort=title&order=asc">Tiêu đề (A-Z)</a></li>
                            <li><a class="dropdown-item" href="?sort=title&order=desc">Tiêu đề (Z-A)</a></li>
                        </ul>
                    </div>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty announcements}">
                            <div class="list-group">
                                <c:forEach var="announcement" items="${announcements}">
                                    <div class="list-group-item list-group-item-action">
                                        <div class="d-flex w-100 justify-content-between align-items-center">
                                            <h5 class="mb-1">
                                                
                                                <c:if test="${announcement.pinned}">
                                                    <i class="fas fa-thumbtack text-warning me-1" title="Đã ghim"></i>
                                                </c:if>

                                                <c:choose>
                                                    <c:when test="${announcement.announcementType == 'urgent'}">
                                                        <span class="badge bg-danger me-2">Khẩn</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary me-2">Chung</span>
                                                    </c:otherwise>
                                                </c:choose>

                                                ${announcement.title}
                                            </h5>

                                            <div class="dropdown">
                                                <button class="btn btn-sm btn-outline-secondary" type="button"
                                                        id="dropdownMenuButton${announcement.announcementId}" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <i class="fas fa-ellipsis-v"></i>
                                                </button>
                                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton${announcement.announcementId}">
                                                    <li>
                                                        <a class="dropdown-item" href="#" onclick="viewAnnouncement(${announcement.announcementId})">
                                                            <i class="fas fa-eye me-2"></i>Xem chi tiết
                                                        </a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="#" onclick="editAnnouncement(${announcement.announcementId})">
                                                            <i class="fas fa-edit me-2"></i>Chỉnh sửa
                                                        </a>
                                                    </li>
                                                    <li><hr class="dropdown-divider"></li>
                                                    <li>
                                                        <a class="dropdown-item text-danger" href="#"
                                                           onclick="confirmDeleteAnnouncement(${announcement.announcementId}, '${announcement.title}')">
                                                            <i class="fas fa-trash me-2"></i>Xóa
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>

                                        <p class="mb-1 text-truncate">${announcement.content}</p>

                                        <div class="d-flex justify-content-between align-items-center flex-wrap">
                                            <div>
                                                <small class="text-muted">
                                                    <i class="fas fa-calendar-alt me-1"></i>
                                                    <fmt:formatDate value="${announcement.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                                    <c:if test="${announcement.expiresAt != null}">
                                                        <span class="text-danger ms-2">
                                                            (Hết hạn: <fmt:formatDate value="${announcement.expiresAt}" pattern="dd/MM/yyyy" />)
                                                        </span>
                                                    </c:if>
                                                </small>
                                            </div>

                                            <div class="d-flex gap-2">
                                                <c:if test="${not empty announcement.targetAudience}">
                                                    <span class="badge bg-light text-dark border border-secondary">
                                                        🎯 ${announcement.targetAudience}
                                                    </span>
                                                </c:if>

                                                <c:choose>
                                                    <c:when test="${not empty announcement.courseId}">
                                                        <span class="badge bg-primary">${announcement.courseId}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">Thông báo chung</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <div class="display-6 text-muted mb-3">
                                    <i class="fas fa-bullhorn"></i>
                                </div>
                                <h4>Không có thông báo nào</h4>
                                <p class="text-muted">Hãy tạo thông báo đầu tiên của bạn</p>
                                <button class="btn btn-primary mt-3" data-bs-toggle="modal" data-bs-target="#createAnnouncementModal">
                                    <i class="fas fa-plus me-2"></i>Tạo thông báo mới
                                </button>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <div class="card-footer">
                        <nav aria-label="Page navigation">
                            <ul class="pagination justify-content-center mb-0">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="?page=${currentPage - 1}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="?page=${i}">${i}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="?page=${currentPage + 1}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<!-- Create Announcement Modal -->
<div class="modal fade" id="createAnnouncementModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Tạo thông báo mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/lecturer/announcements/create" method="post" id="createAnnouncementForm">
                    <input type="hidden" name="action" value="create-announcement">

                    <!-- Tiêu đề -->
                    <div class="mb-3">
                        <label for="title" class="form-label">Tiêu đề <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="title" name="title" required>
                    </div>

                    <!-- Nội dung -->
                    <div class="mb-3">
                        <label for="content" class="form-label">Nội dung <span class="text-danger">*</span></label>
                        <textarea class="form-control" id="content" name="content" rows="5" required></textarea>
                    </div>

                    <!-- Dropdown + loại -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="courseId" class="form-label">Khóa học</label>
                            <select class="form-select" id="courseId" name="courseId">
                                <option value="">Thông báo chung (tất cả khóa học)</option>
                                <c:forEach var="course" items="${myCourses}">
                                    <option value="${course.courseId}">${course.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="type" class="form-label">Loại thông báo</label>
                            <select name="type" class="form-select">
                                <option value="general">Thông báo chung</option>
                                <option value="urgent">Khẩn cấp</option>
                                <option value="system">Hệ thống</option>
                                <option value="assignment">Bài tập</option>
                            </select>

                        </div>
                    </div>

                    <!-- Đối tượng -->
                    <div class="mb-3">
                        <label for="targetAudience" class="form-label">Đối tượng nhận</label>
                        <select name="target_audience" class="form-select">
                            <option value="all">Tất cả</option>
                            <option value="lecturers">Giảng viên</option>
                            <option value="students">Sinh viên</option>
                        </select>

                    </div>

                    <!-- Hết hạn -->
                    <div class="mb-3">
                        <label for="expiresAt" class="form-label">Ngày hết hạn</label>
                        <input type="date" class="form-control" id="expiresAt" name="expiresAt">
                    </div>

                    <!-- Pin -->
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="checkbox" id="sendEmail" name="sendEmail">
                        <label class="form-check-label" for="sendEmail">
                            Ghim thông báo (pinned)
                        </label>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="button" class="btn btn-primary" onclick="submitAnnouncementForm()">Đăng thông báo</button>
            </div>
        </div>
    </div>
</div>

<!-- View Announcement Modal -->
<div class="modal fade" id="viewAnnouncementModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="viewTitle"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <span class="badge bg-primary" id="viewCourse"></span>
                    <span class="badge bg-secondary" id="viewType"></span>
                    <span class="text-muted" id="viewDate"></span>
                </div>
                <div class="card">
                    <div class="card-body" id="viewContent"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteAnnouncementModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Xác nhận xóa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc chắn muốn xóa thông báo <strong id="deleteAnnouncementTitle"></strong>?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <form id="deleteAnnouncementForm" method="post" action="${pageContext.request.contextPath}/lecturer/announcements/delete">
                    <input type="hidden" name="announcementId" id="deleteAnnouncementId">
                    <button type="submit" class="btn btn-danger">Xóa</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function submitAnnouncementForm() {
        document.getElementById('createAnnouncementForm').submit();
    }

    function viewAnnouncement(id) {
        // In a real application, you would fetch the announcement details from the server
        // For now, we'll use a placeholder
        fetch('${pageContext.request.contextPath}/lecturer/announcements/' + id)
                .then(response => response.json())
                .then(data => {
                    document.getElementById('viewTitle').textContent = data.title;
                    document.getElementById('viewContent').textContent = data.content;
                    document.getElementById('viewCourse').textContent = data.courseName || 'Thông báo chung';
                    document.getElementById('viewType').textContent = data.type === 'urgent' ? 'Khẩn' :
                            data.type === 'course' ? 'Khóa học' : 'Chung';
                    document.getElementById('viewDate').textContent = new Date(data.createdAt).toLocaleString('vi-VN');

                    var viewModal = new bootstrap.Modal(document.getElementById('viewAnnouncementModal'));
                    viewModal.show();
                })
                .catch(error => {
                    console.error('Error fetching announcement:', error);
                    showToast('Không thể tải thông tin thông báo', 'danger');
                });
    }

    function editAnnouncement(id) {
        window.location.href = '${pageContext.request.contextPath}/lecturer/announcements/edit?id=' + id;
    }

    function confirmDeleteAnnouncement(id, title) {
        document.getElementById('deleteAnnouncementId').value = id;
        document.getElementById('deleteAnnouncementTitle').textContent = title;
        var deleteModal = new bootstrap.Modal(document.getElementById('deleteAnnouncementModal'));
        deleteModal.show();
    }
</script> 