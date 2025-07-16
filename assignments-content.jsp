<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Session validation and lecturer extraction --%>
<c:choose>
    <c:when test="${empty sessionScope.user or sessionScope.user.role ne 'lecturer'}">
        <c:redirect url="${pageContext.request.contextPath}/login.jsp" />
    </c:when>
    <c:otherwise>
        <c:if test="${not empty sessionScope.lecturer}">
            <c:set var="lecturer" value="${sessionScope.lecturer}" scope="page" />
        </c:if>
    </c:otherwise>
</c:choose>


<div class="container-fluid px-4">
    <h1 class="mt-4">Assignments</h1>
    <ol class="breadcrumb mb-4">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/lecturer/dashboard">Dashboard</a></li>
        <li class="breadcrumb-item active">Assignments</li>
    </ol>

    <div class="card mb-4">
        <div class="card-header d-flex justify-content-between align-items-center">
            <div>
                <i class="fas fa-tasks me-1"></i>
                <c:choose>
                    <c:when test="${not empty courseId}">
                        Assignments for ${courseName}
                    </c:when>
                    <c:otherwise>
                        All Assignments
                    </c:otherwise>
                </c:choose>
            </div>
            <div>
                <c:if test="${not empty courses}">
                    <div class="d-flex align-items-center">
                        <select id="courseFilter" class="form-select me-2">
                            <option value="">All Courses</option>
                            <c:forEach var="course" items="${courses}">
                                <option value="${course.courseId}" ${course.courseId eq courseId ? 'selected' : ''}>
                                    ${course.code} - ${course.name}
                                </option>
                            </c:forEach>
                        </select>
                        <a href="${pageContext.request.contextPath}/lecturer/assignments?action=create${not empty courseId ? '&courseId='.concat(courseId) : ''}" 
                           class="btn btn-primary">
                            <i class="fas fa-plus"></i> New Assignment
                        </a>
                    </div>
                </c:if>
            </div>
        </div>
        <div class="card-body">
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger" role="alert">
                    ${errorMessage}
                </div>
            </c:if>

            <c:if test="${not empty successMessage}">
                <div class="alert alert-success" role="alert">
                    ${successMessage}
                </div>
            </c:if>

            <c:choose>
                <c:when test="${empty assignments}">
                    <div class="alert alert-info" role="alert">
                        No assignments found.
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped" id="assignmentsTable" width="100%" cellspacing="0">
                            <thead>
                                <tr>
                                    <th>Title</th>
                                    <th>Course</th>
                                    <th>Type</th>
                                    <th>Due Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="assignment" items="${assignments}">
                                    <tr>
                                        <td>${assignment.title}</td>
                                        <td>
                                            <c:forEach var="course" items="${courses}">
                                                <c:if test="${course.courseId eq assignment.courseId}">
                                                    ${course.courseCode} - ${course.courseName}
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td>${assignment.type}</td>
                                        <td><fmt:formatDate value="${assignment.dueDate}" pattern="yyyy-MM-dd HH:mm" /></td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/lecturer/assignments?action=view&id=${assignment.assignmentId}" 
                                               class="btn btn-sm btn-info">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/lecturer/assignments?action=edit&id=${assignment.assignmentId}" 
                                               class="btn btn-sm btn-primary">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="#" onclick="confirmDelete(${assignment.assignmentId}, '${assignment.title}')" 
                                               class="btn btn-sm btn-danger">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
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
    document.addEventListener('DOMContentLoaded', function () {
        $('#assignmentsTable').DataTable({
            responsive: true
        });

        $('#courseFilter').on('change', function () {
            const courseId = $(this).val();
            if (courseId) {
                window.location.href = '${pageContext.request.contextPath}/lecturer/assignments?courseId=' + courseId;
            } else {
                window.location.href = '${pageContext.request.contextPath}/lecturer/assignments';
            }
        });
    });

    function confirmDelete(id, title) {
        document.getElementById('assignmentTitle').textContent = title;
        document.getElementById('confirmDeleteBtn').href = '${pageContext.request.contextPath}/lecturer/assignments?action=delete&id=' + id;
        const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
        deleteModal.show();
    }
</script>
