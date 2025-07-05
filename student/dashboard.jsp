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

                <main class="flex-1 overflow-y-auto bg-gray-50 p-4 md:p-6 custom-scrollbar md:mt-16">
                    <div class="max-w-7xl mx-auto">
                        <div class="bg-white rounded-lg shadow-sm overflow-hidden mb-6">
                            <div class="p-6 flex flex-col md:flex-row items-center justify-between">
                                <div class="mb-4 md:mb-0">
                                    <h1 class="text-2xl font-bold text-gray-800">Xin chào, Nguyễn Văn Minh!</h1>
                                    <p class="text-gray-600 mt-1">Hôm nay là Chủ nhật, 25 tháng 5, 2025</p>
                                </div>
                                <div class="flex space-x-3">
                                    <button class="bg-primary text-white px-4 py-2 rounded-button flex items-center gap-2 whitespace-nowrap">
                                        <div class="w-5 h-5 flex items-center justify-center">
                                            <i class="ri-video-add-line"></i>
                                        </div>
                                        <span>Tham gia lớp học</span>
                                    </button>
                                    <button class="bg-white border border-gray-300 text-gray-700 px-4 py-2 rounded-button flex items-center gap-2 whitespace-nowrap">
                                        <div class="w-5 h-5 flex items-center justify-center">
                                            <i class="ri-calendar-check-line"></i>
                                        </div>
                                        <span>Lịch học</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
                            <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-100">
                                <div class="flex items-center justify-between mb-4">
                                    <h3 class="text-gray-500 text-sm font-medium">Khóa học đang học</h3>
                                    <div class="w-10 h-10 flex items-center justify-center rounded-full bg-primary/10 text-primary">
                                        <i class="ri-book-open-line"></i>
                                    </div>
                                </div>
                                <p class="text-3xl font-bold text-gray-800">6</p>
                                <p class="text-sm text-gray-500 mt-1">Học kỳ 2, 2024-2025</p>
                            </div>
                            <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-100">
                                <div class="flex items-center justify-between mb-4">
                                    <h3 class="text-gray-500 text-sm font-medium">Bài tập đang chờ</h3>
                                    <div class="w-10 h-10 flex items-center justify-center rounded-full bg-orange-100 text-orange-500">
                                        <i class="ri-file-list-3-line"></i>
                                    </div>
                                </div>
                                <p class="text-3xl font-bold text-gray-800">4</p>
                                <p class="text-sm text-gray-500 mt-1">Cần hoàn thành trong tuần</p>
                            </div>
                            <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-100">
                                <div class="flex items-center justify-between mb-4">
                                    <h3 class="text-gray-500 text-sm font-medium">Thông báo mới</h3>
                                    <div class="w-10 h-10 flex items-center justify-center rounded-full bg-red-100 text-red-500">
                                        <i class="ri-notification-3-line"></i>
                                    </div>
                                </div>
                                <p class="text-3xl font-bold text-gray-800">3</p>
                                <p class="text-sm text-gray-500 mt-1">Chưa đọc</p>
                            </div>
                            <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-100">
                                <div class="flex items-center justify-between mb-4">
                                    <h3 class="text-gray-500 text-sm font-medium">GPA hiện tại</h3>
                                    <div class="w-10 h-10 flex items-center justify-center rounded-full bg-green-100 text-green-500">
                                        <i class="ri-bar-chart-line"></i>
                                    </div>
                                </div>
                                <p class="text-3xl font-bold text-gray-800">3.65</p>
                                <p class="text-sm text-gray-500 mt-1">Thang điểm 4.0</p>
                            </div>
                        </div>
                        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                            <div class="lg:col-span-2">
                                <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden mb-6">
                                    <div class="p-6 border-b border-gray-100">
                                        <div class="flex items-center justify-between">
                                            <h2 class="text-lg font-semibold text-gray-800">Khóa học của tôi</h2>
                                            <a href="#" class="text-sm text-primary hover:underline">Xem tất cả</a>
                                        </div>
                                    </div>
                                    <div class="divide-y divide-gray-100">
                                        <div class="p-6 hover:bg-gray-50">
                                            <div class="flex items-start">
                                                <div class="w-12 h-12 flex items-center justify-center rounded-lg bg-blue-100 text-blue-600 mr-4 flex-shrink-0">
                                                    <i class="ri-code-s-slash-line text-xl"></i>
                                                </div>
                                                <div class="flex-1">
                                                    <div class="flex flex-col md:flex-row md:items-center md:justify-between mb-2">
                                                        <h3 class="text-base font-medium text-gray-800">Lập trình hướng đối tượng</h3>
                                                        <span class="text-xs text-gray-500 mt-1 md:mt-0">CS201 - Phòng A305</span>
                                                    </div>
                                                    <div class="flex flex-col md:flex-row md:items-center text-sm text-gray-500 mb-3">
                                                        <span class="flex items-center">
                                                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                                <i class="ri-user-line"></i>
                                                            </div>
                                                            TS. Trần Minh Tuấn
                                                        </span>
                                                        <span class="md:ml-4 flex items-center mt-1 md:mt-0">
                                                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                                <i class="ri-time-line"></i>
                                                            </div>
                                                            Thứ 2, 7:30 - 10:30
                                                        </span>
                                                    </div>
                                                    <div class="flex flex-col md:flex-row md:items-center justify-between">
                                                        <div class="flex-1 max-w-md">
                                                            <div class="flex items-center justify-between mb-1">
                                                                <span class="text-xs text-gray-500">Tiến độ: 75%</span>
                                                                <span class="text-xs font-medium text-gray-700">15/20 buổi</span>
                                                            </div>
                                                            <progress class="course-progress w-full h-2" value="75" max="100"></progress>
                                                        </div>
                                                        <a href="#" class="mt-3 md:mt-0 md:ml-4 px-4 py-1.5 bg-primary text-white text-sm rounded-button whitespace-nowrap">Vào học</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="p-6 hover:bg-gray-50">
                                            <div class="flex items-start">
                                                <div class="w-12 h-12 flex items-center justify-center rounded-lg bg-purple-100 text-purple-600 mr-4 flex-shrink-0">
                                                    <i class="ri-database-2-line text-xl"></i>
                                                </div>
                                                <div class="flex-1">
                                                    <div class="flex flex-col md:flex-row md:items-center md:justify-between mb-2">
                                                        <h3 class="text-base font-medium text-gray-800">Cơ sở dữ liệu</h3>
                                                        <span class="text-xs text-gray-500 mt-1 md:mt-0">IT305 - Phòng B204</span>
                                                    </div>
                                                    <div class="flex flex-col md:flex-row md:items-center text-sm text-gray-500 mb-3">
                                                        <span class="flex items-center">
                                                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                                <i class="ri-user-line"></i>
                                                            </div>
                                                            PGS.TS. Lê Thị Hương
                                                        </span>
                                                        <span class="md:ml-4 flex items-center mt-1 md:mt-0">
                                                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                                <i class="ri-time-line"></i>
                                                            </div>
                                                            Thứ 4, 13:00 - 16:00
                                                        </span>
                                                    </div>
                                                    <div class="flex flex-col md:flex-row md:items-center justify-between">
                                                        <div class="flex-1 max-w-md">
                                                            <div class="flex items-center justify-between mb-1">
                                                                <span class="text-xs text-gray-500">Tiến độ: 60%</span>
                                                                <span class="text-xs font-medium text-gray-700">12/20 buổi</span>
                                                            </div>
                                                            <progress class="course-progress w-full h-2" value="60" max="100"></progress>
                                                        </div>
                                                        <a href="#" class="mt-3 md:mt-0 md:ml-4 px-4 py-1.5 bg-primary text-white text-sm rounded-button whitespace-nowrap">Vào học</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="p-6 hover:bg-gray-50">
                                            <div class="flex items-start">
                                                <div class="w-12 h-12 flex items-center justify-center rounded-lg bg-green-100 text-green-600 mr-4 flex-shrink-0">
                                                    <i class="ri-terminal-box-line text-xl"></i>
                                                </div>
                                                <div class="flex-1">
                                                    <div class="flex flex-col md:flex-row md:items-center md:justify-between mb-2">
                                                        <h3 class="text-base font-medium text-gray-800">Nhập môn trí tuệ nhân tạo</h3>
                                                        <span class="text-xs text-gray-500 mt-1 md:mt-0">AI101 - Phòng C401</span>
                                                    </div>
                                                    <div class="flex flex-col md:flex-row md:items-center text-sm text-gray-500 mb-3">
                                                        <span class="flex items-center">
                                                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                                <i class="ri-user-line"></i>
                                                            </div>
                                                            GS.TS. Nguyễn Hữu Dũng
                                                        </span>
                                                        <span class="md:ml-4 flex items-center mt-1 md:mt-0">
                                                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                                <i class="ri-time-line"></i>
                                                            </div>
                                                            Thứ 6, 8:00 - 11:00
                                                        </span>
                                                    </div>
                                                    <div class="flex flex-col md:flex-row md:items-center justify-between">
                                                        <div class="flex-1 max-w-md">
                                                            <div class="flex items-center justify-between mb-1">
                                                                <span class="text-xs text-gray-500">Tiến độ: 90%</span>
                                                                <span class="text-xs font-medium text-gray-700">18/20 buổi</span>
                                                            </div>
                                                            <progress class="course-progress w-full h-2" value="90" max="100"></progress>
                                                        </div>
                                                        <a href="#" class="mt-3 md:mt-0 md:ml-4 px-4 py-1.5 bg-primary text-white text-sm rounded-button whitespace-nowrap">Vào học</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="lg:col-span-1">
                                <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden">
                                    <div class="p-6 border-b border-gray-100">
                                        <div class="flex items-center justify-between">
                                            <h2 class="text-lg font-semibold text-gray-800">Bài tập sắp tới</h2>
                                            <a href="#" class="text-sm text-primary hover:underline">Xem tất cả</a>
                                        </div>
                                    </div>
                                    <div class="divide-y divide-gray-100">
                                        <div class="p-6 hover:bg-gray-50">
                                            <h3 class="text-base font-medium text-gray-800 mb-1">Bài tập 3: SQL nâng cao</h3>
                                            <p class="text-sm text-gray-500 mb-2">Môn: Cơ sở dữ liệu</p>
                                            <div class="flex items-center text-sm text-gray-600">
                                                <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                    <i class="ri-calendar-line"></i>
                                                </div>
                                                <span>Hạn nộp: 30/05/2025</span>
                                                <div class="w-4 h-4 flex items-center justify-center ml-4 mr-1">
                                                    <i class="ri-time-line"></i>
                                                </div>
                                                <span>23:59</span>
                                            </div>
                                            <a href="#" class="mt-3 inline-block px-4 py-1.5 bg-primary text-white text-sm rounded-button">Làm bài</a>
                                        </div>
                                        <div class="p-6 hover:bg-gray-50">
                                            <h3 class="text-base font-medium text-gray-800 mb-1">Kiểm tra giữa kỳ</h3>
                                            <p class="text-sm text-gray-500 mb-2">Môn: Lập trình hướng đối tượng</p>
                                            <div class="flex items-center text-sm text-gray-600">
                                                <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                    <i class="ri-calendar-line"></i>
                                                </div>
                                                <span>Ngày thi: 05/06/2025</span>
                                                <div class="w-4 h-4 flex items-center justify-center ml-4 mr-1">
                                                    <i class="ri-time-line"></i>
                                                </div>
                                                <span>14:00</span>
                                            </div>
                                            <a href="#" class="mt-3 inline-block px-4 py-1.5 bg-primary text-white text-sm rounded-button">Xem chi tiết</a>
                                        </div>
                                        <div class="p-6 hover:bg-gray-50">
                                            <h3 class="text-base font-medium text-gray-800 mb-1">Báo cáo cuối kỳ</h3>
                                            <p class="text-sm text-gray-500 mb-2">Môn: Nhập môn trí tuệ nhân tạo</p>
                                            <div class="flex items-center text-sm text-gray-600">
                                                <div class="w-4 h-4 flex items-center justify-center mr-1">
                                                    <i class="ri-calendar-line"></i>
                                                </div>
                                                <span>Hạn nộp: 15/06/2025</span>
                                                <div class="w-4 h-4 flex items-center justify-center ml-4 mr-1">
                                                    <i class="ri-time-line"></i>
                                                </div>
                                                <span>23:59</span>
                                            </div>
                                            <a href="#" class="mt-3 inline-block px-4 py-1.5 bg-primary text-white text-sm rounded-button">Tải đề bài</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script id="mobileMenuScript">
            document.addEventListener('DOMContentLoaded', function () {
                const menuButton = document.querySelector('header .md\\:hidden .ri-menu-line').parentElement;
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
    </body>
</html>