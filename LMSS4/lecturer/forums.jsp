<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forum Management - Lecturer Panel</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .forum-card {
            transition: transform 0.3s;
            margin-bottom: 20px;
        }
        .forum-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .action-buttons {
            display: flex;
            gap: 10px;
        }
        .action-buttons .btn {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }
        .card-footer {
            background-color: rgba(0,0,0,0.03);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Include Sidebar -->
            <jsp:include page="sidebar.jsp"/>
            
            <!-- Main Content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Forum Management</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/lecturer/forums/create" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Create New Forum
                        </a>
                    </div>
                </div>
                
                <div class="alert alert-info">
                    <i class="fas fa-info-circle"></i> 
                    Forums provide a platform for students and lecturers to engage in academic discussions. Create subject-specific forums for each of your courses.
                </div>

                <!-- Success Message -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> ${successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <!-- Error Message -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle"></i> ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <div class="row">
                    <c:choose>
                        <c:when test="${not empty forums}">
                            <c:forEach var="forum" items="${forums}">
                                <div class="col-md-6 col-lg-4">
                                    <div class="card forum-card h-100">
                                        <div class="card-body">
                                            <h5 class="card-title">
                                                <a href="${pageContext.request.contextPath}/lecturer/forums/${forum.forumId}" class="text-decoration-none">
                                                    ${forum.title}
                                                </a>
                                            </h5>
                                            <p class="card-text small text-muted">
                                                Created: ${forum.createdAt}
                                            </p>
                                        </div>
                                        <div class="card-footer">
                                            <span class="badge bg-primary rounded-pill">
                                                <i class="fas fa-comments"></i> Posts: ${forum.postCount != null ? forum.postCount : 0}
                                            </span>
                                            <div class="action-buttons">
                                                <a href="${pageContext.request.contextPath}/lecturer/forums/${forum.forumId}" class="btn btn-outline-primary">
                                                    <i class="fas fa-eye"></i> View
                                                </a>
                                                <a href="${pageContext.request.contextPath}/lecturer/forums/edit?action=forum&id=${forum.forumId}" class="btn btn-outline-warning">
                                                    <i class="fas fa-edit"></i> Edit
                                                </a>
                                                <a href="${pageContext.request.contextPath}/lecturer/forums/delete?action=forum&id=${forum.forumId}" 
                                                   class="btn btn-outline-danger"
                                                   onclick="return confirm('Are you sure you want to delete this forum? This action cannot be undone.')">
                                                    <i class="fas fa-trash-alt"></i> Delete
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="col-12">
                                <div class="card text-center p-5">
                                    <div class="card-body">
                                        <h5 class="card-title">No Forums Found</h5>
                                        <p class="card-text">You haven't created any forums yet.</p>
                                        <a href="${pageContext.request.contextPath}/lecturer/forums/create" class="btn btn-primary">
                                            <i class="fas fa-plus"></i> Create Your First Forum
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </main>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 