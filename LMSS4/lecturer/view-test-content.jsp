<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container-fluid py-4">
    <div class="row mb-4">
        <div class="col-12">
            <div class="card shadow-sm border-0">
                <div class="card-body">
                    <h2 class="mb-2">${test.title}</h2>
                    <p class="mb-1 text-muted">Khóa học: <strong>${course.name}</strong> (${course.code})</p>
                    <p class="mb-1 text-muted">Loại: <strong>${test.testType}</strong> | Thời lượng: <strong>${test.duration_minutes} phút</strong></p>
                    <p class="mb-1 text-muted">Bắt đầu: <fmt:formatDate value="${test.start_time}" pattern="dd/MM/yyyy HH:mm" /> | Kết thúc: <fmt:formatDate value="${test.end_time}" pattern="dd/MM/yyyy HH:mm" /></p>
                    <p class="mb-1 text-muted">Điểm tối đa: <strong>${test.max_score}</strong></p>
                    <p class="mb-1">${test.description}</p>
                </div>
            </div>
        </div>
    </div>

    <div class="row mb-4">
        <div class="col-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Danh sách câu hỏi</h5>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addQuestionModal">
                        <i class="fas fa-plus me-2"></i>Thêm câu hỏi
                    </button>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty questions}">
                            <ol>
                                <c:forEach var="q" items="${questions}">
                                    <li class="mb-3">
                                        <div>
                                            <strong>Câu hỏi ${q.questionOrder}:</strong> ${q.questionText}
                                            <span class="badge bg-info ms-2">${q.questionType}</span>
                                            <span class="badge bg-secondary ms-2">${q.points} điểm</span>
                                        </div>
                                        <c:if test="${q.questionType eq 'multichoice' || q.questionType eq 'multiple_choice' || q.questionType eq 'multiple-choice'}">
                                            <ul class="mt-2">
                                                <c:forEach var="opt" items="${q.options}">
                                                    <li>
                                                        <c:choose>
                                                            <c:when test="${opt.correct}">
                                                                <span class="text-success fw-bold">${opt.optionText} <i class="fas fa-check"></i></span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${opt.optionText}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </c:if>
                                    </li>
                                </c:forEach>
                            </ol>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-info">Chưa có câu hỏi nào cho bài kiểm tra này.</div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>

---

### Modal "Thêm câu hỏi mới" (đã sửa)

Đây là phần quan trọng nhất đã được chỉnh sửa để khắc phục lỗi 400.

```html
<div class="modal fade" id="addQuestionModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Thêm câu hỏi mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addQuestionForm" method="post" action="${pageContext.request.contextPath}/lecturer/tests">
                    <input type="hidden" name="testId" value="${test.testId}">
                    
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
                                <input type="text" class="form-control" name="optionText[]" placeholder="Lựa chọn 1">
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
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="submit" class="btn btn-primary" form="addQuestionForm">Thêm câu hỏi</button>
            </div>
        </div>
    </div>
</div>

---

### JavaScript (đã cập nhật)

Hàm `addOption` cũng đã được cập nhật để đảm bảo các trường được tạo động có tên `name="optionText[]"` và `name="isCorrect[]"` với giá trị (`value`) là chỉ số tăng dần, giúp Servlet nhận diện đúng các lựa chọn và đáp án.

```javascript
<script>
function toggleOptions() {
    var type = document.getElementById('questionType').value;
    document.getElementById('optionsSection').style.display = (type === 'multichoice' || type === 'truefalse') ? '' : 'none';
    // Nếu bạn muốn hỗ trợ truefalse cũng có options, thì thêm 'truefalse' vào điều kiện trên
}

function addOption() {
    var optionList = document.getElementById('optionList');
    var idx = optionList.children.length + 1; // Chỉ số 1-based cho value của checkbox
    var div = document.createElement('div');
    div.className = 'input-group mb-2';
    div.innerHTML = `<input type="text" class="form-control" name="optionText[]" placeholder="Lựa chọn ${idx}">
        <div class="input-group-text">
            <input class="form-check-input mt-0" type="checkbox" name="isCorrect[]" value="${idx}" title="Đáp án đúng">
        </div>
        <button class="btn btn-outline-danger" type="button" onclick="removeOption(this)"><i class="fas fa-trash"></i></button>`;
    optionList.appendChild(div);
}

function removeOption(btn) {
    btn.parentElement.remove();
    // Sau khi xóa, cập nhật lại value của các checkbox isCorrect[] còn lại để đảm bảo đúng chỉ số
    updateOptionValues();
}

// Hàm mới để cập nhật value của isCorrect[] sau khi xóa
function updateOptionValues() {
    var optionList = document.getElementById('optionList');
    var optionDivs = optionList.children;
    for (var i = 0; i < optionDivs.length; i++) {
        var checkbox = optionDivs[i].querySelector('input[type="checkbox"]');
        if (checkbox) {
            checkbox.value = (i + 1); // Cập nhật lại value theo chỉ số mới
        }
    }
}
</script>