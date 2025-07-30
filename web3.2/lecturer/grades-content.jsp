<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- Nếu bạn cần các hàm xử lý chuỗi (ví dụ: fn:length), hãy uncomment dòng dưới đây --%>
<%-- <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> --%>

<%--
    FILE: grades-content.jsp
    Mô tả: Trang này chứa nội dung chính cho phần "Tổng quan điểm số" dành cho giảng viên.
    Nó được thiết kế để được bao gồm (include) bởi lecturer-template.jsp,
    vì vậy không chứa các thẻ HTML cơ bản (<html>, <head>, <body>) hay các liên kết CSS/JS chung.
--%>

<style>
    /*
        CSS tùy chỉnh dành riêng cho trang "Tổng quan điểm số".
        Các kiểu này bổ sung cho Bootstrap và style.css chung.
    */

    /* Nền cho phần nội dung chính (giả định body background được set trong template hoặc global style) */
    .main-content-area {
        /* Đảm bảo có padding đủ nếu main không có px-md-4 py-4 */
        padding: 1.5rem; /* Padding chung cho toàn bộ khu vực nội dung */
    }

    /* Thanh tiêu đề chính của nội dung (ví dụ: "Tổng quan điểm số") */
    .main-content-header {
        background-color: #ffffff;
        border-bottom: 1px solid #e9ecef;
        padding: 1.5rem 2rem;
        margin-bottom: 1.5rem;
        border-radius: 0.75rem;
        box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .main-content-header h2 {
        color: #007bff; /* Màu chính cho tiêu đề */
        margin-bottom: 0;
        font-weight: 600;
        display: flex; /* Để căn giữa icon và text */
        align-items: center;
    }

    .main-content-header h2 .fas {
        margin-right: 0.8rem; /* Khoảng cách giữa icon và chữ */
        font-size: 1.8rem; /* Kích thước icon lớn hơn một chút */
    }

    /* Kiểu dáng chung cho các thẻ (card) */
    .card {
        border-radius: 0.75rem;
        box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        border: none; /* Bỏ viền mặc định của card */
    }

    .card-header {
        background-color: #ffffff;
        border-bottom: 1px solid #e9ecef;
        padding: 1rem 1.5rem;
        font-weight: 600;
        color: #343a40;
        border-top-left-radius: 0.75rem; /* Đảm bảo bo góc trên */
        border-top-right-radius: 0.75rem;
    }

    /* Kiểu dáng cho bảng */
    .table thead th {
        background-color: #e9ecef;
        color: #495057;
        font-weight: 600;
        vertical-align: middle;
        padding: 0.75rem 1.25rem;
        border-bottom: 2px solid #dee2e6; /* Viền dưới đậm hơn cho header */
    }

    .table tbody tr:hover {
        background-color: #f8f9fa; /* Hiệu ứng hover nhẹ */
    }

    .table-responsive {
        /* Loại bỏ border nếu card đã có border, hoặc thêm border nếu card không có */
        border: none;
        border-radius: 0.75rem;
        overflow: hidden; /* Quan trọng để góc bo tròn hoạt động với bảng */
    }

    /* Kiểu dáng cho các thông báo (alerts) */
    .alert {
        border-radius: 0.5rem;
        padding: 1rem 1.25rem;
        font-size: 0.95rem;
        display: flex;
        align-items: center;
        margin-bottom: 1.5rem;
        box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.05); /* Bóng nhẹ cho alert */
    }

    .alert .fas {
        margin-right: 0.75rem;
        font-size: 1.1rem; /* Kích thước icon trong alert */
    }

    /* Kiểu dáng cho nút */
    .btn-outline-primary {
        color: #007bff;
        border-color: #007bff;
        transition: all 0.2s ease-in-out;
        padding: 0.4rem 0.8rem; /* Tối ưu padding cho nút nhỏ */
        font-size: 0.875rem; /* Kích thước chữ nhỏ hơn cho nút nhỏ */
    }

    .btn-outline-primary:hover {
        background-color: #007bff;
        color: #fff;
        box-shadow: 0 0.125rem 0.25rem rgba(0, 123, 255, 0.25);
        transform: translateY(-1px); /* Hiệu ứng nhấc nhẹ khi hover */
    }

    /* Kiểu dáng cho trạng thái không có dữ liệu */
    .empty-state {
        text-align: center;
        padding: 3rem 0;
        color: #6c757d;
        background-color: #fcfcfc; /* Nền nhẹ cho vùng này */
        border-radius: 0.75rem;
        margin-top: 1.5rem;
        margin-bottom: 1.5rem;
        border: 1px dashed #e9ecef; /* Viền nét đứt nhẹ nhàng */
    }

    .empty-state .fas {
        font-size: 4.5rem; /* Icon lớn hơn một chút */
        margin-bottom: 1.5rem;
        color: #ced4da;
    }

    .empty-state p {
        font-size: 1.15rem; /* Chữ to hơn một chút */
        margin-bottom: 0.75rem;
    }
