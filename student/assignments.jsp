<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/includes/head.jsp" />
<body>
<div class="min-h-screen flex">
    <!-- Sidebar -->
    <jsp:include page="/includes/sidebar.jsp" />

    <!-- Main Content -->
    <div class="flex-1 flex flex-col">
        <!-- Header -->
        <jsp:include page="/includes/header.jsp" />

        <!-- Content -->
        <main class="flex-1 overflow-y-auto bg-gray-50 p-4 md:p-6 custom-scrollbar">
            <div class="max-w-7xl mx-auto">
                <!-- Section title -->
                <div class="bg-white rounded-lg shadow-sm p-6 mb-6 border border-gray-100">
                    <h1 class="text-2xl font-bold text-gray-800 mb-2">Danh sách bài tập</h1>
                    <p class="text-sm text-gray-600">Các bài tập sắp đến hạn hoặc đã giao trong học kỳ.</p>
                </div>

                <!-- Assignment List -->
                <div class="space-y-4">
                    <c:forEach var="assignment" items="${assignments}">
                        <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-6 hover:bg-gray-50">
                            <div class="flex items-center justify-between mb-2">
                                <h3 class="text-base font-medium text-gray-800">${assignment.title}</h3>
                                <span class="px-2.5 py-1 
                                    <c:choose>
                                        <c:when test="${assignment.daysLeft <= 2}">
                                            bg-red-100 text-red-700
                                        </c:when>
                                        <c:when test="${assignment.daysLeft <= 5}">
                                            bg-orange-100 text-orange-700
                                        </c:when>
                                        <c:otherwise>
                                            bg-green-100 text-green-700
                                        </c:otherwise>
                                    </c:choose>
                                    text-xs rounded-full">
                                    Còn ${assignment.daysLeft} ngày
                                </span>
                            </div>
                            <p class="text-sm text-gray-600 mb-3">${assignment.description}</p>
                            <div class="flex items-center justify-between">
                                <span class="text-xs text-gray-500">Môn: ${assignment.subject}</span>
                                <a href="submitAssignment?id=${assignment.id}" class="text-sm text-primary hover:underline">Nộp bài</a>
                            </div>
                        </div>
                    </c:forEach>

                    <!-- Nếu không có bài tập -->
                    <c:if test="${empty assignments}">
                        <div class="bg-white p-6 rounded-lg shadow-sm text-center text-gray-500">
                            <i class="ri-file-list-3-line text-3xl text-gray-400 mb-2"></i>
                            <p>Không có bài tập nào được giao.</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </main>
    </div>
</div>
</body>
</html>
