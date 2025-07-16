<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.*" %>
<%
    List<Notification> notifications = (List<Notification>) request.getAttribute("notifications");
    int unreadCount = (Integer) request.getAttribute("unreadCount");
    User currentUser = (User) request.getAttribute("currentUser");
    
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    
    if (notifications == null) {
        notifications = new ArrayList<>();
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông báo - Hệ thống Quản lý Học tập</title>
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
                            <input type="text" class="bg-gray-50 border-none text-gray-900 text-sm rounded-lg block w-full pl-10 p-2.5 focus:ring-2 focus:ring-primary/20 focus:outline-none" placeholder="Tìm kiếm thông báo...">
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
                                <h1 class="text-2xl font-bold text-gray-800">Thông báo</h1>
                                <p class="text-gray-600 mt-1">Xem tất cả thông báo từ giảng viên và hệ thống</p>
                            </div>
                            <div class="flex items-center space-x-4">
                                <button id="markAllReadBtn" class="px-4 py-2 bg-primary text-white text-sm font-medium rounded-button hover:bg-primary-dark transition-colors">
                                    <i class="ri-check-double-line mr-2"></i>Đánh dấu tất cả đã đọc
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Notifications List -->
                    <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden">
                        <div class="px-6 py-4 border-b border-gray-200">
                            <div class="flex items-center justify-between">
                                <h2 class="text-lg font-semibold text-gray-800">Danh sách thông báo</h2>
                                <span class="text-sm text-gray-500"><%= notifications.size() %> thông báo</span>
                            </div>
                        </div>
                        
                        <% if (!notifications.isEmpty()) { %>
                        <div class="divide-y divide-gray-200">
                            <% for (Notification notification : notifications) { %>
                            <div class="notification-item p-6 hover:bg-gray-50 transition-colors <%= !notification.isRead() ? "bg-blue-50" : "" %>" 
                                 data-notification-id="<%= notification.getNotificationId() %>">
                                <div class="flex items-start space-x-4">
                                    <div class="flex-shrink-0">
                                        <div class="w-10 h-10 rounded-full flex items-center justify-center 
                                                    <%= "info".equals(notification.getNotificationType()) ? "bg-blue-100 text-blue-600" :
                                                       "warning".equals(notification.getNotificationType()) ? "bg-yellow-100 text-yellow-600" :
                                                       "success".equals(notification.getNotificationType()) ? "bg-green-100 text-green-600" :
                                                       "error".equals(notification.getNotificationType()) ? "bg-red-100 text-red-600" :
                                                       "bg-gray-100 text-gray-600" %>">
                                            <i class="<%= "info".equals(notification.getNotificationType()) ? "ri-information-line" :
                                                       "warning".equals(notification.getNotificationType()) ? "ri-alert-line" :
                                                       "success".equals(notification.getNotificationType()) ? "ri-check-line" :
                                                       "error".equals(notification.getNotificationType()) ? "ri-error-warning-line" :
                                                       "ri-notification-line" %> text-lg"></i>
                                        </div>
                                    </div>
                                    <div class="flex-1 min-w-0">
                                        <div class="flex items-center justify-between">
                                            <h3 class="text-sm font-medium text-gray-900 <%= !notification.isRead() ? "font-semibold" : "" %>">
                                                <%= notification.getTitle() %>
                                            </h3>
                                            <div class="flex items-center space-x-2">
                                                <% if (!notification.isRead()) { %>
                                                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                                                    Mới
                                                </span>
                                                <% } %>
                                                <span class="text-xs text-gray-500">
                                                    <%= sdf.format(notification.getCreatedAt()) %>
                                                </span>
                                            </div>
                                        </div>
                                        <p class="mt-1 text-sm text-gray-600">
                                            <%= notification.getMessage() %>
                                        </p>
                                        <% if (notification.getActionUrl() != null && !notification.getActionUrl().isEmpty()) { %>
                                        <div class="mt-3">
                                            <a href="<%= notification.getActionUrl() %>" 
                                               class="text-sm text-primary hover:text-primary-dark font-medium">
                                                Xem chi tiết <i class="ri-arrow-right-line ml-1"></i>
                                            </a>
                                        </div>
                                        <% } %>
                                    </div>
                                    <div class="flex-shrink-0">
                                        <% if (!notification.isRead()) { %>
                                        <button class="mark-read-btn text-gray-400 hover:text-gray-600" 
                                                data-notification-id="<%= notification.getNotificationId() %>">
                                            <i class="ri-check-line text-lg"></i>
                                        </button>
                                        <% } %>
                                    </div>
                                </div>
                            </div>
                            <% } %>
                        </div>
                        <% } else { %>
                        <div class="text-center py-12">
                            <div class="w-20 h-20 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                <i class="ri-notification-line text-2xl text-gray-400"></i>
                            </div>
                            <h3 class="text-lg font-medium text-gray-800 mb-2">Không có thông báo nào</h3>
                            <p class="text-gray-500">Bạn chưa có thông báo nào từ giảng viên hoặc hệ thống.</p>
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

            // Mark notification as read
            document.querySelectorAll('.mark-read-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    const notificationId = this.dataset.notificationId;
                    markNotificationAsRead(notificationId, this);
                });
            });

            // Mark all notifications as read
            document.getElementById('markAllReadBtn').addEventListener('click', function() {
                markAllNotificationsAsRead();
            });

            function markNotificationAsRead(notificationId, button) {
                fetch('<%= request.getContextPath() %>/student/notifications', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: `action=mark-read&notificationId=${notificationId}`
                })
                .then(response => response.text())
                .then(data => {
                    if (data === 'success') {
                        const notificationItem = button.closest('.notification-item');
                        notificationItem.classList.remove('bg-blue-50');
                        button.remove();
                        
                        // Remove "Mới" badge
                        const badge = notificationItem.querySelector('.bg-blue-100');
                        if (badge) badge.remove();
                        
                        // Update title font weight
                        const title = notificationItem.querySelector('h3');
                        title.classList.remove('font-semibold');
                    }
                })
                .catch(error => console.error('Error:', error));
            }

            function markAllNotificationsAsRead() {
                fetch('<%= request.getContextPath() %>/student/notifications', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'action=mark-all-read'
                })
                .then(response => response.text())
                .then(data => {
                    if (data === 'success') {
                        // Remove all blue backgrounds and badges
                        document.querySelectorAll('.notification-item').forEach(item => {
                            item.classList.remove('bg-blue-50');
                            const badge = item.querySelector('.bg-blue-100');
                            if (badge) badge.remove();
                            const title = item.querySelector('h3');
                            title.classList.remove('font-semibold');
                            const markReadBtn = item.querySelector('.mark-read-btn');
                            if (markReadBtn) markReadBtn.remove();
                        });
                    }
                })
                .catch(error => console.error('Error:', error));
            }
        });
    </script>
</body>
</html>