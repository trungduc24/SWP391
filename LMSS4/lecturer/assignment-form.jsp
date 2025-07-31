<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="lecturer-template.jsp">
    <jsp:param name="title" value="${empty assignment ? 'Create Assignment' : 'Edit Assignment'}" />
    <jsp:param name="content" value="assignment-form-content" />
</jsp:include>

<%@ include file="sidebar.jsp" %>

<div id="assignment-form-content">
    <div class="container-fluid px-4">
        <h1 class="mt-4">${empty assignment ? 'Create Assignment' : 'Edit Assignment'}</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/lecturer/dashboard">Dashboard</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/lecturer/assignments">Assignments</a></li>
            <li class="breadcrumb-item active">${empty assignment ? 'Create Assignment' : 'Edit Assignment'}</li>
        </ol>
        
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-edit me-1"></i>
                Assignment Form
            </div>
            <div class="card-body">
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger" role="alert">
                        ${errorMessage}
                    </div>
                </c:if>
                
                <form method="POST" action="${pageContext.request.contextPath}/lecturer/assignments" 
                      class="needs-validation" novalidate>
                      
                    <input type="hidden" name="action" value="${empty assignment ? 'create' : 'update'}">
                    
                    <c:if test="${not empty assignment}">
                        <input type="hidden" name="assignmentId" value="${assignment.assignmentId}">
                    </c:if>
                    
                    <div class="mb-3">
                        <label for="courseId" class="form-label">Course <span class="text-danger">*</span></label>
                        <select class="form-select" id="courseId" name="courseId" required>
                            <option value="">-- Select Course --</option>
                            <c:forEach var="course" items="${courses}">
                                <option value="${course.courseId}" 
                                        ${(not empty courseId and course.courseId eq courseId) or 
                                          (not empty assignment and course.courseId eq assignment.courseId) ? 'selected' : ''}>
                                    ${course.courseCode} - ${course.courseName}
                                </option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback">
                            Please select a course
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="title" class="form-label">Title <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="title" name="title" 
                               value="${not empty assignment ? assignment.title : ''}" required>
                        <div class="invalid-feedback">
                            Please enter a title
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="description" class="form-label">Description <span class="text-danger">*</span></label>
                        <textarea class="form-control" id="description" name="description" rows="5" required>${not empty assignment ? assignment.description : ''}</textarea>
                        <div class="invalid-feedback">
                            Please enter a description
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="type" class="form-label">Type <span class="text-danger">*</span></label>
                        <select class="form-select" id="type" name="type" required>
                            <option value="">-- Select Type --</option>
                            <option value="homework" ${not empty assignment and assignment.type eq 'homework' ? 'selected' : ''}>Homework</option>
                            <option value="project" ${not empty assignment and assignment.type eq 'project' ? 'selected' : ''}>Project</option>
                            <option value="quiz" ${not empty assignment and assignment.type eq 'quiz' ? 'selected' : ''}>Quiz</option>
                            <option value="exam" ${not empty assignment and assignment.type eq 'exam' ? 'selected' : ''}>Exam</option>
                            <option value="other" ${not empty assignment and assignment.type eq 'other' ? 'selected' : ''}>Other</option>
                        </select>
                        <div class="invalid-feedback">
                            Please select a type
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="dueDate" class="form-label">Due Date <span class="text-danger">*</span></label>
                        <input type="datetime-local" class="form-control" id="dueDate" name="dueDate" 
                               value="<c:if test="${not empty assignment}"><fmt:formatDate value="${assignment.dueDate}" pattern="yyyy-MM-dd'T'HH:mm" /></c:if>" required>
                        <div class="invalid-feedback">
                            Please enter a due date
                        </div>
                    </div>
                    
                    <div class="mt-4">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-1"></i> Save
                        </button>
                        <a href="${pageContext.request.contextPath}/lecturer/assignments${not empty courseId ? '?courseId='.concat(courseId) : ''}" class="btn btn-secondary ms-2">
                            <i class="fas fa-times me-1"></i> Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize form validation
        const form = document.querySelector('.needs-validation');
        
        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            
            form.classList.add('was-validated');
        }, false);
        
        // Initialize rich text editor for description if needed
        if (typeof ClassicEditor !== 'undefined') {
            ClassicEditor
                .create(document.querySelector('#description'))
                .catch(error => {
                    console.error(error);
                });
        }
    });
</script> 