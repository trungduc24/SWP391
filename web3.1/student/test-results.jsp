<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.*" %>
<%
    List<Test> completedTests = (List<Test>) request.getAttribute("completedTests");
    Map<Integer, TestSubmission> testSubmissions = (Map<Integer, TestSubmission>) request.getAttribute("testSubmissions");
    Student student = (Student) request.getAttribute("student");
    User currentUser = (User) request.getAttribute("currentUser");
    
    int totalTests = (Integer) request.getAttribute("totalTests");
    int passedTests = (Integer) request.getAttribute("passedTests");
    double averageScore = (Double) request.getAttribute("averageScore");
    double totalScore = (Double) request.getAttribute("totalScore");
    
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    
    if (completedTests == null) completedTests = new ArrayList<>();
    if (testSubmissions == null) testSubmissions = new HashMap<>();
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả bài kiểm tra - Hệ thống Quản lý Học tập</title>
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
        .custom-scrollbar::-webkit-scrollbar {
            width: 6px;
            height: 6px;
        }
        .custom-scrollbar::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 8px;
        }
        .custom-scrollbar::-webkit-scrollbar-thumb {
            background: #c5c7d0;
            border-radius: 8px;
        }
        .custom-scrollbar::-webkit-scrollbar-thumb:hover {
            background: #a1a3af;
        }
    </style>
