<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="model.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
    Assignment assignment = (Assignment) request.getAttribute("assignment");
    Submission submission = (Submission) request.getAttribute("submission");
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    
    boolean isLate = false;
    if (assignment.getDueDate() != null) {
        isLate = new Date().after(assignment.getDueDate());
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nộp bài tập - <%= assignment.getTitle() %></title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
</head>
<body class="bg-gray-50">
    <div class="min-h-screen py-6">
        <div class="max-w-4xl mx-auto px-4">
            
            <!-- Header -->
            <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-6 mb-6">
                <div class="flex items-center justify-between">
                    <div>
                        <h1 class="text-2xl font-bold text-gray-800"><%= assignment.getTitle() %></h1>
                        <p class="text-gray-600 mt-2"><%= assignment.getDescription() %></p>
                    </div>
                    <div class="text-right">
                        <div class="text-sm text-gray-500">Hạn nộp</div>
                        <div class="text-lg font-semibold <%= isLate ? "text-red-600" : "text-blue-600" %>">
                            <%= assignment.getDueDate() != null ? sdf.format(assignment.getDueDate()) : "Không giới hạn" %>
                        </div>
                        <% if (isLate) { %>
                        <div class="text-red-500 text-sm mt-1">
                            <i class="ri-time-line"></i> Đã quá hạn
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- Thông báo -->
            <% if (request.getSession().getAttribute("error") != null) { %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                <%= request.getSession().getAttribute("error") %>
                <% request.getSession().removeAttribute("error"); %>
            </div>
            <% } %>

            <% if (request.getSession().getAttribute("success") != null) { %>
            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
                <%= request.getSession().getAttribute("success") %>
                <% request.getSession().removeAttribute("success"); %>
            </div>
            <% } %>

            <!-- Form nộp bài -->
            <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-6">
                <h2 class="text-xl font-semibold text-gray-800 mb-6">
                    <%= submission != null ? "Chỉnh sửa bài nộp" : "Nộp bài tập" %>
                </h2>

                <form action="<%= request.getContextPath() %>/student/assignment-submit" method="post">
                    <input type="hidden" name="assignmentId" value="<%= assignment.getAssignmentId() %>">
                    
                    <!-- Nội dung bài làm -->
                    <div class="mb-6">
                        <label for="submissionText" class="block text-sm font-medium text-gray-700 mb-2">
                            Nội dung bài làm
                        </label>
                        <textarea 
                            id="submissionText" 
                            name="submissionText" 
                            rows="8" 
                            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                            placeholder="Nhập nội dung bài làm của bạn..."
                        ><%= submission != null && submission.getSubmissionText() != null ? submission.getSubmissionText() : "" %></textarea>
                    </div>

                    <!-- Link file -->
                    <div class="mb-6">
                        <label for="fileUrl" class="block text-sm font-medium text-gray-700 mb-2">
                            Link file bài tập <span class="text-gray-500">(Google Drive, OneDrive, v.v.)</span>
                        </label>
                        <input 
                            type="url" 
                            id="fileUrl" 
                            name="fileUrl" 
                            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                            placeholder="https://drive.google.com/file/d/..."
                            value="<%= submission != null && submission.getFileUrl() != null ? submission.getFileUrl() : "" %>"
                        >
                        <p class="text-sm text-gray-500 mt-1">
                            <i class="ri-information-line"></i> 
                            Hãy đảm bảo link có thể truy cập công khai hoặc chia sẻ với giảng viên
                        </p>
                    </div>

                    <!-- Thông tin submission hiện tại -->
                    <% if (submission != null) { %>
                    <div class="bg-blue-50 border border-blue-200 rounded-md p-4 mb-6">
                        <h3 class="font-medium text-blue-800 mb-2">Thông tin bài nộp hiện tại:</h3>
                        <div class="text-sm text-blue-600">
                            <div class="flex items-center mb-1">
                                <i class="ri-time-line mr-2"></i>
                                Nộp lúc: <%= sdf.format(submission.getSubmittedAt()) %>
                            </div>
                            <div class="flex items-center mb-1">
                                <i class="ri-flag-line mr-2"></i>
                                Trạng thái: 
                                <span class="ml-1 px-2 py-1 rounded-full text-xs
                                    <%= submission.getStatus() != null && submission.getStatus().equals("late") ? "bg-red-100 text-red-800" : "bg-green-100 text-green-800" %>">
                                    <%= submission.getStatus() != null && submission.getStatus().equals("late") ? "Nộp muộn" : "Đúng hạn" %>
                                </span>
                            </div>
                            <% if (submission.getScore() != null) { %>
                            <div class="flex items-center">
                                <i class="ri-star-line mr-2"></i>
                                Điểm: <span class="font-semibold"><%= submission.getScore() %></span>
                            </div>
                            <% } %>
                        </div>
                    </div>
                    <% } %>

                    <!-- Buttons -->
                    <div class="flex justify-between items-center">
                        <a href="<%= request.getContextPath() %>/student/assignments" 
                           class="bg-gray-500 hover:bg-gray-600 text-white font-medium py-2 px-4 rounded-md transition duration-200">
                            <i class="ri-arrow-left-line mr-2"></i>Quay lại
                        </a>
                        
                        <button type="submit" 
                                class="bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-6 rounded-md transition duration-200">
                            <i class="ri-send-plane-line mr-2"></i>
                            <%= submission != null ? "Cập nhật bài nộp" : "Nộp bài" %>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>