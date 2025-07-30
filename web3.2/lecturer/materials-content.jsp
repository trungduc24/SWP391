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
                        <h2 class="mb-1">Quản lý tài liệu</h2>
                        <p class="mb-0">Tải lên và quản lý tài liệu học tập cho sinh viên</p>
                    </div>
                    <div>
                        <button class="btn btn-light" data-bs-toggle="modal" data-bs-target="#uploadMaterialModal">
                            <i class="fas fa-upload me-2"></i>Tải lên tài liệu
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
                    <form action="${pageContext.request.contextPath}/lecturer/materials" method="get" class="row g-3">
                        <div class="col-md-4">
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-search"></i></span>
                                <input type="text" class="form-control" name="keyword" placeholder="Tìm kiếm tài liệu..." value="${param.keyword}">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <select class="form-select" name="courseId">
                                <option value="">Tất cả khóa học</option>
                                <c:forEach var="course" items="${myCourses}">
                                    <option value="${course.id}" ${param.courseId == course.id ? 'selected' : ''}>${course.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <select class="form-select" name="type">
                                <option value="">Tất cả loại</option>
                                <option value="document" ${param.type == 'document' ? 'selected' : ''}>Tài liệu</option>
                                <option value="presentation" ${param.type == 'presentation' ? 'selected' : ''}>Bài giảng</option>
                                <option value="exercise" ${param.type == 'exercise' ? 'selected' : ''}>Bài tập</option>
                                <option value="reference" ${param.type == 'reference' ? 'selected' : ''}>Tài liệu tham khảo</option>
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

    <!-- Materials List -->
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Danh sách tài liệu</h5>
                    <div class="btn-group">
                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="sortDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                            Sắp xếp
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="sortDropdown">
                            <li><a class="dropdown-item" href="?sort=date&order=desc">Mới nhất</a></li>
                            <li><a class="dropdown-item" href="?sort=date&order=asc">Cũ nhất</a></li>
                            <li><a class="dropdown-item" href="?sort=name&order=asc">Tên (A-Z)</a></li>
                            <li><a class="dropdown-item" href="?sort=name&order=desc">Tên (Z-A)</a></li>
                            <li><a class="dropdown-item" href="?sort=downloads&order=desc">Lượt tải (Cao-Thấp)</a></li>
                        </ul>
                    </div>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty materials}">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">Tên tài liệu</th>
                                            <th scope="col">Loại</th>
                                            <th scope="col">Khóa học</th>
                                            <th scope="col">Kích thước</th>
                                            <th scope="col">Ngày tải lên</th>
                                            <th scope="col">Lượt tải</th>
                                            <th scope="col">Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="material" items="${materials}" varStatus="loop">
                                            <tr>
                                                <td>${loop.index + 1}</td>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <div class="me-2">
                                                            <c:choose>
                                                                <c:when test="${material.fileType == 'pdf'}">
                                                                    <i class="fas fa-file-pdf text-danger"></i>
                                                                </c:when>
                                                                <c:when test="${material.fileType == 'doc' || material.fileType == 'docx'}">
                                                                    <i class="fas fa-file-word text-primary"></i>
                                                                </c:when>
                                                                <c:when test="${material.fileType == 'xls' || material.fileType == 'xlsx'}">
                                                                    <i class="fas fa-file-excel text-success"></i>
                                                                </c:when>
                                                                <c:when test="${material.fileType == 'ppt' || material.fileType == 'pptx'}">
                                                                    <i class="fas fa-file-powerpoint text-warning"></i>
                                                                </c:when>
                                                                <c:when test="${material.fileType == 'zip' || material.fileType == 'rar'}">
                                                                    <i class="fas fa-file-archive text-secondary"></i>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <i class="fas fa-file text-info"></i>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <div>${material.title}</div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${material.type == 'document'}">
                                                            <span class="badge bg-primary">Tài liệu</span>
                                                        </c:when>
                                                        <c:when test="${material.type == 'presentation'}">
                                                            <span class="badge bg-warning">Bài giảng</span>
                                                        </c:when>
                                                        <c:when test="${material.type == 'exercise'}">
                                                            <span class="badge bg-success">Bài tập</span>
                                                        </c:when>
                                                        <c:when test="${material.type == 'reference'}">
                                                            <span class="badge bg-info">Tham khảo</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary">Khác</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${material.courseName}</td>
                                                <td>${material.fileSize}</td>
                                                <td><fmt:formatDate value="${material.uploadDate}" pattern="dd/MM/yyyy" /></td>
                                                <td>${material.downloads}</td>
                                                <td>
                                                    <div class="dropdown">
                                                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="dropdownMenuButton${material.id}" data-bs-toggle="dropdown" aria-expanded="false">
                                                            <i class="fas fa-ellipsis-v"></i>
                                                        </button>
                                                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton${material.id}">
                                                            <li>
                                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/lecturer/materials/download/${material.id}">
                                                                    <i class="fas fa-download me-2"></i>Tải xuống
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a class="dropdown-item" href="#" onclick="editMaterial(${material.id})">
                                                                    <i class="fas fa-edit me-2"></i>Chỉnh sửa
                                                                </a>
                                                            </li>
                                                            <li><hr class="dropdown-divider"></li>
                                                            <li>
                                                                <a class="dropdown-item text-danger" href="#" onclick="confirmDeleteMaterial(${material.id}, '${material.title}')">
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
                                    <i class="fas fa-file-alt"></i>
                                </div>
                                <h4>Không có tài liệu nào</h4>
                                <p class="text-muted">Hãy tải lên tài liệu đầu tiên của bạn</p>
                                <button class="btn btn-primary mt-3" data-bs-toggle="modal" data-bs-target="#uploadMaterialModal">
                                    <i class="fas fa-upload me-2"></i>Tải lên tài liệu
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

