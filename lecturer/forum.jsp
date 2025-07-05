<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Diễn đàn - Hệ Thống LMS</title>
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

        /* Forum Topic List Styling */
        .topic-card {
            background-color: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            padding: 1.25rem;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .topic-card:hover {
            border-color: #a7a7a7; /* Slight darker border on hover */
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        }

        .topic-card.read {
            background-color: #fcfcfc;
            opacity: 0.8;
        }
        .topic-card.unread {
            background-color: #f0f8ff; /* Light blue for unread */
            border-left: 4px solid #4f46e5; /* Primary color indicator */
        }

        @media (max-width: 767px) {
            .filter-section {
                flex-direction: column;
                align-items: stretch;
            }
            .filter-section > * {
                width: 100%;
            }
            .filter-tabs {
                justify-content: center;
            }
        }

        /* Modal Styles */
        .modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.3s ease, visibility 0.3s ease;
        }
        .modal.open {
            opacity: 1;
            visibility: visible;
        }
        .modal-content {
            background-color: #fff;
            padding: 2rem;
            border-radius: 0.5rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            width: 90%;
            max-width: 500px;
            transform: translateY(-20px);
            transition: transform 0.3s ease;
        }
        .modal.open .modal-content {
            transform: translateY(0);
        }
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #e5e7eb;
        }
        .modal-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #111827;
        }
        .modal-close-btn {
            background: none;
            border: none;
            font-size: 1.5rem;
            color: #9ca3af;
            cursor: pointer;
        }
        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 0.75rem;
            margin-top: 1.5rem;
            padding-top: 1rem;
            border-top: 1px solid #e5e7eb;
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
                <h1 class="text-2xl font-bold text-gray-900">Diễn đàn</h1>
                <p class="text-sm text-gray-500 mt-1">Trao đổi, thảo luận các vấn đề liên quan đến khóa học.</p>
            </div>
            <button id="createTopicBtn" class="px-4 py-2 bg-primary text-white text-sm font-medium rounded-button hover:bg-primary/90 flex items-center gap-2">
                <i class="ri-add-line"></i>
                <span>Tạo chủ đề mới</span>
            </button>
        </div>

        <div class="bg-white rounded-lg shadow-sm p-5 border border-gray-100 mb-6 filter-section">
            <div class="flex flex-col sm:flex-row gap-4 w-full justify-between items-center mb-4 sm:mb-0">
                <select class="w-full sm:w-auto px-4 py-2 border border-gray-300 rounded-button text-sm text-gray-700 focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent">
                    <option value="all-courses">Tất cả khóa học</option>
                    <option value="cs401">CS401 - Lập trình web nâng cao</option>
                    <option value="cs203">CS203 - Cơ sở dữ liệu</option>
                    <option value="cs202">CS202 - Lập trình Java</option>
                </select>
                <div class="relative w-full sm:w-1/3">
                    <input type="text" placeholder="Tìm kiếm chủ đề..." class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-button focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm">
                    <i class="ri-search-line absolute left-3 top-1/2 -translate-y-1/2 text-gray-400"></i>
                </div>
            </div>
            <div class="flex justify-start sm:justify-start gap-4 mt-4 filter-tabs">
                <button class="px-4 py-2 text-sm font-medium text-primary border-b-2 border-primary">
                    Tất cả
                </button>
                <button class="px-4 py-2 text-sm font-medium text-gray-700 hover:text-primary hover:border-b-2 hover:border-primary/50">
                    Chưa trả lời
                </button>
                <button class="px-4 py-2 text-sm font-medium text-gray-700 hover:text-primary hover:border-b-2 hover:border-primary/50">
                    Đã trả lời
                </button>
            </div>
        </div>

        <div class="forum-topic-list">
            <div class="topic-card unread" data-status="unread">
                <div class="flex items-start justify-between mb-2">
                    <h2 class="text-lg font-semibold text-gray-900 mr-4 cursor-pointer topic-title">
                        Cách xử lý lỗi CORS khi gọi API từ React?
                    </h2>
                    <div class="flex items-center space-x-2">
                        <button class="text-yellow-500 hover:text-yellow-600 important-topic-btn" title="Đánh dấu quan trọng">
                            <i class="ri-star-fill"></i>
                        </button>
                        <span class="px-2 py-0.5 text-xs font-medium rounded-full bg-red-100 text-red-800" title="Chủ đề chưa có phản hồi">
                            Chưa trả lời
                        </span>
                    </div>
                </div>
                <div class="flex items-center text-sm text-gray-600 mb-3">
                    <div class="w-6 h-6 rounded-full overflow-hidden bg-gray-100 mr-2">
                        <img src="https://readdy.ai/api/search-image?query=male%20student%20headshot%20asian&width=50&height=50&seq=1&orientation=squarish" alt="Avatar" class="w-full h-full object-cover">
                    </div>
                    <span class="font-medium text-gray-800">Phạm Văn Nam</span>
                    <span class="mx-2">•</span>
                    <span>Tạo lúc 10:30, 03/07/2025</span>
                </div>
                <div class="flex items-center justify-between text-sm text-gray-500">
                    <div>
                        <span class="px-2 py-1 text-xs font-medium bg-indigo-100 text-indigo-800 rounded-full mr-2">CS401</span>
                        <span class="mr-3"><i class="ri-chat-4-line mr-1"></i> 0 bình luận</span>
                    </div>
                    <button class="px-3 py-1.5 bg-primary text-white text-xs font-medium rounded-button hover:bg-primary/90 quick-reply-btn" title="Trả lời nhanh chủ đề này">
                        Trả lời nhanh
                    </button>
                </div>
            </div>

            <div class="topic-card read" data-status="read">
                <div class="flex items-start justify-between mb-2">
                    <h2 class="text-lg font-semibold text-gray-900 mr-4 cursor-pointer topic-title">
                        Thắc mắc về cách sử dụng JOIN trong SQL
                    </h2>
                    <div class="flex items-center space-x-2">
                        <button class="text-gray-400 hover:text-gray-500 important-topic-btn" title="Đánh dấu quan trọng">
                            <i class="ri-star-line"></i>
                        </button>
                        <span class="px-2 py-0.5 text-xs font-medium rounded-full bg-green-100 text-green-800" title="Chủ đề đã có phản hồi">
                            Đã trả lời
                        </span>
                    </div>
                </div>
                <div class="flex items-center text-sm text-gray-600 mb-3">
                    <div class="w-6 h-6 rounded-full overflow-hidden bg-gray-100 mr-2">
                        <img src="https://readdy.ai/api/search-image?query=female%20student%20headshot%20asian&width=50&height=50&seq=1&orientation=squarish" alt="Avatar" class="w-full h-full object-cover">
                    </div>
                    <span class="font-medium text-gray-800">Trần Thị Mai</span>
                    <span class="mx-2">•</span>
                    <span>Tạo lúc 14:15, 02/07/2025</span>
                </div>
                <div class="flex items-center justify-between text-sm text-gray-500">
                    <div>
                        <span class="px-2 py-1 text-xs font-medium bg-purple-100 text-purple-800 rounded-full mr-2">CS203</span>
                        <span class="mr-3"><i class="ri-chat-4-line mr-1"></i> 5 bình luận</span>
                    </div>
                    <button class="px-3 py-1.5 bg-primary text-white text-xs font-medium rounded-button hover:bg-primary/90 quick-reply-btn" title="Trả lời nhanh chủ đề này">
                        Trả lời nhanh
                    </button>
                </div>
            </div>

            <div class="topic-card unread" data-status="unread">
                <div class="flex items-start justify-between mb-2">
                    <h2 class="text-lg font-semibold text-gray-900 mr-4 cursor-pointer topic-title">
                        Tài liệu tham khảo thêm cho Java Collections Framework
                    </h2>
                    <div class="flex items-center space-x-2">
                        <button class="text-gray-400 hover:text-gray-500 important-topic-btn" title="Đánh dấu quan trọng">
                            <i class="ri-star-line"></i>
                        </button>
                        <span class="px-2 py-0.5 text-xs font-medium rounded-full bg-green-100 text-green-800" title="Chủ đề đã có phản hồi">
                            Đã trả lời
                        </span>
                    </div>
                </div>
                <div class="flex items-center text-sm text-gray-600 mb-3">
                    <div class="w-6 h-6 rounded-full overflow-hidden bg-gray-100 mr-2">
                        <img src="https://readdy.ai/api/search-image?query=female%20teacher%20headshot%20vietnamese&width=50&height=50&seq=1&orientation=squarish" alt="Avatar" class="w-full h-full object-cover">
                    </div>
                    <span class="font-medium text-gray-800">Nguyễn Thị Minh</span>
                    <span class="mx-2">•</span>
                    <span>Tạo lúc 09:00, 01/07/2025</span>
                </div>
                <div class="flex items-center justify-between text-sm text-gray-500">
                    <div>
                        <span class="px-2 py-1 text-xs font-medium bg-red-100 text-red-800 rounded-full mr-2">CS202</span>
                        <span class="mr-3"><i class="ri-chat-4-line mr-1"></i> 8 bình luận</span>
                    </div>
                    <button class="px-3 py-1.5 bg-primary text-white text-xs font-medium rounded-button hover:bg-primary/90 quick-reply-btn" title="Trả lời nhanh chủ đề này">
                        Trả lời nhanh
                    </button>
                </div>
            </div>

            <div id="empty-state" class="hidden topic-card flex flex-col items-center justify-center py-10 text-gray-500">
                <i class="ri-chat-off-line text-5xl mb-3 text-gray-400"></i>
                <p class="text-lg font-medium mb-2">Không có chủ đề nào được tìm thấy.</p>
                <p class="text-sm">Vui lòng thử điều chỉnh bộ lọc hoặc tạo chủ đề mới.</p>
            </div>
        </div>

        <div class="flex flex-col sm:flex-row justify-between items-center gap-4 py-4">
            <div class="text-sm text-gray-700">
                Hiển thị <span class="font-semibold">1-3</span> trong tổng số <span class="font-semibold">6</span> chủ đề
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

