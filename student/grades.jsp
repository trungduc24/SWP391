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

        <!-- Page Content -->
        <main class="flex-1 overflow-y-auto bg-gray-50 p-6 custom-scrollbar">
            <div class="max-w-7xl mx-auto">
                <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-100 mb-6">
                    <h1 class="text-2xl font-semibold text-gray-800 mb-4">Bảng điểm học kỳ</h1>

                    <table class="min-w-full table-auto border border-gray-200 rounded-lg overflow-hidden">
                        <thead class="bg-gray-100 text-gray-700 text-sm font-semibold">
                            <tr>
                                <th class="px-4 py-2 text-left">Mã môn</th>
                                <th class="px-4 py-2 text-left">Tên môn học</th>
                                <th class="px-4 py-2 text-center">Giảng viên</th>
                                <th class="px-4 py-2 text-center">Điểm giữa kỳ</th>
                                <th class="px-4 py-2 text-center">Điểm cuối kỳ</th>
                                <th class="px-4 py-2 text-center">Tổng kết</th>
                                <th class="px-4 py-2 text-center">Xếp loại</th>
                            </tr>
                        </thead>
                        <tbody class="text-sm text-gray-700 divide-y divide-gray-100">
                            <c:forEach var="grade" items="${grades}">
                                <tr class="hover:bg-gray-50">
                                    <td class="px-4 py-2">${grade.courseCode}</td>
                                    <td class="px-4 py-2">${grade.courseName}</td>
                                    <td class="px-4 py-2 text-center">${grade.teacher}</td>
                                    <td class="px-4 py-2 text-center">${grade.midterm}</td>
                                    <td class="px-4 py-2 text-center">${grade.finalExam}</td>
                                    <td class="px-4 py-2 text-center font-semibold">${grade.total}</td>
                                    <td class="px-4 py-2 text-center">
                                        <c:choose>
                                            <c:when test="${grade.total >= 8}">Giỏi</c:when>
                                            <c:when test="${grade.total >= 6.5}">Khá</c:when>
                                            <c:when test="${grade.total >= 5}">Trung bình</c:when>
                                            <c:otherwise>Yếu</c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="text-right text-sm text-gray-600 italic">
                    GPA học kỳ: <strong class="text-primary">${gpa}</strong>
                </div>
            </div>
        </main>
    </div>
</div>
</body>
</html>
