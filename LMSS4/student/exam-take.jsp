<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.*" %>
<%
    Test test = (Test) request.getAttribute("test");
    TestSubmission submission = (TestSubmission) request.getAttribute("submission");
    List<TestQuestion> questions = (List<TestQuestion>) request.getAttribute("questions");
    List<TestAnswer> answers = (List<TestAnswer>) request.getAttribute("answers");
    
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    
    // Create map of existing answers for easy lookup
    Map<Integer, TestAnswer> answerMap = new HashMap<>();
    if (answers != null) {
        for (TestAnswer answer : answers) {
            answerMap.put(answer.getQuestionId(), answer);
        }
    }
    
    if (test == null || submission == null || questions == null) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Bài kiểm tra không tồn tại!");
        return;
    }
    
    // Tính thời gian còn lại
    long timeElapsed = submission.getTimeElapsedMinutes();
    long timeRemaining = test.getDuration_minutes() - timeElapsed;
    if (timeRemaining < 0) timeRemaining = 0;
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Làm bài kiểm tra - <%= test.getTitle() %></title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
</head>
<body class="bg-gray-50">
    <div class="min-h-screen py-6">
        <div class="max-w-5xl mx-auto px-4">
            
            <!-- Header -->
            <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-6 mb-6 sticky top-6 z-10">
                <div class="flex items-center justify-between">
                    <div>
                        <h1 class="text-xl font-bold text-gray-800"><%= test.getTitle() %></h1>
                        <p class="text-gray-600 text-sm"><%= test.getDescription() %></p>
                    </div>
                    <div class="text-right">
                        <div class="text-sm text-gray-500">Thời gian còn lại</div>
                        <div id="timer" class="text-2xl font-bold text-blue-600">
                            <%= String.format("%02d:%02d", timeRemaining / 60, timeRemaining % 60) %>
                        </div>
                        <div class="text-xs text-gray-500 mt-1">
                            Tự động nộp khi hết giờ
                        </div>
                    </div>
                </div>
                
                <!-- Progress -->
                <div class="mt-4">
                    <div class="flex items-center justify-between mb-2">
                        <span class="text-sm text-gray-600">Tiến độ</span>
                        <span class="text-sm text-gray-600">
                            <span id="answered-count">0</span>/<%= questions.size() %> câu đã trả lời
                        </span>
                    </div>
                    <div class="w-full bg-gray-200 rounded-full h-2">
                        <div id="progress-bar" class="bg-blue-600 h-2 rounded-full transition-all duration-300" style="width: 0%"></div>
                    </div>
                </div>
            </div>

            <!-- Questions -->
            <form id="examForm">
                <input type="hidden" name="submissionId" value="<%= submission.getTestSubmissionId() %>">
                
                <div class="space-y-6">
                    <% 
                    int questionIndex = 0;
                    for (TestQuestion question : questions) { 
                        questionIndex++;
                        TestAnswer existingAnswer = answerMap.get(question.getQuestionId());
                    %>
                    <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-6" id="question-<%= question.getQuestionId() %>">
                        <div class="flex items-start justify-between mb-4">
                            <div class="flex items-center">
                                <div class="w-8 h-8 bg-blue-100 text-blue-600 rounded-full flex items-center justify-center mr-3 font-semibold">
                                    <%= questionIndex %>
                                </div>
                                <div>
                                    <h3 class="font-medium text-gray-800">Câu <%= questionIndex %></h3>
                                    <span class="text-sm text-gray-500"><%= question.getPoints() %> điểm</span>
                                </div>
                            </div>
                            <div class="question-status w-6 h-6 rounded-full border-2 border-gray-300" id="status-<%= question.getQuestionId() %>">
                                <% if (existingAnswer != null) { %>
                                <div class="w-full h-full bg-green-500 rounded-full"></div>
                                <% } %>
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <p class="text-gray-700 leading-relaxed"><%= question.getQuestionText() %></p>
                        </div>
                        
                        <% if (question.isMultipleChoice() || question.isTrueFalse()) { %>
                        <div class="space-y-3">
                            <% 
                            char optionLabel = 'A';
                            for (TestQuestionOption option : question.getOptions()) { 
                            %>
                            <label class="flex items-center p-3 bg-gray-50 rounded-lg hover:bg-gray-100 cursor-pointer transition-colors border border-transparent hover:border-blue-200">
                                <input type="radio" 
                                       name="question_<%= question.getQuestionId() %>" 
                                       value="<%= option.getOptionId() %>"
                                       class="mr-3 question-option w-4 h-4 text-blue-600"
                                       data-question-id="<%= question.getQuestionId() %>"
                                       data-submission-id="<%= submission.getTestSubmissionId() %>"
                                       <%= (existingAnswer != null && existingAnswer.getSelectedOptionId() != null && existingAnswer.getSelectedOptionId() == option.getOptionId()) ? "checked" : "" %>
                                       onchange="saveAnswer(this)">
                                <div class="flex items-center">
                                    <span class="w-6 h-6 bg-white border border-gray-300 rounded-full flex items-center justify-center text-xs font-medium mr-3">
                                        <%= optionLabel %>
                                    </span>
                                    <span class="text-gray-700"><%= option.getOptionText() %></span>
                                </div>
                            </label>
                            <% 
                                optionLabel++;
                            } 
                            %>
                        </div>
                        <% } else { %>
                        <div>
                            <textarea name="question_<%= question.getQuestionId() %>" 
                                      class="w-full p-4 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 resize-none"
                                      rows="6" 
                                      placeholder="Nhập câu trả lời của bạn..."
                                      data-question-id="<%= question.getQuestionId() %>"
                                      data-submission-id="<%= submission.getTestSubmissionId() %>"
                                      onchange="saveTextAnswer(this)"
                                      oninput="markAsAnswered(<%= question.getQuestionId() %>)"><%= existingAnswer != null && existingAnswer.getAnswerText() != null ? existingAnswer.getAnswerText() : "" %></textarea>
                        </div>
                        <% } %>
                    </div>
                    <% } %>
                </div>
                
                <!-- Submit Button -->
                <div class="mt-8 text-center sticky bottom-6">
                    <div class="bg-white rounded-lg shadow-lg border border-gray-100 p-4 inline-block">
                        <button type="button" 
                                onclick="confirmSubmit()"
                                class="bg-green-600 hover:bg-green-700 text-white font-medium py-3 px-8 rounded-lg transition duration-200 mr-4">
                            <i class="ri-send-plane-line mr-2"></i>Nộp bài
                        </button>
                        <button type="button" 
                                onclick="saveAll()"
                                class="bg-blue-600 hover:bg-blue-700 text-white font-medium py-3 px-6 rounded-lg transition duration-200">
                            <i class="ri-save-line mr-2"></i>Lưu tạm
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Confirmation Modal -->
    <div id="submitModal" class="fixed inset-0 bg-black bg-opacity-50 z-50 hidden">
        <div class="flex items-center justify-center min-h-screen p-4">
            <div class="bg-white rounded-lg p-6 max-w-md w-full">
                <h3 class="text-lg font-bold text-gray-800 mb-4">Xác nhận nộp bài</h3>
                <p class="text-gray-600 mb-6">Bạn có chắc chắn muốn nộp bài? Sau khi nộp, bạn sẽ không thể thay đổi câu trả lời.</p>
                <div class="flex space-x-4">
                    <button onclick="hideSubmitModal()" 
                            class="flex-1 bg-gray-500 hover:bg-gray-600 text-white py-2 px-4 rounded">
                        Hủy
                    </button>
                    <button onclick="submitExam()" 
                            class="flex-1 bg-green-600 hover:bg-green-700 text-white py-2 px-4 rounded">
                        Nộp bài
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Timer functionality
        var timeLeft = <%= timeRemaining * 60 %>; // Convert to seconds
        var timerElement = document.getElementById('timer');
        
        function updateTimer() {
            var minutes = Math.floor(timeLeft / 60);
            var seconds = timeLeft % 60;
            timerElement.textContent = minutes.toString().padStart(2, '0') + ':' + seconds.toString().padStart(2, '0');
            
            if (timeLeft <= 300) { // 5 minutes
                timerElement.classList.remove('text-blue-600');
                timerElement.classList.add('text-red-600');
            }
            
            if (timeLeft <= 60) { // 1 minute
                timerElement.classList.add('animate-pulse');
            }
            
            if (timeLeft <= 0) {
                alert('Hết thời gian làm bài! Hệ thống sẽ tự động nộp bài.');
                submitExam();
                return;
            }
            
            timeLeft--;
        }
        
        // Update timer every second
        var timerInterval = setInterval(updateTimer, 1000);
        
        // Progress tracking
        function updateProgress() {
            var totalQuestions = <%= questions.size() %>;
            var answeredQuestions = 0;
            
            // Count answered multiple choice questions
            var checkedRadios = document.querySelectorAll('input[type="radio"]:checked');
            answeredQuestions += checkedRadios.length;
            
            // Count answered text questions
            var textareas = document.querySelectorAll('textarea');
            textareas.forEach(function(textarea) {
                if (textarea.value.trim() !== '') {
                    answeredQuestions++;
                }
            });
            
            document.getElementById('answered-count').textContent = answeredQuestions;
            var percentage = (answeredQuestions / totalQuestions) * 100;
            document.getElementById('progress-bar').style.width = percentage + '%';
        }
        
        // Mark question as answered
        function markAsAnswered(questionId) {
            var statusElement = document.getElementById('status-' + questionId);
            statusElement.innerHTML = '<div class="w-full h-full bg-green-500 rounded-full"></div>';
            updateProgress();
        }
        
        // Save answer via AJAX
        function saveAnswer(element) {
            var questionId = element.dataset.questionId;
            var submissionId = element.dataset.submissionId;
            var selectedOptionId = element.value;
            
            fetch('<%= request.getContextPath() %>/student/exam/save-answer', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'submissionId=' + submissionId + '&questionId=' + questionId + '&selectedOptionId=' + selectedOptionId
            })
            .then(function(response) { return response.json(); })
            .then(function(data) {
                if (data.success) {
                    markAsAnswered(questionId);
                    showSaveIndicator('Đã lưu câu trả lời');
                } else {
                    console.error('Failed to save answer');
                    showSaveIndicator('Lỗi khi lưu câu trả lời', 'error');
                }
            })
            .catch(function(error) {
                console.error('Error:', error);
                showSaveIndicator('Lỗi kết nối', 'error');
            });
        }
        
        // Save text answer with debounce
        var saveTimeout;
        function saveTextAnswer(element) {
            var questionId = element.dataset.questionId;
            var submissionId = element.dataset.submissionId;
            var answerText = element.value;
            
            // Clear previous timeout
            clearTimeout(saveTimeout);
            
            // Set new timeout
            saveTimeout = setTimeout(function() {
                if (answerText.trim() === '') return;
                
                fetch('<%= request.getContextPath() %>/student/exam/save-answer', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'submissionId=' + submissionId + '&questionId=' + questionId + '&answerText=' + encodeURIComponent(answerText)
                })
                .then(function(response) { return response.json(); })
                .then(function(data) {
                    if (data.success) {
                        showSaveIndicator('Đã lưu câu trả lời');
                    } else {
                        console.error('Failed to save answer');
                        showSaveIndicator('Lỗi khi lưu câu trả lời', 'error');
                    }
                })
                .catch(function(error) {
                    console.error('Error:', error);
                    showSaveIndicator('Lỗi kết nối', 'error');
                });
            }, 2000); // Save after 2 seconds of no typing
        }
        
        // Show save indicator
        function showSaveIndicator(message, type) {
            if (typeof type === 'undefined') type = 'success';
            
            // Remove existing indicator
            var existing = document.getElementById('save-indicator');
            if (existing) existing.remove();
            
            var indicator = document.createElement('div');
            indicator.id = 'save-indicator';
            indicator.className = 'fixed top-4 right-4 px-4 py-2 rounded-lg text-white text-sm z-50 ' + 
                (type === 'error' ? 'bg-red-500' : 'bg-green-500');
            indicator.textContent = message;
            
            document.body.appendChild(indicator);
            
            setTimeout(function() {
                indicator.remove();
            }, 2000);
        }
        
        // Save all answers
        function saveAll() {
            showSaveIndicator('Đang lưu tất cả câu trả lời...');
            
            // Save all radio buttons
            var checkedRadios = document.querySelectorAll('input[type="radio"]:checked');
            checkedRadios.forEach(function(radio) {
                saveAnswer(radio);
            });
            
            // Save all textareas
            var textareas = document.querySelectorAll('textarea');
            textareas.forEach(function(textarea) {
                if (textarea.value.trim() !== '') {
                    saveTextAnswer(textarea);
                }
            });
        }
        
        // Show submit confirmation modal
        function confirmSubmit() {
            document.getElementById('submitModal').classList.remove('hidden');
        }
        
        // Hide submit confirmation modal
        function hideSubmitModal() {
            document.getElementById('submitModal').classList.add('hidden');
        }
        
        // Submit exam
        function submitExam() {
            clearInterval(timerInterval);
            
            var form = document.createElement('form');
            form.method = 'POST';
            form.action = '<%= request.getContextPath() %>/student/exam/submit';
            
            var submissionIdInput = document.createElement('input');
            submissionIdInput.type = 'hidden';
            submissionIdInput.name = 'submissionId';
            submissionIdInput.value = '<%= submission.getTestSubmissionId() %>';
            form.appendChild(submissionIdInput);
            
            document.body.appendChild(form);
            form.submit();
        }
        
        // Initialize progress
        updateProgress();
        
        // Auto-save every 30 seconds
        setInterval(saveAll, 30000);
        
        // Prevent page refresh/close without warning
        window.addEventListener('beforeunload', function(e) {
            e.preventDefault();
            e.returnValue = 'Bạn có chắc chắn muốn rời khỏi trang? Tiến độ làm bài có thể bị mất.';
        });
        
        // Mark already answered questions
        <% for (TestAnswer answer : answerMap.values()) { %>
        markAsAnswered(<%= answer.getQuestionId() %>);
        <% } %>
    </script>
</body>
</html>