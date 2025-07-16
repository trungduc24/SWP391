<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${forum.title} - Forum - Lecturer Panel</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .post-card {
            margin-bottom: 1.5rem;
        }
        .post-header {
            display: flex;
            align-items: center;
            margin-bottom: 0.75rem;
        }
        .post-avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 1rem;
        }
        .post-meta {
            color: #6c757d;
            font-size: 0.875rem;
        }
        .post-content {
            background-color: #f8f9fa;
            padding: 1rem;
            border-radius: 0.5rem;
        }
        .post-actions {
            margin-top: 0.5rem;
            display: flex;
            gap: 0.5rem;
        }
        .reply-form {
            margin-top: 2rem;
            padding: 1.5rem;
            background-color: #f8f9fa;
            border-radius: 0.5rem;
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
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/lecturer/dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/lecturer/forums">Forums</a></li>
                        <li class="breadcrumb-item active">${forum.title}</li>
                    </ol>
                </nav>
                
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">${forum.title}</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/lecturer/forums/edit?action=forum&id=${forum.forumId}" class="btn btn-sm btn-outline-secondary me-2">
                            <i class="fas fa-edit"></i> Edit Forum
                        </a>
                        <a href="${pageContext.request.contextPath}/lecturer/forums/delete?action=forum&id=${forum.forumId}" 
                           class="btn btn-sm btn-outline-danger"
                           onclick="return confirm('Are you sure you want to delete this forum? This will delete all posts within it. This action cannot be undone.')">
                            <i class="fas fa-trash"></i> Delete Forum
                        </a>
                    </div>
                </div>
                
                <!-- Forum Info -->
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="d-flex align-items-center mb-2">
                            <i class="fas fa-book-open text-primary me-2"></i>
                            <strong>Course:</strong>
                            <span class="ms-2">${course.courseName} (${course.courseCode})</span>
                        </div>
                        <div class="d-flex align-items-center mb-2">
                            <i class="fas fa-calendar-alt text-primary me-2"></i>
                            <strong>Created:</strong>
                            <span class="ms-2">
                                <fmt:formatDate value="${forum.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </span>
                        </div>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-comments text-primary me-2"></i>
                            <strong>Posts:</strong>
                            <span class="ms-2">${posts.size()}</span>
                        </div>
                    </div>
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

                <h3 class="mb-4">Discussion</h3>
                
                <!-- Posts List -->
                <div class="posts-container mb-4">
                    <c:choose>
                        <c:when test="${not empty posts}">
                            <c:forEach var="post" items="${posts}">
                                <div class="card post-card">
                                    <div class="card-body">
                                        <div class="post-header">
                                            <img src="${empty post.userAvatar ? 'https://via.placeholder.com/48' : post.userAvatar}" 
                                                 alt="User Avatar" class="post-avatar">
                                            <div>
                                                <h6 class="mb-0">${post.userFullName}</h6>
                                                <div class="post-meta">
                                                    <fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="post-content">
                                            <p class="mb-0">${post.content}</p>
                                        </div>
                                        <div class="post-actions">
                                            <c:if test="${post.userId == user.userId}">
                                                <a href="${pageContext.request.contextPath}/lecturer/forums/posts/${post.postId}?action=edit" 
                                                   class="btn btn-sm btn-outline-primary">
                                                    <i class="fas fa-edit"></i> Edit
                                                </a>
                                            </c:if>
                                            <a href="${pageContext.request.contextPath}/lecturer/forums/posts/${post.postId}?action=delete" 
                                               class="btn btn-sm btn-outline-danger"
                                               onclick="return confirm('Are you sure you want to delete this post? This action cannot be undone.')">
                                                <i class="fas fa-trash-alt"></i> Delete
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle"></i> There are no posts in this forum yet. Be the first to start the discussion!
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <!-- Post Reply Form -->
                <div class="reply-form">
                    <h4 class="mb-3">Add a Response</h4>
                    <form action="${pageContext.request.contextPath}/lecturer/forums/${forum.forumId}/posts?action=create" method="POST">
                        <div class="mb-3">
                            <label for="content" class="form-label">Your Response <span class="text-danger">*</span></label>
                            <textarea class="form-control" id="content" name="content" rows="5" required></textarea>
                        </div>
                        <div class="d-grid d-md-flex justify-content-md-end">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-paper-plane"></i> Post Response
                            </button>
                        </div>
                    </form>
                </div>
            </main>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 