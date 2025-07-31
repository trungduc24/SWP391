<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.*" %>
<%
    CourseDisplayModel course = (CourseDisplayModel) request.getAttribute("course");
    List<Material> materials = (List<Material>) request.getAttribute("materials");
    List<Assignment> assignments = (List<Assignment>) request.getAttribute("assignments");
    Map<Integer, Submission> submissions = (Map<Integer, Submission>) request.getAttribute("submissions");
    List<Test> upcomingTests = (List<Test>) request.getAttribute("upcomingTests");
    List<Test> currentTests = (List<Test>) request.getAttribute("currentTests");
    List<Test> pastTests = (List<Test>) request.getAttribute("pastTests");
    Map<Integer, TestSubmission> testSubmissions = (Map<Integer, TestSubmission>) request.getAttribute("testSubmissions");
    Student student = (Student) request.getAttribute("student");
    User currentUser = (User) request.getAttribute("currentUser");
    
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    
    if (course == null) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy khóa học!");
        return;
    }
    
    if (materials == null) materials = new ArrayList<>();
    if (assignments == null) assignments = new ArrayList<>();
    if (submissions == null) submissions = new HashMap<>();
    if (upcomingTests == null) upcomingTests = new ArrayList<>();
    if (currentTests == null) currentTests = new ArrayList<>();
    if (pastTests == null) pastTests = new ArrayList<>();
    if (testSubmissions == null) testSubmissions = new HashMap<>();
    
    int totalTests = upcomingTests.size() + currentTests.size() + pastTests.size();
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết khóa học - <%= course.getName() %></title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
</head>
<body class="bg-gray-50">
    <div class="min-h-screen py-6">
        <div class="max-w-7xl mx-auto px-4">
            <%@ include file="sidebar.jsp" %>
            <!-- Header -->
            <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-6 mb-6">
                <div class="flex items-center justify-between">
                    <div class="flex items-center">
                        <div class="w-12 h-12 bg-gradient-to-r from-blue-500 to-purple-600 rounded-lg flex items-center justify-center text-white font-bold text-lg mr-4">
                            <%= course.getCode().substring(0, 2).toUpperCase() %>
                        </div>
                        <div>
                            <h1 class="text-2xl font-bold text-gray-800"><%= course.getName() %></h1>
                            <p class="text-gray-600">Mã khóa học: <%= course.getCode() %></p>
                        </div>
                    </div>
                    
                    <div class="text-right">
                        <div class="text-sm text-gray-500">Giảng viên</div>
                        <div class="text-lg font-semibold text-gray-800"><%= course.getLecturerName() %></div>
                        <div class="text-sm text-gray-500">Phòng: <%= course.getRoom() %></div>
                    </div>
                </div>
                
                <div class="mt-4 p-4 bg-gray-50 rounded-lg">
                    <p class="text-gray-700"><%= course.getDescription() != null ? course.getDescription() : "Không có mô tả" %></p>
                </div>
                
                <div class="mt-4 flex items-center space-x-6 text-sm text-gray-600">
                    <div class="flex items-center">
                        <i class="ri-calendar-line mr-2"></i>
                        <span>Lịch học: <%= course.getSchedule() %></span>
                    </div>
                    <div class="flex items-center">
                        <i class="ri-time-line mr-2"></i>
                        <span>Tiết học: <%= course.getCurrentSession() %>/<%= course.getTotalSessions() %></span>
                    </div>
                    <div class="flex items-center">
                        <i class="ri-star-line mr-2"></i>
                        <span>Tín chỉ: <%= course.getCredits() %></span>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="bg-white rounded-lg shadow-sm border border-gray-100">
                <!-- Tab Navigation -->
                <div class="border-b border-gray-200">
                    <div class="flex space-x-8">
                        <div class="tab-nav-item flex items-center px-4 py-3 cursor-pointer border-b-2 border-blue-500 text-blue-600 font-medium active" data-tab="materials">
                            <i class="ri-folder-line mr-2"></i>
                            <span>Tài liệu</span>
                            <span class="ml-2 bg-blue-100 text-blue-600 px-2 py-1 text-xs rounded-full"><%= materials.size() %></span>
                        </div>
                        <div class="tab-nav-item flex items-center px-4 py-3 cursor-pointer border-b-2 border-transparent text-gray-600 hover:text-gray-800 hover:border-gray-300" data-tab="assignments">
                            <i class="ri-file-text-line mr-2"></i>
                            <span>Bài tập</span>
                            <span class="ml-2 bg-gray-100 text-gray-600 px-2 py-1 text-xs rounded-full"><%= assignments.size() %></span>
                        </div>
                        <div class="tab-nav-item flex items-center px-4 py-3 cursor-pointer border-b-2 border-transparent text-gray-600 hover:text-gray-800 hover:border-gray-300" data-tab="tests">
                            <i class="ri-file-list-line mr-2"></i>
                            <span>Kiểm tra</span>
                            <span class="ml-2 bg-gray-100 text-gray-600 px-2 py-1 text-xs rounded-full"><%= totalTests %></span>
                        </div>
                    </div>
                </div>

                <!-- Tab Content: Materials -->
                <div class="tab-content active" id="materials">
                    <div class="p-6">
                        <div class="flex items-center justify-between mb-6">
                            <h2 class="text-xl font-bold text-gray-800">Tài liệu khóa học</h2>
                            <span class="text-sm text-gray-500"><%= materials.size() %> tài liệu</span>
                        </div>

                        <% if (!materials.isEmpty()) { %>
                        <div class="space-y-3">
                            <% for (Material material : materials) { %>
                            <div class="flex items-center p-4 bg-gray-50 rounded-lg hover:bg-gray-100 transition-colors">
                                <div class="w-12 h-12 bg-blue-100 text-blue-600 rounded-lg flex items-center justify-center mr-4">
                                    <i class="ri-file-text-line text-lg"></i>
                                </div>
                                <div class="flex-1">
                                    <h3 class="font-medium text-gray-800"><%= material.getTitle() %></h3>
                                    <p class="text-sm text-gray-600"><%= material.getDescription() != null ? material.getDescription() : "" %></p>
                                    <div class="flex items-center mt-1 text-xs text-gray-500">
                                        <span>Tải lên: <%= sdf.format(material.getUploadDate()) %></span>
                                    </div>
                                </div>
                                <div class="flex items-center space-x-2">
                                    <a href="<%= material.getFilePath() %>" target="_blank" 
                                       class="bg-blue-600 hover:bg-blue-700 text-white px-3 py-1 rounded text-sm transition-colors">
                                        <i class="ri-download-line mr-1"></i>Xem
                                    </a>
                                </div>
                            </div>
                            <% } %>
                        </div>
                        <% } else { %>
                        <div class="text-center py-12">
                            <div class="w-20 h-20 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                <i class="ri-folder-line text-2xl text-gray-400"></i>
                            </div>
                            <h3 class="text-lg font-medium text-gray-800 mb-2">Chưa có tài liệu nào</h3>
                            <p class="text-gray-500">Giảng viên chưa upload tài liệu cho khóa học này.</p>
                        </div>
                        <% } %>
                    </div>
                </div>

                <!-- Tab Content: Assignments -->
                <div class="tab-content" id="assignments">
                    <div class="p-6">
                        <div class="flex items-center justify-between mb-6">
                            <h2 class="text-xl font-bold text-gray-800">Bài tập</h2>
                            <span class="text-sm text-gray-500"><%= assignments.size() %> bài tập</span>
                        </div>

                        <% if (!assignments.isEmpty()) { %>
                        <div class="space-y-4">
                            <% for (Assignment assignment : assignments) { 
                                Submission submission = submissions.get(assignment.getAssignmentId());
                                boolean isOverdue = assignment.getDueDate() != null && 
                                                  assignment.getDueDate().before(new java.util.Date());
                            %>
                            <div class="bg-gray-50 rounded-lg p-4 hover:shadow-sm transition-shadow">
                                <div class="flex items-start justify-between">
                                    <div class="flex items-center flex-1">
                                        <div class="w-10 h-10 bg-blue-100 text-blue-600 rounded-lg flex items-center justify-center mr-3">
                                            <i class="ri-file-text-line"></i>
                                        </div>
                                        <div class="flex-1">
                                            <h3 class="font-medium text-gray-800"><%= assignment.getTitle() %></h3>
                                            <p class="text-sm text-gray-600 mt-1"><%= assignment.getDescription() != null ? assignment.getDescription() : "Không có mô tả" %></p>
                                            <div class="flex items-center mt-2 text-xs text-gray-500">
                                                <i class="ri-calendar-line mr-1"></i>
                                                <span>Hạn nộp: 
                                                    <span class="<%= isOverdue ? "text-red-600 font-semibold" : "" %>">
                                                        <%= assignment.getDueDate() != null ? sdf.format(assignment.getDueDate()) : "Không giới hạn" %>
                                                    </span>
                                                </span>
                                                <span class="ml-4">Loại: <%= assignment.getType() %></span>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="flex items-center space-x-3">
                                        <% if (submission != null) { %>
                                            <% if (submission.getScore() != null) { %>
                                                <span class="px-2.5 py-1 bg-green-100 text-green-700 text-xs rounded-full">
                                                    Đã chấm: <%= submission.getScore() %> điểm
                                                </span>
                                            <% } else { %>
                                                <span class="px-2.5 py-1 bg-blue-100 text-blue-700 text-xs rounded-full">
                                                    Đã nộp
                                                </span>
                                            <% } %>
                                        <% } else { %>
                                            <% if (isOverdue) { %>
                                                <span class="px-2.5 py-1 bg-red-100 text-red-700 text-xs rounded-full">
                                                    Quá hạn
                                                </span>
                                            <% } else { %>
                                                <span class="px-2.5 py-1 bg-yellow-100 text-yellow-700 text-xs rounded-full">
                                                    Chưa nộp
                                                </span>
                                            <% } %>
                                        <% } %>
                                        
                                        <a href="<%= request.getContextPath() %>/student/assignment-submit?assignmentId=<%= assignment.getAssignmentId() %>" 
                                           class="bg-blue-600 hover:bg-blue-700 text-white px-3 py-1 rounded text-sm transition-colors">
                                            <i class="ri-edit-line mr-1"></i>
                                            <%= submission != null ? "Sửa bài" : "Nộp bài" %>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <% } %>
                        </div>
                        <% } else { %>
                        <div class="text-center py-12">
                            <div class="w-20 h-20 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                <i class="ri-file-text-line text-2xl text-gray-400"></i>
                            </div>
                            <h3 class="text-lg font-medium text-gray-800 mb-2">Chưa có bài tập nào</h3>
                            <p class="text-gray-500">Giảng viên chưa giao bài tập cho khóa học này.</p>
                        </div>
                        <% } %>
                    </div>
                </div>

                <!-- Tab Content: Tests -->
                <div class="tab-content" id="tests">
                    <div class="p-6">
                        <div class="flex items-center justify-between mb-6">
                            <h2 class="text-xl font-bold text-gray-800">Bài kiểm tra</h2>
                            <span class="text-sm text-gray-500"><%= totalTests %> bài kiểm tra</span>
                        </div>

                        <% if (totalTests == 0) { %>
                            <div class="text-center py-12">
                                <div class="w-20 h-20 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                    <i class="ri-file-list-line text-2xl text-gray-400"></i>
                                </div>
                                <h3 class="text-lg font-medium text-gray-800 mb-2">Chưa có bài kiểm tra nào</h3>
                                <p class="text-gray-500">Giảng viên chưa tạo bài kiểm tra cho khóa học này.</p>
                            </div>
                        <% } else { %>
                            <!-- Current Tests (Ưu tiên cao nhất) -->
                            <% if (!currentTests.isEmpty()) { %>
                                <div class="mb-8">
                                    <h3 class="text-lg font-semibold text-gray-900 mb-4 flex items-center">
                                        <i class="ri-play-circle-line mr-2 text-green-600"></i>
                                        Bài kiểm tra hiện tại (<%= currentTests.size() %>) - Có thể làm ngay
                                    </h3>
                                    <div class="space-y-4">
                                        <% for (Test test : currentTests) { 
                                            TestSubmission testSubmission = testSubmissions.get(test.getTestId());
                                        %>
                                            <div class="bg-green-50 border border-green-200 rounded-lg p-4">
                                                <div class="flex items-start justify-between">
                                                    <div class="flex items-center flex-1">
                                                        <div class="w-10 h-10 bg-green-100 text-green-600 rounded-lg flex items-center justify-center mr-3">
                                                            <i class="ri-play-circle-line"></i>
                                                        </div>
                                                        <div class="flex-1">
                                                            <h4 class="font-medium text-gray-800"><%= test.getTitle() %></h4>
                                                            <p class="text-sm text-gray-600 mt-1"><%= test.getDescription() != null ? test.getDescription() : "Không có mô tả" %></p>
                                                            <div class="flex items-center mt-2 text-xs text-gray-500">
                                                                <i class="ri-time-line mr-1"></i>
                                                                <span>Thời gian: <%= test.getDuration() %> phút</span>
                                                                <span class="ml-4">Kết thúc: <%= sdf.format(test.getEndTime()) %></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="flex items-center space-x-3">
                                                        <% if (testSubmission != null) { %>
                                                            <% if (testSubmission.getScore() != null) { %>
                                                                <span class="px-2.5 py-1 bg-green-100 text-green-700 text-xs rounded-full">
                                                                    Đã chấm: <%= testSubmission.getScore() %> điểm
                                                                </span>
                                                            <% } else { %>
                                                                <span class="px-2.5 py-1 bg-blue-100 text-blue-700 text-xs rounded-full">
                                                                    Đã làm
                                                                </span>
                                                            <% } %>
                                                        <% } else { %>
                                                            <span class="px-2.5 py-1 bg-green-100 text-green-700 text-xs rounded-full">
                                                                Có thể làm
                                                            </span>
                                                            <a href="<%= request.getContextPath() %>/student/exam-take?id=<%= test.getTestId() %>" 
                                                               class="bg-green-600 hover:bg-green-700 text-white px-3 py-1 rounded text-sm transition-colors">
                                                                <i class="ri-play-line mr-1"></i>Làm bài
                                                            </a>
                                                        <% } %>
                                                    </div>
                                                </div>
                                            </div>
                                        <% } %>
                                    </div>
                                </div>
                            <% } %>
                            
                            <!-- Upcoming Tests -->
                            <% if (!upcomingTests.isEmpty()) { %>
                                <div class="mb-8">
                                    <h3 class="text-lg font-semibold text-gray-900 mb-4 flex items-center">
                                        <i class="ri-time-line mr-2 text-blue-600"></i>
                                        Bài kiểm tra sắp tới (<%= upcomingTests.size() %>)
                                    </h3>
                                    <div class="space-y-4">
                                        <% for (Test test : upcomingTests) { %>
                                            <div class="bg-blue-50 border border-blue-200 rounded-lg p-4">
                                                <div class="flex items-start justify-between">
                                                    <div class="flex items-center flex-1">
                                                        <div class="w-10 h-10 bg-blue-100 text-blue-600 rounded-lg flex items-center justify-center mr-3">
                                                            <i class="ri-clock-line"></i>
                                                        </div>
                                                        <div class="flex-1">
                                                            <h4 class="font-medium text-gray-800"><%= test.getTitle() %></h4>
                                                            <p class="text-sm text-gray-600 mt-1"><%= test.getDescription() != null ? test.getDescription() : "Không có mô tả" %></p>
                                                            <div class="flex items-center mt-2 text-xs text-gray-500">
                                                                <i class="ri-calendar-line mr-1"></i>
                                                                <span>Bắt đầu: <%= sdf.format(test.getStartTime()) %></span>
                                                                <span class="ml-4">Thời gian: <%= test.getDuration() %> phút</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="flex items-center space-x-3">
                                                        <span class="px-2.5 py-1 bg-blue-100 text-blue-700 text-xs rounded-full">
                                                            <i class="ri-clock-line mr-1"></i>Sắp tới
                                                        </span>
                                                        <button class="text-blue-600 hover:text-blue-800 text-sm font-medium cursor-not-allowed opacity-50">
                                                            <i class="ri-lock-line mr-1"></i>Chờ mở
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        <% } %>
                                    </div>
                                </div>
                            <% } %>
                            
                            <!-- Past Tests -->
                            <% if (!pastTests.isEmpty()) { %>
                                <div class="mb-8">
                                    <h3 class="text-lg font-semibold text-gray-900 mb-4 flex items-center">
                                        <i class="ri-history-line mr-2 text-gray-600"></i>
                                        Bài kiểm tra đã qua (<%= pastTests.size() %>)
                                    </h3>
                                    <div class="space-y-4">
                                        <% for (Test test : pastTests) { 
                                            TestSubmission testSubmission = testSubmissions.get(test.getTestId());
                                        %>
                                            <div class="bg-gray-50 border border-gray-200 rounded-lg p-4">
                                                <div class="flex items-start justify-between">
                                                    <div class="flex items-center flex-1">
                                                        <div class="w-10 h-10 bg-gray-100 text-gray-600 rounded-lg flex items-center justify-center mr-3">
                                                            <i class="ri-history-line"></i>
                                                        </div>
                                                        <div class="flex-1">
                                                            <h4 class="font-medium text-gray-800"><%= test.getTitle() %></h4>
                                                            <p class="text-sm text-gray-600 mt-1"><%= test.getDescription() != null ? test.getDescription() : "Không có mô tả" %></p>
                                                            <div class="flex items-center mt-2 text-xs text-gray-500">
                                                                <i class="ri-calendar-line mr-1"></i>
                                                                <span>Đã kết thúc: <%= sdf.format(test.getEndTime()) %></span>
                                                                <span class="ml-4">Thời gian: <%= test.getDuration() %> phút</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="flex items-center space-x-3">
                                                        <% if (testSubmission != null) { %>
                                                            <% if (testSubmission.getScore() != null) { %>
                                                                <span class="px-2.5 py-1 bg-green-100 text-green-700 text-xs rounded-full">
                                                                    Điểm: <%= testSubmission.getScore() %>
                                                                </span>
                                                            <% } else { %>
                                                                <span class="px-2.5 py-1 bg-blue-100 text-blue-700 text-xs rounded-full">
                                                                    Chờ chấm
                                                                </span>
                                                            <% } %>
                                                        <% } else { %>
                                                            <span class="px-2.5 py-1 bg-red-100 text-red-700 text-xs rounded-full">
                                                                Không làm
                                                            </span>
                                                        <% } %>
                                                    </div>
                                                </div>
                                            </div>
                                        <% } %>
                                    </div>
                                </div>
                            <% } %>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Tab switching functionality
        document.querySelectorAll('.tab-nav-item').forEach(tab => {
            tab.addEventListener('click', function() {
                const targetTab = this.dataset.tab;
                
                // Remove active class from all tabs
                document.querySelectorAll('.tab-nav-item').forEach(t => {
                    t.classList.remove('active', 'border-blue-500', 'text-blue-600');
                    t.classList.add('border-transparent', 'text-gray-600');
                });
                
                // Add active class to clicked tab
                this.classList.add('active', 'border-blue-500', 'text-blue-600');
                this.classList.remove('border-transparent', 'text-gray-600');
                
                // Hide all tab contents
                document.querySelectorAll('.tab-content').forEach(content => {
                    content.classList.remove('active');
                });
                
                // Show target tab content
                document.getElementById(targetTab).classList.add('active');
            });
        });
    </script>

    <style>
        .tab-content {
            display: none;
        }
        .tab-content.active {
            display: block;
        }
    </style>
</body>
</html>