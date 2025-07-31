<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.*" %>
<%
    Test test = (Test) request.getAttribute("test");
    TestSubmission submission = (TestSubmission) request.getAttribute("submission");
    List<TestAnswer> answers = (List<TestAnswer>) request.getAttribute("answers");
    Student student = (Student) request.getAttribute("student");
    
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    
    if (test == null || submission == null) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Kết quả bài kiểm tra không tồn tại!");
        return;
    }
    
    if (answers == null) answers = new ArrayList<>();
    
    // Tính toán thống kê
    int totalQuestions = answers.size();
    int correctAnswers = 0;
    int wrongAnswers = 0;
    int unanswered = 0;
    double totalEarned = 0;
    
    for (TestAnswer answer : answers) {
        if (answer.getIsCorrect() == null) {
            unanswered++;
        } else if (answer.getIsCorrect()) {
            correctAnswers++;
        } else {
            wrongAnswers++;
        }
        totalEarned += answer.getPointsEarned();
    }
    
    double percentage = totalQuestions > 0 ? (double) correctAnswers / totalQuestions * 100 : 0;
    String gradeLevel = "";
    String gradeColor = "";
    
    if (percentage >= 80) {
        gradeLevel = "Xuất sắc";
        gradeColor = "text-green-600";
    } else if (percentage >= 65) {
        gradeLevel = "Giỏi"; 
        gradeColor = "text-blue-600";
    } else if (percentage >= 50) {
        gradeLevel = "Khá";
        gradeColor = "text-yellow-600";
    } else {
        gradeLevel = "Trung bình";
        gradeColor = "text-red-600";
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả bài kiểm tra - <%= test.getTitle() %></title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
</head>
<body class="bg-gray-50">
    <div class="min-h-screen py-6">
        <div class="max-w-5xl mx-auto px-4">
            
            <!-- Header -->
            <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-6 mb-6">
                <div class="flex items-center justify-between mb-4">
                    <div>
                        <h1 class="text-2xl font-bold text-gray-800">Kết quả bài kiểm tra</h1>
                        <p class="text-gray-600"><%= test.getTitle() %></p>
                        <p class="text-sm text-gray-500"><%= test.getDescription() %></p>
                    </div>
                    <div class="text-right">
                        <div class="text-3xl font-bold <%= gradeColor %>">
                            <%= String.format("%.1f", submission.getScore() != null ? submission.getScore() : totalEarned) %>/<%= String.format("%.0f", test.getMaxScore()) %>
                        </div>
                        <div class="text-lg font-medium <%= gradeColor %>"><%= gradeLevel %></div>
                        <div class="text-sm text-gray-500 mt-1">
                            <%= String.format("%.1f%%", percentage) %> đúng
                        </div>
                    </div>
                </div>
                
                <!-- Thống kê tổng quan -->
                <div class="grid grid-cols-2 md:grid-cols-4 gap-4 p-4 bg-gray-50 rounded-lg">
                    <div class="text-center">
                        <div class="text-2xl font-bold text-blue-600"><%= totalQuestions %></div>
                        <div class="text-sm text-gray-600">Tổng câu hỏi</div>
                    </div>
                    <div class="text-center">
                        <div class="text-2xl font-bold text-green-600"><%= correctAnswers %></div>
                        <div class="text-sm text-gray-600">Trả lời đúng</div>
                    </div>
                    <div class="text-center">
                        <div class="text-2xl font-bold text-red-600"><%= wrongAnswers %></div>
                        <div class="text-sm text-gray-600">Trả lời sai</div>
                    </div>
                    <div class="text-center">
                        <div class="text-2xl font-bold text-gray-600"><%= submission.getTimeSpentMinutes() != null ? submission.getTimeSpentMinutes() : 0 %>'</div>
                        <div class="text-sm text-gray-600">Thời gian làm</div>
                    </div>
                </div>
                
                <!-- Thông tin thời gian -->
                <div class="mt-4 flex flex-wrap items-center gap-4 text-sm text-gray-600">
                    <div class="flex items-center">
                        <i class="ri-calendar-line mr-2"></i>
                        <span>Bắt đầu: <%= sdf.format(submission.getStartedAt()) %></span>
                    </div>
                    <% if (submission.getSubmittedAt() != null) { %>
                    <div class="flex items-center">
                        <i class="ri-check-line mr-2"></i>
                        <span>Hoàn thành: <%= sdf.format(submission.getSubmittedAt()) %></span>
                    </div>
                    <% } %>
                    <div class="flex items-center">
                        <i class="ri-time-line mr-2"></i>
                        <span>Thời gian cho phép: <%= test.getDuration_minutes() %> phút</span>
                    </div>
                </div>
            </div>

            <!-- Chi tiết câu trả lời -->
            <div class="bg-white rounded-lg shadow-sm border border-gray-100">
                <div class="p-6 border-b border-gray-200">
                    <h2 class="text-xl font-bold text-gray-800">Chi tiết câu trả lời</h2>
                </div>
                
                <div class="divide-y divide-gray-200">
                    <%
                    int questionNumber = 0;
                    for (TestAnswer answer : answers) {
                        questionNumber++;
                        
                        String statusColor = "";
                        String statusIcon = "";
                        String statusText = "";
                        
                        if (answer.getIsCorrect() == null) {
                            statusColor = "bg-gray-100 text-gray-600";
                            statusIcon = "ri-question-line";
                            statusText = "Chưa chấm";
                        } else if (answer.getIsCorrect()) {
                            statusColor = "bg-green-100 text-green-600";
                            statusIcon = "ri-check-line";
                            statusText = "Đúng";
                        } else {
                            statusColor = "bg-red-100 text-red-600";
                            statusIcon = "ri-close-line";
                            statusText = "Sai";
                        }
                    %>
                    <div class="p-6">
                        <div class="flex items-start justify-between mb-4">
                            <div class="flex items-center">
                                <div class="w-8 h-8 bg-blue-100 text-blue-600 rounded-full flex items-center justify-center mr-3 font-semibold">
                                    <%= questionNumber %>
                                </div>
                                <div>
                                    <h3 class="font-medium text-gray-800">Câu <%= questionNumber %></h3>
                                    <span class="text-sm text-gray-500">
                                        <%= String.format("%.1f", answer.getPointsEarned()) %>/<%= String.format("%.1f", answer.getMaxPoints()) %> điểm
                                    </span>
                                </div>
                            </div>
                            
                            <div class="flex items-center px-3 py-1 rounded-full text-xs font-medium <%= statusColor %>">
                                <i class="<%= statusIcon %> mr-1"></i>
                                <%= statusText %>
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <p class="text-gray-700 font-medium mb-3"><%= answer.getQuestionText() %></p>
                            
                            <% if (answer.getSelectedOptionId() != null) { %>
                            <!-- Câu trả lời trắc nghiệm -->
                            <div class="space-y-2">
                                <div class="p-3 rounded-lg border-2 <%= answer.getIsCorrect() != null && answer.getIsCorrect() ? "border-green-200 bg-green-50" : "border-red-200 bg-red-50" %>">
                                    <div class="flex items-center">
                                        <i class="ri-arrow-right-line mr-2 text-gray-500"></i>
                                        <span class="font-medium text-gray-700">Bạn đã chọn:</span>
                                        <span class="ml-2"><%= answer.getSelectedOptionText() %></span>
                                        <% if (answer.getIsCorrect() != null) { %>
                                        <i class="ml-2 <%= answer.getIsCorrect() ? "ri-check-line text-green-600" : "ri-close-line text-red-600" %>"></i>
                                        <% } %>
                                    </div>
                                </div>
                                
                                <% if (answer.getIsCorrect() != null && !answer.getIsCorrect()) { %>
                                <div class="p-3 rounded-lg border-2 border-green-200 bg-green-50">
                                    <div class="flex items-center">
                                        <i class="ri-check-line mr-2 text-green-600"></i>
                                        <span class="font-medium text-gray-700">Đáp án đúng:</span>
                                        <span class="ml-2 text-green-700">Sẽ hiển thị sau khi giảng viên công bố</span>
                                    </div>
                                </div>
                                <% } %>
                            </div>
                            <% } else if (answer.getAnswerText() != null && !answer.getAnswerText().trim().isEmpty()) { %>
                            <!-- Câu trả lời tự luận -->
                            <div class="space-y-3">
                                <div>
                                    <span class="font-medium text-gray-700">Câu trả lời của bạn:</span>
                                    <div class="mt-2 p-4 bg-gray-50 rounded-lg border">
                                        <p class="text-gray-700 whitespace-pre-wrap"><%= answer.getAnswerText() %></p>
                                    </div>
                                </div>
                                
                                <% if (answer.getIsCorrect() == null) { %>
                                <div class="p-3 rounded-lg border-2 border-yellow-200 bg-yellow-50">
                                    <div class="flex items-center">
                                        <i class="ri-time-line mr-2 text-yellow-600"></i>
                                        <span class="text-yellow-700">Câu trả lời đang được chấm bởi giảng viên</span>
                                    </div>
                                </div>
                                <% } %>
                            </div>
                            <% } else { %>
                            <!-- Không trả lời -->
                            <div class="p-3 rounded-lg border-2 border-gray-200 bg-gray-50">
                                <div class="flex items-center">
                                    <i class="ri-subtract-line mr-2 text-gray-500"></i>
                                    <span class="text-gray-600">Không có câu trả lời</span>
                                </div>
                            </div>
                            <% } %>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
            
            <!-- Actions -->
            <div class="mt-8 text-center space-x-4">
                <a href="<%= request.getContextPath() %>/student/course-detail?id=<%= test.getCourseId() %>" 
                   class="inline-block bg-blue-600 hover:bg-blue-700 text-white font-medium py-3 px-6 rounded-lg transition duration-200">
                    <i class="ri-arrow-left-line mr-2"></i>Quay lại khóa học
                </a>
                
                <button onclick="window.print()" 
                        class="inline-block bg-gray-600 hover:bg-gray-700 text-white font-medium py-3 px-6 rounded-lg transition duration-200">
                    <i class="ri-printer-line mr-2"></i>In kết quả
                </button>
                
                <% if (percentage >= 50) { %>
                <div class="inline-block bg-green-600 text-white font-medium py-3 px-6 rounded-lg">
                    <i class="ri-trophy-line mr-2"></i>Đạt yêu cầu
                </div>
                <% } else { %>
                <div class="inline-block bg-red-600 text-white font-medium py-3 px-6 rounded-lg">
                    <i class="ri-close-circle-line mr-2"></i>Chưa đạt yêu cầu
                </div>
                <% } %>
            </div>
            
            <!-- Thông báo và lời khuyên -->
            <div class="mt-6 bg-blue-50 border border-blue-200 rounded-lg p-4">
                <div class="flex items-start">
                    <i class="ri-information-line text-blue-600 mr-3 mt-1"></i>
                    <div>
                        <h3 class="font-medium text-blue-800 mb-2">Lưu ý</h3>
                        <ul class="text-blue-700 text-sm space-y-1">
                            <li>• Kết quả này đã được lưu vào hệ thống</li>
                            <li>• Điểm số sẽ được tính vào tổng kết môn học</li>
                            <% if (unanswered > 0) { %>
                            <li>• Một số câu tự luận đang chờ giảng viên chấm điểm</li>
                            <% } %>
                            <li>• Bạn có thể xem lại kết quả này bất cứ lúc nào</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <style>
        @media print {
            .no-print {
                display: none !important;
            }
            body {
                background: white !important;
            }
        }
    </style>
</body>
</html> 