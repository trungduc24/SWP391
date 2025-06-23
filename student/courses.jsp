<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/includes/head.jsp" />
<body class="bg-gray-50 font-['Inter']">
<div class="min-h-screen flex">

    <%-- Sidebar --%>
    <jsp:include page="/includes/sidebar.jsp" />

    <%-- Main content --%>
    <div class="flex-1 flex flex-col">
        <jsp:include page="/includes/header.jsp" />

        <main class="flex-1 overflow-y-auto p-6 custom-scrollbar">
            <div class="max-w-7xl mx-auto">
                <h1 class="text-2xl font-bold text-gray-800 mb-6">Khóa học của tôi</h1>

                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <c:forEach var="course" items="${courseList}">
                        <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-100 hover:shadow-md transition">
                            <div class="flex items-center justify-between mb-4">
                                <h3 class="text-lg font-semibold text-gray-800">${course.name}</h3>
                                <span class="text-sm text-gray-500">${course.code}</span>
                            </div>
                            <p class="text-sm text-gray-600 mb-2">
                                <i class="ri-user-line mr-1 text-primary"></i>
                                Giảng viên: ${course.teacher}
                            </p>
                            <p class="text-sm text-gray-600 mb-2">
                                <i class="ri-time-line mr-1 text-primary"></i>
                                Lịch học: ${course.schedule}
                            </p>
                            <p class="text-sm text-gray-600 mb-4">
                                <i class="ri-map-pin-line mr-1 text-primary"></i>
                                Phòng học: ${course.room}
                            </p>

                            <div class="mb-2">
                                <div class="flex items-center justify-between text-xs text-gray-500">
                                    <span>Tiến độ: ${course.progress}%</span>
                                    <span>${course.sessionsCompleted}/${course.totalSessions} buổi</span>
                                </div>
                                <progress class="course-progress w-full h-2 mt-1" value="${course.progress}" max="100"></progress>
                            </div>

                            <a href="CourseDetailServlet?courseId=${course.id}" class="mt-4 inline-block bg-primary text-white px-4 py-2 rounded-button text-sm text-center w-full hover:bg-primary/90 transition">
                                Vào học
                            </a>
                        </div>
                    </c:forEach>
                </div>

                <c:if test="${empty courseList}">
                    <div class="text-center text-gray-500 text-sm mt-10">
                        Bạn chưa đăng ký khóa học nào.
                    </div>
                </c:if>
            </div>
        </main>
    </div>
</div>
</body>
</html>
