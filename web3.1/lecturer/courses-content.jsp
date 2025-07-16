<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid">
    <!-- Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="profile-header">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h2 class="mb-1">Quản lý khóa học</h2>
                        <p class="mb-0">Danh sách các khóa học của bạn</p>
                    </div>
                    <div>
                        <a href="${pageContext.request.contextPath}/lecturer/courses/create" class="btn btn-light">
                            <i class="fas fa-plus me-2"></i>Tạo khóa học mới
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Search and Filter -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/lecturer/courses/search" method="get" class="row g-3">
                        <div class="col-md-4">
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-search"></i></span>
                                <input type="text" class="form-control" name="keyword" placeholder="Tìm kiếm khóa học..." value="${param.keyword}">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <select class="form-select" name="semester">
                                <option value="">Tất cả học kỳ</option>
                                <c:forEach var="semester" items="${semesters}">
                                    <option value="${semester.id}" ${param.semester == semester.id ? 'selected' : ''}>${semester.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <select class="form-select" name="status">
                                <option value="">Tất cả trạng thái</option>
                                <option value="active" ${param.status == 'active' ? 'selected' : ''}>Đang hoạt động</option>
                                <option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Không hoạt động</option>
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

    <!-- Course List -->
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Danh sách khóa học</h5>
                    <div class="dropdown">
                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="sortDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                            Sắp xếp
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="sortDropdown">
                            <li><a class="dropdown-item" href="?sort=name&order=asc">Tên (A-Z)</a></li>
                            <li><a class="dropdown-item" href="?sort=name&order=desc">Tên (Z-A)</a></li>
                            <li><a class="dropdown-item" href="?sort=code&order=asc">Mã khóa học (A-Z)</a></li>
                            <li><a class="dropdown-item" href="?sort=code&order=desc">Mã khóa học (Z-A)</a></li>
                            <li><a class="dropdown-item" href="?sort=students&order=desc">Số sinh viên (Cao-Thấp)</a></li>
                            <li><a class="dropdown-item" href="?sort=students&order=asc">Số sinh viên (Thấp-Cao)</a></li>
                        </ul>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row g-4">
                        <c:choose>
                            <c:when test="${not empty myCourses}">
                                <c:forEach var="course" items="${myCourses}">
                                    <div class="col-md-6 col-lg-4">
                                        <div class="card h-100 ${course.active ? 'border-success' : 'border-secondary'}" style="border-left-width: 5px;">
                                            <div class="card-body">
                                                <h5 class="card-title mb-1">
                                                    <a href="${pageContext.request.contextPath}/lecturer/courses/${course.id}" class="text-decoration-none">
                                                        ${course.name}
                                                    </a>
                                                </h5>
                                                <p class="text-muted mb-2">Mã: ${course.courseCode}</p>
                                                <div class="d-flex justify-content-between mb-3">
                                                    <span class="badge ${course.active ? 'bg-success' : 'bg-secondary'}">
                                                        ${course.active ? 'Đang hoạt động' : 'Không hoạt động'}
                                                    </span>
                                                    <span class="badge bg-info">${course.semester.name}</span>
                                                </div>
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <i class="fas fa-users me-1"></i> ${course.studentCount} sinh viên
                                                    </div>
                                                    <div class="dropdown">
                                                        <button class="btn btn-sm btn-outline-secondary" type="button" id="dropdownMenuButton${course.id}" data-bs-toggle="dropdown" aria-expanded="false">
                                                            <i class="fas fa-ellipsis-v"></i>
                                                        </button>
                                                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton${course.id}">
                                                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/lecturer/courses/${course.id}">
                                                                <i class="fas fa-eye me-2"></i>Xem chi tiết
                                                            </a></li>
                                                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/lecturer/courses/${course.id}/edit">
                                                                <i class="fas fa-edit me-2"></i>Chỉnh sửa
                                                            </a></li>
                                                            <li><hr class="dropdown-divider"></li>
                                                            <li><a class="dropdown-item text-danger" href="#" onclick="confirmDelete(${course.id}, '${course.name}')">
                                                                <i class="fas fa-trash me-2"></i>Xóa
                                                            </a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="col-12 text-center py-5">
                                    <div class="display-6 text-muted mb-3">
                                        <i class="fas fa-book"></i>
                                    </div>
                                    <h4>Không tìm thấy khóa học nào</h4>
                                    <p class="text-muted">Bạn chưa có khóa học nào hoặc không có khóa học nào phù hợp với bộ lọc.</p>
                                    <a href="${pageContext.request.contextPath}/lecturer/courses/create" class="btn btn-primary mt-3">
                                        <i class="fas fa-plus me-2"></i>Tạo khóa học mới
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
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
                <form id="deleteForm" method="post" action="${pageContext.request.contextPath}/lecturer/courses">
                    <input type="hidden" name="action" value="delete-course">
                    <input type="hidden" name="id" id="courseId">
                    <button type="submit" class="btn btn-danger">Xóa</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function confirmDelete(id, name) {
        document.getElementById('courseId').value = id;
        document.getElementById('courseName').textContent = name;
        var deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
        deleteModal.show();
    }
</script> 