<!-- Upload Material Modal -->
<div class="modal fade" id="uploadMaterialModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Tải lên tài liệu mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/lecturer/materials/upload" method="post" enctype="multipart/form-data" id="uploadMaterialForm" class="needs-validation" novalidate>
                    <div class="mb-3">
                        <label for="title" class="form-label">Tiêu đề <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="title" name="title" required>
                        <div class="invalid-feedback">
                            Vui lòng nhập tiêu đề tài liệu
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
                                <c:forEach var="course" items="${myCourses}">
                                    <option value="${course.id}">${course.name}</option>
                                </c:forEach>
                            </select>
                            <div class="invalid-feedback">
                                Vui lòng chọn khóa học
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="type" class="form-label">Loại tài liệu <span class="text-danger">*</span></label>
                            <select class="form-select" id="type" name="type" required>
                                <option value="" selected disabled>-- Chọn loại --</option>
                                <option value="document">Tài liệu</option>
                                <option value="presentation">Bài giảng</option>
                                <option value="exercise">Bài tập</option>
                                <option value="reference">Tài liệu tham khảo</option>
                            </select>
                            <div class="invalid-feedback">
                                Vui lòng chọn loại tài liệu
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="materialFile" class="form-label">Chọn file <span class="text-danger">*</span></label>
                        <input type="file" class="form-control" id="materialFile" name="materialFile" required>
                        <div class="invalid-feedback">
                            Vui lòng chọn file tài liệu
                        </div>
                        <div class="form-text">
                            Định dạng hỗ trợ: PDF, Word, Excel, PowerPoint, ZIP, RAR (tối đa 50MB)
                        </div>
                    </div>
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="checkbox" id="notifyStudents" name="notifyStudents">
                        <label class="form-check-label" for="notifyStudents">
                            Thông báo cho sinh viên về tài liệu mới
                        </label>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="button" class="btn btn-primary" onclick="submitMaterialForm()">Tải lên</button>
            </div>
        </div>
    </div>
</div>

<!-- Edit Material Modal -->
<div class="modal fade" id="editMaterialModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Chỉnh sửa tài liệu</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/lecturer/materials/edit" method="post" id="editMaterialForm">
                    <input type="hidden" id="editMaterialId" name="materialId">
                    <div class="mb-3">
                        <label for="editTitle" class="form-label">Tiêu đề</label>
                        <input type="text" class="form-control" id="editTitle" name="title" required>
                    </div>
                    <div class="mb-3">
                        <label for="editDescription" class="form-label">Mô tả</label>
                        <textarea class="form-control" id="editDescription" name="description" rows="3"></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="editType" class="form-label">Loại tài liệu</label>
                        <select class="form-select" id="editType" name="type">
                            <option value="document">Tài liệu</option>
                            <option value="presentation">Bài giảng</option>
                            <option value="exercise">Bài tập</option>
                            <option value="reference">Tài liệu tham khảo</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="button" class="btn btn-primary" onclick="submitEditForm()">Lưu thay đổi</button>
            </div>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteMaterialModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Xác nhận xóa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc chắn muốn xóa tài liệu <strong id="deleteMaterialTitle"></strong>?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <form id="deleteMaterialForm" method="post" action="${pageContext.request.contextPath}/lecturer/materials/delete">
                    <input type="hidden" name="materialId" id="deleteMaterialId">
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
    
    function submitMaterialForm() {
        var form = document.getElementById('uploadMaterialForm');
        if (form.checkValidity()) {
            form.submit();
        } else {
            form.classList.add('was-validated');
        }
    }
    
    function editMaterial(id) {
        // In a real application, you would fetch the material details from the server
        // For now, we'll use a placeholder
        fetch('${pageContext.request.contextPath}/lecturer/materials/' + id)
            .then(response => response.json())
            .then(data => {
                document.getElementById('editMaterialId').value = data.id;
                document.getElementById('editTitle').value = data.title;
                document.getElementById('editDescription').value = data.description;
                document.getElementById('editType').value = data.type;
                
                var editModal = new bootstrap.Modal(document.getElementById('editMaterialModal'));
                editModal.show();
            })
            .catch(error => {
                console.error('Error fetching material:', error);
                showToast('Không thể tải thông tin tài liệu', 'danger');
            });
    }
    
    function submitEditForm() {
        document.getElementById('editMaterialForm').submit();
    }
    
    function confirmDeleteMaterial(id, title) {
        document.getElementById('deleteMaterialId').value = id;
        document.getElementById('deleteMaterialTitle').textContent = title;
        var deleteModal = new bootstrap.Modal(document.getElementById('deleteMaterialModal'));
        deleteModal.show();
    }
</script> 