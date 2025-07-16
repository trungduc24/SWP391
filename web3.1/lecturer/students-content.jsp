<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="container-fluid py-4">
    <div class="row mb-4">
        <div class="col-12">
            <div class="card shadow-sm border-0 rounded-4 bg-primary text-bg-primary">
                <div class="card-body py-4 px-4 d-flex justify-content-between align-items-center">
                    <div>
                        <h2 class="mb-1 text-white">Quản lý sinh viên</h2>
                        <p class="mb-0 text-white-50">Danh sách sinh viên đăng ký khóa học của bạn</p>
                    </div>
                    <div>
                        <button class="btn btn-light btn-lg shadow-sm rounded-pill px-4" data-bs-toggle="modal" data-bs-target="#importStudentsModal">
                            <i class="fas fa-cloud-upload-alt me-2"></i>Nhập danh sách
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row mb-4">
        <div class="col-12">
            <div class="card shadow-sm border-0 rounded-4">
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/lecturer/students" method="get" class="row g-3 align-items-end">
                        <div class="col-md-4 col-lg-3">
                            <label for="keywordInput" class="form-label text-muted">Tìm kiếm</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-search"></i></span>
                                <input type="text" class="form-control" id="keywordInput" name="keyword" placeholder="Theo tên, MSSV, email..." value="${param.keyword}">
                            </div>
                        </div>
                        <div class="col-md-4 col-lg-3">
                            <label for="courseSelectFilter" class="form-label text-muted">Khóa học</label>
                            <select class="form-select" id="courseSelectFilter" name="courseId">
                                <option value="">Tất cả khóa học</option>
                                <c:forEach var="course" items="${myCourses}">
                                    <option value="${course.id}" ${param.courseId == course.id ? 'selected' : ''}>${course.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-3 col-lg-3">
                            <label for="statusSelectFilter" class="form-label text-muted">Trạng thái</label>
                            <select class="form-select" id="statusSelectFilter" name="status">
                                <option value="">Tất cả trạng thái</option>
                                <option value="active" ${param.status == 'active' ? 'selected' : ''}>Đang học</option>
                                <option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Đã rút</option>
                            </select>
                        </div>
                        <div class="col-md-1 col-lg-3 d-grid">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-filter me-2"></i>Lọc
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <div class="card shadow-sm border-0 rounded-4">
                <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
                    <h5 class="mb-0 text-primary">Danh sách sinh viên</h5>
                    <div>
                        <button class="btn btn-outline-secondary me-2" id="exportBtn">
                            <i class="fas fa-file-export me-1"></i>Xuất Excel
                        </button>
                        <div class="btn-group">
                            <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="sortDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                Sắp xếp <i class="fas fa-sort me-1"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end shadow-sm" aria-labelledby="sortDropdown">
                                <li><a class="dropdown-item" href="?sort=name&order=asc">Tên (A-Z)</a></li>
                                <li><a class="dropdown-item" href="?sort=name&order=desc">Tên (Z-A)</a></li>
                                <li><a class="dropdown-item" href="?sort=id&order=asc">MSSV (Tăng dần)</a></li>
                                <li><a class="dropdown-item" href="?sort=id&order=desc">MSSV (Giảm dần)</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover table-striped mb-0">
                            <thead>
                                <tr>
                                    <th scope="col" class="text-center">#</th>
                                    <th scope="col">MSSV</th>
                                    <th scope="col">Họ và tên</th>
                                    <th scope="col">Email</th>
                                    <th scope="col">Khóa học</th>
                                    <th scope="col">Trạng thái</th>
                                    <th scope="col" class="text-center">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty students}">
                                        <c:forEach var="student" items="${students}" varStatus="loop">
                                            <tr>
                                                <td class="text-center">${loop.index + 1}</td>
                                                <td>${student.studentId}</td>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <div class="avatar rounded-circle bg-secondary text-white d-flex align-items-center justify-content-center me-2" style="width: 36px; height: 36px; font-size: 0.9rem;">
                                                            <c:out value="${fn:substring(student.fullName, 0, 1)}" />
                                                        </div>
                                                        <div>${student.fullName}</div>
                                                    </div>
                                                </td>
                                                <td>${student.email}</td>
                                                <td>${student.courseName}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${student.active}">
                                                            <span class="badge bg-success-subtle text-success py-2 px-3 rounded-pill">Đang học</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary-subtle text-secondary py-2 px-3 rounded-pill">Đã rút</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-center">
                                                    <div class="dropdown">
                                                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="dropdownMenuButton${student.id}" data-bs-toggle="dropdown" aria-expanded="false">
                                                            <i class="fas fa-ellipsis-h"></i>
                                                        </button>
                                                        <ul class="dropdown-menu shadow-sm" aria-labelledby="dropdownMenuButton${student.id}">
                                                            <li>
                                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/lecturer/students/${student.id}">
                                                                    <i class="fas fa-eye me-2"></i>Xem chi tiết
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/lecturer/grades?studentId=${student.id}">
                                                                    <i class="fas fa-chart-line me-2"></i>Xem điểm
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/lecturer/attendance?studentId=${student.id}">
                                                                    <i class="fas fa-calendar-check me-2"></i>Điểm danh
                                                                </a>
                                                            </li>
                                                            <li><hr class="dropdown-divider"></li>
                                                            <li>
                                                                <a class="dropdown-item text-danger" href="#" onclick="confirmRemoveStudent(${student.id}, '${student.fullName}', ${student.enrollmentId})">
                                                                    <i class="fas fa-user-minus me-2"></i>Xóa khỏi khóa học
                                                                </a>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="7" class="text-center py-5">
                                                <div class="text-muted">
                                                    <i class="fas fa-users-slash fa-4x mb-3 text-secondary"></i>
                                                    <p class="fs-5">Không tìm thấy sinh viên nào trong danh sách này.</p>
                                                    <p>Hãy thử điều chỉnh bộ lọc hoặc thêm sinh viên mới.</p>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>

                <c:if test="${totalPages > 1}">
                    <div class="card-footer bg-light py-3">
                        <nav aria-label="Page navigation">
                            <ul class="pagination justify-content-center mb-0">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="?page=${currentPage - 1}&keyword=${param.keyword}&courseId=${param.courseId}&status=${param.status}&sort=${param.sort}&order=${param.order}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="?page=${i}&keyword=${param.keyword}&courseId=${param.courseId}&status=${param.status}&sort=${param.sort}&order=${param.order}">${i}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="?page=${currentPage + 1}&keyword=${param.keyword}&courseId=${param.courseId}&status=${param.status}&sort=${param.sort}&order=${param.order}" aria-label="Next">
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

