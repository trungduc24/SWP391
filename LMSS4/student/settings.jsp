<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"student".equals(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cài đặt - Hệ thống Quản lý Học tập</title>
        <script src="https://cdn.tailwindcss.com/3.4.16"></script>
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            primary: '#4f46e5',
                            secondary: '#818cf8'
                        }
                    }
                }
            }
        </script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css">
        <style>
            body {
                font-family: 'Inter', sans-serif;
                background-color: #f9fafb;
            }
            .custom-scrollbar::-webkit-scrollbar {
                width: 6px;
            }
            .custom-scrollbar::-webkit-scrollbar-track {
                background: #f1f1f1;
                border-radius: 8px;
            }
            .custom-scrollbar::-webkit-scrollbar-thumb {
                background: #d1d5db;
                border-radius: 8px;
            }
            .custom-scrollbar::-webkit-scrollbar-thumb:hover {
                background: #9ca3af;
            }
            .section-card {
                background: white;
                border-radius: 12px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                border: 1px solid #e5e7eb;
                margin-bottom: 24px;
            }
            .form-group {
                margin-bottom: 16px;
            }
            .form-label {
                display: block;
                font-size: 14px;
                font-weight: 500;
                color: #374151;
                margin-bottom: 4px;
            }
            .form-input {
                width: 100%;
                padding: 8px 12px;
                border: 1px solid #d1d5db;
                border-radius: 6px;
                font-size: 14px;
                transition: border-color 0.2s;
            }
            .form-input:focus {
                outline: none;
                border-color: #4f46e5;
                box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
            }
            .btn-primary {
                background-color: #4f46e5;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.2s;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }
            .btn-primary:hover {
                background-color: #4338ca;
            }
            .alert {
                padding: 12px 16px;
                border-radius: 8px;
                margin-bottom: 20px;
                font-size: 14px;
            }
            .alert-success {
                background-color: #d1fae5;
                border: 1px solid #a7f3d0;
                color: #065f46;
            }
            .alert-error {
                background-color: #fee2e2;
                border: 1px solid #fecaca;
                color: #991b1b;
            }
        </style>
    </head>
    <body class="bg-gray-100 font-sans text-gray-900">
        <div class="flex h-screen">
            <%@ include file="sidebar.jsp" %>

            <div class="flex-1 flex flex-col">
                <!-- Header -->
                <header class="bg-white border-b border-gray-200 shadow-sm sticky top-0 z-10">
                    <div class="flex items-center justify-between px-4 py-3">
                        <button class="md:hidden w-10 h-10 flex items-center justify-center text-gray-600" id="mobileMenuBtn">
                            <i class="ri-menu-line text-xl"></i>
                        </button>
                        <a href="./dashboard.jsp" class="flex items-center text-gray-600 hover:text-primary">
                            <div class="w-8 h-8 flex items-center justify-center">
                                <i class="ri-arrow-left-line text-xl"></i>
                            </div>
                            <span class="ml-1 text-sm font-medium hidden md:block">Quay lại</span>
                        </a>
                        <h1 class="text-lg md:text-xl font-bold text-gray-800 flex-1 text-center pr-10 md:pr-0">Cài đặt</h1>
                    </div>
                </header>

                <!-- Main Content -->
                <main class="flex-1 overflow-y-auto bg-gray-50 p-4 md:p-6 custom-scrollbar">
                    <div class="max-w-4xl mx-auto">

                        <!-- Thông báo -->
                        <c:if test="${not empty successMessage}">
                            <div class="alert alert-success">
                                <i class="ri-check-circle-line mr-2"></i>
                                ${successMessage}
                            </div>
                        </c:if>

                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-error">
                                <i class="ri-error-warning-line mr-2"></i>
                                ${errorMessage}
                            </div>
                        </c:if>

                        <!-- Profile Section -->
                        <div class="section-card">
                            <div class="p-6">
                                <h2 class="text-xl font-semibold text-gray-800 mb-6">Thông tin cá nhân</h2>

                                <form method="post" action="./settings">
                                    <input type="hidden" name="action" value="updateInfo">

                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                        <div class="form-group">
                                            <label for="fullName" class="form-label">Họ và tên *</label>
                                            <input type="text" id="fullName" name="fullName" class="form-input" 
                                                   value="${student.fullName}" placeholder="Nhập họ và tên" required>
                                        </div>

                                        <div class="form-group">
                                            <label for="studentCode" class="form-label">Mã sinh viên</label>
                                            <input type="text" id="studentCode" class="form-input" 
                                                   value="${student.studentCode}" readonly>
                                        </div>

                                        <div class="form-group">
                                            <label for="email" class="form-label">Email</label>
                                            <input type="email" id="email" class="form-input" 
                                                   value="${student.email}" readonly>
                                        </div>

                                        <div class="form-group">
                                            <label for="phone" class="form-label">Số điện thoại</label>
                                            <input type="tel" id="phone" name="phone" class="form-input" 
                                                   value="${student.phone > 0 ? student.phone : ''}" placeholder="Nhập số điện thoại">
                                        </div>

                                        

                                      

                                        <div class="form-group md:col-span-2">
                                            <label for="address" class="form-label">Địa chỉ</label>
                                            <input type="text" id="address" name="address" class="form-input" 
                                                   value="${student.address}" placeholder="Nhập địa chỉ">
                                        </div>

                                       
                                    </div>

                                    <div class="mt-6">
                                        <button type="submit" class="btn-primary">
                                            <i class="ri-save-line"></i>
                                            Lưu thông tin
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <!-- Password Section -->
                        <div class="section-card">
                            <div class="p-6">
                                <h2 class="text-xl font-semibold text-gray-800 mb-6">Đổi mật khẩu</h2>

                                <c:if test="${not empty passwordSuccess}">
                                    <div class="alert alert-success">
                                        <i class="ri-check-circle-line mr-2"></i>
                                        ${passwordSuccess}
                                    </div>
                                </c:if>

                                <c:if test="${not empty passwordError}">
                                    <div class="alert alert-error">
                                        <i class="ri-error-warning-line mr-2"></i>
                                        ${passwordError}
                                    </div>
                                </c:if>

                                <form method="post" action="./settings">
                                    <input type="hidden" name="action" value="updatePassword">

                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                        <div class="form-group md:col-span-2">
                                            <label for="currentPassword" class="form-label">Mật khẩu hiện tại *</label>
                                            <div class="relative">
                                                <input type="password" id="currentPassword" name="currentPassword" 
                                                       class="form-input pr-10" placeholder="Nhập mật khẩu hiện tại" required>
                                                <button type="button" class="absolute right-2 top-2 p-1 text-gray-500 hover:text-gray-700" 
                                                        onclick="togglePassword('currentPassword')">
                                                    <i class="ri-eye-line"></i>
                                                </button>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="newPassword" class="form-label">Mật khẩu mới *</label>
                                            <div class="relative">
                                                <input type="password" id="newPassword" name="newPassword" 
                                                       class="form-input pr-10" placeholder="Nhập mật khẩu mới" required>
                                                <button type="button" class="absolute right-2 top-2 p-1 text-gray-500 hover:text-gray-700" 
                                                        onclick="togglePassword('newPassword')">
                                                    <i class="ri-eye-line"></i>
                                                </button>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="confirmPassword" class="form-label">Xác nhận mật khẩu mới *</label>
                                            <div class="relative">
                                                <input type="password" id="confirmPassword" name="confirmPassword" 
                                                       class="form-input pr-10" placeholder="Nhập lại mật khẩu mới" required>
                                                <button type="button" class="absolute right-2 top-2 p-1 text-gray-500 hover:text-gray-700" 
                                                        onclick="togglePassword('confirmPassword')">
                                                    <i class="ri-eye-line"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mt-6 flex gap-3">
                                        <button type="submit" class="btn-primary">
                                            <i class="ri-lock-password-line"></i>
                                            Đổi mật khẩu
                                        </button>
                                        <button type="button" onclick="clearPasswordForm()" class="bg-gray-500 text-white px-4 py-2 rounded-lg hover:bg-gray-600 transition-colors">
                                            <i class="ri-eraser-line mr-2"></i>
                                            Xóa form
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <!-- Mobile Bottom Navigation -->
        <div class="md:hidden fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 z-10">
            <div class="flex items-center justify-around">
                <a href="./dashboard.jsp" class="flex flex-col items-center py-2 text-gray-500">
                    <div class="w-6 h-6 flex items-center justify-center">
                        <i class="ri-dashboard-line"></i>
                    </div>
                    <span class="text-xs mt-1">Trang chủ</span>
                </a>
                <a href="./courses.jsp" class="flex flex-col items-center py-2 text-gray-500">
                    <div class="w-6 h-6 flex items-center justify-center">
                        <i class="ri-book-open-line"></i>
                    </div>
                    <span class="text-xs mt-1">Khóa học</span>
                </a>
                <a href="./calendar.jsp" class="flex flex-col items-center py-2 text-gray-500">
                    <div class="w-6 h-6 flex items-center justify-center">
                        <i class="ri-calendar-line"></i>
                    </div>
                    <span class="text-xs mt-1">Lịch</span>
                </a>
                <a href="./assignments.jsp" class="flex flex-col items-center py-2 text-gray-500">
                    <div class="w-6 h-6 flex items-center justify-center">
                        <i class="ri-file-list-3-line"></i>
                    </div>
                    <span class="text-xs mt-1">Bài tập</span>
                </a>
                <a href="./settings.jsp" class="flex flex-col items-center py-2 text-primary">
                    <div class="w-6 h-6 flex items-center justify-center">
                        <i class="ri-settings-3-line"></i>
                    </div>
                    <span class="text-xs mt-1">Cài đặt</span>
                </a>
            </div>
        </div>

        <script>
            // Mobile menu toggle
            document.getElementById('mobileMenuBtn').addEventListener('click', function () {
                const sidebar = document.querySelector('aside');
                sidebar.classList.toggle('hidden');
                sidebar.classList.toggle('fixed');
                sidebar.classList.toggle('z-50');
                sidebar.classList.toggle('top-0');
                sidebar.classList.toggle('left-0');
                sidebar.classList.toggle('h-full');
                sidebar.classList.toggle('w-64');
            });

            // Toggle password visibility
            function togglePassword(inputId) {
                const input = document.getElementById(inputId);
                const button = input.nextElementSibling;
                const icon = button.querySelector('i');

                if (input.type === 'password') {
                    input.type = 'text';
                    icon.className = 'ri-eye-off-line';
                } else {
                    input.type = 'password';
                    icon.className = 'ri-eye-line';
                }
            }

            // Clear password form
            function clearPasswordForm() {
                document.getElementById('currentPassword').value = '';
                document.getElementById('newPassword').value = '';
                document.getElementById('confirmPassword').value = '';
            }

            // Auto-hide alerts after 5 seconds
            setTimeout(function () {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(function (alert) {
                    alert.style.opacity = '0';
                    setTimeout(function () {
                        alert.remove();
                    }, 300);
                });
            }, 5000);
        </script>
    </body>
</html>