<div id="createTopicModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">Tạo chủ đề mới</h3>
            <button class="modal-close-btn">&times;</button>
        </div>
        <form id="createTopicForm">
            <div class="mb-4">
                <label for="topicTitle" class="block text-sm font-medium text-gray-700 mb-1">Tiêu đề chủ đề</label>
                <input type="text" id="topicTitle" name="topicTitle" class="w-full px-3 py-2 border border-gray-300 rounded-button focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" placeholder="Nhập tiêu đề chủ đề" required>
            </div>
            <div class="mb-4">
                <label for="topicCourse" class="block text-sm font-medium text-gray-700 mb-1">Khóa học</label>
                <select id="topicCourse" name="topicCourse" class="w-full px-3 py-2 border border-gray-300 rounded-button text-gray-700 focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" required>
                    <option value="">Chọn khóa học</option>
                    <option value="cs401">CS401 - Lập trình web nâng cao</option>
                    <option value="cs203">CS203 - Cơ sở dữ liệu</option>
                    <option value="cs202">CS202 - Lập trình Java</option>
                </select>
            </div>
            <div class="mb-4">
                <label for="topicContent" class="block text-sm font-medium text-gray-700 mb-1">Nội dung</label>
                <textarea id="topicContent" name="topicContent" rows="5" class="w-full px-3 py-2 border border-gray-300 rounded-button focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" placeholder="Viết nội dung chủ đề của bạn tại đây..." required></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="px-4 py-2 bg-gray-200 text-gray-800 text-sm font-medium rounded-button hover:bg-gray-300 close-modal-btn">Hủy</button>
                <button type="submit" class="px-4 py-2 bg-primary text-white text-sm font-medium rounded-button hover:bg-primary/90">Đăng chủ đề</button>
            </div>
        </form>
    </div>
