<%
    // Đảm bảo biến currentUser, currentURI, contextPath, baseUrl đã được set ở file cha
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar">
    <div class="sidebar-header">
        <h3>LMSS</h3>
        <p class="mb-0">Hệ thống quản lý học tập</p>
    </div>
    <div class="sidebar-menu">
        <ul>
            <li>
                <a href="<%= baseUrl %>/dashboard" class="<%= currentURI.contains("/dashboard") ? "active" : "" %>">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
            </li>
            <li>
                <a href="<%= baseUrl %>/courses" class="<%= currentURI.contains("/courses") ? "active" : "" %>">
                    <i class="fas fa-book"></i> Khóa học
                </a>
            </li>
            <li>
                <a href="<%= baseUrl %>/students" class="<%= currentURI.contains("/students") ? "active" : "" %>">
                    <i class="fas fa-users"></i> Sinh viên
                </a>
            </li>
            <li>
                <a href="<%= baseUrl %>/tests" class="<%= currentURI.contains("/tests") ? "active" : "" %>">
                    <i class="fas fa-clipboard-check"></i> Bài kiểm tra
                </a>
            </li>
            <li>
                <a href="<%= baseUrl %>/grades" class="<%= currentURI.contains("/grades") ? "active" : "" %>">
                    <i class="fas fa-chart-line"></i> Điểm số
                </a>
            </li>
            <li>
                <a href="<%= baseUrl %>/materials" class="<%= currentURI.contains("/materials") ? "active" : "" %>">
                    <i class="fas fa-file-alt"></i> Tài liệu
                </a>
            </li>
            <li>
                <a href="<%= baseUrl %>/announcements" class="<%= currentURI.contains("/announcements") ? "active" : "" %>">
                    <i class="fas fa-bullhorn"></i> Thông báo
                </a>
            </li>
            <li>
                <a href="<%= baseUrl %>/profile" class="<%= currentURI.contains("/profile") ? "active" : "" %>">
                    <i class="fas fa-user"></i> Hồ sơ cá nhân
                </a>
            </li>
        </ul>
    </div>
    <div class="sidebar-footer p-3 mt-auto border-top border-light">
        <a href="<%= contextPath %>/logout" class="btn btn-danger w-100">
            <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
        </a>
    </div>
</div> 