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
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css">
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

                <!-- Course Navigation Tabs -->
                <ul class="nav nav-tabs mb-4" id="courseTab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="overview-tab" data-bs-toggle="tab" data-bs-target="#overview" type="button" role="tab" aria-controls="overview" aria-selected="true">Overview</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="students-tab" data-bs-toggle="tab" data-bs-target="#students" type="button" role="tab" aria-controls="students" aria-selected="false">Students</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="materials-tab" data-bs-toggle="tab" data-bs-target="#materials" type="button" role="tab" aria-controls="materials" aria-selected="false">Materials</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="tests-tab" data-bs-toggle="tab" data-bs-target="#tests" type="button" role="tab" aria-controls="tests" aria-selected="false">Tests</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="announcements-tab" data-bs-toggle="tab" data-bs-target="#announcements" type="button" role="tab" aria-controls="announcements" aria-selected="false">Announcements</button>
                    </li>
                </ul>

                <!-- Tab Content -->
                <div class="tab-content" id="courseTabContent">
                    <!-- Overview Tab -->
                    <div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview-tab">
                        <div class="row">
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
                                    <div class="card-header">
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
                                    <div class="card-header">
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
                    </div>

                    <!-- Students Tab -->
                    <div class="tab-pane fade" id="students" role="tabpanel" aria-labelledby="students-tab">
                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Enrolled Students</h5>
                                <a href="${pageContext.request.contextPath}/lecturer/students/course/${course.courseId}" class="btn btn-sm btn-outline-primary">
                                    <i class="fas fa-external-link-alt"></i> Full Student Management
                                </a>
                            </div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${empty students}">
                                        <div class="alert alert-info">No students enrolled in this course yet.</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="table-responsive">
                                            <table class="table table-striped table-hover" id="studentsTable">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Name</th>
                                                        <th>Email</th>
                                                        <th>Enrollment Date</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="student" items="${students}">
                                                        <tr>
                                                            <td>${student.studentId}</td>
                                                            <td>${student.user.firstName} ${student.user.lastName}</td>
                                                            <td>${student.user.email}</td>
                                                            <td>
                                                                <fmt:formatDate value="${student.enrollmentDate}" pattern="dd/MM/yyyy" />
                                                            </td>
                                                            <td>
                                                                <div class="btn-group btn-group-sm">
                                                                    <a href="${pageContext.request.contextPath}/lecturer/students/view/${student.studentId}" class="btn btn-outline-primary">
                                                                        <i class="fas fa-eye"></i>
                                                                    </a>
                                                                    <a href="${pageContext.request.contextPath}/lecturer/grades/student/${student.studentId}" class="btn btn-outline-secondary">
                                                                        <i class="fas fa-chart-bar"></i>
                                                                    </a>
                                                                </div>
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

                    <!-- Materials Tab -->
                    <div class="tab-pane fade" id="materials" role="tabpanel" aria-labelledby="materials-tab">
                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Course Materials</h5>
                                <a href="${pageContext.request.contextPath}/lecturer/materials?courseId=${course.courseId}" class="btn btn-sm btn-outline-primary">
                                    <i class="fas fa-external-link-alt"></i> Full Material Management
                                </a>
                            </div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${empty materials}">
                                        <div class="alert alert-info">No materials available for this course yet.</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="table-responsive">
                                            <table class="table table-striped table-hover" id="materialsTable">
                                                <thead>
                                                    <tr>
                                                        <th>Title</th>
                                                        <th>Type</th>
                                                        <th>Upload Date</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="material" items="${materials}">
                                                        <tr>
                                                            <td>${material.title}</td>
                                                            <td>${material.type}</td>
                                                            <td>
                                                                <fmt:formatDate value="${material.uploadDate}" pattern="dd/MM/yyyy" />
                                                            </td>
                                                            <td>
                                                                <div class="btn-group btn-group-sm">
                                                                    <a href="${pageContext.request.contextPath}/${material.filePath}" class="btn btn-outline-primary" target="_blank">
                                                                        <i class="fas fa-download"></i>
                                                                    </a>
                                                                    <a href="${pageContext.request.contextPath}/lecturer/materials/edit/${material.materialId}" class="btn btn-outline-secondary">
                                                                        <i class="fas fa-edit"></i>
                                                                    </a>
                                                                </div>
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

                    <!-- Tests Tab -->
                    <div class="tab-pane fade" id="tests" role="tabpanel" aria-labelledby="tests-tab">
                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Course Tests</h5>
                                <a href="${pageContext.request.contextPath}/lecturer/tests?courseId=${course.courseId}" class="btn btn-sm btn-outline-primary">
                                    <i class="fas fa-external-link-alt"></i> Full Test Management
                                </a>
                            </div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${empty tests}">
                                        <div class="alert alert-info">No tests available for this course yet.</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="table-responsive">
                                            <table class="table table-striped table-hover" id="testsTable">
                                                <thead>
                                                    <tr>
                                                        <th>Test Name</th>
                                                        <th>Date</th>
                                                        <th>Duration</th>
                                                        <th>Status</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="test" items="${tests}">
                                                        <tr>
                                                            <td>${test.testName}</td>
                                                            <td>
                                                                <fmt:formatDate value="${test.testDate}" pattern="dd/MM/yyyy HH:mm" />
                                                            </td>
                                                            <td>${test.duration} minutes</td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${test.status == 'UPCOMING'}">
                                                                        <span class="badge bg-info">Upcoming</span>
                                                                    </c:when>
                                                                    <c:when test="${test.status == 'ONGOING'}">
                                                                        <span class="badge bg-warning">Ongoing</span>
                                                                    </c:when>
                                                                    <c:when test="${test.status == 'COMPLETED'}">
                                                                        <span class="badge bg-success">Completed</span>
                                                                    </c:when>
                                                                </c:choose>
                                                            </td>
                                                            <td>
                                                                <div class="btn-group btn-group-sm">
                                                                    <a href="${pageContext.request.contextPath}/lecturer/tests/${test.testId}" class="btn btn-outline-primary">
                                                                        <i class="fas fa-eye"></i>
                                                                    </a>
                                                                    <a href="${pageContext.request.contextPath}/lecturer/tests/edit/${test.testId}" class="btn btn-outline-secondary">
                                                                        <i class="fas fa-edit"></i>
                                                                    </a>
                                                                    <a href="${pageContext.request.contextPath}/lecturer/grades/test/${test.testId}" class="btn btn-outline-success">
                                                                        <i class="fas fa-chart-bar"></i>
                                                                    </a>
                                                                </div>
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

                    <!-- Announcements Tab -->
                    <div class="tab-pane fade" id="announcements" role="tabpanel" aria-labelledby="announcements-tab">
                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Course Announcements</h5>
                                <a href="${pageContext.request.contextPath}/lecturer/announcements?courseId=${course.courseId}" class="btn btn-sm btn-outline-primary">
                                    <i class="fas fa-external-link-alt"></i> Full Announcement Management
                                </a>
                            </div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${empty announcements}">
                                        <div class="alert alert-info">No announcements available for this course yet.</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="list-group">
                                            <c:forEach var="announcement" items="${announcements}">
                                                <div class="list-group-item">
                                                    <div class="d-flex w-100 justify-content-between">
                                                        <h5 class="mb-1">${announcement.title}</h5>
                                                        <small>
                                                            <fmt:formatDate value="${announcement.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                                        </small>
                                                    </div>
                                                    <p class="mb-1">${announcement.content}</p>
                                                    <div class="d-flex justify-content-end">
                                                        <a href="${pageContext.request.contextPath}/lecturer/announcements/edit/${announcement.announcementId}" class="btn btn-sm btn-outline-secondary">
                                                            <i class="fas fa-edit"></i> Edit
                                                        </a>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    <script>
        $(document).ready(function() {
            // Initialize DataTables
            $('#studentsTable').DataTable({
                "pageLength": 10,
                "lengthMenu": [5, 10, 25, 50]
            });
            
            $('#materialsTable').DataTable({
                "pageLength": 10,
                "lengthMenu": [5, 10, 25, 50]
            });
            
            $('#testsTable').DataTable({
                "pageLength": 10,
                "lengthMenu": [5, 10, 25, 50]
            });
            
            // Handle tab navigation from URL
            const urlParams = new URLSearchParams(window.location.search);
            const tab = urlParams.get('tab');
            if (tab) {
                const tabElement = document.querySelector('#courseTab button[data-bs-target="#' + tab + '"]');
                if (tabElement) {
                    const tabTrigger = new bootstrap.Tab(tabElement);
                    tabTrigger.show();
                }
            }
        });
    </script>
</body>
</html> 