</head>
<body class="bg-gray-100 font-sans text-gray-900">
    <div class="flex h-screen">
        <%@ include file="sidebar.jsp" %>

        <div class="flex-1 flex flex-col">
            <header class="bg-white border-b border-gray-200 shadow-sm">
                <div class="flex items-center justify-between px-4 py-3">
                    <button class="md:hidden w-10 h-10 flex items-center justify-center text-gray-600" id="mobileMenuBtn">
                        <i class="ri-menu-line text-xl"></i>
                    </button>
                    <a href="./dashboard.jsp" class="hidden md:flex items-center text-gray-600 hover:text-primary">
                        <div class="w-8 h-8 flex items-center justify-center">
                            <i class="ri-arrow-left-line text-xl"></i>
                        </div>
                        <span class="ml-1 text-sm font-medium">Quay lại</span>
                    </a>
                    <div class="md:hidden flex items-center">
                        <span class="text-xl font-['Pacifico'] text-primary">logo</span>
                        <span class="ml-1 text-base font-semibold text-gray-800">LMS</span>
                    </div>
                    <div class="hidden md:flex items-center flex-1 max-w-lg mx-4">
                        <div class="relative w-full">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                <i class="ri-search-line text-gray-400"></i>
                            </div>
                            <input type="text" class="bg-gray-50 border-none text-gray-900 text-sm rounded-lg block w-full pl-10 p-2.5 focus:ring-2 focus:ring-primary/20 focus:outline-none" placeholder="Tìm kiếm bài kiểm tra...">
                        </div>
                    </div>
                    <div class="flex items-center space-x-4">
                        <div class="relative">
                            <button class="w-10 h-10 flex items-center justify-center text-gray-600 hover:text-primary hover:bg-gray-100 rounded-full">
                                <i class="ri-notification-3-line"></i>
                            </button>
                            <span class="absolute top-1 right-1 w-5 h-5 flex items-center justify-center bg-red-500 text-white text-xs rounded-full">3</span>
                        </div>
                        <button class="w-10 h-10 flex items-center justify-center text-gray-600 hover:text-primary hover:bg-gray-100 rounded-full">
                            <i class="ri-message-3-line"></i>
                        </button>
                        <div class="md:hidden">
                            <button class="w-10 h-10 flex items-center justify-center">
                                <img src="https://readdy.ai/api/search-image?query=professional%20portrait%20photo%20of%20a%20young%20vietnamese%20male%20student%2C%20casual%20outfit%2C%20neutral%20background%2C%20friendly%20smile&width=100&height=100&seq=1&orientation=squarish" alt="Avatar" class="w-8 h-8 rounded-full object-cover">
                            </button>
                        </div>
                    </div>
                </div>
            </header>
            
            <main class="flex-1 overflow-y-auto bg-gray-50 p-4 md:p-6 custom-scrollbar">
                <div class="max-w-7xl mx-auto" style="margin-left: 300px;">
                    <!-- Header -->
                    <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-6 mb-6">
                        <div class="flex items-center justify-between">
                            <div>
                                <h1 class="text-2xl font-bold text-gray-800">Kết quả bài kiểm tra</h1>
                                <p class="text-gray-600 mt-1">Xem điểm số và thống kê các bài kiểm tra đã hoàn thành</p>
                            </div>
                            <div class="flex items-center space-x-4">
                                <button class="px-4 py-2 bg-primary text-white text-sm font-medium rounded-button hover:bg-primary-dark transition-colors">
                                    <i class="ri-download-line mr-2"></i>Xuất báo cáo
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Statistics Cards -->
                    <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-6">
                        <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-6">
                            <div class="flex items-center">
                                <div class="w-12 h-12 bg-blue-100 text-blue-600 rounded-lg flex items-center justify-center mr-4">
                                    <i class="ri-file-list-line text-xl"></i>
                                </div>
                                <div>
                                    <p class="text-sm font-medium text-gray-600">Tổng bài kiểm tra</p>
                                    <p class="text-2xl font-bold text-gray-900"><%= totalTests %></p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-6">
                            <div class="flex items-center">
                                <div class="w-12 h-12 bg-green-100 text-green-600 rounded-lg flex items-center justify-center mr-4">
                                    <i class="ri-check-line text-xl"></i>
                                </div>
                                <div>
                                    <p class="text-sm font-medium text-gray-600">Bài đạt</p>
                                    <p class="text-2xl font-bold text-gray-900"><%= passedTests %></p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-6">
                            <div class="flex items-center">
                                <div class="w-12 h-12 bg-yellow-100 text-yellow-600 rounded-lg flex items-center justify-center mr-4">
                                    <i class="ri-star-line text-xl"></i>
                                </div>
                                <div>
                                    <p class="text-sm font-medium text-gray-600">Điểm trung bình</p>
                                    <p class="text-2xl font-bold text-gray-900"><%= String.format("%.1f", averageScore) %></p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-6">
                            <div class="flex items-center">
                                <div class="w-12 h-12 bg-purple-100 text-purple-600 rounded-lg flex items-center justify-center mr-4">
                                    <i class="ri-trophy-line text-xl"></i>
                                </div>
                                <div>
                                    <p class="text-sm font-medium text-gray-600">Tổng điểm</p>
                                    <p class="text-2xl font-bold text-gray-900"><%= String.format("%.0f", totalScore) %></p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Test Results Table -->
                    <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden">
                        <div class="px-6 py-4 border-b border-gray-200">
                            <h2 class="text-lg font-semibold text-gray-800">Danh sách bài kiểm tra</h2>
                        </div>
                        
                        <% if (!completedTests.isEmpty()) { %>
                        <div class="overflow-x-auto">
                            <table class="min-w-full divide-y divide-gray-200">
                                <thead class="bg-gray-50">
                                    <tr>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Bài kiểm tra
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Môn học
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Loại
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Điểm
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Thời gian làm
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Ngày làm
                                        </th>
                                        <th scope="col" class="relative px-6 py-3">
                                            <span class="sr-only">Hành động</span>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody class="bg-white divide-y divide-gray-200">
                                    <% for (Test test : completedTests) { 
                                        TestSubmission submission = testSubmissions.get(test.getTestId());
                                        boolean isPassed = submission != null && submission.getScore() != null && 
                                                          submission.getScore() >= test.getMaxScore() * 0.5;
                                    %>
                                    <tr>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="flex items-center">
                                                <div class="w-10 h-10 flex items-center justify-center rounded-lg <%= isPassed ? "bg-green-100 text-green-600" : "bg-red-100 text-red-600" %> mr-3">
                                                    <i class="<%= isPassed ? "ri-check-line" : "ri-close-line" %> text-lg"></i>
                                                </div>
                                                <div>
                                                    <div class="text-sm font-medium text-gray-900"><%= test.getTitle() %></div>
                                                    <div class="text-sm text-gray-500">Giảng viên: <%= test.getLecturerName() %></div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="text-sm text-gray-900"><%= test.getCourseName() %></div>
                                            <div class="text-sm text-gray-500"><%= test.getCourseCode() %></div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                                                       <%= "midterm".equals(test.getTestType()) ? "bg-blue-100 text-blue-800" : 
                                                          "final".equals(test.getTestType()) ? "bg-red-100 text-red-800" : 
                                                          "bg-gray-100 text-gray-800" %>">
                                                <%= "midterm".equals(test.getTestType()) ? "Giữa kỳ" : 
                                                   "final".equals(test.getTestType()) ? "Cuối kỳ" : 
                                                   "Quiz" %>
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <% if (submission != null && submission.getScore() != null) { %>
                                                <div class="text-sm font-medium text-gray-900">
                                                    <%= String.format("%.1f", submission.getScore()) %> / <%= test.getMaxScore() %>
                                                </div>
                                                <div class="text-sm text-gray-500">
                                                    <%= String.format("%.1f", (submission.getScore() / test.getMaxScore()) * 100) %>%
                                                </div>
                                            <% } else { %>
                                                <span class="text-sm text-gray-500">Chưa chấm</span>
                                            <% } %>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                            <% if (submission != null && submission.getTimeSpentMinutes() != null) { %>
                                                <%= submission.getTimeSpentMinutes() %> phút
                                            <% } else { %>
                                                -
                                            <% } %>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                            <% if (submission != null && submission.getSubmittedAt() != null) { %>
                                                <%= sdf.format(submission.getSubmittedAt()) %>
                                            <% } else { %>
                                                -
                                            <% } %>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                            <a href="<%= request.getContextPath() %>/student/exam-result?id=<%= test.getTestId() %>" 
                                               class="text-primary hover:text-primary-dark">
                                                Xem chi tiết
                                            </a>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                        <% } else { %>
                        <div class="text-center py-12">
                            <div class="w-20 h-20 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                <i class="ri-file-list-line text-2xl text-gray-400"></i>
                            </div>
                            <h3 class="text-lg font-medium text-gray-800 mb-2">Chưa có bài kiểm tra nào</h3>
                            <p class="text-gray-500">Bạn chưa hoàn thành bài kiểm tra nào.</p>
                        </div>
                        <% } %>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Mobile Menu Toggle
            const mobileMenuBtn = document.getElementById('mobileMenuBtn');
            const sidebar = document.querySelector('aside');
            mobileMenuBtn.addEventListener('click', function () {
                sidebar.classList.toggle('hidden');
                sidebar.classList.toggle('fixed');
                sidebar.classList.toggle('z-50');
                sidebar.classList.toggle('top-0');
                sidebar.classList.toggle('left-0');
                sidebar.classList.toggle('h-full');
                sidebar.classList.toggle('w-64');
            });
        });
    </script>
</body>
</html>