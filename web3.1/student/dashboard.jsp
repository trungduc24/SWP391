<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"student".equals(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hệ thống Quản lý Học tập - Sinh viên</title>
        <script src="https://cdn.tailwindcss.com/3.4.16"></script>
        <script>tailwind.config = {theme: {extend: {colors: {primary: '#4f46e5', secondary: '#818cf8'}, borderRadius: {'none': '0px', 'sm': '4px', DEFAULT: '8px', 'md': '12px', 'lg': '16px', 'xl': '20px', '2xl': '24px', '3xl': '32px', 'full': '9999px', 'button': '8px'}}}}</script>
        <!-- CSS styles giữ nguyên -->
        <style>
            /* Giữ nguyên styles từ file cũ */
            body {
                font-family: 'Inter', sans-serif;
                background-color: #f9fafb;
            }
            /* ... các styles khác ... */
        </style>
    </head>
    <body class="bg-gray-100 font-sans text-gray-900">
        <div class="flex h-screen">
            <%@ include file="sidebar.jsp" %>

            <div class="flex-1 flex flex-col md:ml-64">
                <!-- Header giữ nguyên -->
                <header class="bg-white border-b border-gray-200 shadow-sm fixed top-0 z-40 w-full md:w-[calc(100%-16rem)] md:left-64">
                    <!-- Header content giữ nguyên -->
                </header>

                <main class="flex-1 overflow-y-auto bg-gray-50 p-4 md:p-6 custom-scrollbar md:mt-16">
                    <div class="max-w-7xl mx-auto">
                        <!-- Welcome Section -->
                        <div class="bg-white rounded-lg shadow-sm overflow-hidden mb-6">
                            <div class="p-6 flex flex-col md:flex-row items-center justify-between">
                                <div class="mb-4 md:mb-0">
                                    <h1 class="text-2xl font-bold text-gray-800">Xin chào, ${student.fullName}!</h1>
                                    <p class="text-gray-600 mt-1">
                                        <fmt:formatDate value="<%= new java.util.Date() %>" pattern="EEEE, dd 'tháng' MM, yyyy" />
                                    </p>
                                </div>
                                <div class="flex space-x-3">
                                    <a href="${pageContext.request.contextPath}/student/available-courses" 
                                       class="bg-primary text-white px-4 py-2 rounded-button flex items-center gap-2 whitespace-nowrap">
                                        <div class="w-5 h-5 flex items-center justify-center">
                                            <i class="ri-video-add-line"></i>
                                        </div>
                                        <span>Tham gia lớp học</span>
                                    </a>
                                    
                                </div>
                            </div>
                        </div>

                        <!-- Statistics Cards -->
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
                            <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-100">
                                <div class="flex items-center justify-between mb-4">
                                    <h3 class="text-gray-500 text-sm font-medium">Khóa học đang học</h3>
                                    <div class="w-10 h-10 flex items-center justify-center rounded-full bg-primary/10 text-primary">
                                        <i class="ri-book-open-line"></i>
                                    </div>
                                </div>
                                <p class="text-3xl font-bold text-gray-800">${dashboardStats.enrolledCourses}</p>
                                <p class="text-sm text-gray-500 mt-1">Học kỳ hiện tại</p>
                            </div>
                            
                            <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-100">
                                <div class="flex items-center justify-between mb-4">
                                    <h3 class="text-gray-500 text-sm font-medium">Bài tập đang chờ</h3>
                                    <div class="w-10 h-10 flex items-center justify-center rounded-full bg-orange-100 text-orange-500">
                                        <i class="ri-file-list-3-line"></i>
                                    </div>
                                </div>
                                <p class="text-3xl font-bold text-gray-800">${dashboardStats.pendingAssignments}</p>
                                <p class="text-sm text-gray-500 mt-1">Cần hoàn thành</p>
                            </div>
                            
                            <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-100">
                                <div class="flex items-center justify-between mb-4">
                                    <h3 class="text-gray-500 text-sm font-medium">Thông báo mới</h3>
                                    <div class="w-10 h-10 flex items-center justify-center rounded-full bg-red-100 text-red-500">
                                        <i class="ri-notification-3-line"></i>
                                    </div>
                                </div>
                                <p class="text-3xl font-bold text-gray-800">${dashboardStats.unreadAnnouncements}</p>
                                <p class="text-sm text-gray-500 mt-1">Trong tuần</p>
                            </div>
                            
                            <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-100">
                                <div class="flex items-center justify-between mb-4">
                                    <h3 class="text-gray-500 text-sm font-medium">GPA hiện tại</h3>
                                    <div class="w-10 h-10 flex items-center justify-center rounded-full bg-green-100 text-green-500">
                                        <i class="ri-bar-chart-line"></i>
                                    </div>
                                </div>
                                <p class="text-3xl font-bold text-gray-800">
                                    <fmt:formatNumber value="${gpa}" pattern="##0.00"/>
                                </p>
                                <p class="text-sm text-gray-500 mt-1">Thang điểm 10</p>
                            </div>
                        </div>

                        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                            <!-- Enrolled Courses -->
                            <div class="lg:col-span-2">
                                <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden mb-6">
                                    <div class="p-6 border-b border-gray-100">
                                        <div class="flex items-center justify-between">
                                            <h2 class="text-lg font-semibold text-gray-800">Khóa học của tôi</h2>
                                            <a href="${pageContext.request.contextPath}/student/courses" 
                                               class="text-sm text-primary hover:underline">Xem tất cả</a>
                                        </div>
                                    </div>
                                    <div class="divide-y divide-gray-100">
                                        <c:forEach var="course" items="${enrolledCourses}" varStatus="status">
                                            <c:if test="${status.index < 3}">
                                                <div class="p-6 hover:bg-gray-50">
                                                    <div class="flex items-start">
                                                        <div class="w-12 h-12 flex items-center justify-center rounded-lg bg-blue-100 text-blue-600 mr-4 flex-shrink-0">
                                                            <i class="ri-code-s-slash-line text-xl"></i>
                                                        </div>
                                                        <div class="flex-1">
                                                            <div class="flex flex-col md:flex-row md:items-center md:justify-between mb-2">
                                                                <h3 class="text-base font-medium text-gray-800">${course.name}</h3>
                                                                <span class="text-xs text-gray-500 mt-1 md:mt-0">${course.code} - ${course.room}</span>
                                                            </div>
                                                            
                                                            
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                        
                                        <c:if test="${empty enrolledCourses}">
                                            <div class="p-6 text-center text-gray-500">
                                                <i class="ri-book-2-line text-4xl mb-2"></i>
                                                <p>Chưa có khóa học nào</p>
                                                <a href="${pageContext.request.contextPath}/student/available-courses" 
                                                   class="text-primary hover:underline">Đăng ký khóa học</a>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Upcoming Assignments -->
                            <div class="lg:col-span-1">
                                <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden">
                                    <div class="p-6 border-b border-gray-100">
                                        <div class="flex items-center justify-between">
                                            <h2 class="text-lg font-semibold text-gray-800">Bài tập sắp tới</h2>
                                            <a href="${pageContext.request.contextPath}/student/assignments" 
                                               class="text-sm text-primary hover:underline">Xem tất cả</a>
                                        </div>
                                    </div>
                                    <div class="divide-y divide-gray-100">
                                        <c:forEach var="assignment" items="${upcomingAssignments}" varStatus="status">
                                            <c:if test="${status.index < 3}">
                                                <div class="p-6 hover:bg-gray-50">
                                                    <h3 class="text-base font-medium text-gray-800 mb-1">${assignment.title}</h3>
                                                    <p class="text-sm text-gray-500 mb-2">Môn: ${assignment.courseName}</p>
                                                    <div class="flex items-center text-sm text-gray-600">
                                                        <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                            <i class="ri-calendar-line"></i>
                                                        </div>
                                                        <span>Hạn nộp: <fmt:formatDate value="${assignment.dueDate}" pattern="dd/MM/yyyy"/></span>
                                                        <div class="w-4 h-4 flex items-center justify-center ml-4 mr-1">
                                                            <i class="ri-time-line"></i>
                                                        </div>
                                                        <span><fmt:formatDate value="${assignment.dueDate}" pattern="HH:mm"/></span>
                                                    </div>
                                                    <c:choose>
                                                        <c:when test="${assignment.submitted}">
                                                            <span class="mt-3 inline-block px-4 py-1.5 bg-green-100 text-green-800 text-sm rounded-button">Đã nộp</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="${pageContext.request.contextPath}/student/assignment-submit?assignmentId=${assignment.assignmentId}" 
                                                               class="mt-3 inline-block px-4 py-1.5 bg-primary text-white text-sm rounded-button">Làm bài</a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                        
                                        <c:if test="${empty upcomingAssignments}">
                                            <div class="p-6 text-center text-gray-500">
                                                <i class="ri-file-list-3-line text-4xl mb-2"></i>
                                                <p>Không có bài tập nào sắp tới</p>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        
        <!-- Scripts giữ nguyên -->
        <script>
            // Mobile menu script giữ nguyên
        </script>
    </body>
</html>