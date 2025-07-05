<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Khóa học - Hệ Thống LMS</title>
    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#4f46e5',
                        secondary: '#6366f1'
                    },
                    borderRadius: {
                        'none': '0px',
                        'sm': '4px',
                        DEFAULT: '8px',
                        'md': '12px',
                        'lg': '16px',
                        'xl': '20px',
                        '2xl': '24px',
                        '3xl': '32px',
                        'full': '9999px',
                        'button': '8px'
                    }
                }
            }
        }
    </script>
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
        .custom-checkbox {
            position: relative;
            display: inline-block;
            width: 20px;
            height: 20px;
        }
        .custom-checkbox input {
            opacity: 0;
            width: 0;
            height: 0;
        }
        .checkmark {
            position: absolute;
            top: 0;
            left: 0;
            width: 20px;
            height: 20px;
            background-color: #fff;
            border: 2px solid #d1d5db;
            border-radius: 4px;
            transition: all 0.2s ease;
        }
        .custom-checkbox input:checked ~ .checkmark {
            background-color: #4f46e5;
            border-color: #4f46e5;
        }
        .checkmark:after {
            content: "";
            position: absolute;
            display: none;
        }
        .custom-checkbox input:checked ~ .checkmark:after {
            display: block;
        }
        .custom-checkbox .checkmark:after {
            left: 6px;
            top: 2px;
            width: 6px;
            height: 12px;
            border: solid white;
            border-width: 0 2px 2px 0;
            transform: rotate(45deg);
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
            border-radius: 34px;
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
        .custom-switch input:checked + .switch-slider {
            background-color: #4f46e5;
        }
        .custom-switch input:checked + .switch-slider:before {
            transform: translateX(20px);
        }

        /* Modal specific styles */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1000; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
            justify-content: center;
            align-items: center;
            padding: 20px; /* Add padding for smaller screens */
        }
        .modal-content {
            background-color: #fefefe;
            margin: auto;
            padding: 30px;
            border-radius: 8px;
            width: 90%;
            max-width: 600px; /* Max width for the form */
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
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
<body class="min-h-screen flex">
<aside class="fixed top-0 left-0 h-screen w-64 bg-white border-r border-gray-200 z-50 hidden lg:flex flex-col justify-between">
    <div class="flex items-center px-6 py-3 border-b border-gray-200">
        <div class="text-2xl font-['Pacifico'] text-primary">logo</div>
    </div>
    <nav class="p-4 space-y-1 flex-1">
        <a href="dashboard.jsp" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button">
            <div class="flex items-center">
                <div class="w-5 h-5 flex items-center justify-center mr-3">
                    <i class="ri-dashboard-line"></i>
                </div>
                <span>Dashboard</span>
            </div>
        </a>
        <a href="courses.jsp" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button">
            <div class="flex items-center">
                <div class="w-5 h-5 flex items-center justify-center mr-3">
                    <i class="ri-book-open-line"></i>
                </div>
                <span>Khóa học</span>
            </div>
        </a>
        <a href="assignments.jsp" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button">
            <div class="flex items-center">
                <div class="w-5 h-5 flex items-center justify-center mr-3">
                    <i class="ri-book-open-line"></i>
                </div>
                <span>Bài tập</span>
            </div>
        </a>
       <a href="grades.jsp" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button">
            <div class="flex items-center">
                <div class="w-5 h-5 flex items-center justify-center mr-3">
                    <i class="ri-book-open-line"></i>
                </div>
                <span>Điểm số</span>
            </div>
        </a>
        <a href="forum.jsp" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button">
            <div class="flex items-center">
                <div class="w-5 h-5 flex items-center justify-center mr-3">
                    <i class="ri-book-open-line"></i>
                </div>
                <span>Diễn đàn</span>
            </div>
        </a>
        <a href="materials.jsp" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button">
            <div class="flex items-center">
                <div class="w-5 h-5 flex items-center justify-center mr-3">
                    <i class="ri-book-open-line"></i>
                </div>
                <span>Tài liệu</span>
            </div>
        </a>
        <a href="settings.jsp" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button">
            <div class="flex items-center">
                <div class="w-5 h-5 flex items-center justify-center mr-3">
                    <i class="ri-book-open-line"></i>
                </div>
                <span>Cài đặt</span>
            </div>
        </a>
    </nav>
    <div class="p-4 border-t border-gray-200">
        <div class="flex items-center gap-3 mb-3 px-3">
            <div class="w-10 h-10 rounded-full overflow-hidden bg-gray-100 border">
                <img src="https://readdy.ai/api/search-image?query=professional%20headshot%20of%20a%20Vietnamese%20female%20teacher%20with%20glasses%2C%20smiling%2C%20professional%20attire%2C%20neutral%20background%2C%20high%20quality%20portrait&width=200&height=200&seq=1&orientation=squarish" alt="Avatar" class="w-full h-full object-cover">
            </div>
            <div class="flex-1 min-w-0">
                <p class="text-sm font-medium text-gray-900 truncate">Nguyễn Thị Minh</p>
                <p class="text-xs text-gray-500 truncate">Giảng viên</p>
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
<header class="bg-white shadow-sm fixed top-0 left-0 right-0 z-50">
    <div class="flex items-center justify-between px-6 py-3">
        <div class="flex items-center">
            <button class="p-2 text-gray-600 hover:text-primary rounded-full lg:hidden">
                <div class="w-6 h-6 flex items-center justify-center">
                    <i class="ri-menu-line"></i>
                </div>
            </button>
            <div class="text-2xl font-['Pacifico'] text-primary ml-2">logo</div>
        </div>
        <div class="flex items-center space-x-4">
            <button class="relative p-2 text-gray-600 hover:text-primary rounded-full">
                <div class="w-6 h-6 flex items-center justify-center">
                    <i class="ri-search-line"></i>
                </div>
            </button>
            <button class="relative p-2 text-gray-600 hover:text-primary rounded-full">
                <div class="w-6 h-6 flex items-center justify-center">
                    <i class="ri-notification-3-line"></i>
                </div>
                <span class="absolute top-1 right-1 w-4 h-4 bg-red-500 text-white text-xs flex items-center justify-center rounded-full">5</span>
            </button>
            <div class="relative">
                <button class="flex items-center space-x-2">
                    <div class="w-9 h-9 rounded-full overflow-hidden bg-gray-100 border">
                        <img src="https://readdy.ai/api/search-image?query=professional%20headshot%20of%20a%20Vietnamese%20female%20teacher%20with%20glasses%2C%20smiling%2C%20professional%20attire%2C%20neutral%20background%2C%20high%20quality%20portrait&width=200&height=200&seq=1&orientation=squarish" alt="Avatar" class="w-full h-full object-cover">
                    </div>
                    <div class="hidden md:block text-left">
                        <p class="text-sm font-medium text-gray-800">Nguyễn Thị Minh</p>
                        <p class="text-xs text-gray-500">Giảng viên</p>
                    </div>
                    <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                        <i class="ri-arrow-down-s-line"></i>
                    </div>
                </button>
            </div>
            <button class="md:hidden p-2 text-gray-600 hover:text-primary rounded-full">
                <div class="w-6 h-6 flex items-center justify-center">
                    <i class="ri-menu-line"></i>
                </div>
            </button>
        </div>
    </div>
</header>

<main class="flex-1 pt-16 pb-8 px-4 md:px-6 lg:ml-64">
    <div class="max-w-7xl mx-auto">
        <div class="my-6 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
            <div>
                <h1 class="text-2xl font-bold text-gray-900">Quản lý Khóa học</h1>
                <p class="text-sm text-gray-500 mt-1">Danh sách các khóa học bạn đang giảng dạy.</p>
            </div>
            <button id="createCourseBtn" class="px-4 py-2 bg-primary text-white text-sm font-medium rounded-button hover:bg-primary/90 flex items-center gap-2">
                <i class="ri-add-line"></i>
                <span>Tạo khóa học mới</span>
            </button>
        </div>

        <div class="bg-white rounded-lg shadow-sm p-5 border border-gray-100 mb-6 flex flex-col sm:flex-row items-center justify-between gap-4">
            <div class="relative w-full sm:w-auto flex-1">
                <input type="text" placeholder="Tìm kiếm khóa học..." class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-button focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm">
                <i class="ri-search-line absolute left-3 top-1/2 -translate-y-1/2 text-gray-400"></i>
            </div>
            <div class="w-full sm:w-auto">
                <select class="w-full sm:w-auto px-4 py-2 border border-gray-300 rounded-button text-sm text-gray-700 focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent">
                    <option value="all">Tất cả trạng thái</option>
                    <option value="ongoing">Đang diễn ra</option>
                    <option value="finished">Đã kết thúc</option>
                </select>
            </div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
            <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-5 hover:shadow-md transition-shadow">
                <div class="flex items-start justify-between mb-4">
                    <div class="flex items-center gap-3">
                        <div class="w-12 h-12 flex items-center justify-center rounded-lg bg-primary/10 text-primary">
                            <i class="ri-code-line ri-lg"></i>
                        </div>
                        <div>
                            <h3 class="font-medium text-gray-900">Lập trình web nâng cao</h3>
                            <p class="text-sm text-gray-500">CS401 • 60 sinh viên</p>
                        </div>
                    </div>
                    <div class="px-2 py-1 text-xs font-medium bg-green-100 text-green-700 rounded-full">Đang diễn ra</div>
                </div>
                <div class="mb-4">
                    <div class="flex justify-between text-xs mb-1">
                        <span class="font-medium text-gray-700">Tiến độ</span>
                        <span class="text-gray-500">65%</span>
                    </div>
                    <div class="w-full bg-gray-200 rounded-full h-2">
                        <div class="bg-primary h-2 rounded-full" style="width: 65%"></div>
                    </div>
                </div>
                <div class="flex flex-col sm:flex-row gap-2 justify-end">
                    <button class="px-3 py-1.5 text-sm font-medium text-primary hover:bg-primary/5 border border-primary rounded-button whitespace-nowrap">Vào lớp</button>
                    <button class="px-3 py-1.5 text-sm font-medium text-gray-700 hover:bg-gray-50 border border-gray-300 rounded-button whitespace-nowrap">Chỉnh sửa</button>
                    <button class="px-3 py-1.5 text-sm font-medium text-gray-700 hover:bg-gray-50 border border-gray-300 rounded-button whitespace-nowrap">Xem chi tiết</button>
                </div>
            </div>

            <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-5 hover:shadow-md transition-shadow">
                <div class="flex items-start justify-between mb-4">
                    <div class="flex items-center gap-3">
                        <div class="w-12 h-12 flex items-center justify-center rounded-lg bg-blue-500/10 text-blue-500">
                            <i class="ri-database-2-line ri-lg"></i>
                        </div>
                        <div>
                            <h3 class="font-medium text-gray-900">Cơ sở dữ liệu</h3>
                            <p class="text-sm text-gray-500">CS203 • 48 sinh viên</p>
                        </div>
                    </div>
                    <div class="px-2 py-1 text-xs font-medium bg-green-100 text-green-700 rounded-full">Đang diễn ra</div>
                </div>
                <div class="mb-4">
                    <div class="flex justify-between text-xs mb-1">
                        <span class="font-medium text-gray-700">Tiến độ</span>
                        <span class="text-gray-500">45%</span>
                    </div>
                    <div class="w-full bg-gray-200 rounded-full h-2">
                        <div class="bg-blue-500 h-2 rounded-full" style="width: 45%"></div>
                    </div>
                </div>
                <div class="flex flex-col sm:flex-row gap-2 justify-end">
                    <button class="px-3 py-1.5 text-sm font-medium text-primary hover:bg-primary/5 border border-primary rounded-button whitespace-nowrap">Vào lớp</button>
                    <button class="px-3 py-1.5 text-sm font-medium text-gray-700 hover:bg-gray-50 border border-gray-300 rounded-button whitespace-nowrap">Chỉnh sửa</button>
                    <button class="px-3 py-1.5 text-sm font-medium text-gray-700 hover:bg-gray-50 border border-gray-300 rounded-button whitespace-nowrap">Xem chi tiết</button>
                </div>
            </div>

            <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-5 hover:shadow-md transition-shadow">
                <div class="flex items-start justify-between mb-4">
                    <div class="flex items-center gap-3">
                        <div class="w-12 h-12 flex items-center justify-center rounded-lg bg-amber-500/10 text-amber-500">
                            <i class="ri-terminal-box-line ri-lg"></i>
                        </div>
                        <div>
                            <h3 class="font-medium text-gray-900">Lập trình Java</h3>
                            <p class="text-sm text-gray-500">CS202 • 55 sinh viên</p>
                        </div>
                    </div>
                    <div class="px-2 py-1 text-xs font-medium bg-green-100 text-green-700 rounded-full">Đang diễn ra</div>
                </div>
                <div class="mb-4">
                    <div class="flex justify-between text-xs mb-1">
                        <span class="font-medium text-gray-700">Tiến độ</span>
                        <span class="text-gray-500">80%</span>
                    </div>
                    <div class="w-full bg-gray-200 rounded-full h-2">
                        <div class="bg-amber-500 h-2 rounded-full" style="width: 80%"></div>
                    </div>
                </div>
                <div class="flex flex-col sm:flex-row gap-2 justify-end">
                    <button class="px-3 py-1.5 text-sm font-medium text-primary hover:bg-primary/5 border border-primary rounded-button whitespace-nowrap">Vào lớp</button>
                    <button class="px-3 py-1.5 text-sm font-medium text-gray-700 hover:bg-gray-50 border border-gray-300 rounded-button whitespace-nowrap">Chỉnh sửa</button>
                    <button class="px-3 py-1.5 text-sm font-medium text-gray-700 hover:bg-gray-50 border border-gray-300 rounded-button whitespace-nowrap">Xem chi tiết</button>
                </div>
            </div>

            <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-5 hover:shadow-md transition-shadow">
                <div class="flex items-start justify-between mb-4">
                    <div class="flex items-center gap-3">
                        <div class="w-12 h-12 flex items-center justify-center rounded-lg bg-emerald-500/10 text-emerald-500">
                            <i class="ri-cloud-line ri-lg"></i>
                        </div>
                        <div>
                            <h3 class="font-medium text-gray-900">Điện toán đám mây</h3>
                            <p class="text-sm text-gray-500">CS405 • 38 sinh viên</p>
                        </div>
                    </div>
                    <div class="px-2 py-1 text-xs font-medium bg-green-100 text-green-700 rounded-full">Đang diễn ra</div>
                </div>
                <div class="mb-4">
                    <div class="flex justify-between text-xs mb-1">
                        <span class="font-medium text-gray-700">Tiến độ</span>
                        <span class="text-gray-500">30%</span>
                    </div>
                    <div class="w-full bg-gray-200 rounded-full h-2">
                        <div class="bg-emerald-500 h-2 rounded-full" style="width: 30%"></div>
                    </div>
                </div>
                <div class="flex flex-col sm:flex-row gap-2 justify-end">
                    <button class="px-3 py-1.5 text-sm font-medium text-primary hover:bg-primary/5 border border-primary rounded-button whitespace-nowrap">Vào lớp</button>
                    <button class="px-3 py-1.5 text-sm font-medium text-gray-700 hover:bg-gray-50 border border-gray-300 rounded-button whitespace-nowrap">Chỉnh sửa</button>
                    <button class="px-3 py-1.5 text-sm font-medium text-gray-700 hover:bg-gray-50 border border-gray-300 rounded-button whitespace-nowrap">Xem chi tiết</button>
                </div>
            </div>

            <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-5 hover:shadow-md transition-shadow">
                <div class="flex items-start justify-between mb-4">
                    <div class="flex items-center gap-3">
                        <div class="w-12 h-12 flex items-center justify-center rounded-lg bg-red-500/10 text-red-500">
                            <i class="ri-file-code-line ri-lg"></i>
                        </div>
                        <div>
                            <h3 class="font-medium text-gray-900">Nhập môn Lập trình C++</h3>
                            <p class="text-sm text-gray-500">CS101 • 75 sinh viên</p>
                        </div>
                    </div>
                    <div class="px-2 py-1 text-xs font-medium bg-gray-200 text-gray-700 rounded-full">Đã kết thúc</div>
                </div>
                <div class="mb-4">
                    <div class="flex justify-between text-xs mb-1">
                        <span class="font-medium text-gray-700">Tiến độ</span>
                        <span class="text-gray-500">100%</span>
                    </div>
                    <div class="w-full bg-gray-200 rounded-full h-2">
                        <div class="bg-red-500 h-2 rounded-full" style="width: 100%"></div>
                    </div>
                </div>
                <div class="flex flex-col sm:flex-row gap-2 justify-end">
                    <button class="px-3 py-1.5 text-sm font-medium text-primary hover:bg-primary/5 border border-primary rounded-button whitespace-nowrap" disabled>Vào lớp</button>
                    <button class="px-3 py-1.5 text-sm font-medium text-gray-700 hover:bg-gray-50 border border-gray-300 rounded-button whitespace-nowrap">Chỉnh sửa</button>
                    <button class="px-3 py-1.5 text-sm font-medium text-gray-700 hover:bg-gray-50 border border-gray-300 rounded-button whitespace-nowrap">Xem chi tiết</button>
                </div>
            </div>

            <div id="no-results" class="col-span-1 md:col-span-2 bg-white rounded-lg shadow-sm border border-gray-100 p-5 text-center text-gray-500 hidden">
                <p class="text-lg font-medium mb-2">Không tìm thấy khóa học nào.</p>
                <p class="text-sm">Vui lòng thử lại với từ khóa khác hoặc điều chỉnh bộ lọc.</p>
            </div>
        </div>

        <div class="flex flex-col sm:flex-row justify-between items-center gap-4 py-4">
            <div class="text-sm text-gray-700">
                Hiển thị <span class="font-semibold">1-5</span> trong tổng số <span class="font-semibold">10</span> khóa học
            </div>
            <div class="flex items-center space-x-2">
                <button class="px-3 py-1.5 text-sm font-medium text-gray-700 hover:bg-gray-100 rounded-button disabled:opacity-50 disabled:cursor-not-allowed" disabled>
                    <i class="ri-arrow-left-s-line"></i> Trước
                </button>
                <button class="px-3 py-1.5 text-sm font-medium text-white bg-primary hover:bg-primary/90 rounded-button">1</button>
                <button class="px-3 py-1.5 text-sm font-medium text-gray-700 hover:bg-gray-100 rounded-button">2</button>
                <button class="px-3 py-1.5 text-sm font-medium text-gray-700 hover:bg-gray-100 rounded-button">3</button>
                <button class="px-3 py-1.5 text-sm font-medium text-gray-700 hover:bg-gray-100 rounded-button">
                    Tiếp <i class="ri-arrow-right-s-line"></i>
                </button>
            </div>
        </div>

    </div>
</main>

<div id="createCourseModal" class="modal">
    <div class="modal-content">
        <span class="close-button">&times;</span>
        <h2 class="text-2xl font-bold text-gray-900 mb-6">Tạo khóa học mới</h2>
        <form action="#" method="POST" class="space-y-4">
            <div>
                <label for="courseCode" class="block text-sm font-medium text-gray-700">Mã khóa học</label>
                <input type="text" id="courseCode" name="courseCode" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary focus:border-primary sm:text-sm" required>
            </div>
            <div>
                <label for="courseName" class="block text-sm font-medium text-gray-700">Tên khóa học</label>
                <input type="text" id="courseName" name="courseName" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary focus:border-primary sm:text-sm" required>
            </div>
            <div>
                <label for="studentCount" class="block text-sm font-medium text-gray-700">Số lượng sinh viên dự kiến</label>
                <input type="number" id="studentCount" name="studentCount" min="0" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary focus:border-primary sm:text-sm">
            </div>
            <div>
                <label for="description" class="block text-sm font-medium text-gray-700">Mô tả</label>
                <textarea id="description" name="description" rows="3" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary focus:border-primary sm:text-sm"></textarea>
            </div>
            <div class="flex justify-end gap-3 pt-4">
                <button type="button" id="cancelCreateCourse" class="px-4 py-2 bg-gray-200 text-gray-800 text-sm font-medium rounded-button hover:bg-gray-300">Hủy</button>
                <button type="submit" class="px-4 py-2 bg-primary text-white text-sm font-medium rounded-button hover:bg-primary/90">Tạo khóa học</button>
            </div>
        </form>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const createCourseBtn = document.getElementById('createCourseBtn');
        const createCourseModal = document.getElementById('createCourseModal');
        const closeButton = createCourseModal.querySelector('.close-button');
        const cancelCreateCourseBtn = document.getElementById('cancelCreateCourse');

        // Function to open the modal
        function openModal() {
            createCourseModal.style.display = 'flex'; // Use flex to center
        }

        // Function to close the modal
        function closeModal() {
            createCourseModal.style.display = 'none';
        }

        // Event listener for "Tạo khóa học mới" button
        if (createCourseBtn) {
            createCourseBtn.addEventListener('click', openModal);
        }

        // Event listener for the close button (x)
        if (closeButton) {
            closeButton.addEventListener('click', closeModal);
        }

        // Event listener for the "Hủy" button inside the modal
        if (cancelCreateCourseBtn) {
            cancelCreateCourseBtn.addEventListener('click', closeModal);
        }

        // Close the modal if clicked outside of the modal content
        if (createCourseModal) {
            createCourseModal.addEventListener('click', function(event) {
                if (event.target === createCourseModal) {
                    closeModal();
                }
            });
        }

        // --- Example for other buttons (Chỉnh sửa, Xem chi tiết, Vào lớp) ---
        // These would typically involve fetching data or navigating.
        // For demonstration, we'll just log to console.

        const editButtons = document.querySelectorAll('.course-card-buttons button:nth-child(2)'); // "Chỉnh sửa"
        const viewDetailButtons = document.querySelectorAll('.course-card-buttons button:nth-child(3)'); // "Xem chi tiết"
        const enterClassButtons = document.querySelectorAll('.course-card-buttons button:nth-child(1)'); // "Vào lớp"

        enterClassButtons.forEach(button => {
            button.addEventListener('click', function() {
                // In a real application, you'd navigate to the class page or open a class-specific modal
                if (!this.disabled) {
                    alert('Bạn đã vào lớp!'); // Placeholder action
                    console.log('Vào lớp clicked');
                }
            });
        });

        editButtons.forEach(button => {
            button.addEventListener('click', function() {
                // In a real application, you'd open an "Edit Course" modal populated with existing data
                alert('Mở form chỉnh sửa khóa học này!'); // Placeholder action
                console.log('Chỉnh sửa clicked');
            });
        });

        viewDetailButtons.forEach(button => {
            button.addEventListener('click', function() {
                // In a real application, you'd navigate to a dedicated course detail page or open a detail modal
                alert('Mở trang chi tiết khóa học này!'); // Placeholder action
                console.log('Xem chi tiết clicked');
            });
        });

        // Pagination buttons (already linked to no specific action, just visual)
        // You would typically handle these with JavaScript to load new data via AJAX or change URL params
        const paginationButtons = document.querySelectorAll('.flex.items-center.space-x-2 button');
        paginationButtons.forEach(button => {
            button.addEventListener('click', function() {
                if (!this.disabled) {
                    // Example: simulate page change
                    console.log('Pagination button clicked:', this.textContent.trim());
                    // In a real app, this would trigger data loading for the selected page
                }
            });
        });
    });
</script>

</body>
</html>