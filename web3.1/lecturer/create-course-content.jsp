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
                        <h2 class="mb-1">Tạo khóa học mới</h2>
                        <p class="mb-0">Nhập thông tin chi tiết để tạo khóa học mới</p>
                    </div>
                    <div>
                        <a href="${pageContext.request.contextPath}/lecturer/courses" class="btn btn-light">
                            <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Course Creation Form -->
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/lecturer/courses" method="post" class="needs-validation" novalidate>
                        <input type="hidden" name="action" value="create-course">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="courseName" class="form-label">Tên khóa học <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="courseName" name="courseName" required>
                                <div class="invalid-feedback">
                                    Vui lòng nhập tên khóa học
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label for="courseCode" class="form-label">Mã khóa học <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="courseCode" name="courseCode" required>
                                <div class="invalid-feedback">
                                    Vui lòng nhập mã khóa học
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="semesterId" class="form-label">Học kỳ <span class="text-danger">*</span></label>
                                <select class="form-select" id="semesterId" name="semesterId" required>
                                    <option value="" selected disabled>Chọn học kỳ</option>
                                    <c:forEach var="semester" items="${semesters}">
                                        <option value="${semester.id}">${semester.name}</option>
                                    </c:forEach>
                                </select>
                                <div class="invalid-feedback">
                                    Vui lòng chọn học kỳ
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label for="credits" class="form-label">Số tín chỉ <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="credits" name="credits" min="1" max="10" required>
                                <div class="invalid-feedback">
                                    Vui lòng nhập số tín chỉ hợp lệ (1-10)
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="room" class="form-label">Phòng học</label>
                                <input type="text" class="form-control" id="room" name="room">
                            </div>
                            <div class="col-md-6">
                                <label for="maxStudents" class="form-label">Số sinh viên tối đa</label>
                                <input type="number" class="form-control" id="maxStudents" name="maxStudents" min="1">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="startDate" class="form-label">Ngày bắt đầu</label>
                                <input type="date" class="form-control" id="startDate" name="startDate">
                            </div>
                            <div class="col-md-6">
                                <label for="endDate" class="form-label">Ngày kết thúc</label>
                                <input type="date" class="form-control" id="endDate" name="endDate">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="schedule" class="form-label">Lịch học</label>
                                <input type="text" class="form-control" id="schedule" name="schedule" placeholder="Ví dụ: Thứ 2, 4 (14:00 - 16:00)">
                            </div>
                            <div class="col-md-6">
                                <label for="active" class="form-label">Trạng thái</label>
                                <div class="form-check form-switch mt-2">
                                    <input class="form-check-input" type="checkbox" id="active" name="active" checked>
                                    <label class="form-check-label" for="active">Kích hoạt khóa học</label>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="description" class="form-label">Mô tả khóa học</label>
                            <textarea class="form-control" id="description" name="description" rows="4"></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="objectives" class="form-label">Mục tiêu khóa học</label>
                            <textarea class="form-control" id="objectives" name="objectives" rows="4"></textarea>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <button type="reset" class="btn btn-light me-md-2">
                                <i class="fas fa-redo me-2"></i>Làm mới
                            </button>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-2"></i>Tạo khóa học
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Form validation
    (function() {
        'use strict';
        
        // Fetch all forms that need validation
        var forms = document.querySelectorAll('.needs-validation');
        
        // Loop over them and prevent submission
        Array.prototype.slice.call(forms).forEach(function(form) {
            form.addEventListener('submit', function(event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                
                form.classList.add('was-validated');
            }, false);
        });
        
        // Date validation
        document.getElementById('startDate').addEventListener('change', function() {
            var startDate = this.value;
            document.getElementById('endDate').min = startDate;
        });
        
        document.getElementById('endDate').addEventListener('change', function() {
            var endDate = this.value;
            document.getElementById('startDate').max = endDate;
        });
    })();
</script> 