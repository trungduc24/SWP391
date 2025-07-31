<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="model.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    List<Assignment> assignments = (List<Assignment>) request.getAttribute("assignments");
    List<Assignment> completedAssignments = (List<Assignment>) request.getAttribute("completedAssignments");
    List<Assignment> upcomingAssignments = (List<Assignment>) request.getAttribute("upcomingAssignments");
    List<Assignment> overdueAssignments = (List<Assignment>) request.getAttribute("overdueAssignments");
    List<Assignment> submittedAssignments = (List<Assignment>) request.getAttribute("submittedAssignments");
    Map<Integer, Submission> submissions = (Map<Integer, Submission>) request.getAttribute("submissions");
    Double completionRate = (Double) request.getAttribute("completionRate");
    
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    
    // Debug thông tin
    System.out.println("DEBUG - Assignments loaded:");
    System.out.println("Total assignments: " + (assignments != null ? assignments.size() : 0));
    System.out.println("Completed: " + (completedAssignments != null ? completedAssignments.size() : 0));
    System.out.println("Upcoming: " + (upcomingAssignments != null ? upcomingAssignments.size() : 0));
    System.out.println("Overdue: " + (overdueAssignments != null ? overdueAssignments.size() : 0));
    System.out.println("Submitted: " + (submittedAssignments != null ? submittedAssignments.size() : 0));
    
    if (assignments == null) assignments = new ArrayList<>();
    if (completedAssignments == null) completedAssignments = new ArrayList<>();
    if (upcomingAssignments == null) upcomingAssignments = new ArrayList<>();
    if (overdueAssignments == null) overdueAssignments = new ArrayList<>();
    if (submittedAssignments == null) submittedAssignments = new ArrayList<>();
    if (submissions == null) submissions = new HashMap<>();
    if (completionRate == null) completionRate = 0.0;
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bài tập - LMSS</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
    <style>
        .tab-button {
            padding: 0.5rem 1rem;
            font-size: 0.875rem;
            font-weight: 500;
            color: #6b7280;
            border-bottom: 2px solid transparent;
            transition: all 0.2s ease;
        }
        
        .tab-button:hover {
            color: #374151;
            border-bottom-color: #d1d5db;
        }
        
        .tab-button.active {
            color: #2563eb;
            border-bottom-color: #2563eb;
        }
        
        .line-clamp-3 {
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
    </style>
</head>
<body class="bg-gray-50">
    <div class="flex h-screen">
        <%@ include file="sidebar.jsp" %>
        
        <div class="flex-1 flex flex-col md:ml-64">
            <!-- Header -->
            <header class="bg-white border-b border-gray-200 shadow-sm fixed top-0 z-40 w-full md:w-[calc(100%-16rem)] md:left-64">
                <div class="flex items-center justify-between h-16 px-4 md:px-6">
                    <div class="flex items-center">
                        <button class="md:hidden p-2 rounded-md text-gray-400 hover:text-gray-500 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-primary">
                            <i class="ri-menu-line text-xl"></i>
                        </button>
                        <h1 class="ml-4 text-xl font-semibold text-gray-800">Bài tập/Kiểm tra</h1>
                    </div>
                </div>
            </header>

            <main class="flex-1 overflow-y-auto bg-gray-50 pt-16 p-4 md:p-6">
                <div class="max-w-7xl mx-auto">
                    
                    <!-- Debug Info (remove in production) -->
                    <div class="bg-yellow-100 border border-yellow-400 text-yellow-700 px-4 py-3 rounded mb-4" style="font-size: 12px;">
                        <strong>Debug:</strong> 
                        Total: <%= assignments.size() %> | 
                        Completed: <%= completedAssignments.size() %> | 
                        Upcoming: <%= upcomingAssignments.size() %> | 
                        Overdue: <%= overdueAssignments.size() %> | 
                        Submitted: <%= submittedAssignments.size() %>
                    </div>
                    
                    <!-- Header with Description -->
                    <div class="mb-6">
                        <p class="text-gray-600 mb-4">Quản lý bài tập, kiểm tra và theo dõi tiến độ học tập của bạn</p>
                        
                        <!-- Statistics Cards -->
                        <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
                            <div class="bg-white p-4 rounded-lg shadow-sm border">
                                <div class="flex items-center">
                                    <div class="w-8 h-8 bg-blue-100 rounded-full flex items-center justify-center mr-3">
                                        <i class="ri-file-text-line text-blue-600"></i>
                                    </div>
                                    <div>
                                        <p class="text-sm text-gray-600">Tổng bài tập</p>
                                        <p class="text-xl font-semibold text-gray-800"><%= assignments.size() %></p>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="bg-white p-4 rounded-lg shadow-sm border">
                                <div class="flex items-center">
                                    <div class="w-8 h-8 bg-green-100 rounded-full flex items-center justify-center mr-3">
                                        <i class="ri-check-double-line text-green-600"></i>
                                    </div>
                                    <div>
                                        <p class="text-sm text-gray-600">Đã hoàn thành</p>
                                        <p class="text-xl font-semibold text-gray-800"><%= completedAssignments.size() %></p>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="bg-white p-4 rounded-lg shadow-sm border">
                                <div class="flex items-center">
                                    <div class="w-8 h-8 bg-yellow-100 rounded-full flex items-center justify-center mr-3">
                                        <i class="ri-time-line text-yellow-600"></i>
                                    </div>
                                    <div>
                                        <p class="text-sm text-gray-600">Sắp đến hạn</p>
                                        <p class="text-xl font-semibold text-gray-800"><%= upcomingAssignments.size() %></p>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="bg-white p-4 rounded-lg shadow-sm border">
                                <div class="flex items-center">
                                    <div class="w-8 h-8 bg-red-100 rounded-full flex items-center justify-center mr-3">
                                        <i class="ri-alert-line text-red-600"></i>
                                    </div>
                                    <div>
                                        <p class="text-sm text-gray-600">Quá hạn</p>
                                        <p class="text-xl font-semibold text-gray-800"><%= overdueAssignments.size() %></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Progress Bar -->
                        <div class="bg-white p-4 rounded-lg shadow-sm border">
                            <div class="flex justify-between items-center mb-2">
                                <span class="text-sm text-gray-600">Tiến độ hoàn thành</span>
                                <span class="text-sm font-semibold text-gray-800"><%= String.format("%.1f", completionRate) %>%</span>
                            </div>
                            <div class="w-full bg-gray-200 rounded-full h-2">
                                <div class="bg-blue-600 h-2 rounded-full transition-all duration-300" 
                                     style="width: <%= completionRate %>%"></div>
                            </div>
                        </div>
                    </div>

                    <!-- Tab Navigation -->
                    <div class="mb-6">
                        <nav class="flex space-x-8 border-b border-gray-200" aria-label="Tabs">
                            <button onclick="showTab('upcoming')" id="tab-upcoming" class="tab-button active">
                                <i class="ri-time-line mr-2"></i>Sắp đến hạn (<%= upcomingAssignments.size() %>)
                            </button>
                            <button onclick="showTab('overdue')" id="tab-overdue" class="tab-button">
                                <i class="ri-alert-line mr-2"></i>Quá hạn (<%= overdueAssignments.size() %>)
                            </button>
                            <button onclick="showTab('submitted')" id="tab-submitted" class="tab-button">
                                <i class="ri-send-plane-line mr-2"></i>Đã nộp (<%= submittedAssignments.size() %>)
                            </button>
                            <button onclick="showTab('completed')" id="tab-completed" class="tab-button">
                                <i class="ri-check-double-line mr-2"></i>Đã hoàn thành (<%= completedAssignments.size() %>)
                            </button>
                        </nav>
                    </div>

                    <!-- Tab Content - Upcoming -->
                    <div id="content-upcoming" class="tab-content">
                        <h2 class="text-xl font-semibold text-gray-800 mb-4">Bài tập sắp đến hạn</h2>
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                            <% for (Assignment assignment : upcomingAssignments) { %>
                            <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden hover:shadow-md transition-shadow">
                                <div class="p-6">
                                    <div class="flex justify-between items-start mb-4">
                                        <div class="flex items-center">
                                            <div class="w-10 h-10 flex items-center justify-center rounded-lg bg-yellow-100 text-yellow-600 mr-3">
                                                <i class="ri-time-line"></i>
                                            </div>
                                            <div>
                                                <h3 class="font-medium text-gray-800"><%= assignment.getTitle() %></h3>
                                                <p class="text-xs text-gray-500">Loại: <%= assignment.getType() %></p>
                                            </div>
                                        </div>
                                        <span class="px-2.5 py-1 bg-yellow-100 text-yellow-700 text-xs rounded-full">
                                            Chưa nộp
                                        </span>
                                    </div>
                                    <p class="text-sm text-gray-600 mb-4 line-clamp-3">
                                        <%= assignment.getDescription() != null ? assignment.getDescription() : "Không có mô tả" %>
                                    </p>
                                    <div class="flex items-center text-sm text-gray-500 mb-4">
                                        <i class="ri-calendar-line mr-2"></i>
                                        <span>Hạn nộp: <%= assignment.getDueDate() != null ? sdf.format(assignment.getDueDate()) : "Không giới hạn" %></span>
                                    </div>
                                    <div class="flex space-x-2">
                                        <a href="<%= request.getContextPath() %>/student/assignment/submit?assignmentId=<%= assignment.getAssignmentId() %>" 
                                           class="flex-1 bg-blue-600 hover:bg-blue-700 text-white text-sm font-medium py-2 px-3 rounded-md text-center transition duration-200">
                                            <i class="ri-send-plane-line mr-1"></i>Nộp bài
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <% } %>
                            
                            <% if (upcomingAssignments.isEmpty()) { %>
                            <div class="col-span-full text-center py-12">
                                <div class="w-20 h-20 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                    <i class="ri-time-line text-2xl text-gray-400"></i>
                                </div>
                                <h3 class="text-lg font-medium text-gray-800 mb-2">Không có bài tập sắp đến hạn</h3>
                                <p class="text-gray-500">Tất cả bài tập đã được nộp hoặc đã quá hạn.</p>
                            </div>
                            <% } %>
                        </div>
                    </div>

                    <!-- Tab Content - Overdue -->
                    <div id="content-overdue" class="tab-content hidden">
                        <h2 class="text-xl font-semibold text-gray-800 mb-4">Bài tập quá hạn</h2>
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                            <% for (Assignment assignment : overdueAssignments) { %>
                            <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden hover:shadow-md transition-shadow">
                                <div class="p-6">
                                    <div class="flex justify-between items-start mb-4">
                                        <div class="flex items-center">
                                            <div class="w-10 h-10 flex items-center justify-center rounded-lg bg-red-100 text-red-600 mr-3">
                                                <i class="ri-alert-line"></i>
                                            </div>
                                            <div>
                                                <h3 class="font-medium text-gray-800"><%= assignment.getTitle() %></h3>
                                                <p class="text-xs text-gray-500">Loại: <%= assignment.getType() %></p>
                                            </div>
                                        </div>
                                        <span class="px-2.5 py-1 bg-red-100 text-red-700 text-xs rounded-full">
                                            Quá hạn
                                        </span>
                                    </div>
                                    <p class="text-sm text-gray-600 mb-4 line-clamp-3">
                                        <%= assignment.getDescription() != null ? assignment.getDescription() : "Không có mô tả" %>
                                    </p>
                                    <div class="flex items-center text-sm text-red-600 mb-4">
                                        <i class="ri-calendar-line mr-2"></i>
                                        <span>Hạn nộp: <%= assignment.getDueDate() != null ? sdf.format(assignment.getDueDate()) : "Không giới hạn" %></span>
                                    </div>
                                    <div class="flex space-x-2">
                                        <a href="<%= request.getContextPath() %>/student/assignment/submit?assignmentId=<%= assignment.getAssignmentId() %>" 
                                           class="flex-1 bg-red-600 hover:bg-red-700 text-white text-sm font-medium py-2 px-3 rounded-md text-center transition duration-200">
                                            <i class="ri-send-plane-line mr-1"></i>Nộp muộn
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <% } %>
                            
                            <% if (overdueAssignments.isEmpty()) { %>
                            <div class="col-span-full text-center py-12">
                                <div class="w-20 h-20 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                    <i class="ri-alert-line text-2xl text-gray-400"></i>
                                </div>
                                <h3 class="text-lg font-medium text-gray-800 mb-2">Không có bài tập quá hạn</h3>
                                <p class="text-gray-500">Tuyệt vời! Bạn đã hoàn thành tất cả bài tập đúng hạn.</p>
                            </div>
                            <% } %>
                        </div>
                    </div>

                    <!-- Tab Content - Submitted -->
                    <div id="content-submitted" class="tab-content hidden">
                        <h2 class="text-xl font-semibold text-gray-800 mb-4">Bài tập đã nộp</h2>
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                            <% for (Assignment assignment : submittedAssignments) { 
                                Submission submission = submissions.get(assignment.getAssignmentId());
                            %>
                            <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden hover:shadow-md transition-shadow">
                                <div class="p-6">
                                    <div class="flex justify-between items-start mb-4">
                                        <div class="flex items-center">
                                            <div class="w-10 h-10 flex items-center justify-center rounded-lg bg-blue-100 text-blue-600 mr-3">
                                                <i class="ri-send-plane-line"></i>
                                            </div>
                                            <div>
                                                <h3 class="font-medium text-gray-800"><%= assignment.getTitle() %></h3>
                                                <p class="text-xs text-gray-500">Loại: <%= assignment.getType() %></p>
                                            </div>
                                        </div>
                                        <span class="px-2.5 py-1 bg-blue-100 text-blue-700 text-xs rounded-full">
                                            <%= submission != null && submission.isLate() ? "Nộp muộn" : "Đã nộp" %>
                                        </span>
                                    </div>
                                    <p class="text-sm text-gray-600 mb-4 line-clamp-3">
                                        <%= assignment.getDescription() != null ? assignment.getDescription() : "Không có mô tả" %>
                                    </p>
                                    <% if (submission != null) { %>
                                    <div class="bg-gray-50 rounded-md p-3 mb-4">
                                        <div class="flex items-center text-sm text-gray-600 mb-2">
                                            <i class="ri-time-line mr-2"></i>
                                            Nộp lúc: <%= sdf.format(submission.getSubmittedAt()) %>
                                        </div>
                                    </div>
                                    <% } %>
                                    <div class="flex space-x-2">
                                      
                                        <a href="<%= request.getContextPath() %>/student/assignment/submit?assignmentId=<%= assignment.getAssignmentId() %>" 
                                           class="flex-1 bg-gray-600 hover:bg-gray-700 text-white text-sm font-medium py-2 px-3 rounded-md text-center transition duration-200">
                                            <i class="ri-edit-line mr-1"></i>Chỉnh sửa
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <% } %>
                            
                            <% if (submittedAssignments.isEmpty()) { %>
                            <div class="col-span-full text-center py-12">
                                <div class="w-20 h-20 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                    <i class="ri-send-plane-line text-2xl text-gray-400"></i>
                                </div>
                                <h3 class="text-lg font-medium text-gray-800 mb-2">Chưa có bài tập nào được nộp</h3>
                                <p class="text-gray-500">Hãy kiểm tra các bài tập sắp đến hạn để nộp bài.</p>
                            </div>
                            <% } %>
                        </div>
                    </div>

                    <!-- Tab Content - Completed -->
                    <div id="content-completed" class="tab-content hidden">
                        <h2 class="text-xl font-semibold text-gray-800 mb-4">Bài tập đã hoàn thành</h2>
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                            <% for (Assignment assignment : completedAssignments) { 
                                Submission submission = submissions.get(assignment.getAssignmentId());
                            %>
                            <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden hover:shadow-md transition-shadow">
                                <div class="p-6">
                                    <div class="flex justify-between items-start mb-4">
                                        <div class="flex items-center">
                                            <div class="w-10 h-10 flex items-center justify-center rounded-lg bg-green-100 text-green-600 mr-3">
                                                <i class="ri-check-double-line"></i>
                                            </div>
                                            <div>
                                                <h3 class="font-medium text-gray-800"><%= assignment.getTitle() %></h3>
                                                <p class="text-xs text-gray-500">Loại: <%= assignment.getType() %></p>
                                            </div>
                                        </div>
                                        <span class="px-2.5 py-1 bg-green-100 text-green-700 text-xs rounded-full">
                                            Đã chấm điểm
                                        </span>
                                    </div>
                                    <p class="text-sm text-gray-600 mb-4 line-clamp-3">
                                        <%= assignment.getDescription() != null ? assignment.getDescription() : "Không có mô tả" %>
                                    </p>
                                    <% if (submission != null) { %>
                                    <div class="bg-gray-50 rounded-md p-3 mb-4">
                                        <div class="flex items-center text-sm text-gray-600 mb-2">
                                            <i class="ri-time-line mr-2"></i>
                                            Nộp lúc: <%= sdf.format(submission.getSubmittedAt()) %>
                                        </div>
                                        <div class="flex items-center text-sm text-gray-600">
                                            <i class="ri-star-line mr-2"></i>
                                            Điểm: <span class="font-semibold text-green-600"><%= submission.getScore() %></span>
                                        </div>
                                    </div>
                                    <% } %>
                                    <div class="flex space-x-2">
                                        <a href="<%= request.getContextPath() %>/student/assignment/view?assignmentId=<%= assignment.getAssignmentId() %>" 
                                           class="flex-1 bg-green-600 hover:bg-green-700 text-white text-sm font-medium py-2 px-3 rounded-md text-center transition duration-200">
                                            <i class="ri-eye-line mr-1"></i>Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <% } %>
                            
                            <% if (completedAssignments.isEmpty()) { %>
                            <div class="col-span-full text-center py-12">
                                <div class="w-20 h-20 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                    <i class="ri-check-double-line text-2xl text-gray-400"></i>
                                </div>
                                <h3 class="text-lg font-medium text-gray-800 mb-2">Chưa có bài tập nào được hoàn thành</h3>
                                <p class="text-gray-500">Hãy hoàn thành và nộp bài tập để có điểm số.</p>
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Mobile navigation -->
    <div class="md:hidden fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 z-10">
        <div class="grid grid-cols-4 py-2">
            <a href="dashboard.jsp" class="flex flex-col items-center py-2 text-gray-600">
                <i class="ri-dashboard-line text-xl"></i>
                <span class="text-xs mt-1">Dashboard</span>
            </a>
            <a href="courses" class="flex flex-col items-center py-2 text-gray-600">
                <i class="ri-book-open-line text-xl"></i>
                <span class="text-xs mt-1">Khóa học</span>
            </a>
            <a href="assignments" class="flex flex-col items-center py-2 text-blue-600">
                <i class="ri-file-list-line text-xl"></i>
                <span class="text-xs mt-1">Bài tập</span>
            </a>
            <a href="documents" class="flex flex-col items-center py-2 text-gray-600">
                <i class="ri-folder-line text-xl"></i>
                <span class="text-xs mt-1">Tài liệu</span>
            </a>
        </div>
    </div>

    <script>
        function showTab(tabName) {
            // Hide all tab contents
            document.querySelectorAll('.tab-content').forEach(content => {
                content.classList.add('hidden');
            });
            
            // Remove active class from all buttons
            document.querySelectorAll('.tab-button').forEach(button => {
                button.classList.remove('active');
            });
            
            // Show selected tab content
            document.getElementById('content-' + tabName).classList.remove('hidden');
            document.getElementById('tab-' + tabName).classList.add('active');
        }
        
        // Initialize first tab
        document.addEventListener('DOMContentLoaded', function() {
            showTab('upcoming');
        });
    </script>
</body>
</html>