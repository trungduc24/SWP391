<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${course == null ? 'Create New Course' : 'Edit Course'} | Learning Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <jsp:include page="sidebar.jsp">
                <jsp:param name="activeSection" value="courses" />
            </jsp:include>

            <!-- Main Content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">${course == null ? 'Create New Course' : 'Edit Course'}</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/lecturer/courses" class="btn btn-sm btn-outline-secondary">
                            <i class="fas fa-arrow-left"></i> Back to Courses
                        </a>
                    </div>
                </div>

                <!-- Error/Success Messages -->
                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${sessionScope.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <% session.removeAttribute("error"); %>
                </c:if>
                <c:if test="${not empty sessionScope.success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${sessionScope.success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <% session.removeAttribute("success"); %>
                </c:if>

                <!-- Course Form -->
                <div class="card">
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/lecturer/courses/${course == null ? 'create' : 'update'}" method="post" enctype="multipart/form-data">
                            <c:if test="${course != null}">
                                <input type="hidden" name="courseId" value="${course.courseId}">
                            </c:if>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="courseCode" class="form-label">Course Code*</label>
                                    <input type="text" class="form-control" id="courseCode" name="courseCode" 
                                           value="${course != null ? course.courseCode : ''}" required>
                                    <div class="form-text">Example: CS101, MATH202, etc.</div>
                                </div>
                                <div class="col-md-6">
                                    <label for="semesterId" class="form-label">Semester*</label>
                                    <select class="form-select" id="semesterId" name="semesterId" required>
                                        <option value="">Select Semester</option>
                                        <c:forEach var="semester" items="${semesters}">
                                            <option value="${semester.semesterId}" ${course != null && course.semester.semesterId == semester.semesterId ? 'selected' : ''}>
                                                ${semester.semesterName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="courseName" class="form-label">Course Name*</label>
                                <input type="text" class="form-control" id="courseName" name="courseName" 
                                       value="${course != null ? course.courseName : ''}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="description" class="form-label">Course Description</label>
                                <textarea class="form-control" id="description" name="description" rows="5">${course != null ? course.description : ''}</textarea>
                            </div>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="credits" class="form-label">Credits*</label>
                                    <input type="number" class="form-control" id="credits" name="credits" 
                                           value="${course != null ? course.credits : '3'}" min="1" max="10" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="capacity" class="form-label">Capacity</label>
                                    <input type="number" class="form-control" id="capacity" name="capacity" 
                                           value="${course != null ? course.capacity : '40'}" min="1">
                                    <div class="form-text">Maximum number of students allowed.</div>
                                </div>
                            </div>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="startDate" class="form-label">Start Date</label>
                                    <input type="date" class="form-control" id="startDate" name="startDate" 
                                           value="${course != null ? course.startDate : ''}">
                                </div>
                                <div class="col-md-6">
                                    <label for="endDate" class="form-label">End Date</label>
                                    <input type="date" class="form-control" id="endDate" name="endDate" 
                                           value="${course != null ? course.endDate : ''}">
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="schedule" class="form-label">Schedule</label>
                                <input type="text" class="form-control" id="schedule" name="schedule" 
                                       value="${course != null ? course.schedule : ''}" placeholder="e.g., Monday 9:00-11:00, Wednesday 14:00-16:00">
                            </div>
                            
                            <div class="mb-3">
                                <label for="location" class="form-label">Location</label>
                                <input type="text" class="form-control" id="location" name="location" 
                                       value="${course != null ? course.location : ''}" placeholder="e.g., Room 301, Building A">
                            </div>
                            
                            <div class="mb-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="active" name="active" 
                                           ${course == null || course.active ? 'checked' : ''}>
                                    <label class="form-check-label" for="active">
                                        Active Course
                                    </label>
                                    <div class="form-text">Inactive courses are not visible to students.</div>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="courseImage" class="form-label">Course Image</label>
                                <input type="file" class="form-control" id="courseImage" name="courseImage" accept="image/*">
                                <c:if test="${course != null && not empty course.imageUrl}">
                                    <div class="mt-2">
                                        <img src="${pageContext.request.contextPath}/${course.imageUrl}" alt="Course Image" class="img-thumbnail" style="max-height: 150px;">
                                    </div>
                                </c:if>
                            </div>
                            
                            <div class="mb-3">
                                <label for="syllabus" class="form-label">Syllabus</label>
                                <textarea class="form-control summernote" id="syllabus" name="syllabus">${course != null ? course.syllabus : ''}</textarea>
                            </div>
                            
                            <div class="d-flex justify-content-between">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> ${course == null ? 'Create Course' : 'Update Course'}
                                </button>
                                <a href="${pageContext.request.contextPath}/lecturer/courses" class="btn btn-outline-secondary">Cancel</a>
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
    <script>
        $(document).ready(function() {
            // Initialize Summernote editor
            $('.summernote').summernote({
                placeholder: 'Enter course syllabus here...',
                height: 300,
                toolbar: [
                    ['style', ['style']],
                    ['font', ['bold', 'underline', 'clear']],
                    ['color', ['color']],
                    ['para', ['ul', 'ol', 'paragraph']],
                    ['table', ['table']],
                    ['insert', ['link']],
                    ['view', ['fullscreen', 'codeview', 'help']]
                ]
            });
            
            // Form validation
            $('form').submit(function(event) {
                const startDate = new Date($('#startDate').val());
                const endDate = new Date($('#endDate').val());
                
                if (startDate && endDate && startDate > endDate) {
                    event.preventDefault();
                    alert('Start date cannot be after end date.');
                }
            });
        });
    </script>
</body>
</html> 