<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${course.courseName} | Learning Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
                    <h1 class="h2">${course.courseCode}: ${course.courseName}</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="${pageContext.request.contextPath}/lecturer/courses/edit/${course.courseId}" class="btn btn-sm btn-outline-secondary">
                                <i class="fas fa-edit"></i> Edit Course
                            </a>
                            <a href="${pageContext.request.contextPath}/lecturer/courses" class="btn btn-sm btn-outline-secondary">
                                <i class="fas fa-arrow-left"></i> Back to Courses
                            </a>
                        </div>
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

                <!-- Course Information -->
                <div class="row mb-4">
                    <div class="col-md-8">
                        <div class="card mb-4">
                            <div class="card-header">
                                <h5 class="mb-0">Course Information</h5>
                            </div>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-4 fw-bold">Course Code:</div>
                                    <div class="col-md-8">${course.courseCode}</div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-4 fw-bold">Course Name:</div>
                                    <div class="col-md-8">${course.courseName}</div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-4 fw-bold">Semester:</div>
                                    <div class="col-md-8">${course.semester.semesterName}</div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-4 fw-bold">Credits:</div>
                                    <div class="col-md-8">${course.credits}</div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-4 fw-bold">Status:</div>
                                    <div class="col-md-8">
                                        <span class="badge bg-${course.active ? 'success' : 'secondary'}">
                                            ${course.active ? 'Active' : 'Inactive'}
                                        </span>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-4 fw-bold">Schedule:</div>
                                    <div class="col-md-8">${course.schedule}</div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-4 fw-bold">Location:</div>
                                    <div class="col-md-8">${course.location}</div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-4 fw-bold">Start Date:</div>
                                    <div class="col-md-8">
                                        <fmt:formatDate value="${course.startDate}" pattern="dd/MM/yyyy" />
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-4 fw-bold">End Date:</div>
                                    <div class="col-md-8">
                                        <fmt:formatDate value="${course.endDate}" pattern="dd/MM/yyyy" />
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-4 fw-bold">Capacity:</div>
                                    <div class="col-md-8">${course.capacity} students</div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-4 fw-bold">Current Enrollment:</div>
                                    <div class="col-md-8">${course.studentCount} students</div>
                                </div>
                            </div>
                        </div>

                        <div class="card mb-4">
                            <div class="card-header">
                                <h5 class="mb-0">Course Description</h5>
                            </div>
                            <div class="card-body">
                                <p>${course.description}</p>
                            </div>
                        </div>

                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">Syllabus</h5>
                            </div>
                            <div class="card-body">
                                ${course.syllabus}
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="card mb-4">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Course Image</h5>
                            </div>
                            <div class="card-body text-center">
                                <c:choose>
                                    <c:when test="${not empty course.imageUrl}">
                                        <img src="${pageContext.request.contextPath}/${course.imageUrl}" 
                                             alt="${course.courseName}" class="img-fluid rounded">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/assets/img/default-course.jpg" 
                                             alt="Default Course Image" class="img-fluid rounded">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="card mb-4">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Quick Actions</h5>
                            </div>
                            <div class="card-body">
                                <div class="list-group">
                                    <a href="${pageContext.request.contextPath}/lecturer/materials?courseId=${course.courseId}" class="list-group-item list-group-item-action">
                                        <i class="fas fa-file-pdf me-2"></i> Manage Materials
                                    </a>
                                    <a href="${pageContext.request.contextPath}/lecturer/tests?courseId=${course.courseId}" class="list-group-item list-group-item-action">
                                        <i class="fas fa-file-alt me-2"></i> Manage Tests
                                    </a>
                                    <a href="${pageContext.request.contextPath}/lecturer/announcements?courseId=${course.courseId}" class="list-group-item list-group-item-action">
                                        <i class="fas fa-bullhorn me-2"></i> Manage Announcements
                                    </a>
                                    <a href="${pageContext.request.contextPath}/lecturer/students/course/${course.courseId}" class="list-group-item list-group-item-action">
                                        <i class="fas fa-users me-2"></i> View Students
                                    </a>
                                    <a href="${pageContext.request.contextPath}/lecturer/grades?courseId=${course.courseId}" class="list-group-item list-group-item-action">
                                        <i class="fas fa-chart-bar me-2"></i> Manage Grades
                                    </a>
                                </div>
                            </div>
                        </div>

                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Course Statistics</h5>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <h6>Student Enrollment</h6>
                                    <div class="progress">
                                        <div class="progress-bar bg-success" role="progressbar" 
                                             style="width: ${course.capacity > 0 ? (course.studentCount * 100 / course.capacity) : 0}%" 
                                             aria-valuenow="${course.studentCount}" aria-valuemin="0" aria-valuemax="${course.capacity}">
                                            ${course.studentCount}/${course.capacity}
                                        </div>
                                    </div>
                                </div>
                                <div class="row text-center">
                                    <div class="col">
                                        <h5>${testCount}</h5>
                                        <small class="text-muted">Tests</small>
                                    </div>
                                    <div class="col">
                                        <h5>${materialCount}</h5>
                                        <small class="text-muted">Materials</small>
                                    </div>
                                    <div class="col">
                                        <h5>${announcementCount}</h5>
                                        <small class="text-muted">Announcements</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
</body>
</html> 