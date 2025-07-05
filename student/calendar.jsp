<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hệ thống Quản lý Học tập - Sinh viên</title>
        <script src="https://cdn.tailwindcss.com/3.4.16"></script>
        <script>tailwind.config = {theme: {extend: {colors: {primary: '#4f46e5', secondary: '#818cf8'}, borderRadius: {'none': '0px', 'sm': '4px', DEFAULT: '8px', 'md': '12px', 'lg': '16px', 'xl': '20px', '2xl': '24px', '3xl': '32px', 'full': '9999px', 'button': '8px'}}}}</script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css">
<style>
        :where([class^="ri-"])::before { content: "\f3c2"; }
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
            background: #d1d5db;
            border-radius: 8px;
        }
        .custom-scrollbar::-webkit-scrollbar-thumb:hover {
            background: #9ca3af;
        }
        .custom-switch {
            position: relative;
            display: inline-block;
            width: 44px;
            height: 24px;
        }
        .custom-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }
        .switch-slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #e5e7eb;
            transition: .4s;
            border-radius: 24px;
        }
        .switch-slider:before {
            position: absolute;
            content: "";
            height: 18px;
            width: 18px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }
        input:checked + .switch-slider {
            background-color: #4f46e5;
        }
        input:checked + .switch-slider:before {
            transform: translateX(20px);
        }
        .dropdown-content {
            display: none;
            position: absolute;
            min-width: 200px;
            z-index: 50;
            top: 100%;
            left: 0;
        }
        .dropdown:hover .dropdown-content {
            display: block;
        }

        /* Calendar specific styles */
        .calendar-grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 1px;
            background-color: #e5e7eb; /* Border color for cells */
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            overflow: hidden;
        }
        .calendar-cell {
            background-color: #ffffff;
            padding: 8px;
            min-height: 100px;
            position: relative;
        }
        .calendar-day-header {
            background-color: #f3f4f6;
            font-weight: 500;
            text-align: center;
            padding: 8px;
        }
        .event-item {
            background-color: #eff6ff; /* Default color for events */
            border-left: 3px solid #3b82f6; /* Default border color */
            padding: 6px 8px;
            border-radius: 4px;
            margin-bottom: 4px;
            font-size: 0.875rem;
            cursor: pointer;
            position: relative;
        }
        /* Example color coding for courses */
        .event-item.math { border-left-color: #ef4444; background-color: #fee2e2; } /* red-500 */
        .event-item.cs { border-left-color: #3b82f6; background-color: #eff6ff; } /* blue-500 */
        .event-item.english { border-left-color: #22c55e; background-color: #f0fdf4; } /* green-500 */

        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 100;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border-radius: 8px;
            width: 90%;
            max-width: 600px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            position: relative;
        }
        .close-button {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            position: absolute;
            top: 10px;
            right: 20px;
        }
        .close-button:hover,
        .close-button:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
    </head>
    <body class="bg-gray-100 font-sans text-gray-900">
        <div class="flex h-screen">
            <aside class="fixed inset-y-0 left-0 z-50 w-64 bg-white border-r border-gray-200 shadow-lg hidden md:flex flex-col">
                <div class="flex items-center px-6 py-3 border-b border-gray-200">
                    <div class="text-2xl font-['Pacifico'] text-primary">logo</div>
                </div>
                <nav class="p-4 space-y-1 flex-1">
                    <a href="dashboard.jsp" class="w-full px-3 py-2 text-sm font-medium text-primary bg-primary/5 rounded-button block">
                        <div class="flex items-center">
                            <div class="w-5 h-5 flex items-center justify-center mr-3">
                                <i class="ri-dashboard-line"></i>
                            </div>
                            <span>Dashboard</span>
                        </div>
                    </a>
                    <a href="courses.jsp" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button block">
                        <div class="flex items-center">
                            <div class="w-5 h-5 flex items-center justify-center mr-3">
                                <i class="ri-book-open-line"></i>
                            </div>
                            <span>Khóa học</span>
                        </div>
                    </a>
                    <a href="assignments.jsp" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button block">
                        <div class="flex items-center">
                            <div class="w-5 h-5 flex items-center justify-center mr-3">
                                <i class="ri-file-list-line"></i>
                            </div>
                            <span>Bài tập</span>
                        </div>
                    </a>
                    <a href="grades.jsp" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button block">
                        <div class="flex items-center">
                            <div class="w-5 h-5 flex items-center justify-center mr-3">
                                <i class="ri-bar-chart-line"></i>
                            </div>
                            <span>Điểm số</span>
                        </div>
                    </a>
                    <a href="forum.jsp" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button block">
                        <div class="flex items-center">
                            <div class="w-5 h-5 flex items-center justify-center mr-3">
                                <i class="ri-question-answer-line"></i>
                            </div>
                            <span>Diễn đàn</span>
                        </div>
                    </a>
                    <a href="calendar.jsp" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button block">
                        <div class="flex items-center">
                            <div class="w-5 h-5 flex items-center justify-center mr-3">
                                <i class="ri-calendar-line"></i>
                            </div>
                            <span>Lịch</span>
                        </div>
                    </a>
                    <a href="documents.jsp" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button block">
                        <div class="flex items-center">
                            <div class="w-5 h-5 flex items-center justify-center mr-3">
                                <i class="ri-calendar-line"></i>
                            </div>
                            <span>Tài Liệu</span>
                        </div>
                    </a>
                    <a href="settings.jsp" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button block">
                        <div class="flex items-center">
                            <div class="w-5 h-5 flex items-center justify-center mr-3">
                                <i class="ri-settings-line"></i>
                            </div>
                            <span>Cài đặt</span>
                        </div>
                    </a>
                </nav>
        <div class="p-4 border-t border-gray-200">
            <div class="flex items-center">
                <img src="https://readdy.ai/api/search-image?query=professional%2520portrait%2520photo%2520of%2520a%2520young%2520vietnamese%2520male%2520student%2520with%2520short%2520black%2520hair%252C%2520casual%2520outfit%252C%2520neutral%2520background%252C%2520friendly%2520smile&width=100&height=100&seq=1&orientation=squarish" alt="Avatar" class="w-10 h-10 rounded-full object-cover">
                <div class="ml-3">
                    <p class="text-sm font-medium text-gray-800">Nguyễn Văn Minh</p>
                    <p class="text-xs text-gray-500">SV2023405</p>
                </div>
            </div>
                <a href="http://localhost:8080/WebApplication2/" class="w-full flex items-center justify-center gap-2 px-3 py-2 text-sm font-medium text-red-600 hover:bg-red-50 rounded-button">
                    <div class="w-5 h-5 flex items-center justify-center">
                        <i class="ri-logout-box-line"></i>
                    </div>
                    <span>Đăng xuất</span>
                </a>
        </div>
            </aside>

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
                        <input type="text" class="bg-gray-50 border-none text-gray-900 text-sm rounded-lg block w-full pl-10 p-2.5 focus:ring-2 focus:ring-primary/20 focus:outline-none" placeholder="Tìm kiếm khóa học, tài liệu...">
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
                            <img src="https://readdy.ai/api/search-image?query=professional%20portrait%20photo%20of%2520a%2520young%2520vietnamese%2520male%2520student%2520with%2520short%2520black%2520hair%252C%2520casual%2520outfit%252C%2520neutral%2520background%252C%2520friendly%2520smile&width=100&height=100&seq=1&orientation=squarish" alt="Avatar" class="w-8 h-8 rounded-full object-cover">
                        </button>
                    </div>
                </div>
            </div>
        </header>

        <main class="flex-1 overflow-y-auto bg-gray-50 p-4 md:p-6 custom-scrollbar">
            <div class="max-w-7xl mx-auto" style="   margin-left: 300px;">
                <h1 class="text-2xl font-bold text-gray-800 mb-6">Lịch học của tôi</h1>

                <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-4 mb-6 flex flex-col md:flex-row items-center justify-between gap-4">
                    <div class="flex items-center gap-3 w-full md:w-auto">
                        <div class="flex rounded-button overflow-hidden border border-gray-300">
                            <button id="weekViewBtn" class="px-3 py-1.5 text-sm font-medium text-white bg-primary">Tuần</button>
                            <button id="monthViewBtn" class="px-3 py-1.5 text-sm font-medium text-gray-700 bg-gray-100 hover:bg-gray-200">Tháng</button>
                        </div>
                        <div class="flex items-center gap-1">
                            <button id="prevPeriodBtn" class="p-2 rounded-full text-gray-600 hover:bg-gray-100"><i class="ri-arrow-left-s-line text-lg"></i></button>
                            <span id="currentPeriodDisplay" class="font-medium text-gray-800 text-sm whitespace-nowrap">Tháng 7, 2025</span>
                            <button id="nextPeriodBtn" class="p-2 rounded-full text-gray-600 hover:bg-gray-100"><i class="ri-arrow-right-s-line text-lg"></i></button>
                        </div>
                    </div>

                    <div class="flex flex-col md:flex-row items-stretch md:items-center gap-3 w-full md:w-auto">
                        <div class="relative flex-1">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                <i class="ri-search-line text-gray-400"></i>
                            </div>
                            <input type="text" id="eventSearchInput" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg block w-full pl-10 p-2.5 focus:ring-primary/20 focus:border-primary" placeholder="Tìm kiếm sự kiện/môn học...">
                        </div>
                        <select id="courseFilter" class="block w-full md:w-auto px-3 py-2 border border-gray-300 bg-white rounded-lg shadow-sm focus:outline-none focus:ring-primary/20 focus:border-primary text-sm">
                            <option value="all">Tất cả môn học</option>
                            <option value="CS201">Lập trình hướng đối tượng</option>
                            <option value="IT305">Cơ sở dữ liệu</option>
                            <option value="NET202">Mạng máy tính</option>
                        </select>
                        <select id="typeFilter" class="block w-full md:w-auto px-3 py-2 border border-gray-300 bg-white rounded-lg shadow-sm focus:outline-none focus:ring-primary/20 focus:border-primary text-sm">
                            <option value="all">Tất cả loại</option>
                            <option value="lythuyet">Lý thuyết</option>
                            <option value="thuchanh">Thực hành</option>
                        </select>
                        <select id="locationFilter" class="block w-full md:w-auto px-3 py-2 border border-gray-300 bg-white rounded-lg shadow-sm focus:outline-none focus:ring-primary/20 focus:border-primary text-sm">
                            <option value="all">Tất cả địa điểm</option>
                            <option value="A305">Phòng A305</option>
                            <option value="B204">Phòng B204</option>
                            <option value="C103">Phòng C103</option>
                        </select>
                        <a href="./dashboard.jsp" class="px-4 py-2 text-sm font-medium text-gray-700 bg-gray-100 rounded-button whitespace-nowrap hover:bg-gray-200 flex items-center justify-center">
                            <i class="ri-home-line mr-1"></i> Trở về trang gốc
                        </a>
                    </div>
                </div>

                <div id="calendarDisplay" class="bg-white rounded-lg shadow-sm border border-gray-100 p-4">
                    <div id="weekView" class="calendar-grid">
                        <div class="calendar-day-header">Thứ 2</div>
                        <div class="calendar-day-header">Thứ 3</div>
                        <div class="calendar-day-header">Thứ 4</div>
                        <div class="calendar-day-header">Thứ 5</div>
                        <div class="calendar-day-header">Thứ 6</div>
                        <div class="calendar-day-header">Thứ 7</div>
                        <div class="calendar-day-header">Chủ Nhật</div>

                        <div class="calendar-cell" data-date="2025-07-01">
                            <p class="text-xs text-gray-500 mb-2">1/7</p>
                            <div class="event-item cs" data-event-id="e1">
                                <span class="font-medium">Lập trình HDT</span><br>
                                <span class="text-xs text-gray-600">7:30 - 10:30, A305</span>
                            </div>
                        </div>
                        <div class="calendar-cell" data-date="2025-07-02">
                            <p class="text-xs text-gray-500 mb-2">2/7</p>
                            <div class="event-item english" data-event-id="e2">
                                <span class="font-medium">Tiếng Anh C2</span><br>
                                <span class="text-xs text-gray-600">8:00 - 10:00, B101</span>
                            </div>
                        </div>
                        <div class="calendar-cell" data-date="2025-07-03">
                            <p class="text-xs text-gray-500 mb-2">3/7</p>
                            <div class="event-item math" data-event-id="e3">
                                <span class="font-medium">Giải tích 1</span><br>
                                <span class="text-xs text-gray-600">13:00 - 16:00, C203</span>
                            </div>
                            <div class="event-item cs" data-event-id="e4">
                                <span class="font-medium">Cơ sở dữ liệu</span><br>
                                <span class="text-xs text-gray-600">14:00 - 17:00, B204</span>
                            </div>
                        </div>
                        <div class="calendar-cell" data-date="2025-07-04" style="background-color: #e0e7ff;"> <p class="text-xs text-gray-500 mb-2 font-bold">4/7 (Hôm nay)</p>
                            <div class="event-item cs" data-event-id="e5">
                                <span class="font-medium">Mạng máy tính</span><br>
                                <span class="text-xs text-gray-600">9:30 - 12:30, C103</span>
                            </div>
                        </div>
                        <div class="calendar-cell" data-date="2025-07-05">
                            <p class="text-xs text-gray-500 mb-2">5/7</p>
                            <div class="event-item math" data-event-id="e6">
                                <span class="font-medium">Đại số tuyến tính</span><br>
                                <span class="text-xs text-gray-600">7:30 - 10:30, D102</span>
                            </div>
                        </div>
                        <div class="calendar-cell" data-date="2025-07-06">
                            <p class="text-xs text-gray-500 mb-2">6/7</p>
                            </div>
                        <div class="calendar-cell" data-date="2025-07-07">
                            <p class="text-xs text-gray-500 mb-2">7/7</p>
                            </div>

                        </div>

                    <div id="monthView" class="hidden calendar-grid">
                        <div class="calendar-day-header">Thứ 2</div>
                        <div class="calendar-day-header">Thứ 3</div>
                        <div class="calendar-day-header">Thứ 4</div>
                        <div class="calendar-day-header">Thứ 5</div>
                        <div class="calendar-day-header">Thứ 6</div>
                        <div class="calendar-day-header">Thứ 7</div>
                        <div class="calendar-day-header">Chủ Nhật</div>
                        <%-- Fill with empty cells for days from previous month if needed --%>
                        <% for (int i = 24; i <= 30; i++) { %>
                        <div class="calendar-cell text-gray-400" data-date="2025-06-<%= i %>">
                            <p class="text-xs mb-2"><%= i %>/6</p>
                        </div>
                        <% } %>
                        <%-- Current month days --%>
                        <% for (int i = 1; i <= 31; i++) { %>
                        <div class="calendar-cell <%= (i == 4) ? "bg-blue-50" : "" %>" data-date="2025-07-<%= i %>">
                            <p class="text-xs text-gray-500 mb-2 <%= (i == 4) ? "font-bold" : "" %>"><%= i %>/7 <%= (i == 4) ? "(Hôm nay)" : "" %></p>
                            <% if (i == 1) { %>
                            <div class="event-item cs" data-event-id="e1">Lập trình HDT</div>
                            <% } else if (i == 2) { %>
                            <div class="event-item english" data-event-id="e2">Tiếng Anh C2</div>
                            <% } else if (i == 3) { %>
                            <div class="event-item math" data-event-id="e3">Giải tích 1</div>
                            <div class="event-item cs" data-event-id="e4">Cơ sở dữ liệu</div>
                            <% } else if (i == 4) { %>
                            <div class="event-item cs" data-event-id="e5">Mạng máy tính</div>
                            <% } else if (i == 5) { %>
                            <div class="event-item math" data-event-id="e6">Đại số tuyến tính</div>
                            <% } %>
                            </div>
                        <% } %>
                        <%-- Fill with empty cells for days from next month if needed --%>
                        <% for (int i = 1; i <= 5; i++) { %>
                        <div class="calendar-cell text-gray-400" data-date="2025-08-<%= i %>">
                            <p class="text-xs mb-2"><%= i %>/8</p>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

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
        <a href="./calendar.jsp" class="flex flex-col items-center py-2 text-primary">
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
        <a href="./profile.jsp" class="flex flex-col items-center py-2 text-gray-500">
            <div class="w-6 h-6 flex items-center justify-center">
                <i class="ri-user-line"></i>
            </div>
            <span class="text-xs mt-1">Cá nhân</span>
        </a>
    </div>
</div>

<div id="eventDetailModal" class="modal">
    <div class="modal-content">
        <span class="close-button">&times;</span>
        <h2 id="modalEventTitle" class="text-xl font-bold text-gray-800 mb-3"></h2>
        <p class="text-sm text-gray-700 mb-1"><i class="ri-book-mark-line mr-1"></i> <span id="modalCourseCode"></span></p>
        <p class="text-sm text-gray-700 mb-1"><i class="ri-time-line mr-1"></i> <span id="modalEventTime"></span></p>
        <p class="text-sm text-gray-700 mb-1"><i class="ri-map-pin-line mr-1"></i> <span id="modalEventLocation"></span></p>
        <p class="text-sm text-gray-700 mb-3"><i class="ri-user-line mr-1"></i> <span id="modalEventInstructor"></span></p>

        <h3 class="font-semibold text-gray-800 mb-2">Thông tin chi tiết:</h3>
        <p id="modalEventDetails" class="text-sm text-gray-600 mb-4">Thông tin bài giảng, tài liệu liên quan...</p>

        <h3 class="font-semibold text-gray-800 mb-2">Bài tập/Deadline:</h3>
        <ul id="modalAssignments" class="list-disc list-inside text-sm text-gray-600 mb-4">
            <li>Bài tập 1: Hạn nộp 10/07/2025</li>
            <li>Kiểm tra giữa kỳ: 20/07/2025</li>
        </ul>

        <h3 class="font-semibold text-gray-800 mb-2">Ghi chú cá nhân:</h3>
        <textarea id="modalStudentNotes" class="w-full p-2 border border-gray-300 rounded-md text-sm mb-4" rows="3" placeholder="Thêm ghi chú của bạn về sự kiện này..."></textarea>

        <div class="flex justify-end gap-2">
            <button id="joinOnlineBtn" class="px-4 py-2 bg-primary text-white text-sm rounded-button hover:bg-primary-dark hidden"><i class="ri-video-chat-line mr-1"></i> Tham gia học trực tuyến</button>
            <button id="saveNotesBtn" class="px-4 py-2 bg-gray-200 text-gray-800 text-sm rounded-button hover:bg-gray-300">Lưu ghi chú</button>
        </div>
    </div>
</div>


<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Mock Event Data (Replace with real data from backend in production)
        const events = {
            'e1': {
                title: 'Lập trình hướng đối tượng',
                courseCode: 'CS201',
                time: 'Thứ 2, 7:30 - 10:30',
                location: 'Phòng A305',
                instructor: 'TS. Trần Minh Tuấn',
                details: 'Bài giảng về lập trình OOP cơ bản, giới thiệu class, object, inheritance.',
                onlineLink: 'https://meet.google.com/abc-xyz'
            },
            'e2': {
                title: 'Tiếng Anh C2',
                courseCode: 'ENG401',
                time: 'Thứ 3, 8:00 - 10:00',
                location: 'Phòng B101',
                instructor: 'Cô Nguyễn Thị Lan',
                details: 'Thực hành kỹ năng nói và nghe, chủ đề giao tiếp kinh doanh.',
                onlineLink: null
            },
            'e3': {
                title: 'Giải tích 1',
                courseCode: 'MATH101',
                time: 'Thứ 4, 13:00 - 16:00',
                location: 'Phòng C203',
                instructor: 'GS. Hoàng Văn Chung',
                details: 'Chương 3: Tích phân xác định và ứng dụng.',
                onlineLink: 'https://zoom.us/j/1234567890'
            },
            'e4': {
                title: 'Cơ sở dữ liệu',
                courseCode: 'IT305',
                time: 'Thứ 4, 14:00 - 17:00',
                location: 'Phòng B204',
                instructor: 'PGS.TS. Lê Thị Hương',
                details: 'Thực hành SQL: Join và Subquery.',
                onlineLink: null
            },
            'e5': {
                title: 'Mạng máy tính',
                courseCode: 'NET202',
                time: 'Thứ 5, 9:30 - 12:30',
                location: 'Phòng C103',
                instructor: 'ThS. Phạm Văn Đức',
                details: 'Giới thiệu về mô hình TCP/IP và các giao thức tầng ứng dụng.',
                onlineLink: null
            },
            'e6': {
                title: 'Đại số tuyến tính',
                courseCode: 'MATH102',
                time: 'Thứ 6, 7:30 - 10:30',
                location: 'Phòng D102',
                instructor: 'TS. Phan Thị Mai',
                details: 'Bài tập về không gian vector và ánh xạ tuyến tính.',
                onlineLink: null
            }
        };

        // Mobile Menu Toggle
        const mobileMenuBtn = document.getElementById('mobileMenuBtn');
        const sidebar = document.querySelector('aside');
        mobileMenuBtn.addEventListener('click', function() {
            sidebar.classList.toggle('hidden');
            sidebar.classList.toggle('fixed');
            sidebar.classList.toggle('z-50');
            sidebar.classList.toggle('top-0');
            sidebar.classList.toggle('left-0');
            sidebar.classList.toggle('h-full');
            sidebar.classList.toggle('w-64');
        });

        // Calendar View Toggles
        const weekViewBtn = document.getElementById('weekViewBtn');
        const monthViewBtn = document.getElementById('monthViewBtn');
        const weekView = document.getElementById('weekView');
        const monthView = document.getElementById('monthView');
        const currentPeriodDisplay = document.getElementById('currentPeriodDisplay');

        let currentView = 'week'; // Default view
        let currentMoment = new Date(); // Using native Date for simplicity, for complex calendars consider libraries like moment.js

        function updatePeriodDisplay() {
            if (currentView === 'week') {
                const startOfWeek = new Date(currentMoment);
                startOfWeek.setDate(currentMoment.getDate() - currentMoment.getDay() + (currentMoment.getDay() === 0 ? -6 : 1)); // Adjust for Monday start
                const endOfWeek = new Date(startOfWeek);
                endOfWeek.setDate(startOfWeek.getDate() + 6);
                currentPeriodDisplay.textContent = `Tuần từ ${startOfWeek.getDate()}/${startOfWeek.getMonth() + 1} - ${endOfWeek.getDate()}/${endOfWeek.getMonth() + 1}, ${currentMoment.getFullYear()}`;
            } else { // Month view
                currentPeriodDisplay.textContent = `Tháng ${currentMoment.getMonth() + 1}, ${currentMoment.getFullYear()}`;
            }
        }

        function switchView(view) {
            currentView = view;
            if (view === 'week') {
                weekView.classList.remove('hidden');
                monthView.classList.add('hidden');
                weekViewBtn.classList.add('bg-primary', 'text-white');
                weekViewBtn.classList.remove('bg-gray-100', 'text-gray-700');
                monthViewBtn.classList.remove('bg-primary', 'text-white');
                monthViewBtn.classList.add('bg-gray-100', 'text-gray-700');
            } else { // month
                monthView.classList.remove('hidden');
                weekView.classList.add('hidden');
                monthViewBtn.classList.add('bg-primary', 'text-white');
                monthViewBtn.classList.remove('bg-gray-100', 'text-gray-700');
                weekViewBtn.classList.remove('bg-primary', 'text-white');
                weekViewBtn.classList.add('bg-gray-100', 'text-gray-700');
            }
            updatePeriodDisplay();
        }

        weekViewBtn.addEventListener('click', () => switchView('week'));
        monthViewBtn.addEventListener('click', () => switchView('month'));

        // Calendar Navigation
        const prevPeriodBtn = document.getElementById('prevPeriodBtn');
        const nextPeriodBtn = document.getElementById('nextPeriodBtn');

        prevPeriodBtn.addEventListener('click', () => {
            if (currentView === 'week') {
                currentMoment.setDate(currentMoment.getDate() - 7);
            } else {
                currentMoment.setMonth(currentMoment.getMonth() - 1);
            }
            // In a real app, you'd re-render calendar events here based on currentMoment
            updatePeriodDisplay();
        });

        nextPeriodBtn.addEventListener('click', () => {
            if (currentView === 'week') {
                currentMoment.setDate(currentMoment.getDate() + 7);
            } else {
                currentMoment.setMonth(currentMoment.getMonth() + 1);
            }
            // In a real app, you'd re-render calendar events here based on currentMoment
            updatePeriodDisplay();
        });

        // Event Search and Filters (basic client-side filtering)
        const eventSearchInput = document.getElementById('eventSearchInput');
        const courseFilter = document.getElementById('courseFilter');
        const typeFilter = document.getElementById('typeFilter');
        const locationFilter = document.getElementById('locationFilter');
        const allEventItems = document.querySelectorAll('.event-item'); // Get all event items

        function applyFilters() {
            const searchTerm = eventSearchInput.value.toLowerCase();
            const selectedCourse = courseFilter.value;
            const selectedType = typeFilter.value; // You'll need to add data-type to your event-item divs
            const selectedLocation = locationFilter.value; // You'll need to add data-location to your event-item divs

            allEventItems.forEach(eventItem => {
                const eventTitle = eventItem.querySelector('span.font-medium').textContent.toLowerCase();
                // For demonstration, use simple checks. In real app, match with events data structure.
                const isCourseMatch = (selectedCourse === 'all' || eventItem.classList.contains(selectedCourse.toLowerCase())); // Needs better mapping
                const isLocationMatch = (selectedLocation === 'all' || eventItem.querySelector('span.text-xs').textContent.includes(selectedLocation));
                const isSearchMatch = eventTitle.includes(searchTerm);

                // Assuming type is not in mock data, this filter won't work without it.
                // You'd need a data-type attribute on event-item, e.g., data-type="lythuyet"
                const isTypeMatch = (selectedType === 'all'); // Placeholder

                if (isCourseMatch && isLocationMatch && isSearchMatch && isTypeMatch) {
                    eventItem.style.display = 'block';
                } else {
                    eventItem.style.display = 'none';
                }
            });
        }

        eventSearchInput.addEventListener('keyup', applyFilters);
        courseFilter.addEventListener('change', applyFilters);
        typeFilter.addEventListener('change', applyFilters);
        locationFilter.addEventListener('change', applyFilters);

        // Event Detail Modal
        const modal = document.getElementById('eventDetailModal');
        const closeButton = document.querySelector('.close-button');

        const modalEventTitle = document.getElementById('modalEventTitle');
        const modalCourseCode = document.getElementById('modalCourseCode');
        const modalEventTime = document.getElementById('modalEventTime');
        const modalEventLocation = document.getElementById('modalEventLocation');
        const modalEventInstructor = document.getElementById('modalEventInstructor');
        const modalEventDetails = document.getElementById('modalEventDetails');
        const modalAssignments = document.getElementById('modalAssignments');
        const modalStudentNotes = document.getElementById('modalStudentNotes');
        const joinOnlineBtn = document.getElementById('joinOnlineBtn');
        const saveNotesBtn = document.getElementById('saveNotesBtn');

        allEventItems.forEach(item => {
            item.addEventListener('click', function() {
                const eventId = this.dataset.eventId;
                const eventData = events[eventId];

                if (eventData) {
                    modalEventTitle.textContent = eventData.title;
                    modalCourseCode.textContent = eventData.courseCode;
                    modalEventTime.textContent = eventData.time;
                    modalEventLocation.textContent = eventData.location;
                    modalEventInstructor.textContent = eventData.instructor;
                    modalEventDetails.textContent = eventData.details;

                    // Clear previous assignments and add new ones (mock data)
                    modalAssignments.innerHTML = '<li>Bài tập 1: Hạn nộp 10/07/2025</li><li>Kiểm tra giữa kỳ: 20/07/2025</li>';

                    // Mock for student notes (load from local storage or backend)
                    modalStudentNotes.value = localStorage.getItem(`notes_event_${eventId}`) || '';

                    if (eventData.onlineLink) {
                        joinOnlineBtn.href = eventData.onlineLink;
                        joinOnlineBtn.classList.remove('hidden');
                    } else {
                        joinOnlineBtn.classList.add('hidden');
                    }

                    modal.style.display = 'flex'; // Show modal
                }
            });
        });

        closeButton.addEventListener('click', () => {
            modal.style.display = 'none';
        });

        window.addEventListener('click', (event) => {
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        });

        saveNotesBtn.addEventListener('click', () => {
            // In a real application, save to backend
            const eventId = modalEventTitle.textContent.includes('Lập trình hướng đối tượng') ? 'e1' : 'other_event_id_logic'; // This needs to be more robust
            // For now, let's just save to local storage (very basic)
            localStorage.setItem(`notes_event_${eventId}`, modalStudentNotes.value);
            alert('Ghi chú đã được lưu!');
        });

        // Initial setup
        updatePeriodDisplay(); // Set initial period display
    });
</script>
</body>
</html>