<div class="modal fade" id="importStudentsModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 shadow-lg">
            <div class="modal-header bg-primary text-white p-4">
                <h5 class="modal-title"><i class="fas fa-file-excel me-2"></i>Nhập danh sách sinh viên</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <form action="${pageContext.request.contextPath}/lecturer/students/import" method="post" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="courseSelect" class="form-label fw-bold">Chọn khóa học <span class="text-danger">*</span></label>
                        <select class="form-select" id="courseSelect" name="courseId" required>
                            <option value="" selected disabled>-- Chọn khóa học --</option>
                            <c:forEach var="course" items="${myCourses}">
                                <option value="${course.id}">${course.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="studentFile" class="form-label fw-bold">Chọn file Excel <span class="text-danger">*</span></label>
                        <input type="file" class="form-control" id="studentFile" name="studentFile" accept=".xlsx, .xls" required>
                        <div class="form-text mt-2">Chỉ chấp nhận file Excel (.xlsx, .xls).</div>
                    </div>
                    <div class="mb-4 text-center">
                        <a href="${pageContext.request.contextPath}/templates/student_import_template.xlsx" download class="btn btn-outline-info rounded-pill px-4">
                            <i class="fas fa-download me-1"></i> Tải mẫu nhập liệu
                        </a>
                    </div>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary btn-lg rounded-pill">
                            <i class="fas fa-cloud-upload-alt me-2"></i>Thực hiện nhập
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="removeStudentModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 shadow-lg">
            <div class="modal-header bg-warning text-white p-3">
                <h5 class="modal-title"><i class="fas fa-exclamation-triangle me-2"></i>Xác nhận xóa sinh viên</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <p class="lead">Bạn có chắc chắn muốn xóa sinh viên <strong id="studentName" class="text-primary"></strong> khỏi khóa học này?</p>
                <p class="text-danger small">Lưu ý: Hành động này sẽ xóa tất cả dữ liệu liên quan đến sinh viên trong khóa học này (điểm số, điểm danh, v.v.) và không thể hoàn tác.</p>
            </div>
            <div class="modal-footer d-flex justify-content-between p-3">
                <button type="button" class="btn btn-secondary rounded-pill px-4" data-bs-dismiss="modal">Hủy bỏ</button>
                <form id="removeStudentForm" method="post" action="${pageContext.request.contextPath}/lecturer/students/remove">
                    <input type="hidden" name="studentId" id="removeStudentId">
                    <input type="hidden" name="enrollmentId" id="removeEnrollmentId">
                    <button type="submit" class="btn btn-danger rounded-pill px-4"><i class="fas fa-trash-alt me-2"></i>Xóa vĩnh viễn</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function confirmRemoveStudent(studentId, name, enrollmentId) {
        document.getElementById('removeStudentId').value = studentId;
        document.getElementById('removeEnrollmentId').value = enrollmentId;
        document.getElementById('studentName').textContent = name;
        var removeModal = new bootstrap.Modal(document.getElementById('removeStudentModal'));
        removeModal.show();
    }

    // Export to Excel
    document.getElementById('exportBtn').addEventListener('click', function() {
        window.location.href = '${pageContext.request.contextPath}/lecturer/students/export' + window.location.search;
    });

    // Add search and filter parameters to pagination links
    document.querySelectorAll('.pagination .page-link').forEach(link => {
        const url = new URL(link.href);
        const searchParams = new URLSearchParams(window.location.search);

        // Preserve existing search and filter parameters
        ['keyword', 'courseId', 'status', 'sort', 'order'].forEach(param => {
            if (searchParams.has(param)) {
                url.searchParams.set(param, searchParams.get(param));
            }
        });
        link.href = url.toString();
    });
</script>