</style>

<%-- Bắt đầu nội dung chính được hiển thị trong thẻ <main> của template --%>

<%-- Tiêu đề của trang nội dung --%>
<div class="main-content-header">
    <h2><i class="fas fa-chart-bar"></i>Tổng quan điểm số</h2>
    <%-- Bạn có thể thêm các nút hành động hoặc thông tin bổ sung tại đây nếu cần --%>
    <%-- Ví dụ: <button class="btn btn-primary"><i class="fas fa-plus me-2"></i>Thêm bài kiểm tra mới</button> --%>
</div>

<%-- Phần hiển thị thông báo lỗi hoặc thành công từ session --%>
<c:if test="${not empty sessionScope.error}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="fas fa-times-circle"></i>
        <strong>Lỗi:</strong> ${sessionScope.error}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
    </div>
    <% session.removeAttribute("error"); %>
</c:if>
<c:if test="${not empty sessionScope.success}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="fas fa-check-circle"></i>
        <strong>Thành công:</strong> ${sessionScope.success}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
    </div>
    <% session.removeAttribute("success"); %>
</c:if>

<%-- Thẻ Card chứa bảng điểm --%>
<div class="card">
    <div class="card-header">
        <h5 class="mb-0">Danh sách bài kiểm tra và điểm số</h5>
    </div>
    <div class="card-body p-0"> <%-- p-0 để loại bỏ padding mặc định của card-body, giúp bảng tràn viền --%>
        <c:choose>
            <c:when test="${empty tests}">
                <%-- Trạng thái khi không có bài kiểm tra nào --%>
                <div class="empty-state">
                    <i class="fas fa-clipboard-list"></i>
                    <p>Hiện không có bài kiểm tra nào được tạo hoặc chưa có điểm số.</p>
                    <p class="small text-muted">Vui lòng tạo bài kiểm tra mới hoặc đợi sinh viên hoàn thành bài.</p>
                </div>
            </c:when>
            <c:otherwise>
                <%-- Bảng hiển thị danh sách bài kiểm tra và nút xem điểm --%>
                <div class="table-responsive">
                    <table class="table table-bordered table-striped mb-0">
                        <thead>
                            <tr>
                                <th>Tên bài kiểm tra</th>
                                <th>Khóa học</th>
                                <th>Hạn chót</th>
                                <th class="text-center">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="test" items="${tests}">
                                <tr>
                                    <td>${test.title}</td>
                                    <td>
                                        <c:forEach var="course" items="${courses}">
                                            <c:if test="${course.courseId eq test.courseId}">
                                                <span class="badge bg-info text-dark me-1">${course.code}</span>${course.name}
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                    <td><fmt:formatDate value="${test.dueDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/lecturer/grades/test/${test.testId}" class="btn btn-sm btn-outline-primary">
                                            <i class="fas fa-eye me-1"></i> Xem điểm
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%-- Script JavaScript chỉ dành riêng cho trang này nếu cần --%>
<%-- bootstrap.bundle.min.js cần thiết cho các tính năng của Bootstrap như dismissible alerts --%>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>

<%-- Kết thúc nội dung chính --%>