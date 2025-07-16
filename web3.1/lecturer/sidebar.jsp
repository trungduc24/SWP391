<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .sidebar {
        width: 260px;
        background: linear-gradient(to bottom, #3498db, #2980b9);
        color: white;
        height: 100vh;
        padding-top: 20px;
        position: fixed;
        top: 0;
        left: 0;
        z-index: 1000;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        overflow-y: auto;
    }

    .sidebar .text-center img {
        border-radius: 50%;
        width: 80px;
        height: 80px;
        object-fit: cover;
        border: 3px solid #fff;
        margin-bottom: 10px;
    }

    .sidebar h5, .sidebar p {
        color: white;
        margin-bottom: 0.5rem;
    }

    .sidebar .nav-link {
        color: white;
        padding: 12px 20px;
        display: flex;
        align-items: center;
        text-decoration: none;
        border-radius: 8px;
        margin: 5px 12px;
        transition: background 0.3s, border-left 0.3s;
        border-left: 4px solid transparent;
    }

    .sidebar .nav-link:hover,
    .sidebar .nav-link.active {
        background-color: rgba(255, 255, 255, 0.15);
        border-left-color: #fff;
        font-weight: bold;
    }

    .sidebar .nav-link i {
        margin-right: 10px;
        width: 20px;
        text-align: center;
    }

    @media (max-width: 992px) {
        .sidebar {
            transform: translateX(-100%);
            transition: transform 0.3s ease-in-out;
        }

        .sidebar.active {
            transform: translateX(0);
        }
    }
</style>

<nav id="sidebar" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
    <div class="position-sticky pt-3">
        <div class="text-center mb-4">
            <c:choose>
                <c:when test="${not empty lecturer.avatarUrl}">
                    <img src="${pageContext.request.contextPath}/${lecturer.avatarUrl}" alt="Profile" class="rounded-circle mb-2" width="80" height="80">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/assets/img/default-avatar.png" alt="Profile" class="rounded-circle mb-2" width="80" height="80">
                </c:otherwise>
            </c:choose>

            <h5>${lecturer.fullName}</h5>
            <p class="text-muted">${lecturer.degree}</p>
        </div>

        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link ${param.activeSection == 'dashboard' ? 'active' : ''}" href="${pageContext.request.contextPath}/lecturer/dashboard">
                    <i class="fas fa-tachometer-alt me-2"></i>
                    Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${param.activeSection == 'courses' ? 'active' : ''}" href="${pageContext.request.contextPath}/lecturer/courses">
                    <i class="fas fa-book me-2"></i>
                    Khóa học
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${param.activeSection == 'tests' ? 'active' : ''}" href="${pageContext.request.contextPath}/lecturer/tests">
                    <i class="fas fa-file-alt me-2"></i>
                    Bài kiểm tra
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${param.activeSection == 'assignments' ? 'active' : ''}" href="${pageContext.request.contextPath}/lecturer/assignments">
                    <i class="fas fa-tasks me-2"></i>
                    Bài tập
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${param.activeSection == 'materials' ? 'active' : ''}" href="${pageContext.request.contextPath}/lecturer/materials">
                    <i class="fas fa-file-pdf me-2"></i>
                    Tài liệu
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${param.activeSection == 'forums' ? 'active' : ''}" href="${pageContext.request.contextPath}/lecturer/forums">
                    <i class="fas fa-comments me-2"></i>
                    Diễn đàn
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${param.activeSection == 'announcements' ? 'active' : ''}" href="${pageContext.request.contextPath}/lecturer/announcements">
                    <i class="fas fa-bullhorn me-2"></i>
                    Thông báo
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${param.activeSection == 'grades' ? 'active' : ''}" href="${pageContext.request.contextPath}/lecturer/grades">
                    <i class="fas fa-chart-bar me-2"></i>
                    Điểm số
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${param.activeSection == 'students' ? 'active' : ''}" href="${pageContext.request.contextPath}/lecturer/students">
                    <i class="fas fa-users me-2"></i>
                    Sinh viên
                </a>
            </li>
        </ul>

        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
            <span>Tài khoản</span>
        </h6>
        <ul class="nav flex-column mb-2">
            <li class="nav-item">
                <a class="nav-link ${param.activeSection == 'profile' ? 'active' : ''}" href="${pageContext.request.contextPath}/lecturer/profile">
                    <i class="fas fa-user-circle me-2"></i>
                    Hồ sơ cá nhân
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                    <i class="fas fa-sign-out-alt me-2"></i>
                    Đăng xuất
                </a>
            </li>
        </ul>
    </div>
</nav>