</div>

<div id="quickReplyModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">Trả lời nhanh chủ đề: <span id="replyTopicTitle" class="font-normal text-primary"></span></h3>
            <button class="modal-close-btn">&times;</button>
        </div>
        <form id="quickReplyForm">
            <input type="hidden" id="replyTopicId" name="replyTopicId">
            <div class="mb-4">
                <label for="replyContent" class="block text-sm font-medium text-gray-700 mb-1">Nội dung trả lời</label>
                <textarea id="replyContent" name="replyContent" rows="5" class="w-full px-3 py-2 border border-gray-300 rounded-button focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" placeholder="Viết phản hồi của bạn tại đây..." required></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="px-4 py-2 bg-gray-200 text-gray-800 text-sm font-medium rounded-button hover:bg-gray-300 close-modal-btn">Hủy</button>
                <button type="submit" class="px-4 py-2 bg-primary text-white text-sm font-medium rounded-button hover:bg-primary/90">Gửi trả lời</button>
            </div>
        </form>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Mobile menu toggle (from previous pages)
        const mobileMenuButton = document.querySelector('header .lg\\:hidden button');
        const sidebar = document.querySelector('aside');

        if (mobileMenuButton && sidebar) {
            mobileMenuButton.addEventListener('click', function() {
                sidebar.classList.toggle('hidden');
                sidebar.classList.toggle('flex');
            });
        }

        // Modals
        const createTopicModal = document.getElementById('createTopicModal');
        const quickReplyModal = document.getElementById('quickReplyModal');
        const createTopicBtn = document.getElementById('createTopicBtn');
        const quickReplyBtns = document.querySelectorAll('.quick-reply-btn');
        const modalCloseBtns = document.querySelectorAll('.modal-close-btn');
        const closeModalsByBtn = document.querySelectorAll('.close-modal-btn');

        function openModal(modal) {
            modal.classList.add('open');
        }

        function closeModal(modal) {
            modal.classList.remove('open');
        }

        // Open Create Topic Modal
        if (createTopicBtn) {
            createTopicBtn.addEventListener('click', function() {
                openModal(createTopicModal);
            });
        }

        // Open Quick Reply Modal
        quickReplyBtns.forEach(button => {
            button.addEventListener('click', function(event) {
                event.stopPropagation(); // Prevent topic card click event from firing
                const topicCard = this.closest('.topic-card');
                const topicTitle = topicCard.querySelector('.topic-title').textContent.trim();
                // You might need a data attribute for topic ID in a real application
                // const topicId = topicCard.dataset.topicId;

                document.getElementById('replyTopicTitle').textContent = topicTitle;
                // document.getElementById('replyTopicId').value = topicId; // Set hidden input value
                openModal(quickReplyModal);
            });
        });

        // Close Modals with 'X' button
        modalCloseBtns.forEach(button => {
            button.addEventListener('click', function() {
                closeModal(this.closest('.modal'));
            });
        });

        // Close Modals with "Hủy" (Cancel) button
        closeModalsByBtn.forEach(button => {
            button.addEventListener('click', function() {
                closeModal(this.closest('.modal'));
            });
        });

        // Close modal when clicking outside the modal content
        [createTopicModal, quickReplyModal].forEach(modal => {
            modal.addEventListener('click', function(event) {
                if (event.target === modal) { // Check if the click was directly on the modal overlay
                    closeModal(modal);
                }
            });
        });


        // Handle form submissions (placeholder)
        const createTopicForm = document.getElementById('createTopicForm');
        if (createTopicForm) {
            createTopicForm.addEventListener('submit', function(event) {
                event.preventDefault();
                const title = document.getElementById('topicTitle').value;
                const course = document.getElementById('topicCourse').value;
                const content = document.getElementById('topicContent').value;
                alert(`Đăng chủ đề mới:\nTiêu đề: ${title}\nKhóa học: ${course}\nNội dung: ${content}`);
                console.log('New topic submitted:', { title, course, content });
                closeModal(createTopicModal);
                this.reset(); // Clear form fields
            });
        }

        const quickReplyForm = document.getElementById('quickReplyForm');
        if (quickReplyForm) {
            quickReplyForm.addEventListener('submit', function(event) {
                event.preventDefault();
                const topicTitle = document.getElementById('replyTopicTitle').textContent;
                // const topicId = document.getElementById('replyTopicId').value;
                const replyContent = document.getElementById('replyContent').value;
                alert(`Trả lời chủ đề "${topicTitle}":\nNội dung: ${replyContent}`);
                console.log(`Reply to "${topicTitle}" submitted:`, { replyContent });
                closeModal(quickReplyModal);
                this.reset(); // Clear form fields
            });
        }


        // Other existing functionalities
        const topicTitles = document.querySelectorAll('.topic-title');
        const importantTopicBtns = document.querySelectorAll('.important-topic-btn');
        const topicCards = document.querySelectorAll('.topic-card');

        topicTitles.forEach(title => {
            title.addEventListener('click', function() {
                const topicTitle = this.textContent.trim();
                alert(`Chuyển đến trang chi tiết chủ đề: "${topicTitle}"`);
                console.log(`Xem chi tiết chủ đề "${topicTitle}" clicked`);
                // In a real app, navigate to a detailed topic page
            });
        });

        importantTopicBtns.forEach(button => {
            button.addEventListener('click', function(event) {
                event.stopPropagation(); // Prevent topic card click event from firing
                const icon = this.querySelector('i');
                const isImportant = icon.classList.contains('ri-star-fill');
                if (isImportant) {
                    icon.classList.remove('ri-star-fill', 'text-yellow-500');
                    icon.classList.add('ri-star-line', 'text-gray-400');
                    alert('Đã bỏ đánh dấu quan trọng.');
                } else {
                    icon.classList.remove('ri-star-line', 'text-gray-400');
                    icon.classList.add('ri-star-fill', 'text-yellow-500');
                    alert('Đã đánh dấu chủ đề quan trọng!');
                }
                console.log('Đánh dấu quan trọng clicked');
            });
        });

        topicCards.forEach(card => {
            card.addEventListener('click', function() {
                // Mark as read when clicked (visual only)
                this.classList.remove('unread');
                this.classList.add('read');
                // In a real app, you would send a request to mark it as read in the backend
            });
        });

        // Pagination buttons (placeholder actions)
        const paginationButtons = document.querySelectorAll('.flex.items-center.space-x-2 button');
        paginationButtons.forEach(button => {
            button.addEventListener('click', function() {
                if (!this.disabled) {
                    console.log('Pagination button clicked:', this.textContent.trim());
                    // In a real app, this would trigger data loading for the selected page
                }
            });
        });

        // Example for "empty state" display
        // You would typically toggle this based on your data fetching results
        // const emptyStateDiv = document.getElementById('empty-state');
        // if (someConditionForNoTopics) { // Replace 'someConditionForNoTopics' with actual logic
        //     emptyStateDiv.classList.remove('hidden');
        // } else {
        //     emptyStateDiv.classList.add('hidden');
        // }
    });
</script>

</body>
</html>