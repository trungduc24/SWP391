<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Question Form</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2>Test Question Form</h2>
        
        <!-- Thông báo -->
        <% if (request.getSession().getAttribute("error") != null) { %>
        <div class="alert alert-danger">
            <%= request.getSession().getAttribute("error") %>
            <% request.getSession().removeAttribute("error"); %>
        </div>
        <% } %>

        <% if (request.getSession().getAttribute("success") != null) { %>
        <div class="alert alert-success">
            <%= request.getSession().getAttribute("success") %>
            <% request.getSession().removeAttribute("success"); %>
        </div>
        <% } %>

        <form method="post" action="${pageContext.request.contextPath}/lecturer/tests" onsubmit="return validateForm()">
            <input type="hidden" name="testId" value="1">
            <input type="hidden" name="action" value="add-question">

            <div class="mb-3">
                <label for="questionText" class="form-label">Nội dung câu hỏi <span class="text-danger">*</span></label>
                <textarea class="form-control" id="questionText" name="questionText" rows="3" required></textarea>
            </div>
            
            <div class="mb-3">
                <label for="questionType" class="form-label">Loại câu hỏi <span class="text-danger">*</span></label>
                <select class="form-select" id="questionType" name="questionType" required onchange="toggleOptions()">
                    <option value="" selected disabled>-- Chọn loại --</option>
                    <option value="multichoice">Trắc nghiệm</option>
                    <option value="short_answer">Tự luận ngắn</option>
                    <option value="essay">Tự luận dài</option>
                </select>
            </div>
            
            <div id="optionsSection" style="display:none;">
                <label class="form-label">Các lựa chọn (chỉ cho câu hỏi trắc nghiệm)</label>
                <div id="optionList">
                    <div class="input-group mb-2">
                        <input type="text" class="form-control" name="optionText[]" placeholder="Lựa chọn 1" required>
                        <div class="input-group-text">
                            <input class="form-check-input mt-0" type="checkbox" name="isCorrect[]" value="1" title="Đáp án đúng">
                        </div>
                        <button class="btn btn-outline-danger" type="button" onclick="removeOption(this)"><i class="fas fa-trash"></i></button>
                    </div>
                </div>
                <button type="button" class="btn btn-outline-secondary btn-sm" onclick="addOption()"><i class="fas fa-plus"></i> Thêm lựa chọn</button>
            </div>
            
            <div class="mb-3 mt-3">
                <label for="points" class="form-label">Điểm cho câu hỏi <span class="text-danger">*</span></label>
                <input type="number" class="form-control" id="points" name="points" min="0.1" step="0.1" required>
            </div>
            
            <button type="submit" class="btn btn-primary">Thêm câu hỏi</button>
        </form>
    </div>

    <script>
    function validateForm() {
        var questionText = document.getElementById('questionText').value.trim();
        var questionType = document.getElementById('questionType').value;
        var points = document.getElementById('points').value;
        
        if (!questionText) {
            alert('Vui lòng nhập nội dung câu hỏi');
            return false;
        }
        
        if (!questionType) {
            alert('Vui lòng chọn loại câu hỏi');
            return false;
        }
        
        if (!points || points <= 0) {
            alert('Vui lòng nhập điểm hợp lệ');
            return false;
        }
        
        // Kiểm tra options cho câu hỏi trắc nghiệm
        if (questionType === 'multichoice') {
            var optionList = document.getElementById('optionList');
            var options = optionList.querySelectorAll('input[name="optionText[]"]');
            var checkedOptions = optionList.querySelectorAll('input[name="isCorrect[]"]:checked');
            
            if (options.length < 2) {
                alert('Câu hỏi trắc nghiệm cần ít nhất 2 lựa chọn');
                return false;
            }
            
            if (checkedOptions.length === 0) {
                alert('Vui lòng chọn ít nhất một đáp án đúng');
                return false;
            }
            
            // Kiểm tra xem tất cả options có nội dung không
            for (var i = 0; i < options.length; i++) {
                if (!options[i].value.trim()) {
                    alert('Vui lòng nhập nội dung cho tất cả lựa chọn');
                    return false;
                }
            }
        }
        
        return true;
    }

    function toggleOptions() {
        var type = document.getElementById('questionType').value;
        document.getElementById('optionsSection').style.display = (type === 'multichoice' || type === 'truefalse') ? '' : 'none';
    }

    function addOption() {
        var optionList = document.getElementById('optionList');
        var idx = optionList.children.length + 1;
        var div = document.createElement('div');
        div.className = 'input-group mb-2';
        div.innerHTML = `<input type="text" class="form-control" name="optionText[]" placeholder="Lựa chọn ${idx}" required>
            <div class="input-group-text">
                <input class="form-check-input mt-0" type="checkbox" name="isCorrect[]" value="${idx}" title="Đáp án đúng">
            </div>
            <button class="btn btn-outline-danger" type="button" onclick="removeOption(this)"><i class="fas fa-trash"></i></button>`;
        optionList.appendChild(div);
    }

    function removeOption(btn) {
        btn.parentElement.remove();
        updateOptionValues();
    }

    function updateOptionValues() {
        var optionList = document.getElementById('optionList');
        var optionDivs = optionList.children;
        for (var i = 0; i < optionDivs.length; i++) {
            var checkbox = optionDivs[i].querySelector('input[type="checkbox"]');
            if (checkbox) {
                checkbox.value = (i + 1);
            }
        }
    }
    </script>
</body>
</html> 