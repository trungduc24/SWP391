<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/includes/head.jsp" />
<body>
<div class="min-h-screen flex">
    <%-- Sidebar --%>
    <jsp:include page="/includes/sidebar.jsp" />

    <%-- Main content --%>
    <div class="flex-1 flex flex-col">
        <%-- Header --%>
        <jsp:include page="/includes/header.jsp" />

        <main class="flex-1 overflow-y-auto bg-gray-50 p-4 md:p-6 custom-scrollbar">
            <div class="max-w-6xl mx-auto">
                <h1 class="text-2xl font-bold text-gray-800 mb-6">Lịch học của bạn</h1>

                <%-- Ngày hiện tại --%>
                <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-100 mb-4">
                    <h2 class="text-xl font-semibold text-gray-800 mb-4">Hôm nay: 
                        <c:out value="${currentDate}" />
                    </h2>
                    <c:choose>
                        <c:when test="${not empty todaySchedule}">
                            <c:forEach var="item" items="${todaySchedule}">
                                <div class="flex items-center p-4 bg-gray-50 rounded-lg mb-3">
                                    <div class="w-2 h-10 bg-green-500 rounded-full mr-4"></div>
                                    <div>
                                        <p class="text-sm font-medium text-gray-800">${item.subjectName}</p>
                                        <p class="text-xs text-gray-500">${item.time} • ${item.room}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="p-4 bg-yellow-50 text-yellow-800 rounded-lg">Không có lịch học hôm nay</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <%-- Lịch học các ngày khác trong tuần --%>
                <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-100">
                    <h2 class="text-xl font-semibold text-gray-800 mb-4">Lịch học trong tuần</h2>
                    <c:forEach var="day" items="${weekSchedule}">
                        <div class="mb-4">
                            <h3 class="text-lg font-semibold text-gray-700">${day.dateFormatted}</h3>
                            <c:choose>
                                <c:when test="${not empty day.classes}">
                                    <c:forEach var="cls" items="${day.classes}">
                                        <div class="flex items-center p-3 bg-blue-50 rounded-lg mb-2">
                                            <div class="w-2 h-10 bg-blue-500 rounded-full mr-4"></div>
                                            <div class="flex-1">
                                                <p class="text-sm font-medium text-gray-800">${cls.subjectName}</p>
                                                <p class="text-xs text-gray-500">${cls.time} • ${cls.room}</p>
                                            </div>
                                            <div class="w-8 h-8 flex items-center justify-center rounded-full bg-blue-100 text-blue-600">
                                                <i class="ri-arrow-right-s-line"></i>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-sm text-gray-400 italic">Không có lớp học</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </main>
    </div>
</div>
</body>
</html>
