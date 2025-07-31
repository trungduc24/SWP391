<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="model.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    List<CourseDisplayModel> enrolledCourses = (List<CourseDisplayModel>) request.getAttribute("enrolledCourses");
    Map<Integer, List<Material>> courseMaterials = (Map<Integer, List<Material>>) request.getAttribute("courseMaterials");
    SimpleDateFormat sdf = (SimpleDateFormat) request.getAttribute("sdf");
    
    if (enrolledCourses == null) {
        enrolledCourses = new ArrayList<>();
    }
    if (courseMaterials == null) {
        courseMaterials = new HashMap<>();
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
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css">
        <style>
            body {
                font-family: 'Inter', sans-serif;
                background-color: #f9fafb;
            }
            /* ... other styles ... */
        </style>
    </head>
    <body class="bg-gray-100 font-sans text-gray-900">
        <div class="flex h-screen">
            <%@ include file="sidebar.jsp" %>
            <div class="flex-1 flex flex-col md:ml-64">
                <!-- Header -->
                <header class="bg-white border-b border-gray-200 shadow-sm fixed top-0 z-40 w-full md:w-[calc(100%-16rem)] md:left-64">
                    <!-- Header content -->
                </header>

                <main class="flex-1 overflow-y-auto bg-gray-50 p-4 md:p-6 custom-scrollbar">
                    <div class="max-w-7xl mx-auto">
                        <!-- Breadcrumb -->
                        <nav class="flex mb-4" aria-label="Breadcrumb">
                            <ol class="inline-flex items-center space-x-1 md:space-x-2 rtl:space-x-reverse">
                                <li class="inline-flex items-center">
                                    <a href="./dashboard.jsp" class="inline-flex items-center text-sm font-medium text-gray-700 hover:text-primary">
                                        <i class="ri-home-line mr-2"></i>
                                        Trang chủ
                                    </a>
                                </li>
                                <li aria-current="page">
                                    <div class="flex items-center">
                                        <i class="ri-arrow-right-s-line text-gray-400 mx-1"></i>
                                        <span class="text-sm font-medium text-gray-500">Tài liệu</span>
                                    </div>
                                </li>
                            </ol>
                        </nav>

                        <h1 class="text-2xl font-bold text-gray-800 mb-6">Tài liệu học tập</h1>

                        <!-- Filters -->
                        <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-4 mb-6 flex flex-col md:flex-row items-center justify-between gap-4">
                            <!-- Filter content -->
                        </div>

                        <div id="documentListContainer">
                            <% if (enrolledCourses.isEmpty()) { %>
                            <div class="text-center py-12">
                                <div class="w-20 h-20 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                    <i class="ri-book-line text-2xl text-gray-400"></i>
                                </div>
                                <h3 class="text-lg font-medium text-gray-800 mb-2">Chưa có khóa học nào</h3>
                                <p class="text-gray-500">Bạn chưa đăng ký khóa học nào. Hãy đăng ký khóa học để xem tài liệu.</p>
                                <a href="available-courses" class="inline-block mt-4 px-4 py-2 bg-primary text-white rounded-button hover:bg-indigo-600">
                                    Xem khóa học có thể đăng ký
                                </a>
                            </div>
                            <% } else { %>
                            <% for (CourseDisplayModel course : enrolledCourses) { 
                                List<Material> materials = courseMaterials.get(course.getCourseId());
                                if (materials == null) materials = new ArrayList<>();
                            %>
                            <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-4 mb-6" data-subject="<%= course.getCode() %>">
                                <h2 class="text-xl font-semibold text-gray-800 mb-4 flex items-center">
                                    <i class="ri-book-open-line mr-2 text-primary"></i> 
                                    <%= course.getName() %> (<%= course.getCode() %>)
                                </h2>

                                <% if (materials.isEmpty()) { %>
                                <div class="text-center py-8">
                                    <i class="ri-file-line text-4xl text-gray-300 mb-2"></i>
                                    <p class="text-gray-500">Chưa có tài liệu nào cho khóa học này</p>
                                </div>
                                <% } else { %>
                                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4" id="documents_<%= course.getCode() %>">
                                    <% for (Material material : materials) { 
                                        String iconClass = "ri-file-text-line";
                                        String iconColor = "text-blue-500";
                                        String materialType = material.getMaterialType() != null ? material.getMaterialType().toLowerCase() : "other";
                        
                                        switch(materialType) {
                                            case "lecture":
                                                iconClass = "ri-file-text-line";
                                                iconColor = "text-blue-500";
                                                break;
                                            case "assignment":
                                                iconClass = "ri-file-list-3-line";
                                                iconColor = "text-green-500";
                                                break;
                                            case "reference":
                                                iconClass = "ri-booklet-line";
                                                iconColor = "text-purple-500";
                                                break;
                                            case "solution":
                                                iconClass = "ri-check-double-line";
                                                iconColor = "text-yellow-600";
                                                break;
                                            default:
                                                iconClass = "ri-file-line";
                                                iconColor = "text-gray-500";
                                        }
                                    %>
                                    <div class="document-item bg-gray-50 p-3 rounded-lg border border-gray-200 hover:shadow-md transition-shadow" 
                                         data-type="<%= materialType %>" 
                                         data-time="<%= material.getUploadDate() != null ? sdf.format(material.getUploadDate()) : "" %>">
                                        <div class="flex items-center mb-2">
                                            <i class="<%= iconClass %> text-2xl <%= iconColor %> mr-2"></i>
                                            <h3 class="text-base font-medium text-gray-900"><%= material.getTitle() %></h3>
                                        </div>
                                        <p class="text-sm text-gray-600 mb-2 line-clamp-2">
                                            <%= material.getDescription() != null ? material.getDescription() : "Không có mô tả" %>
                                        </p>
                                        <div class="text-xs text-gray-500 mb-3">
                                            <span class="mr-2">
                                                <i class="ri-user-line"></i> <%= course.getLecturerName() %>
                                            </span>
                                            <% if (material.getUploadDate() != null) { %>
                                            <span>
                                                <i class="ri-time-line"></i> <%= sdf.format(material.getUploadDate()) %>
                                            </span>
                                            <% } %>
                                        </div>
                                        <% if (material.getFilePath() != null && !material.getFilePath().trim().isEmpty()) { %>
                                        <a href="<%= request.getContextPath() %>/student/download-material?id=<%= material.getMaterialId() %>" 
                                           class="download-btn w-full flex items-center justify-center gap-2 py-2 px-3 bg-primary text-white text-sm font-medium rounded-button hover:bg-indigo-600">
                                            <i class="ri-download-line"></i> Tải xuống
                                        </a>
                                        <% } else { %>
                                        <button class="w-full flex items-center justify-center gap-2 py-2 px-3 bg-gray-400 text-white text-sm font-medium rounded-button cursor-not-allowed" disabled>
                                            <i class="ri-file-forbid-line"></i> Không có file
                                        </button>
                                        <% } %>
                                    </div>
                                    <% } %>
                                </div>
                                <% } %>
                            </div>
                            <% } %>
                            <% } %>

                            <!-- Pagination -->
                            <% if (!enrolledCourses.isEmpty()) { %>
                            <div class="flex justify-center mt-8">
                                <nav class="flex items-center space-x-2">
                                    <span class="px-3 py-2 rounded-lg text-sm font-medium text-white bg-primary">1</span>
                                </nav>
                            </div>
                            <% } %>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <!-- Mobile navigation -->
        <div class="md:hidden fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 z-10">
            <!-- Mobile nav content -->
        </div>

        <script>
            // JavaScript code for filtering and interactions
            document.addEventListener('DOMContentLoaded', function () {
                // Your existing JavaScript code...
            });
        </script>
    </body>
</html>