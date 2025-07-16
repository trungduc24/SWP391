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
                        <h2 class="mb-1">${course.name}</h2>
                        <p class="mb-0">Mã khóa học: <strong>${course.courseCode}</strong></p>
                    </div>
                    <div>
                        <a href="${pageContext.request.contextPath}/lecturer/courses/${course.id}/edit" class="btn btn-primary">
                            <i class="fas fa-edit me-2"></i>Chỉnh sửa
                        </a>
                        <a href="${pageContext.request.contextPath}/lecturer/courses" class="btn btn-light ms-2">
                            <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Course Status -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <span class="badge ${course.active ? 'bg-success' : 'bg-secondary'} p-2">
                                <i class="fas ${course.active ? 'fa-check-circle' : 'fa-pause-circle'} me-1"></i>
                                ${course.active ? 'Đang hoạt động' : 'Không hoạt động'}
                            </span>
                            <span class="badge bg-info p-2 ms-2">
                                <i class="fas fa-calendar-alt me-1"></i>
                                ${course.semester.name}
                            </span>
                        </div>
                        <div>
                            <button type="button" class="btn btn-sm btn-danger" onclick="confirmDelete(${course.id}, '${course.name}')">
                                <i class="fas fa-trash me-2"></i>Xóa khóa học
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Course Information -->
        <div class="col-md-8">
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Thông tin khóa học</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <div class="fw-bold text-muted">ID khóa học</div>
                            <div>#${course.id}</div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="fw-bold text-muted">Mã khóa học</div>
                            <div>${course.courseCode}</div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="fw-bold text-muted">Tên khóa học</div>
                            <div>${course.name}</div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="fw-bold text-muted">Phòng học</div>
                            <div>${not empty course.room ? course.room : 'Chưa xác định'}</div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="fw-bold text-muted">Số tín chỉ</div>
                            <div>${course.credits}</div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="fw-bold text-muted">Số sinh viên tối đa</div>
                            <div>${course.maxStudents > 0 ? course.maxStudents : 'Không giới hạn'}</div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="fw-bold text-muted">Ngày bắt đầu</div>
                            <div>
                                <c:if test="${not empty course.startDate}">
                                    <fmt:formatDate value="${course.startDate}" pattern="dd/MM/yyyy"/>
                                </c:if>
                                <c:if test="${empty course.startDate}">Chưa xác định</c:if>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="fw-bold text-muted">Ngày kết thúc</div>
                            <div>
                                <c:if test="${not empty course.endDate}">
                                    <fmt:formatDate value="${course.endDate}" pattern="dd/MM/yyyy"/>
                                </c:if>
                                <c:if test="${empty course.endDate}">Chưa xác định</c:if>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="fw-bold text-muted">Lịch học</div>
                            <div>${not empty course.schedule ? course.schedule : 'Chưa xác định'}</div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="fw-bold text-muted">Số sinh viên đã đăng ký</div>
                            <div>${course.studentCount} sinh viên</div>
                        </div>
                    </div>
                    
                    <c:if test="${not empty course.description}">
                        <div class="mb-3">
                            <div class="fw-bold text-muted">Mô tả khóa học</div>
                            <div class="mt-2">${course.description}</div>
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty course.objectives}">
                        <div>
                            <div class="fw-bold text-muted">Mục tiêu khóa học</div>
                            <div class="mt-2">${course.objectives}</div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="col-md-4">
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0"><i class="fas fa-bolt me-2"></i>Thao tác nhanh</h5>
                </div>
                <div class="card-body">
                    <div class="d-grid gap-2">
                        <a href="${pageContext.request.contextPath}/lecturer/courses/${course.id}/edit" class="btn btn-warning">
                            <i class="fas fa-edit me-2"></i>Chỉnh sửa khóa học
                        </a>
                        <a href="${pageContext.request.contextPath}/lecturer/tests?courseId=${course.id}" class="btn btn-info">
                            <i class="fas fa-clipboard-list me-2"></i>Quản lý bài kiểm tra
                        </a>
                        <a href="${pageContext.request.contextPath}/lecturer/grades?courseId=${course.id}" class="btn btn-success">
                            <i class="fas fa-chart-line me-2"></i>Chấm điểm
                        </a>
                        <a href="${pageContext.request.contextPath}/lecturer/materials?courseId=${course.id}" class="btn btn-secondary">
                            <i class="fas fa-folder me-2"></i>Tài liệu khóa học
                        </a>
                        <a href="${pageContext.request.contextPath}/lecturer/announcements?courseId=${course.id}" class="btn btn-primary">
                            <i class="fas fa-bullhorn me-2"></i>Thông báo
                        </a>
                    </div>
                </div>
            </div>

            <!-- Statistics -->
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0"><i class="fas fa-chart-bar me-2"></i>Thống kê</h5>
                </div>
                <div class="card-body">
                    <div class="row text-center">
                        <div class="col-6 mb-3">
                            <div class="fw-bold text-muted">Sinh viên đăng ký</div>
                            <div class="fs-4 text-primary">${course.studentCount}</div>
                        </div>
                        <div class="col-6 mb-3">
                            <div class="fw-bold text-muted">Bài kiểm tra</div>
                            <div class="fs-4 text-info">${testCount}</div>
                        </div>
                        <div class="col-6 mb-3">
                            <div class="fw-bold text-muted">Tài liệu</div>
                            <div class="fs-4 text-success">${materialCount}</div>
                        </div>
                        <div class="col-6 mb-3">
                            <div class="fw-bold text-muted">Thông báo</div>
                            <div class="fs-4 text-warning">${announcementCount}</div>
                        </div>
                    </div>
                </div>
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