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
                        <h2 class="mb-1">Quản lý bài kiểm tra</h2>
                        <p class="mb-0">Tạo và quản lý các bài kiểm tra, bài thi</p>
                    </div>
                    <div>
                        <button class="btn btn-light" data-bs-toggle="modal" data-bs-target="#createTestModal">
                            <i class="fas fa-plus me-2"></i>Tạo bài kiểm tra mới
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
                    <form action="${pageContext.request.contextPath}/lecturer/tests" method="get" class="row g-3">
                        <div class="col-md-4">
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-search"></i></span>
                                <input type="text" class="form-control" name="keyword" placeholder="Tìm kiếm bài kiểm tra..." value="${param.keyword}">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <select class="form-select" name="courseId">
                                <option value="">Tất cả khóa học</option>
                                <c:forEach var="course" items="${courses}">
                                    <option value="${course.courseId}" ${param.courseId == course.courseId ? 'selected' : ''}>${course.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <select class="form-select" name="status">
                                <option value="">Tất cả trạng thái</option>
                                <option value="upcoming" ${param.status == 'upcoming' ? 'selected' : ''}>Sắp diễn ra</option>
                                <option value="ongoing" ${param.status == 'ongoing' ? 'selected' : ''}>Đang diễn ra</option>
                                <option value="completed" ${param.status == 'completed' ? 'selected' : ''}>Đã kết thúc</option>
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

    <!-- Tests List -->
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Danh sách bài kiểm tra</h5>
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
                        <c:when test="${not empty tests}">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">Tiêu đề</th>
                                            <th scope="col">Mã khóa học</th>
                                            <th scope="col">Khóa học</th>
                                            <th scope="col">Loại</th>
                                            <th scope="col">Thời gian bắt đầu</th>
                                            <th scope="col">Thời lượng</th>
                                            <th scope="col">Điểm tối đa</th>
                                            <th scope="col">Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="test" items="${tests}" varStatus="loop">
                                            <tr>
                                                <td>${loop.index + 1}</td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/lecturer/tests/view/${test.testId}" class="text-decoration-none">
                                                        ${test.title}
                                                    </a>
                                                </td>
                                                <td>
                                                    <c:forEach var="course" items="${courses}">
                                                        <c:if test="${course.courseId == test.courseId}">${course.code}</c:if>
                                                    </c:forEach>
                                                </td>
                                                <td>
                                                    <c:forEach var="course" items="${courses}">
                                                        <c:if test="${course.courseId == test.courseId}">${course.name}</c:if>
                                                    </c:forEach>
                                                </td>
                                                <td>${test.testType}</td>
                                                <td><fmt:formatDate value="${test.startTime}" pattern="dd/MM/yyyy HH:mm" /></td>
                                                <td>${test.duration} phút</td>
                                                <td>${test.maxScore}</td>
                                                
                                                <td>
                                                    <div class="dropdown">
                                                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="dropdownMenuButton${test.testId}" data-bs-toggle="dropdown" aria-expanded="false">
                                                            <i class="fas fa-ellipsis-v"></i>
                                                        </button>
                                                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton${test.testId}">
                                                            <li>
                                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/lecturer/tests/view/${test.testId}">
                                                                    <i class="fas fa-eye me-2"></i>Xem chi tiết
                                                                </a>
                                                            </li>
                                                            <!--
                                                            <li>
                                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/lecturer/tests/${test.testId}/edit">
                                                                    <i class="fas fa-edit me-2"></i>Chỉnh sửa
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/lecturer/tests/${test.testId}/results">
                                                                    <i class="fas fa-chart-bar me-2"></i>Xem kết quả
                                                                </a>
                                                            </li>
                                                            -->
                                                            <li><hr class="dropdown-divider"></li>
                                                            <li>
                                                                <a class="dropdown-item text-danger" href="#" onclick="confirmDeleteTest('${test.testId}', '${test.title}')">
                                                                    <i class="fas fa-trash me-2"></i>Xóa
                                                                </a>
                                                            </li>
                                                            
                                                        </ul>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <div class="display-6 text-muted mb-3">
                                    <i class="fas fa-clipboard-check"></i>
                                </div>
                                <h4>Không có bài kiểm tra nào</h4>
                                <p class="text-muted">Hãy tạo bài kiểm tra đầu tiên của bạn</p>
                                <button class="btn btn-primary mt-3" data-bs-toggle="modal" data-bs-target="#createTestModal">
                                    <i class="fas fa-plus me-2"></i>Tạo bài kiểm tra mới
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

<!-- Create Test Modal -->
<div class="modal fade" id="createTestModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Tạo bài kiểm tra mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/lecturer/tests/create" method="post" id="createTestForm" class="needs-validation" novalidate>
                    <input type="hidden" name="action" value="create-test" />
                    <div class="mb-3">
                        <label for="title" class="form-label">Tiêu đề <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="title" name="title" required>
                        <div class="invalid-feedback">
                            Vui lòng nhập tiêu đề bài kiểm tra
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="description" class="form-label">Mô tả</label>
                        <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="courseId" class="form-label">Khóa học <span class="text-danger">*</span></label>
                            <select class="form-select" id="courseId" name="courseId" required>
                                <option value="" selected disabled>-- Chọn khóa học --</option>
                                <c:forEach var="course" items="${courses}">
                                    <option value="${course.courseId}">${course.name}</option>
                                </c:forEach>
                            </select>
                            <div class="invalid-feedback">
                                Vui lòng chọn khóa học
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="testType" class="form-label">Loại bài kiểm tra <span class="text-danger">*</span></label>
                            <select class="form-select" id="testType" name="testType" required>
                                <option value="" selected disabled>-- Chọn loại --</option>
                                <option value="quiz">Bài kiểm tra nhanh</option>
                                <option value="midterm">Kiểm tra giữa kỳ</option>
                                <option value="final">Thi cuối kỳ</option>
                                <option value="practice">Bài tập thực hành</option>
                            </select>
                            <div class="invalid-feedback">
                                Vui lòng chọn loại bài kiểm tra
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="startDate" class="form-label">Ngày bắt đầu <span class="text-danger">*</span></label>
                            <input type="date" class="form-control" id="startDate" name="startDate" required>
                            <div class="invalid-feedback">
                                Vui lòng chọn ngày bắt đầu
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="startTime" class="form-label">Giờ bắt đầu <span class="text-danger">*</span></label>
                            <input type="time" class="form-control" id="startTime" name="startTime" required>
                            <div class="invalid-feedback">
                                Vui lòng chọn giờ bắt đầu
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="duration" class="form-label">Thời lượng (phút) <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" id="duration" name="duration" min="5" max="300" required>
                            <div class="invalid-feedback">
                                Vui lòng nhập thời lượng hợp lệ (5-300 phút)
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="maxScore" class="form-label">Điểm tối đa <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" id="maxScore" name="maxScore" min="1" max="100" required>
                            <div class="invalid-feedback">
                                Vui lòng nhập điểm tối đa hợp lệ (1-100)
                            </div>
                        </div>
                    </div>
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="checkbox" id="notifyStudents" name="notifyStudents">
                        <label class="form-check-label" for="notifyStudents">
                            Thông báo cho sinh viên về bài kiểm tra mới
                        </label>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="button" class="btn btn-primary" onclick="submitTestForm()">Tạo bài kiểm tra</button>
            </div>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteTestModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Xác nhận xóa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc chắn muốn xóa bài kiểm tra <strong id="deleteTestTitle"></strong>?</p>
                <p class="text-danger">Lưu ý: Hành động này sẽ xóa tất cả dữ liệu liên quan đến bài kiểm tra này, bao gồm cả kết quả của sinh viên.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <form id="deleteTestForm" method="post" action="${pageContext.request.contextPath}/lecturer/tests/delete">
                    <input type="hidden" name="testId" id="deleteTestId">
                    <button type="submit" class="btn btn-danger">Xóa</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    // Form validation
    (function() {
        'use strict';
        
        var forms = document.querySelectorAll('.needs-validation');
        
        Array.prototype.slice.call(forms).forEach(function(form) {
            form.addEventListener('submit', function(event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                
                form.classList.add('was-validated');
            }, false);
        });
    })();
    
    function submitTestForm() {
        var form = document.getElementById('createTestForm');
        if (form.checkValidity()) {
            form.submit();
        } else {
            form.classList.add('was-validated');
        }
    }
    
    function confirmDeleteTest(id, title) {
        document.getElementById('deleteTestId').value = id;
        document.getElementById('deleteTestTitle').textContent = title;
        var deleteModal = new bootstrap.Modal(document.getElementById('deleteTestModal'));
        deleteModal.show();
    }
</script> 