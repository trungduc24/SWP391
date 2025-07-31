<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/includes/head.jsp" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Tài liệu học tập</title>
</head>
<body class="bg-gray-50">
<div class="min-h-screen flex">
    <%@ include file="/includes/sidebar.jsp" %>

    <div class="flex-1 flex flex-col">
        <%@ include file="/includes/header.jsp" %>

        <main class="flex-1 overflow-y-auto bg-gray-50 p-6 custom-scrollbar">
            <div class="max-w-7xl mx-auto">
                <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden mb-6">
                    <div class="p-6 border-b border-gray-100 flex items-center justify-between">
                        <h2 class="text-xl font-semibold text-gray-800">Tài liệu học tập</h2>
                        <form method="get" action="documents.jsp" class="flex">
                            <input type="text" name="search" placeholder="Tìm tài liệu..." class="px-3 py-2 border rounded-lg text-sm focus:outline-none" />
                            <button type="submit" class="ml-2 px-4 py-2 bg-primary text-white rounded-button text-sm">Tìm</button>
                        </form>
                    </div>

                    <div class="divide-y divide-gray-100">
                        <c:choose>
                            <c:when test="${not empty documentList}">
                                <c:forEach var="doc" items="${documentList}">
                                    <div class="p-6 hover:bg-gray-50">
                                        <div class="flex justify-between items-center">
                                            <div>
                                                <h3 class="text-base font-semibold text-gray-800">${doc.title}</h3>
                                                <p class="text-sm text-gray-500 mt-1">${doc.courseName} • ${doc.uploadDate}</p>
                                            </div>
                                            <a href="${doc.downloadLink}" class="text-sm text-primary hover:underline" download>
                                                <i class="ri-download-2-line mr-1"></i>Tải xuống
                                            </a>
                                        </div>
                                        <p class="text-sm text-gray-600 mt-2">${doc.description}</p>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="p-6 text-center text-gray-500">
                                    Không tìm thấy tài liệu nào.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
</body>
</html>
