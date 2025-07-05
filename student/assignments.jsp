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
            body {
                font-family: 'Inter', sans-serif;
                background-color: #f9fafb;
            }
            input[type="number"]::-webkit-inner-spin-button,
            input[type="number"]::-webkit-outer-spin-button {
                -webkit-appearance: none;
                margin: 0;
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
            progress.course-progress::-webkit-progress-bar {
                background-color: #e5e7eb;
                border-radius: 9999px;
            }
            progress.course-progress::-webkit-progress-value {
                background-color: #4f46e5;
                border-radius: 9999px;
            }
            :where([class^="ri-"])::before {
                content: "\f3c2";
            }
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
            .tab-content {
                display: none;
            }
            .tab-content.active {
                display: block;
            }
            input[type="checkbox"] {
                appearance: none;
                -webkit-appearance: none;
                width: 18px;
                height: 18px;
                border: 2px solid #d1d5db;
                border-radius: 4px;
                outline: none;
                cursor: pointer;
                position: relative;
                background-color: white;
            }
            input[type="checkbox"]:checked {
                background-color: #4f46e5;
                border-color: #4f46e5;
            }
            input[type="checkbox"]:checked::after {
                content: "";
                position: absolute;
                width: 5px;
                height: 10px;
                border: solid white;
                border-width: 0 2px 2px 0;
                top: 1px;
                left: 5px;
                transform: rotate(45deg);
            }
            .md\:ml-64 + header + main { /* Selects the main content area */
                padding-top: 5rem; /* Điều chỉnh giá trị này tùy theo chiều cao thực tế của header của bạn */
            }

            @media (max-width: 767px) { /* Adjust for mobile if header height is different */
                .md\:ml-64 + header + main {
                    padding-top: 4rem; /* Hoặc giá trị phù hợp cho thiết bị di động */
                }
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

            <div class="flex-1 flex flex-col md:ml-64">
                <header class="bg-white border-b border-gray-200 shadow-sm fixed top-0 z-40 w-full md:w-[calc(100%-16rem)] md:left-64">
                    <div class="flex items-center justify-between px-4 py-3">
                        <button class="md:hidden w-10 h-10 flex items-center justify-center text-gray-600">
                            <i class="ri-menu-line text-xl"></i>
                        </button>
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
                                    <img src="https://readdy.ai/api/search-image?query=professional%20portrait%20photo%20of%20a%20young%20vietnamese%20male%20student%20with%20short%20black%20hair%2C%20casual%20outfit%2C%20neutral%20background%2C%20friendly%20smile&amp;width=100&amp;height=100&amp;seq=1&amp;orientation=squarish" alt="Avatar" class="w-8 h-8 rounded-full object-cover">
                                </button>
                            </div>
                        </div>
                    </div>
                </header>

      
                        <main class="flex-1 overflow-y-auto bg-gray-50 p-4 md:p-6 custom-scrollbar">
                            <div class="max-w-7xl mx-auto" style=" margin-top: 50px;">
                        <!-- Assignments Header -->
                        <div class="flex flex-col md:flex-row md:items-center justify-between mb-6">
                            
                            <div>
                                <h1 class="text-2xl font-bold text-gray-800 mb-1">Bài tập/Kiểm tra</h1>
                                <p class="text-gray-600">Quản lý bài tập, kiểm tra và theo dõi tiến độ học tập của bạn</p>
                            </div>
                            <div class="flex gap-2 mt-4 md:mt-0">

                            </div>
                        </div>
                        <!-- Tab Navigation -->
                        <div class="bg-white rounded-lg shadow-sm border border-gray-100 mb-6 overflow-hidden">
                            <div class="flex border-b border-gray-100">
                                <button class="tab-button flex-1 py-3 px-4 text-center font-medium text-primary border-b-2 border-primary" data-tab="homework">
                                    <div class="flex items-center justify-center gap-2">
                                        <div class="w-5 h-5 flex items-center justify-center">
                                            <i class="ri-book-2-line"></i>
                                        </div>
                                        <span>Bài tập về nhà</span>
                                    </div>
                                </button>
                                <button class="tab-button flex-1 py-3 px-4 text-center font-medium text-gray-500 hover:text-gray-700" data-tab="exams">
                                    <div class="flex items-center justify-center gap-2">
                                        <div class="w-5 h-5 flex items-center justify-center">
                                            <i class="ri-file-text-line"></i>
                                        </div>
                                        <span>Bài kiểm tra</span>
                                    </div>
                                </button>
                                <button class="tab-button flex-1 py-3 px-4 text-center font-medium text-gray-500 hover:text-gray-700" data-tab="classwork">
                                    <div class="flex items-center justify-center gap-2">
                                        <div class="w-5 h-5 flex items-center justify-center">
                                            <i class="ri-group-line"></i>
                                        </div>
                                        <span>Bài tập trên lớp</span>
                                    </div>
                                </button>
                            </div>
                        </div>
                        <!-- Search and Filter -->
                        <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-4 mb-6">
                            <div class="flex flex-col md:flex-row gap-4">
                                <div class="relative flex-1">
                                    <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                        <i class="ri-search-line text-gray-400"></i>
                                    </div>
                                    <input type="text" class="bg-gray-50 border border-gray-200 text-gray-900 text-sm rounded-lg block w-full pl-10 p-2.5 focus:ring-2 focus:ring-primary/20 focus:outline-none" placeholder="Tìm kiếm bài tập, kiểm tra...">
                                </div>
                                <div class="flex flex-col md:flex-row gap-4">
                                    <div class="relative dropdown">
                                        <button class="bg-white border border-gray-200 text-gray-700 text-sm rounded-lg px-4 py-2.5 flex items-center justify-between min-w-[180px] !rounded-button">
                                            <span>Tất cả môn học</span>
                                            <div class="w-5 h-5 flex items-center justify-center">
                                                <i class="ri-arrow-down-s-line"></i>
                                            </div>
                                        </button>
                                        <div class="dropdown-content bg-white shadow-lg rounded-lg mt-1 border border-gray-100">
                                            <ul class="py-2">
                                                <li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Tất cả môn học</a></li>
                                                <li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Lập trình hướng đối tượng</a></li>
                                                <li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Cơ sở dữ liệu</a></li>
                                                <li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Mạng máy tính</a></li>
                                                <li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Trí tuệ nhân tạo</a></li>
                                                <li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Phát triển ứng dụng web</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="relative dropdown">
                                        <button class="bg-white border border-gray-200 text-gray-700 text-sm rounded-lg px-4 py-2.5 flex items-center justify-between min-w-[180px] !rounded-button">
                                            <span>Trạng thái</span>
                                            <div class="w-5 h-5 flex items-center justify-center">
                                                <i class="ri-arrow-down-s-line"></i>
                                            </div>
                                        </button>
                                        <div class="dropdown-content bg-white shadow-lg rounded-lg mt-1 border border-gray-100">
                                            <ul class="py-2">
                                                <li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Tất cả</a></li>
                                                <li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Đã nộp</a></li>
                                                <li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Chưa nộp</a></li>
                                                <li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Quá hạn</a></li>
                                                <li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Đã chấm điểm</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="relative dropdown">
                                        <button class="bg-white border border-gray-200 text-gray-700 text-sm rounded-lg px-4 py-2.5 flex items-center justify-between min-w-[180px] !rounded-button">
                                            <span>Thời hạn</span>
                                            <div class="w-5 h-5 flex items-center justify-center">
                                                <i class="ri-arrow-down-s-line"></i>
                                            </div>
                                        </button>
                                        <div class="dropdown-content bg-white shadow-lg rounded-lg mt-1 border border-gray-100">
                                            <ul class="py-2">
                                                <li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Tất cả</a></li>
                                                <li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Hôm nay</a></li>
                                                <li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Tuần này</a></li>
                                                <li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Tháng này</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Tab Content -->
                        <div class="tab-content active" id="homework">
                            <!-- Bài tập sắp đến hạn -->
                            <div class="mb-6">
                                <h2 class="text-lg font-semibold text-gray-800 mb-4">Bài tập sắp đến hạn</h2>
                                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                                    <!-- Bài tập 1 -->
                                    <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden hover:shadow-md transition-shadow">
                                        <div class="p-4 border-b border-gray-100">
                                            <div class="flex justify-between items-start mb-2">
                                                <div class="flex items-center">
                                                    <div class="w-10 h-10 flex items-center justify-center rounded-lg bg-blue-100 text-blue-600 mr-3 flex-shrink-0">
                                                        <i class="ri-code-s-slash-line"></i>
                                                    </div>
                                                    <div>
                                                        <h3 class="font-medium text-gray-800">Lập trình hướng đối tượng</h3>
                                                        <p class="text-xs text-gray-500">CS201</p>
                                                    </div>
                                                </div>
                                                <span class="px-2.5 py-1 bg-yellow-100 text-yellow-700 text-xs rounded-full">Chưa nộp</span>
                                            </div>
                                            <h3 class="text-lg font-medium text-gray-800 mb-2">Bài tập thực hành Java kế thừa</h3>
                                            <p class="text-sm text-gray-600 mb-3">Xây dựng chương trình quản lý nhân viên sử dụng tính kế thừa trong Java</p>
                                            <div class="flex items-center text-sm text-gray-500 mb-2">
                                                <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                    <i class="ri-calendar-line"></i>
                                                </div>
                                                <span>Ngày giao: 20/05/2025</span>
                                            </div>
                                            <div class="flex items-center text-sm text-red-500">
                                                <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                    <i class="ri-time-line"></i>
                                                </div>
                                                <span>Hạn nộp: 28/05/2025 (còn 3 ngày)</span>
                                            </div>
                                        </div>
                                        <div class="p-4 bg-gray-50 flex justify-between items-center">
                                            <div class="text-sm">
                                                <span class="font-medium text-gray-700">Điểm: </span>
                                                <span class="text-gray-600">Chưa chấm</span>
                                            </div>
                                            <div class="flex gap-2">
                                                <a href="#" class="text-gray-600 hover:text-primary text-sm">Chi tiết</a>
                                                <span class="text-gray-300">|</span>
                                                <button class="text-primary hover:text-primary-dark text-sm font-medium">Nộp bài</button>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Bài tập 2 -->
                                    <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden hover:shadow-md transition-shadow">
                                        <div class="p-4 border-b border-gray-100">
                                            <div class="flex justify-between items-start mb-2">
                                                <div class="flex items-center">
                                                    <div class="w-10 h-10 flex items-center justify-center rounded-lg bg-purple-100 text-purple-600 mr-3 flex-shrink-0">
                                                        <i class="ri-database-2-line"></i>
                                                    </div>
                                                    <div>
                                                        <h3 class="font-medium text-gray-800">Cơ sở dữ liệu</h3>
                                                        <p class="text-xs text-gray-500">IT305</p>
                                                    </div>
                                                </div>
                                                <span class="px-2.5 py-1 bg-yellow-100 text-yellow-700 text-xs rounded-full">Chưa nộp</span>
                                            </div>
                                            <h3 class="text-lg font-medium text-gray-800 mb-2">Thiết kế cơ sở dữ liệu quan hệ</h3>
                                            <p class="text-sm text-gray-600 mb-3">Thiết kế CSDL cho hệ thống quản lý thư viện và chuẩn hóa đến dạng 3NF</p>
                                            <div class="flex items-center text-sm text-gray-500 mb-2">
                                                <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                    <i class="ri-calendar-line"></i>
                                                </div>
                                                <span>Ngày giao: 18/05/2025</span>
                                            </div>
                                            <div class="flex items-center text-sm text-red-500">
                                                <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                    <i class="ri-time-line"></i>
                                                </div>
                                                <span>Hạn nộp: 27/05/2025 (còn 2 ngày)</span>
                                            </div>
                                        </div>
                                        <div class="p-4 bg-gray-50 flex justify-between items-center">
                                            <div class="text-sm">
                                                <span class="font-medium text-gray-700">Điểm: </span>
                                                <span class="text-gray-600">Chưa chấm</span>
                                            </div>
                                            <div class="flex gap-2">
                                                <a href="#" class="text-gray-600 hover:text-primary text-sm">Chi tiết</a>
                                                <span class="text-gray-300">|</span>
                                                <button class="text-primary hover:text-primary-dark text-sm font-medium">Nộp bài</button>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Bài tập 3 -->
                                    <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden hover:shadow-md transition-shadow">
                                        <div class="p-4 border-b border-gray-100">
                                            <div class="flex justify-between items-start mb-2">
                                                <div class="flex items-center">
                                                    <div class="w-10 h-10 flex items-center justify-center rounded-lg bg-green-100 text-green-600 mr-3 flex-shrink-0">
                                                        <i class="ri-global-line"></i>
                                                    </div>
                                                    <div>
                                                        <h3 class="font-medium text-gray-800">Mạng máy tính</h3>
                                                        <p class="text-xs text-gray-500">NET202</p>
                                                    </div>
                                                </div>
                                                <span class="px-2.5 py-1 bg-yellow-100 text-yellow-700 text-xs rounded-full">Chưa nộp</span>
                                            </div>
                                            <h3 class="text-lg font-medium text-gray-800 mb-2">Cấu hình mạng VLAN</h3>
                                            <p class="text-sm text-gray-600 mb-3">Thực hành cấu hình VLAN trên thiết bị Cisco và viết báo cáo kết quả</p>
                                            <div class="flex items-center text-sm text-gray-500 mb-2">
                                                <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                    <i class="ri-calendar-line"></i>
                                                </div>
                                                <span>Ngày giao: 22/05/2025</span>
                                            </div>
                                            <div class="flex items-center text-sm text-red-500">
                                                <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                    <i class="ri-time-line"></i>
                                                </div>
                                                <span>Hạn nộp: 29/05/2025 (còn 4 ngày)</span>
                                            </div>
                                        </div>
                                        <div class="p-4 bg-gray-50 flex justify-between items-center">
                                            <div class="text-sm">
                                                <span class="font-medium text-gray-700">Điểm: </span>
                                                <span class="text-gray-600">Chưa chấm</span>
                                            </div>
                                            <div class="flex gap-2">
                                                <a href="#" class="text-gray-600 hover:text-primary text-sm">Chi tiết</a>
                                                <span class="text-gray-300">|</span>
                                                <button class="text-primary hover:text-primary-dark text-sm font-medium">Nộp bài</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Bài tập đã nộp -->
                            <div class="mb-6">
                                <h2 class="text-lg font-semibold text-gray-800 mb-4">Bài tập đã nộp</h2>
                                <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden">
                                    <div class="overflow-x-auto">
                                        <table class="min-w-full divide-y divide-gray-200">
                                            <thead class="bg-gray-50">
                                                <tr>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        <div class="flex items-center">
                                                            <input type="checkbox" class="mr-2">
                                                            Tên bài tập
                                                        </div>
                                                    </th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Môn học
                                                    </th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Ngày nộp
                                                    </th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Hạn nộp
                                                    </th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Trạng thái
                                                    </th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Điểm
                                                    </th>
                                                    <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Thao tác
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody class="bg-white divide-y divide-gray-200">
                                                <tr class="hover:bg-gray-50">
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="flex items-center">
                                                            <input type="checkbox" class="mr-2">
                                                            <div class="text-sm font-medium text-gray-900">Bài tập lập trình hàm trong Python</div>
                                                        </div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">Lập trình Python</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">15/05/2025</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">16/05/2025</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <span class="px-2.5 py-1 bg-green-100 text-green-700 text-xs rounded-full">Đã nộp</span>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-900">9.0/10</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                                        <div class="flex justify-end gap-2">
                                                            <button class="text-gray-600 hover:text-primary">
                                                                <div class="w-5 h-5 flex items-center justify-center">
                                                                    <i class="ri-eye-line"></i>
                                                                </div>
                                                            </button>
                                                            <button class="text-gray-600 hover:text-primary">
                                                                <div class="w-5 h-5 flex items-center justify-center">
                                                                    <i class="ri-download-line"></i>
                                                                </div>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr class="hover:bg-gray-50">
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="flex items-center">
                                                            <input type="checkbox" class="mr-2">
                                                            <div class="text-sm font-medium text-gray-900">Thiết kế giao diện người dùng</div>
                                                        </div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">Phát triển ứng dụng web</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">10/05/2025</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">12/05/2025</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <span class="px-2.5 py-1 bg-green-100 text-green-700 text-xs rounded-full">Đã nộp</span>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-900">8.5/10</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                                        <div class="flex justify-end gap-2">
                                                            <button class="text-gray-600 hover:text-primary">
                                                                <div class="w-5 h-5 flex items-center justify-center">
                                                                    <i class="ri-eye-line"></i>
                                                                </div>
                                                            </button>
                                                            <button class="text-gray-600 hover:text-primary">
                                                                <div class="w-5 h-5 flex items-center justify-center">
                                                                    <i class="ri-download-line"></i>
                                                                </div>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr class="hover:bg-gray-50">
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="flex items-center">
                                                            <input type="checkbox" class="mr-2">
                                                            <div class="text-sm font-medium text-gray-900">Báo cáo an toàn mạng</div>
                                                        </div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">An toàn thông tin</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">05/05/2025</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">08/05/2025</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <span class="px-2.5 py-1 bg-green-100 text-green-700 text-xs rounded-full">Đã nộp</span>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-900">9.5/10</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                                        <div class="flex justify-end gap-2">
                                                            <button class="text-gray-600 hover:text-primary">
                                                                <div class="w-5 h-5 flex items-center justify-center">
                                                                    <i class="ri-eye-line"></i>
                                                                </div>
                                                            </button>
                                                            <button class="text-gray-600 hover:text-primary">
                                                                <div class="w-5 h-5 flex items-center justify-center">
                                                                    <i class="ri-download-line"></i>
                                                                </div>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr class="hover:bg-gray-50">
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="flex items-center">
                                                            <input type="checkbox" class="mr-2">
                                                            <div class="text-sm font-medium text-gray-900">Bài tập tối ưu hóa truy vấn SQL</div>
                                                        </div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">Cơ sở dữ liệu</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">01/05/2025</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">03/05/2025</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <span class="px-2.5 py-1 bg-green-100 text-green-700 text-xs rounded-full">Đã nộp</span>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-900">8.0/10</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                                        <div class="flex justify-end gap-2">
                                                            <button class="text-gray-600 hover:text-primary">
                                                                <div class="w-5 h-5 flex items-center justify-center">
                                                                    <i class="ri-eye-line"></i>
                                                                </div>
                                                            </button>
                                                            <button class="text-gray-600 hover:text-primary">
                                                                <div class="w-5 h-5 flex items-center justify-center">
                                                                    <i class="ri-download-line"></i>
                                                                </div>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="px-6 py-3 bg-gray-50 border-t border-gray-200 flex items-center justify-between">
                                        <div class="text-sm text-gray-500">
                                            Hiển thị 1-4 của 4 bài tập
                                        </div>
                                        <div class="flex items-center space-x-2">
                                            <button class="px-3 py-1 bg-white border border-gray-200 rounded text-gray-500 hover:bg-gray-50 text-sm disabled:opacity-50 disabled:cursor-not-allowed" disabled>
                                                Trước
                                            </button>
                                            <button class="px-3 py-1 bg-primary text-white rounded text-sm">
                                                1
                                            </button>
                                            <button class="px-3 py-1 bg-white border border-gray-200 rounded text-gray-500 hover:bg-gray-50 text-sm disabled:opacity-50 disabled:cursor-not-allowed" disabled>
                                                Sau
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Bài tập quá hạn -->
                            <div class="mb-6">
                                <h2 class="text-lg font-semibold text-gray-800 mb-4">Bài tập quá hạn</h2>
                                <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden">
                                    <div class="p-6 text-center">
                                        <div class="w-16 h-16 mx-auto flex items-center justify-center rounded-full bg-gray-100 text-gray-400 mb-4">
                                            <i class="ri-check-line text-2xl"></i>
                                        </div>
                                        <h3 class="text-lg font-medium text-gray-800 mb-2">Không có bài tập quá hạn</h3>
                                        <p class="text-gray-500">Bạn đã nộp tất cả bài tập đúng hạn. Hãy tiếp tục duy trì!</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-content" id="exams">
                            <!-- Bài kiểm tra sắp tới -->
                            <div class="mb-6">
                                <h2 class="text-lg font-semibold text-gray-800 mb-4">Bài kiểm tra sắp tới</h2>
                                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                                    <!-- Bài kiểm tra 1 -->
                                    <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden hover:shadow-md transition-shadow">
                                        <div class="p-4 border-b border-gray-100">
                                            <div class="flex justify-between items-start mb-2">
                                                <div class="flex items-center">
                                                    <div class="w-10 h-10 flex items-center justify-center rounded-lg bg-blue-100 text-blue-600 mr-3 flex-shrink-0">
                                                        <i class="ri-code-s-slash-line"></i>
                                                    </div>
                                                    <div>
                                                        <h3 class="font-medium text-gray-800">Lập trình hướng đối tượng</h3>
                                                        <p class="text-xs text-gray-500">CS201</p>
                                                    </div>
                                                </div>
                                                <span class="px-2.5 py-1 bg-blue-100 text-blue-700 text-xs rounded-full">Sắp diễn ra</span>
                                            </div>
                                            <h3 class="text-lg font-medium text-gray-800 mb-2">Kiểm tra giữa kỳ</h3>
                                            <p class="text-sm text-gray-600 mb-3">Kiểm tra kiến thức về tính kế thừa, đa hình và đóng gói trong Java</p>
                                            <div class="flex items-center text-sm text-gray-500 mb-2">
                                                <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                    <i class="ri-calendar-line"></i>
                                                </div>
                                                <span>Ngày thi: 30/05/2025</span>
                                            </div>
                                            <div class="flex items-center text-sm text-gray-500">
                                                <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                    <i class="ri-time-line"></i>
                                                </div>
                                                <span>Thời gian: 90 phút</span>
                                            </div>
                                        </div>
                                        <div class="p-4 bg-gray-50 flex justify-between items-center">
                                            <div class="text-sm">
                                                <span class="font-medium text-gray-700">Hình thức: </span>
                                                <span class="text-gray-600">Trực tuyến</span>
                                            </div>
                                            <div class="flex gap-2">
                                                <a href="#" class="text-gray-600 hover:text-primary text-sm">Chi tiết</a>
                                                <span class="text-gray-300">|</span>
                                                <button class="text-primary hover:text-primary-dark text-sm font-medium">Chuẩn bị</button>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Bài kiểm tra 2 -->
                                    <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden hover:shadow-md transition-shadow">
                                        <div class="p-4 border-b border-gray-100">
                                            <div class="flex justify-between items-start mb-2">
                                                <div class="flex items-center">
                                                    <div class="w-10 h-10 flex items-center justify-center rounded-lg bg-purple-100 text-purple-600 mr-3 flex-shrink-0">
                                                        <i class="ri-database-2-line"></i>
                                                    </div>
                                                    <div>
                                                        <h3 class="font-medium text-gray-800">Cơ sở dữ liệu</h3>
                                                        <p class="text-xs text-gray-500">IT305</p>
                                                    </div>
                                                </div>
                                                <span class="px-2.5 py-1 bg-blue-100 text-blue-700 text-xs rounded-full">Sắp diễn ra</span>
                                            </div>
                                            <h3 class="text-lg font-medium text-gray-800 mb-2">Kiểm tra SQL nâng cao</h3>
                                            <p class="text-sm text-gray-600 mb-3">Kiểm tra về truy vấn phức tạp, stored procedure và transaction</p>
                                            <div class="flex items-center text-sm text-gray-500 mb-2">
                                                <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                    <i class="ri-calendar-line"></i>
                                                </div>
                                                <span>Ngày thi: 02/06/2025</span>
                                            </div>
                                            <div class="flex items-center text-sm text-gray-500">
                                                <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                    <i class="ri-time-line"></i>
                                                </div>
                                                <span>Thời gian: 120 phút</span>
                                            </div>
                                        </div>
                                        <div class="p-4 bg-gray-50 flex justify-between items-center">
                                            <div class="text-sm">
                                                <span class="font-medium text-gray-700">Hình thức: </span>
                                                <span class="text-gray-600">Trực tiếp</span>
                                            </div>
                                            <div class="flex gap-2">
                                                <a href="#" class="text-gray-600 hover:text-primary text-sm">Chi tiết</a>
                                                <span class="text-gray-300">|</span>
                                                <button class="text-primary hover:text-primary-dark text-sm font-medium">Chuẩn bị</button>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Bài kiểm tra 3 -->
                                    <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden hover:shadow-md transition-shadow">
                                        <div class="p-4 border-b border-gray-100">
                                            <div class="flex justify-between items-start mb-2">
                                                <div class="flex items-center">
                                                    <div class="w-10 h-10 flex items-center justify-center rounded-lg bg-green-100 text-green-600 mr-3 flex-shrink-0">
                                                        <i class="ri-global-line"></i>
                                                    </div>
                                                    <div>
                                                        <h3 class="font-medium text-gray-800">Mạng máy tính</h3>
                                                        <p class="text-xs text-gray-500">NET202</p>
                                                    </div>
                                                </div>
                                                <span class="px-2.5 py-1 bg-blue-100 text-blue-700 text-xs rounded-full">Sắp diễn ra</span>
                                            </div>
                                            <h3 class="text-lg font-medium text-gray-800 mb-2">Kiểm tra định tuyến</h3>
                                            <p class="text-sm text-gray-600 mb-3">Kiểm tra về các giao thức định tuyến và cấu hình router</p>
                                            <div class="flex items-center text-sm text-gray-500 mb-2">
                                                <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                    <i class="ri-calendar-line"></i>
                                                </div>
                                                <span>Ngày thi: 05/06/2025</span>
                                            </div>
                                            <div class="flex items-center text-sm text-gray-500">
                                                <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                    <i class="ri-time-line"></i>
                                                </div>
                                                <span>Thời gian: 60 phút</span>
                                            </div>
                                        </div>
                                        <div class="p-4 bg-gray-50 flex justify-between items-center">
                                            <div class="text-sm">
                                                <span class="font-medium text-gray-700">Hình thức: </span>
                                                <span class="text-gray-600">Trực tuyến</span>
                                            </div>
                                            <div class="flex gap-2">
                                                <a href="#" class="text-gray-600 hover:text-primary text-sm">Chi tiết</a>
                                                <span class="text-gray-300">|</span>
                                                <button class="text-primary hover:text-primary-dark text-sm font-medium">Chuẩn bị</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Bài kiểm tra đã hoàn thành -->
                            <div class="mb-6">
                                <h2 class="text-lg font-semibold text-gray-800 mb-4">Bài kiểm tra đã hoàn thành</h2>
                                <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden">
                                    <div class="overflow-x-auto">
                                        <table class="min-w-full divide-y divide-gray-200">
                                            <thead class="bg-gray-50">
                                                <tr>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Tên bài kiểm tra
                                                    </th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Môn học
                                                    </th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Ngày thi
                                                    </th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Thời gian
                                                    </th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Hình thức
                                                    </th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Điểm
                                                    </th>
                                                    <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Thao tác
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody class="bg-white divide-y divide-gray-200">
                                                <tr class="hover:bg-gray-50">
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm font-medium text-gray-900">Kiểm tra Python cơ bản</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">Lập trình Python</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">10/04/2025</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">60 phút</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">Trực tuyến</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-900">8.5/10</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                                        <button class="text-primary hover:text-primary-dark">Xem kết quả</button>
                                                    </td>
                                                </tr>
                                                <tr class="hover:bg-gray-50">
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm font-medium text-gray-900">Kiểm tra HTML/CSS</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">Phát triển ứng dụng web</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">15/04/2025</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">90 phút</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">Trực tiếp</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-900">9.0/10</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                                        <button class="text-primary hover:text-primary-dark">Xem kết quả</button>
                                                    </td>
                                                </tr>
                                                <tr class="hover:bg-gray-50">
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm font-medium text-gray-900">Kiểm tra SQL cơ bản</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">Cơ sở dữ liệu</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">20/04/2025</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">60 phút</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">Trực tuyến</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-900">8.0/10</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                                        <button class="text-primary hover:text-primary-dark">Xem kết quả</button>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="px-6 py-3 bg-gray-50 border-t border-gray-200 flex items-center justify-between">
                                        <div class="text-sm text-gray-500">
                                            Hiển thị 1-3 của 3 bài kiểm tra
                                        </div>
                                        <div class="flex items-center space-x-2">
                                            <button class="px-3 py-1 bg-white border border-gray-200 rounded text-gray-500 hover:bg-gray-50 text-sm disabled:opacity-50 disabled:cursor-not-allowed" disabled>
                                                Trước
                                            </button>
                                            <button class="px-3 py-1 bg-primary text-white rounded text-sm">
                                                1
                                            </button>
                                            <button class="px-3 py-1 bg-white border border-gray-200 rounded text-gray-500 hover:bg-gray-50 text-sm disabled:opacity-50 disabled:cursor-not-allowed" disabled>
                                                Sau
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-content" id="classwork">
                            <!-- Bài tập trên lớp -->
                            <div class="mb-6">
                                <h2 class="text-lg font-semibold text-gray-800 mb-4">Bài tập trên lớp hiện tại</h2>
                                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                                    <!-- Bài tập 1 -->
                                    <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden hover:shadow-md transition-shadow">
                                        <div class="p-4 border-b border-gray-100">
                                            <div class="flex justify-between items-start mb-2">
                                                <div class="flex items-center">
                                                    <div class="w-10 h-10 flex items-center justify-center rounded-lg bg-blue-100 text-blue-600 mr-3 flex-shrink-0">
                                                        <i class="ri-code-s-slash-line"></i>
                                                    </div>
                                                    <div>
                                                        <h3 class="font-medium text-gray-800">Lập trình hướng đối tượng</h3>
                                                        <p class="text-xs text-gray-500">CS201</p>
                                                    </div>
                                                </div>
                                                <span class="px-2.5 py-1 bg-yellow-100 text-yellow-700 text-xs rounded-full">Đang làm</span>
                                            </div>
                                            <h3 class="text-lg font-medium text-gray-800 mb-2">Thực hành Interface trong Java</h3>
                                            <p class="text-sm text-gray-600 mb-3">Bài tập thực hành về interface và abstract class trong Java</p>
                                            <div class="flex items-center text-sm text-gray-500 mb-2">
                                                <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                    <i class="ri-calendar-line"></i>
                                                </div>
                                                <span>Ngày: 25/05/2025</span>
                                            </div>
                                            <div class="flex items-center text-sm text-gray-500">
                                                <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                    <i class="ri-time-line"></i>
                                                </div>
                                                <span>Thời gian: 90 phút</span>
                                            </div>
                                        </div>
                                        <div class="p-4 bg-gray-50 flex justify-between items-center">
                                            <div class="text-sm">
                                                <span class="font-medium text-gray-700">Tiến độ: </span>
                                                <span class="text-gray-600">70%</span>
                                            </div>
                                            <div class="flex gap-2">
                                                <a href="#" class="text-gray-600 hover:text-primary text-sm">Chi tiết</a>
                                                <span class="text-gray-300">|</span>
                                                <button class="text-primary hover:text-primary-dark text-sm font-medium">Tiếp tục</button>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Bài tập 2 -->
                                    <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden hover:shadow-md transition-shadow">
                                        <div class="p-4 border-b border-gray-100">
                                            <div class="flex justify-between items-start mb-2">
                                                <div class="flex items-center">
                                                    <div class="w-10 h-10 flex items-center justify-center rounded-lg bg-purple-100 text-purple-600 mr-3 flex-shrink-0">
                                                        <i class="ri-database-2-line"></i>
                                                    </div>
                                                    <div>
                                                        <h3 class="font-medium text-gray-800">Cơ sở dữ liệu</h3>
                                                        <p class="text-xs text-gray-500">IT305</p>
                                                    </div>
                                                </div>
                                                <span class="px-2.5 py-1 bg-yellow-100 text-yellow-700 text-xs rounded-full">Đang làm</span>
                                            </div>
                                            <h3 class="text-lg font-medium text-gray-800 mb-2">Thực hành Stored Procedure</h3>
                                            <p class="text-sm text-gray-600 mb-3">Bài tập thực hành viết và sử dụng stored procedure trong SQL Server</p>
                                            <div class="flex items-center text-sm text-gray-500 mb-2">
                                                <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                    <i class="ri-calendar-line"></i>
                                                </div>
                                                <span>Ngày: 24/05/2025</span>
                                            </div>
                                            <div class="flex items-center text-sm text-gray-500">
                                                <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                    <i class="ri-time-line"></i>
                                                </div>
                                                <span>Thời gian: 120 phút</span>
                                            </div>
                                        </div>
                                        <div class="p-4 bg-gray-50 flex justify-between items-center">
                                            <div class="text-sm">
                                                <span class="font-medium text-gray-700">Tiến độ: </span>
                                                <span class="text-gray-600">50%</span>
                                            </div>
                                            <div class="flex gap-2">
                                                <a href="#" class="text-gray-600 hover:text-primary text-sm">Chi tiết</a>
                                                <span class="text-gray-300">|</span>
                                                <button class="text-primary hover:text-primary-dark text-sm font-medium">Tiếp tục</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Bài tập trên lớp đã hoàn thành -->
                            <div class="mb-6">
                                <h2 class="text-lg font-semibold text-gray-800 mb-4">Bài tập trên lớp đã hoàn thành</h2>
                                <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden">
                                    <div class="overflow-x-auto">
                                        <table class="min-w-full divide-y divide-gray-200">
                                            <thead class="bg-gray-50">
                                                <tr>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Tên bài tập
                                                    </th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Môn học
                                                    </th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Ngày thực hành
                                                    </th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Thời gian
                                                    </th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Trạng thái
                                                    </th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Điểm
                                                    </th>
                                                    <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Thao tác
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody class="bg-white divide-y divide-gray-200">
                                                <tr class="hover:bg-gray-50">
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm font-medium text-gray-900">Thực hành xử lý ngoại lệ trong Java</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">Lập trình hướng đối tượng</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">18/05/2025</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">90 phút</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <span class="px-2.5 py-1 bg-green-100 text-green-700 text-xs rounded-full">Hoàn thành</span>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-900">9.0/10</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                                        <button class="text-primary hover:text-primary-dark">Xem kết quả</button>
                                                    </td>
                                                </tr>
                                                <tr class="hover:bg-gray-50">
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm font-medium text-gray-900">Thực hành truy vấn SQL</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">Cơ sở dữ liệu</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">15/05/2025</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">120 phút</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <span class="px-2.5 py-1 bg-green-100 text-green-700 text-xs rounded-full">Hoàn thành</span>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-900">8.5/10</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                                        <button class="text-primary hover:text-primary-dark">Xem kết quả</button>
                                                    </td>
                                                </tr>
                                                <tr class="hover:bg-gray-50">
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm font-medium text-gray-900">Thực hành cấu hình DHCP</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">Mạng máy tính</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">10/05/2025</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-500">90 phút</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <span class="px-2.5 py-1 bg-green-100 text-green-700 text-xs rounded-full">Hoàn thành</span>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm text-gray-900">9.5/10</div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                                        <button class="text-primary hover:text-primary-dark">Xem kết quả</button>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="px-6 py-3 bg-gray-50 border-t border-gray-200 flex items-center justify-between">
                                        <div class="text-sm text-gray-500">
                                            Hiển thị 1-3 của 3 bài tập
                                        </div>
                                        <div class="flex items-center space-x-2">
                                            <button class="px-3 py-1 bg-white border border-gray-200 rounded text-gray-500 hover:bg-gray-50 text-sm disabled:opacity-50 disabled:cursor-not-allowed" disabled>
                                                Trước
                                            </button>
                                            <button class="px-3 py-1 bg-primary text-white rounded text-sm">
                                                1
                                            </button>
                                            <button class="px-3 py-1 bg-white border border-gray-200 rounded text-gray-500 hover:bg-gray-50 text-sm disabled:opacity-50 disabled:cursor-not-allowed" disabled>
                                                Sau
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <!-- Mobile Navigation -->
        <div class="md:hidden fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 z-10">
            <div class="flex items-center justify-around">
                <a href="#" class="flex flex-col items-center py-2 text-gray-500">
                    <div class="w-6 h-6 flex items-center justify-center">
                        <i class="ri-dashboard-line"></i>
                    </div>
                    <span class="text-xs mt-1">Trang chủ</span>
                </a>
                <a href="#" class="flex flex-col items-center py-2 text-gray-500">
                    <div class="w-6 h-6 flex items-center justify-center">
                        <i class="ri-book-open-line"></i>
                    </div>
                    <span class="text-xs mt-1">Khóa học</span>
                </a>
                <a href="https://" data-readdy="true" class="flex flex-col items-center py-2 text-gray-500">
                    <div class="w-6 h-6 flex items-center justify-center">
                        <i class="ri-discuss-line"></i>
                    </div>
                    <span class="text-xs mt-1">Diễn đàn</span>
                </a>
                <a href="#" class="flex flex-col items-center py-2 text-primary">
                    <div class="w-6 h-6 flex items-center justify-center">
                        <i class="ri-file-list-3-line"></i>
                    </div>
                    <span class="text-xs mt-1">Bài tập</span>
                </a>
                <a href="#" class="flex flex-col items-center py-2 text-gray-500">
                    <div class="w-6 h-6 flex items-center justify-center">
                        <i class="ri-user-line"></i>
                    </div>
                    <span class="text-xs mt-1">Cá nhân</span>
                </a>
            </div>
        </div>
        <script id="mobileMenuScript">
            document.addEventListener('DOMContentLoaded', function () {
                const menuButton = document.querySelector('.md\\:hidden .ri-menu-line').parentElement;
                const sidebar = document.querySelector('aside');
                menuButton.addEventListener('click', function () {
                    sidebar.classList.toggle('hidden');
                    sidebar.classList.toggle('fixed');
                    sidebar.classList.toggle('z-50');
                    sidebar.classList.toggle('top-0');
                    sidebar.classList.toggle('left-0');
                    sidebar.classList.toggle('h-full');
                });
            });
        </script>
        <script id="dropdownScript">
            document.addEventListener('DOMContentLoaded', function () {
        // Handling dropdown on mobile
                const dropdowns = document.querySelectorAll('.dropdown');
                dropdowns.forEach(dropdown => {
                    const button = dropdown.querySelector('button');
                    const content = dropdown.querySelector('.dropdown-content');
        // For mobile, toggle on click instead of hover
                    if (window.innerWidth < 768) {
                        button.addEventListener('click', function (e) {
                            e.stopPropagation();
        // Close all other dropdowns
                            dropdowns.forEach(otherDropdown => {
                                if (otherDropdown !== dropdown) {
                                    otherDropdown.querySelector('.dropdown-content').style.display = 'none';
                                }
                            });
        // Toggle current dropdown
                            if (content.style.display === 'block') {
                                content.style.display = 'none';
                            } else {
                                content.style.display = 'block';
                            }
                        });
        // Close dropdown when clicking outside
                        document.addEventListener('click', function () {
                            content.style.display = 'none';
                        });
                    }
                });
            });
        </script>
        <style>
            .toast {
                position: fixed;
                bottom: 24px;
                right: 24px;
                padding: 12px 24px;
                background: rgba(0, 0, 0, 0.8);
                color: white;
                border-radius: 8px;
                font-size: 14px;
                transform: translateY(100px);
                opacity: 0;
                transition: all 0.3s ease;
                z-index: 1000;
            }
            .toast.show {
                transform: translateY(0);
                opacity: 1;
            }
        </style>
        <script id="tabScript">
            document.addEventListener('DOMContentLoaded', function () {
                const tabButtons = document.querySelectorAll('.tab-button');
                const tabContents = document.querySelectorAll('.tab-content');
        // Create toast element
                const toast = document.createElement('div');
                toast.className = 'toast';
                toast.textContent = 'Bạn đang ở trang Bài tập/Kiểm tra';
                document.body.appendChild(toast);
        // Handle current page link click
                const currentPageLink = document.querySelector('a[href="#"].text-primary.font-medium');
                if (currentPageLink) {
                    currentPageLink.addEventListener('click', function (e) {
                        e.preventDefault();

                        // Show toast
                        toast.classList.add('show');
                        setTimeout(() => {
                            toast.classList.remove('show');
                        }, 2000);
                        // Add refresh effect to main content
                        const mainContent = document.querySelector('main');
                        if (mainContent) {
                            mainContent.style.opacity = '0.6';
                            mainContent.style.transition = 'opacity 0.3s ease';
                            setTimeout(() => {
                                mainContent.style.opacity = '1';
                            }, 300);
                        }
                    });
                }
                tabButtons.forEach(button => {
                    button.addEventListener('click', () => {
        // Remove active class from all buttons and contents
                        tabButtons.forEach(btn => {
                            btn.classList.remove('text-primary', 'border-b-2', 'border-primary');
                            btn.classList.add('text-gray-500', 'hover:text-gray-700');
                        });
                        tabContents.forEach(content => {
                            content.classList.remove('active');
                        });
        // Add active class to clicked button and corresponding content
                        button.classList.add('text-primary', 'border-b-2', 'border-primary');
                        button.classList.remove('text-gray-500', 'hover:text-gray-700');
                        const tabId = button.getAttribute('data-tab');
                        document.getElementById(tabId).classList.add('active');
                    });
                });
            });
        </script>
    </body>
</html>