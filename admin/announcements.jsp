<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduLearn LMS - Quản Lý Thông Báo</title>
    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#4F46E5',
                        secondary: '#818CF8'
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
        /* Remixicon fix - ensure icons display correctly */
        [class^="ri-"]::before, [class*=" ri-"]::before {
            font-family: "remixicon" !important;
            font-style: normal;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #f9fafb;
        }
        .sidebar-link.active {
            background-color: rgba(79, 70, 229, 0.1);
            color: #4F46E5;
            border-left: 3px solid #4F46E5;
        }
        input[type="checkbox"] {
            appearance: none;
            -webkit-appearance: none;
            height: 20px;
            width: 20px;
            background-color: #fff;
            border: 1px solid #d1d5db;
            border-radius: 4px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        input[type="checkbox"]:checked {
            background-color: #4F46E5;
            border-color: #4F46E5;
        }
        input[type="checkbox"]:checked::after {
            content: "";
            width: 10px;
            height: 10px;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='white' viewBox='0 0 24 24'%3E%3Cpath d='M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41L9 16.17z'/%3E%3C/svg%3E");
            background-size: contain;
            background-repeat: no-repeat;
        }
        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
        .switch {
            position: relative;
            display: inline-block;
            width: 44px;
            height: 24px;
        }
        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }
        .slider {
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
        .slider:before {
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
        input:checked + .slider {
            background-color: #4F46E5;
        }
        input:checked + .slider:before {
            transform: translateX(20px);
        }
        .custom-scrollbar::-webkit-scrollbar {
            width: 6px;
        }
        .custom-scrollbar::-webkit-scrollbar-track {
            background: #f1f1f1;
        }
        .custom-scrollbar::-webkit-scrollbar-thumb {
            background: #c5c5c5;
            border-radius: 10px;
        }
        .custom-scrollbar::-webkit-scrollbar-thumb:hover {
            background: #a3a3a3;
        }
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
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .modal-content {
            background-color: #fefefe;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            width: 90%;
            max-width: 700px; /* Increased max-width for rich text editor */
            position: relative;
        }
        .close-button {
            color: #aaa;
            position: absolute;
            top: 10px;
            right: 15px;
            font-size: 28px;
            font-weight: bold;
        }
        .close-button:hover,
        .close-button:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        /* Rich Text Editor placeholder for demonstration */
        .rich-text-editor {
            min-height: 150px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            padding: 10px;
            font-size: 0.875rem; /* text-sm */
            line-height: 1.5;
            resize: vertical;
            overflow-y: auto;
            background-color: #fff;
        }
        .rich-text-editor:focus-within {
             outline: none;
             border-color: #4F46E5; /* primary */
             box-shadow: 0 0 0 1px #4F46E5;
        }
        /* Category tag styling */
        .category-tag {
            display: inline-flex;
            align-items: center;
            padding: 0.25rem 0.6rem;
            border-radius: 9999px; /* full */
            font-size: 0.75rem; /* text-xs */
            font-weight: 500; /* font-medium */
            text-transform: uppercase;
            letter-spacing: 0.05em; /* tracking-wider */
        }
        .category-academic { background-color: #e0f2fe; color: #0284c7; } /* light blue, blue */
        .category-administrative { background-color: #fef9c3; color: #a16207; } /* light yellow, yellow */
        .category-events { background-color: #eef2ff; color: #4f46e5; } /* light indigo, primary */
        .category-general { background-color: #e5e7eb; color: #4b5563; } /* light gray, gray */
    </style>
</head>
<body class="flex h-screen overflow-hidden">
    <!-- Sidebar -->
    <aside class="w-64 h-full bg-white shadow-md flex-shrink-0 flex flex-col z-10">
        <div class="p-4 border-b flex items-center">
            <span class="text-2xl font-['Pacifico'] text-primary">logo</span>
            <span class="ml-2 font-semibold text-gray-800">EduLearn</span>
        </div>
        
        <div class="p-4">
            <div class="flex items-center space-x-3 mb-6">
                <div class="w-10 h-10 rounded-full bg-primary flex items-center justify-center text-white">
                    <span class="font-medium">JD</span>
                </div>
                <div>
                    <h3 class="font-medium text-gray-800">John Doe</h3>
                    <p class="text-xs text-gray-500">Admin</p>
                </div>
            </div>
        </div>
        
        <nav class="flex-1 overflow-y-auto custom-scrollbar">
            <div class="px-4 py-2">
                <h3 class="text-xs font-semibold text-gray-500 uppercase tracking-wider">Main</h3>
                <div class="mt-2 space-y-1">
                    <a href="dashboard.html" class="sidebar-link  flex items-center px-3 py-2 text-sm font-medium rounded-md">
                        <div class="w-5 h-5 mr-3 flex items-center justify-center">
                            <i class="ri-dashboard-line"></i>
                        </div>
                        Trang Chủ
                    </a>
                    <a href="users.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium text-gray-600 rounded-md hover:bg-gray-50">
                        <div class="w-5 h-5 mr-3 flex items-center justify-center">
                            <i class="ri-user-line"></i>
                        </div>
                        Người Dùng
                    </a>
                    <a href="coursers.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium text-gray-600 rounded-md hover:bg-gray-50">
                        <div class="w-5 h-5 mr-3 flex items-center justify-center">
                            <i class="ri-book-open-line"></i>
                        </div>
                        Môn Học
                    </a>
                </div>
            </div>
            
            <div class="px-4 py-2 mt-2">
                <h3 class="text-xs font-semibold text-gray-500 uppercase tracking-wider">Academic</h3>
                <div class="mt-2 space-y-1">
                    <a href="semesters.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium text-gray-600 rounded-md hover:bg-gray-50">
                        <div class="w-5 h-5 mr-3 flex items-center justify-center">
                            <i class="ri-calendar-line"></i>
                        </div>
                        Học Kỳ
                    </a>

                    <a href="assignments.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium text-gray-600 rounded-md hover:bg-gray-50">
                        <div class="w-5 h-5 mr-3 flex items-center justify-center">
                            <i class="ri-file-list-line"></i>
                        </div>
                        Bài Kiểm Tra
                    </a>
                    <a href="grades.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium text-gray-600 rounded-md hover:bg-gray-50">
                        <div class="w-5 h-5 mr-3 flex items-center justify-center">
                            <i class="ri-bar-chart-line"></i>
                        </div>
                        Điểm
                    </a>
                </div>
            </div>
            
            <div class="px-4 py-2 mt-2">
                <h3 class="text-xs font-semibold text-gray-500 uppercase tracking-wider">Communication</h3>
                <div class="mt-2 space-y-1">

                    <a href="forums.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium text-gray-600 rounded-md hover:bg-gray-50">
                        <div class="w-5 h-5 mr-3 flex items-center justify-center">
                            <i class="ri-discuss-line"></i>
                        </div>
                        Diễn Đàn
                    </a>
                    <a href="announcements.jsp" class="sidebar-link active flex items-center px-3 py-2 text-sm font-medium text-gray-600 rounded-md hover:bg-gray-50">
                        <div class="w-5 h-5 mr-3 flex items-center justify-center">
                            <i class="ri-notification-3-line"></i>
                        </div>
                        Thông báo
                    </a>
                </div>
            </div>
            
            <div class="px-4 py-2 mt-2">
                <h3 class="text-xs font-semibold text-gray-500 uppercase tracking-wider">System</h3>
                <div class="mt-2 space-y-1">
                    <a href="settings.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium text-gray-600 rounded-md hover:bg-gray-50">
                        <div class="w-5 h-5 mr-3 flex items-center justify-center">
                            <i class="ri-settings-line"></i>
                        </div>
                        Cài Đặt
                    </a>
                    <a href="helpcenter.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium text-gray-600 rounded-md hover:bg-gray-50">
                        <div class="w-5 h-5 mr-3 flex items-center justify-center">
                            <i class="ri-question-line"></i>
                        </div>
                        Hướng Dẫn
                    </a>
                </div>
            </div>
        </nav>
        
       <div class="p-4 border-t">
    <a href="/LMSS" class="flex items-center justify-center w-full px-4 py-2 text-sm font-medium text-gray-700 bg-gray-100 rounded-button hover:bg-gray-200 whitespace-nowrap" style="text-decoration:none;">
        <div class="w-5 h-5 mr-2 flex items-center justify-center">
            <i class="ri-logout-box-line"></i>
        </div>
        Đăng Xuất
    </a>
</div>

    </aside>
<div class="flex-1 flex flex-col">
    <header class="bg-white shadow-sm px-6 py-4 flex justify-between items-center border-b">
        <div class="flex items-center w-1/2">
            <input type="text" placeholder="Search for courses, users..." class="w-full border border-gray-300 rounded px-3 py-2 text-sm" />
        </div>
        <div class="flex items-center space-x-4">
            <div class="relative">
                <i class="ri-notification-3-line text-xl"></i>
                <span class="absolute -top-2 -right-2 bg-red-500 text-white text-xs rounded-full px-1">3</span>
            </div>
            <div class="relative">
                <i class="ri-flag-line text-xl"></i>
                <span class="absolute -top-2 -right-2 bg-blue-500 text-white text-xs rounded-full px-1">5</span>
            </div>
            <div class="flex items-center space-x-2">
                <div class="w-8 h-8 rounded-full bg-blue-600 text-white flex items-center justify-center text-sm font-medium">JD</div>
                <span class="text-sm font-medium">John Doe</span>
            </div>
        </div>
    </header>
    <main class="flex-1 p-8 overflow-auto">
        <nav class="text-sm text-gray-500 mb-4" aria-label="Breadcrumb">
            <ol class="list-none p-0 inline-flex">
                <li class="flex items-center">
                    <a href="dashboard.html" class="text-blue-600 hover:text-blue-800">Trang Chủ</a>
                    <i class="ri-arrow-right-s-line mx-2"></i>
                </li>
                <li>
                    <span class="text-gray-700">Quản lý Thông Báo</span>
                </li>
            </ol>
        </nav>

        <div class="flex justify-between items-center mb-6">
            <div>
                <h1 class="text-2xl font-bold text-gray-800">Quản lý Thông Báo</h1>
                <p class="text-gray-600 text-sm">Tạo, chỉnh sửa và quản lý các thông báo cho người dùng hệ thống.</p>
            </div>
            <button id="createAnnouncementBtn" class="bg-primary text-white px-4 py-2 rounded-button hover:bg-primary/90 text-sm font-medium flex items-center gap-1">
                <i class="ri-add-line text-lg"></i> Tạo Thông Báo Mới
            </button>
        </div>

        <div class="bg-white shadow rounded-lg p-4 mb-6 flex flex-col md:flex-row items-center gap-4">
            <input type="text" placeholder="Tìm kiếm thông báo..." class="flex-grow border px-3 py-2 rounded-md text-sm focus:ring-primary focus:border-primary">
            <input type="date" class="border px-3 py-2 rounded-md text-sm focus:ring-primary focus:border-primary">
            <input type="date" class="border px-3 py-2 rounded-md text-sm focus:ring-primary focus:border-primary">
            <select class="border px-3 py-2 rounded-md text-sm focus:ring-primary focus:border-primary bg-white">
                <option value="">Tất cả danh mục</option>
                <option value="academic">Học thuật</option>
                <option value="administrative">Hành chính</option>
                <option value="events">Sự kiện</option>
                <option value="general">Chung</option>
            </select>
            <select class="border px-3 py-2 rounded-md text-sm focus:ring-primary focus:border-primary bg-white">
                <option value="">Sắp xếp theo</option>
                <option value="newest">Mới nhất</option>
                <option value="oldest">Cũ nhất</option>
                <option value="relevant">Liên quan nhất</option>
            </select>
        </div>

        <div class="flex flex-wrap items-center gap-2 mb-4 text-sm">
            <span class="text-gray-700 font-medium">Hiển thị 3 trên 5 thông báo</span>
            <div id="active-filters" class="flex flex-wrap gap-2 ml-4">
                <span class="bg-gray-200 text-gray-700 px-2 py-1 rounded-full flex items-center">
                    Category: Học thuật <button class="ml-1 text-gray-500 hover:text-gray-700"><i class="ri-close-line text-xs"></i></button>
                </span>
                <span class="bg-gray-200 text-gray-700 px-2 py-1 rounded-full flex items-center">
                    Date: 01/07/2025 <button class="ml-1 text-gray-500 hover:text-gray-700"><i class="ri-close-line text-xs"></i></button>
                </span>
            </div>
            <button class="text-primary hover:underline text-sm ml-auto">Xóa tất cả bộ lọc</button>
        </div>

        <div id="announcementList" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <div class="bg-white shadow rounded-lg p-6 border border-gray-200 hover:shadow-md transition-shadow duration-200 cursor-pointer announcement-card">
                <div class="flex justify-between items-start mb-3">
                    <h3 class="text-lg font-semibold text-gray-800 leading-tight">Thông báo quan trọng về lịch thi cuối kỳ</h3>
                    <span class="category-tag category-academic">Học thuật</span>
                </div>
                <p class="text-gray-600 text-sm mb-3 line-clamp-3">Xin thông báo về việc thay đổi lịch thi cuối kỳ cho tất cả các môn học. Sinh viên vui lòng kiểm tra email và cổng thông tin sinh viên để cập nhật lịch trình mới nhất...</p>
                <div class="flex flex-wrap items-center justify-between text-xs text-gray-500 mt-4 pt-4 border-t border-gray-100">
                    <div class="flex items-center space-x-3">
                        <span class="flex items-center"><i class="ri-time-line mr-1"></i> Đăng: 01/07/2025 10:00 AM</span>
                        <span class="flex items-center"><i class="ri-group-line mr-1"></i> Đối tượng: <span class="font-medium">Sinh viên, Giảng viên</span></span>
                    </div>
                    <div class="flex items-center space-x-2 mt-2 md:mt-0">
                        <button class="text-blue-600 hover:text-blue-800 text-sm font-medium edit-btn"><i class="ri-edit-line mr-1"></i>Sửa</button>
                        <button class="text-red-600 hover:text-red-800 text-sm font-medium delete-btn"><i class="ri-delete-bin-line mr-1"></i>Xóa</button>
                    </div>
                </div>
            </div>

            <div class="bg-white shadow rounded-lg p-6 border border-gray-200 hover:shadow-md transition-shadow duration-200 cursor-pointer announcement-card">
                <div class="flex justify-between items-start mb-3">
                    <h3 class="text-lg font-semibold text-gray-800 leading-tight">Sự kiện chào đón tân sinh viên 2025</h3>
                    <span class="category-tag category-events">Sự kiện</span>
                </div>
                <p class="text-gray-600 text-sm mb-3 line-clamp-3">Ban tổ chức xin trân trọng thông báo về chương trình chào đón tân sinh viên khóa 2025 sẽ diễn ra vào ngày 15/08/2025 tại Sân vận động trường...</p>
                <div class="flex flex-wrap items-center justify-between text-xs text-gray-500 mt-4 pt-4 border-t border-gray-100">
                    <div class="flex items-center space-x-3">
                        <span class="flex items-center"><i class="ri-time-line mr-1"></i> Đăng: 28/06/2025 09:30 AM</span>
                        <span class="flex items-center"><i class="ri-group-line mr-1"></i> Đối tượng: <span class="font-medium">Tất cả người dùng</span></span>
                    </div>
                    <div class="flex items-center space-x-2 mt-2 md:mt-0">
                        <button class="text-blue-600 hover:text-blue-800 text-sm font-medium edit-btn"><i class="ri-edit-line mr-1"></i>Sửa</button>
                        <button class="text-red-600 hover:text-red-800 text-sm font-medium delete-btn"><i class="ri-delete-bin-line mr-1"></i>Xóa</button>
                    </div>
                </div>
            </div>

            <div class="bg-white shadow rounded-lg p-6 border border-gray-200 hover:shadow-md transition-shadow duration-200 cursor-pointer announcement-card">
                <div class="flex justify-between items-start mb-3">
                    <h3 class="text-lg font-semibold text-gray-800 leading-tight">Chính sách bảo mật dữ liệu mới của hệ thống</h3>
                    <span class="category-tag category-administrative">Hành chính</span>
                </div>
                <p class="text-gray-600 text-sm mb-3 line-clamp-3">Để tuân thủ các quy định mới về bảo vệ dữ liệu, EduLearn LMS sẽ áp dụng chính sách bảo mật dữ liệu cập nhật từ ngày 01/08/2025...</p>
                <div class="flex flex-wrap items-center justify-between text-xs text-gray-500 mt-4 pt-4 border-t border-gray-100">
                    <div class="flex items-center space-x-3">
                        <span class="flex items-center"><i class="ri-time-line mr-1"></i> Đăng: 25/06/2025 02:00 PM</span>
                        <span class="flex items-center"><i class="ri-group-line mr-1"></i> Đối tượng: <span class="font-medium">Tất cả người dùng</span></span>
                    </div>
                    <div class="flex items-center space-x-2 mt-2 md:mt-0">
                        <button class="text-blue-600 hover:text-blue-800 text-sm font-medium edit-btn"><i class="ri-edit-line mr-1"></i>Sửa</button>
                        <button class="text-red-600 hover:text-red-800 text-sm font-medium delete-btn"><i class="ri-delete-bin-line mr-1"></i>Xóa</button>
                    </div>
                </div>
            </div>

            <div id="empty-state" class="hidden col-span-full text-center py-10 text-gray-500">
                <i class="ri-file-info-line text-5xl mb-3 text-gray-400"></i>
                <p class="text-lg font-semibold">Chưa có thông báo nào được tìm thấy.</p>
                <p class="text-sm">Hãy thử điều chỉnh bộ lọc hoặc <button class="text-primary hover:underline font-medium" onclick="document.getElementById('createAnnouncementBtn').click();">tạo thông báo mới</button>.</p>
            </div>
        </div>

    </main>
</div>

<div id="announcementModal" class="modal">
    <div class="modal-content">
        <span class="close-button">&times;</span>
        <h2 class="text-xl font-bold text-gray-800 mb-4" id="modalTitle">Tạo Thông Báo Mới</h2>
        <form id="announcementForm">
            <div class="mb-4">
                <label for="announcementTitle" class="block text-sm font-medium text-gray-700 mb-1">Tiêu đề thông báo</label>
                <input type="text" id="announcementTitle" name="title" class="w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-primary focus:border-primary text-gray-900" placeholder="Nhập tiêu đề thông báo..." required>
            </div>
            <div class="mb-4">
                <label for="announcementContent" class="block text-sm font-medium text-gray-700 mb-1">Nội dung thông báo</label>
                <div class="rich-text-editor border border-gray-300 rounded-lg focus-within:ring-primary focus-within:border-primary" contenteditable="true" id="announcementContent" style="min-height: 150px; padding: 10px; font-size: 0.875rem; line-height: 1.5; resize: vertical; overflow-y: auto;">
                    <p>Viết nội dung thông báo tại đây...</p>
                </div>
                <input type="hidden" name="content" id="announcementContentHidden">
            </div>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                <div>
                    <label for="announcementCategory" class="block text-sm font-medium text-gray-700 mb-1">Danh mục</label>
                    <select id="announcementCategory" name="category" class="w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-primary focus:border-primary text-gray-900 bg-white" required>
                        <option value="">Chọn danh mục</option>
                        <option value="academic">Học thuật</option>
                        <option value="administrative">Hành chính</option>
                        <option value="events">Sự kiện</option>
                        <option value="general">Chung</option>
                    </select>
                </div>
                <div>
                    <label for="announcementTarget" class="block text-sm font-medium text-gray-700 mb-1">Đối tượng</label>
                    <select id="announcementTarget" name="targetAudience" class="w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-primary focus:border-primary text-gray-900 bg-white" required>
                        <option value="">Chọn đối tượng</option>
                        <option value="all">Tất cả người dùng</option>
                        <option value="students">Sinh viên</option>
                        <option value="faculty">Giảng viên</option>
                        <option value="staff">Nhân viên</option>
                    </select>
                </div>
            </div>
            <div class="mb-6">
                <label for="publicationDate" class="block text-sm font-medium text-gray-700 mb-1">Ngày/Giờ xuất bản</label>
                <input type="datetime-local" id="publicationDate" name="publicationDateTime" class="w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-primary focus:border-primary text-gray-900" required>
            </div>
            <div class="flex justify-end space-x-3">
                <button type="button" id="cancelAnnouncementBtn" class="bg-gray-200 text-gray-800 px-4 py-2 rounded-button hover:bg-gray-300">Hủy</button>
                <button type="submit" class="bg-primary text-white px-4 py-2 rounded-button hover:bg-primary/90">Lưu Thông Báo</button>
            </div>
        </form>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const createAnnouncementBtn = document.getElementById('createAnnouncementBtn');
        const announcementModal = document.getElementById('announcementModal');
        const closeButton = document.querySelector('#announcementModal .close-button');
        const cancelAnnouncementBtn = document.getElementById('cancelAnnouncementBtn');
        const announcementForm = document.getElementById('announcementForm');
        const modalTitle = document.getElementById('modalTitle');
        const announcementContentDiv = document.getElementById('announcementContent');
        const announcementContentHiddenInput = document.getElementById('announcementContentHidden');
        const announcementCards = document.querySelectorAll('.announcement-card');

        // Show modal when 'Create Announcement' button is clicked
        if (createAnnouncementBtn) {
            createAnnouncementBtn.addEventListener('click', function() {
                modalTitle.textContent = 'Tạo Thông Báo Mới';
                announcementForm.reset(); // Clear form fields for new announcement
                announcementContentDiv.innerHTML = '<p>Viết nội dung thông báo tại đây...</p>'; // Reset rich text editor
                announcementModal.style.display = 'flex';
            });
        }

        // Close modal when 'x' or 'Hủy' button is clicked
        if (closeButton) {
            closeButton.addEventListener('click', function() {
                announcementModal.style.display = 'none';
            });
        }

        if (cancelAnnouncementBtn) {
            cancelAnnouncementBtn.addEventListener('click', function() {
                announcementModal.style.display = 'none';
            });
        }

        // Close modal when clicking outside of it
        window.addEventListener('click', function(event) {
            if (event.target == announcementModal) {
                announcementModal.style.display = 'none';
            }
        });

        // Handle form submission (for static demo, just console log)
        if (announcementForm) {
            announcementForm.addEventListener('submit', function(event) {
                event.preventDefault(); // Prevent actual form submission
                // For a dynamic application, you would send this data to your server
                
                // Get content from contenteditable div and put into hidden input
                announcementContentHiddenInput.value = announcementContentDiv.innerHTML;

                const formData = new FormData(announcementForm);
                const data = {};
                for (let [key, value] of formData.entries()) {
                    data[key] = value;
                }
                console.log('Announcement data submitted:', data);
                alert('Thông báo đã được gửi (trong demo, không lưu dữ liệu thực tế). Xem trong console để biết chi tiết.');
                announcementModal.style.display = 'none'; // Close modal after submission
            });
        }

        // Handle 'Edit' button click (for static demo, populate modal with card data)
        announcementCards.forEach(card => {
            const editBtn = card.querySelector('.edit-btn');
            if (editBtn) {
                editBtn.addEventListener('click', function(event) {
                    event.stopPropagation(); // Prevent card click event
                    modalTitle.textContent = 'Chỉnh Sửa Thông Báo';
                    // Populate form fields with data from the clicked card for demo purposes
                    document.getElementById('announcementTitle').value = card.querySelector('h3').textContent.trim();
                    // This is a simplified way; in a real app, you'd fetch full content
                    announcementContentDiv.innerHTML = `<p>${card.querySelector('p').textContent.trim()}</p>`;
                    
                    const categoryElement = card.querySelector('.category-tag');
                    if (categoryElement) {
                        let categoryValue = '';
                        if (categoryElement.classList.contains('category-academic')) categoryValue = 'academic';
                        else if (categoryElement.classList.contains('category-administrative')) categoryValue = 'administrative';
                        else if (categoryElement.classList.contains('category-events')) categoryValue = 'events';
                        else if (categoryElement.classList.contains('category-general')) categoryValue = 'general';
                        document.getElementById('announcementCategory').value = categoryValue;
                    }

                    // Placeholder for target audience and publication date
                    document.getElementById('announcementTarget').value = 'all'; // Default or derive from card
                    document.getElementById('publicationDate').value = '2025-07-05T10:00'; // Example or derive from card

                    announcementModal.style.display = 'flex';
                });
            }

            // Handle 'Delete' button click (for static demo, just console log)
            const deleteBtn = card.querySelector('.delete-btn');
            if (deleteBtn) {
                deleteBtn.addEventListener('click', function(event) {
                    event.stopPropagation(); // Prevent card click event
                    if (confirm('Bạn có chắc chắn muốn xóa thông báo này?')) {
                        console.log('Delete announcement clicked for:', card.querySelector('h3').textContent.trim());
                        // In a real app, this would send a DELETE request
                        card.remove(); // Remove card from DOM for visual effect
                        alert('Thông báo đã được xóa (chỉ demo).');
                        // Update empty state if no cards left
                        updateEmptyState();
                    }
                });
            }

            // Handle card click to view full announcement (can be modal or new page)
            card.addEventListener('click', function() {
                // For demo, we'll just log and could potentially open a more detailed modal
                console.log('View full announcement for:', this.querySelector('h3').textContent.trim());
                // In a real application, you might load a full announcement detail modal here
                alert('Bạn đã click vào thông báo: "' + this.querySelector('h3').textContent.trim() + '". (Trong demo này, không có trang chi tiết riêng)');
            });
        });

        // Function to update empty state display
        function updateEmptyState() {
            const currentCards = document.querySelectorAll('.announcement-card').length;
            const emptyStateDiv = document.getElementById('empty-state');
            if (emptyStateDiv) {
                if (currentCards === 0) {
                    emptyStateDiv.classList.remove('hidden');
                } else {
                    emptyStateDiv.classList.add('hidden');
                }
            }
            // Update "Showing X of Y announcements" count if dynamic
            const resultCountSpan = document.querySelector('.text-gray-700.font-medium');
            if (resultCountSpan) {
                resultCountSpan.textContent = `Hiển thị ${currentCards} trên ${currentCards} thông báo`; // Simple for static
            }
        }

        // Initial check for empty state
        updateEmptyState();
    });
</script>

</body>
</html>