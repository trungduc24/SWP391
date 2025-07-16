<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${forum != null ? 'Edit Forum' : 'Create Forum'} - Lecturer Panel</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Include Sidebar -->
            <jsp:include page="sidebar.jsp"/>
            
            <!-- Main Content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/lecturer/dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/lecturer/forums">Forums</a></li>
                        <li class="breadcrumb-item active">${forum != null ? 'Edit Forum' : 'Create Forum'}</li>
                    </ol>
                </nav>
                
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">${forum != null ? 'Edit Forum' : 'Create New Forum'}</h1>
                </div>
                
                <!-- Error Message -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle"></i> ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <div class="card mb-4">
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/lecturer/forums/${forum != null ? 'update' : 'create'}?action=forum" method="POST">
                            <c:if test="${forum != null}">
                                <input type="hidden" name="forumId" value="${forum.forumId}">
                            </c:if>
                            
                            <div class="mb-3">
                                <label for="title" class="form-label">Forum Title <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="title" name="title" value="${forum != null ? forum.title : ''}" required>
                                <div class="form-text">Choose a clear, descriptive title for your forum.</div>
                            </div>
                            
                            <c:if test="${forum == null}">
                                <div class="mb-3">
                                    <label for="courseId" class="form-label">Course <span class="text-danger">*</span></label>
                                    <select class="form-select" id="courseId" name="courseId" required>
                                        <option value="" selected disabled>-- Select Course --</option>
                                        <c:forEach var="course" items="${courses}">
                                            <option value="${course.courseId}">${course.courseName} (${course.courseCode})</option>
                                        </c:forEach>
                                    </select>
                                    <div class="form-text">Select the course this forum is related to.</div>
                                </div>
                            </c:if>
                            <c:if test="${forum != null}">
                                <div class="mb-3">
                                    <label class="form-label">Course</label>
                                    <input type="text" class="form-control" value="${course.courseName} (${course.courseCode})" readonly>
                                    <div class="form-text">The course cannot be changed after forum creation.</div>
                                </div>
                            </c:if>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <a href="${pageContext.request.contextPath}/lecturer/forums" class="btn btn-secondary me-md-2">
                                    <i class="fas fa-times"></i> Cancel
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> ${forum != null ? 'Update Forum' : 'Create Forum'}
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 