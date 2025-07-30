<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="lecturer-template.jsp">
    <jsp:param name="title" value="View Assignment" />
    <jsp:param name="content" value="assignment-view-content" />
</jsp:include>

<%@ include file="sidebar.jsp" %>

<div id="assignment-view-content">
    <div class="container-fluid px-4">
        <h1 class="mt-4">View Assignment</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/lecturer/dashboard">Dashboard</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/lecturer/assignments">Assignments</a></li>
            <li class="breadcrumb-item active">View Assignment</li>
        </ol>
        
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-tasks me-1"></i>
                Assignment Details
            </div>
            <div class="card-body">
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger" role="alert">
                        ${errorMessage}
                    </div>
                </c:if>
                
                <div class="row mb-4">
                    <div class="col-md-9">
                        <h2>${assignment.title}</h2>
                        <p class="text-muted mb-0">
                            <strong>Course:</strong> ${course.courseCode} - ${course.courseName}
                        </p>
                        <p class="text-muted mb-0">
                            <strong>Type:</strong> ${assignment.type}
                        </p>
                        <p class="text-muted">
                            <strong>Due Date:</strong> <fmt:formatDate value="${assignment.dueDate}" pattern="MMMM d, yyyy 'at' h:mm a" />
                        </p>
                    </div>
                    <div class="col-md-3 text-md-end">
                        <a href="${pageContext.request.contextPath}/lecturer/assignments?action=edit&id=${assignment.assignmentId}" class="btn btn-primary mb-2">
                            <i class="fas fa-edit me-1"></i> Edit
                        </a>
                        <a href="#" onclick="confirmDelete(${assignment.assignmentId}, '${assignment.title}')" class="btn btn-danger mb-2">
                            <i class="fas fa-trash me-1"></i> Delete
                        </a>
                        <a href="${pageContext.request.contextPath}/lecturer/assignments?courseId=${assignment.courseId}" class="btn btn-secondary">
                            <i class="fas fa-arrow-left me-1"></i> Back
                        </a>
                    </div>
                </div>
                
                <div class="card mb-4">
                    <div class="card-header">
                        <i class="fas fa-file-alt me-1"></i>
                        Description
                    </div>
                    <div class="card-body">
                        <p>${assignment.description}</p>
                    </div>
                </div>
                
                <!-- Submissions would go here in a future enhancement -->
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-file-upload me-1"></i>
                        Student Submissions
                    </div>
                    <div class="card-body">
                        <div class="alert alert-info" role="alert">
                            Submissions feature will be available soon.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete the assignment <span id="assignmentTitle"></span>?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <a href="#" id="confirmDeleteBtn" class="btn btn-danger">Delete</a>
            </div>
        </div>
    </div>
</div>

<script>
    function confirmDelete(id, title) {
        document.getElementById('assignmentTitle').textContent = title;
        document.getElementById('confirmDeleteBtn').href = '${pageContext.request.contextPath}/lecturer/assignments?action=delete&id=' + id;
        
        const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
        deleteModal.show();
    }
</script> 