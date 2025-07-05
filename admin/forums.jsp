<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduLearn LMS - Quản lý Diễn Đàn</title>
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
            max-width: 600px;
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

        /* Forum Specific Styles */
        .category-card {
            background-color: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            padding: 1.5rem;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
            transition: all 0.2s ease-in-out;
        }
        .category-card:hover {
            border-color: #4F46E5;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            transform: translateY(-2px);
        }
        .category-card .icon {
            font-size: 2.5rem;
            color: #4F46E5;
            margin-bottom: 0.75rem;
        }
        .unread-indicator {
            width: 10px;
            height: 10px;
            background-color: #EF4444; /* red-500 */
            border-radius: 9999px; /* full */
            margin-left: 0.5rem;
        }

        /* Topic card styles (simplified from previous forumlecture.txt) */
        .topic-card {
            background-color: #fff;
            border-radius: 0.5rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            padding: 1rem;
            display: flex;
            align-items: flex-start;
            gap: 1rem;
        }
        .topic-card.read {
            background-color: #f9fafb; /* Lighter background for read topics */
        }
        .topic-card.unread {
            border-left: 4px solid #4F46E5; /* Primary color indicator for unread */
        }
        .topic-card .icon-container {
            width: 2.5rem;
            height: 2.5rem;
            border-radius: 9999px;
            background-color: #e0e7ff;
            color: #4F46E5;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            font-size: 1.25rem;
        }
        .topic-card .meta-info {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-top: 0.5rem;
            font-size: 0.75rem; /* text-xs */
            color: #6b7280; /* gray-500 */
        }
        .topic-card .meta-info span {
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }
        .tag {
            display: inline-flex;
            align-items: center;
            padding: 0.2rem 0.6rem;
            border-radius: 9999px; /* full */
            font-size: 0.75rem; /* text-xs */
            font-weight: 500; /* font-medium */
            background-color: #e0f2fe; /* light blue */
            color: #0284c7; /* blue-700 */
        }

        /* Popular Tags Cloud */
        .popular-tags .tag-item {
            display: inline-block;
            background-color: #e5e7eb; /* gray-200 */
            color: #4b5563; /* gray-700 */
            padding: 0.3rem 0.7rem;
            border-radius: 0.5rem;
            font-size: 0.8rem;
            margin: 0.25rem;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .popular-tags .tag-item:hover {
            background-color: #d1d5db; /* gray-300 */
        }
    </style>
</head>
<body class="flex h-screen overflow-hidden">
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
        <div class="px-4 space-y-1">
            <p class="text-xs font-semibold text-gray-400 uppercase tracking-wide">Main</p>
            <a href="dashboard.html" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-dashboard-line mr-2"></i> Trang Chủ
            </a>
            <a href="users.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-user-line mr-2"></i> Người dùng
            </a>
            <a href="coursers.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-book-open-line mr-2"></i> Môn Học
            </a>
        </div>
        <div class="mt-6 px-4 space-y-1">
            <p class="text-xs font-semibold text-gray-400 uppercase tracking-wide">Academic</p>
            <a href="semesters.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-calendar-line mr-2"></i> Học kỳ
            </a>
            <a href="assignments.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-file-list-line mr-2"></i> Bài Kiểm Tra
            </a>
            <a href="grades.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-bar-chart-line mr-2"></i> Điểm Số
            </a>
        </div>
        <div class="mt-6 px-4 space-y-1">
            <p class="text-xs font-semibold text-gray-400 uppercase tracking-wide">Communication</p>
            <a href="forums.jsp" class="sidebar-link active flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-discuss-line mr-2"></i> Diễn Đàn
            </a>
            <a href="announcements.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-notification-3-line mr-2"></i> Thông Báo
            </a>
        </div>
        <div class="mt-6 px-4 space-y-1">
            <p class="text-xs font-semibold text-gray-400 uppercase tracking-wide">System</p>
            <a href="settings.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-settings-3-line mr-2"></i> Cài Đặt
            </a>
            <a href="helpcenter.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-question-line mr-2"></i> Hướng Dẫn
            </a>
        </div>
    </nav>
    <div class="p-4 border-t">
        <a href="/WebApplication1" class="flex items-center justify-center w-full px-4 py-2 text-sm font-medium text-gray-700 bg-gray-100 rounded-button hover:bg-gray-200 whitespace-nowrap" style="text-decoration:none;">
            <div class="w-5 h-5 mr-2 flex items-center justify-center">
                <i class="ri-logout-box-line"></i>
            </div>
            Sign Out
        </a>
    </div>
</aside>
<div class="flex-1 flex flex-col">
    <header class="bg-white shadow-sm px-6 py-4 flex justify-between items-center border-b">
        <div class="flex items-center w-1/2">
            <input type="text" placeholder="Tìm kiếm diễn đàn, chủ đề..." class="w-full border border-gray-300 rounded px-3 py-2 text-sm" />
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
    <main class="flex-1 p-8 overflow-auto flex">
        <div class="flex-1 pr-6"> <nav class="text-sm text-gray-500 mb-4" aria-label="Breadcrumb">
                <ol class="list-none p-0 inline-flex">
                    <li class="flex items-center">
                        <a href="dashboard.html" class="text-primary hover:text-primary/80">Trang Chủ</a>
                        <i class="ri-arrow-right-s-line mx-2"></i>
                    </li>
                    <li>
                        <span class="text-gray-700">Diễn Đàn</span>
                    </li>
                </ol>
            </nav>

            <div class="flex justify-between items-center mb-6">
                <div>
                    <h1 class="text-2xl font-bold text-gray-800">Diễn Đàn</h1>
                    <p class="text-gray-600 text-sm">Quản lý các danh mục diễn đàn và chủ đề thảo luận.</p>
                </div>
                <button id="createNewTopicBtn" class="bg-primary text-white px-4 py-2 rounded-button hover:bg-primary/90 text-sm font-medium flex items-center gap-1">
                    <i class="ri-add-line text-lg"></i> Tạo Chủ Đề Mới
                </button>
            </div>

            <section class="mb-8">
                <h2 class="text-xl font-semibold text-gray-800 mb-4">Danh Mục Diễn Đàn</h2>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <div class="category-card flex flex-col justify-between">
                        <div>
                            <i class="ri-book-open-line icon"></i>
                            <h3 class="text-lg font-semibold text-gray-800 mt-2 mb-1">Thảo luận Học thuật</h3>
                            <p class="text-sm text-gray-600 mb-4 line-clamp-2">Nơi trao đổi về bài giảng, bài tập, và các vấn đề học thuật khác.</p>
                        </div>
                        <div class="flex justify-between items-center text-xs text-gray-500">
                            <div class="flex items-center">
                                <span><i class="ri-chat-1-line mr-1"></i> 120 Chủ đề</span>
                                <span class="ml-4"><i class="ri-message-2-line mr-1"></i> 540 Bài viết</span>
                            </div>
                            <div class="flex items-center">
                                <span><i class="ri-history-line mr-1"></i> Hoạt động gần nhất: 1h trước</span>
                                <div class="unread-indicator" title="Có bài viết chưa đọc"></div>
                            </div>
                        </div>
                    </div>

                    <div class="category-card flex flex-col justify-between">
                        <div>
                            <i class="ri-group-line icon"></i>
                            <h3 class="text-lg font-semibold text-gray-800 mt-2 mb-1">Thảo luận Chung</h3>
                            <p class="text-sm text-gray-600 mb-4 line-clamp-2">Mọi chủ đề không thuộc danh mục học thuật hay khóa học cụ thể.</p>
                        </div>
                        <div class="flex justify-between items-center text-xs text-gray-500">
                            <div class="flex items-center">
                                <span><i class="ri-chat-1-line mr-1"></i> 85 Chủ đề</span>
                                <span class="ml-4"><i class="ri-message-2-line mr-1"></i> 310 Bài viết</span>
                            </div>
                            <div class="flex items-center">
                                <span><i class="ri-history-line mr-1"></i> Hoạt động gần nhất: 30p trước</span>
                            </div>
                        </div>
                    </div>

                    <div class="category-card flex flex-col justify-between">
                        <div>
                            <i class="ri-book-mark-line icon"></i>
                            <h3 class="text-lg font-semibold text-gray-800 mt-2 mb-1">Diễn đàn Khóa học</h3>
                            <p class="text-sm text-gray-600 mb-4 line-clamp-2">Diễn đàn riêng cho từng khóa học, dành cho sinh viên và giảng viên.</p>
                        </div>
                        <div class="flex justify-between items-center text-xs text-gray-500">
                            <div class="flex items-center">
                                <span><i class="ri-chat-1-line mr-1"></i> 210 Chủ đề</span>
                                <span class="ml-4"><i class="ri-message-2-line mr-1"></i> 980 Bài viết</span>
                            </div>
                            <div class="flex items-center">
                                <span><i class="ri-history-line mr-1"></i> Hoạt động gần nhất: 15p trước</span>
                                <div class="unread-indicator" title="Có bài viết chưa đọc"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section>
                <div class="flex justify-between items-center mb-4">
                    <h2 class="text-xl font-semibold text-gray-800">Chủ đề Gần đây</h2>
                    <div class="flex space-x-2 text-sm">
                        <select class="border px-2 py-1 rounded-md focus:ring-primary focus:border-primary bg-white">
                            <option>Sắp xếp: Mới nhất</option>
                            <option>Sắp xếp: Hoạt động nhiều nhất</option>
                            <option>Sắp xếp: Chưa được trả lời</option>
                        </select>
                        <select class="border px-2 py-1 rounded-md focus:ring-primary focus:border-primary bg-white">
                            <option>Lọc: Tất cả</option>
                            <option>Lọc: Chưa đọc</option>
                            <option>Lọc: Đã đăng ký</option>
                        </select>
                    </div>
                </div>

                <div class="space-y-4">
                    <div class="topic-card unread cursor-pointer">
                        <div class="icon-container">
                            <i class="ri-question-answer-line"></i>
                        </div>
                        <div class="flex-1">
                            <h4 class="text-base font-semibold text-gray-800 hover:text-primary">Làm cách nào để nộp bài tập đúng hạn?</h4>
                            <p class="text-sm text-gray-600 line-clamp-2">Tôi đang gặp khó khăn trong việc quản lý thời gian nộp bài tập. Có lời khuyên nào không ạ?</p>
                            <div class="meta-info">
                                <span><i class="ri-user-line"></i> John Doe</span>
                                <span><i class="ri-time-line"></i> 10 phút trước</span>
                                <span><i class="ri-message-2-line"></i> 5 trả lời</span>
                                <span class="tag">#HocTap</span>
                            </div>
                        </div>
                        <div class="text-right flex-shrink-0 flex flex-col space-y-2">
                             <button class="text-sm text-blue-600 hover:text-blue-800 edit-topic-btn"><i class="ri-edit-line mr-1"></i>Sửa</button>
                             <button class="text-sm text-red-600 hover:text-red-800 delete-topic-btn"><i class="ri-delete-bin-line mr-1"></i>Xóa</button>
                        </div>
                    </div>

                    <div class="topic-card read cursor-pointer">
                        <div class="icon-container">
                            <i class="ri-lightbulb-line"></i>
                        </div>
                        <div class="flex-1">
                            <h4 class="text-base font-semibold text-gray-800 hover:text-primary">Gợi ý tài liệu học tập cho môn Lập trình Web</h4>
                            <p class="text-sm text-gray-600 line-clamp-2">Bạn nào có tài liệu hay hoặc khóa học online miễn phí nào cho môn này không?</p>
                            <div class="meta-info">
                                <span><i class="ri-user-line"></i> Jane Smith</span>
                                <span><i class="ri-time-line"></i> 2 giờ trước</span>
                                <span><i class="ri-message-2-line"></i> 12 trả lời</span>
                                <span class="tag">#LậpTrình</span>
                            </div>
                        </div>
                        <div class="text-right flex-shrink-0 flex flex-col space-y-2">
                             <button class="text-sm text-blue-600 hover:text-blue-800 edit-topic-btn"><i class="ri-edit-line mr-1"></i>Sửa</button>
                             <button class="text-sm text-red-600 hover:text-red-800 delete-topic-btn"><i class="ri-delete-bin-line mr-1"></i>Xóa</button>
                        </div>
                    </div>

                    <div class="topic-card cursor-pointer">
                        <div class="icon-container">
                            <i class="ri-calendar-event-line"></i>
                        </div>
                        <div class="flex-1">
                            <h4 class="text-base font-semibold text-gray-800 hover:text-primary">Thông báo về buổi hội thảo CNTT sắp tới</h4>
                            <p class="text-sm text-gray-600 line-clamp-2">Hãy tham gia buổi hội thảo về Trí tuệ nhân tạo và học máy vào tuần sau!</p>
                            <div class="meta-info">
                                <span><i class="ri-user-line"></i> Admin</span>
                                <span><i class="ri-time-line"></i> 1 ngày trước</span>
                                <span><i class="ri-message-2-line"></i> 8 trả lời</span>
                                <span class="tag">#SựKiện</span>
                            </div>
                        </div>
                        <div class="text-right flex-shrink-0 flex flex-col space-y-2">
                             <button class="text-sm text-blue-600 hover:text-blue-800 edit-topic-btn"><i class="ri-edit-line mr-1"></i>Sửa</button>
                             <button class="text-sm text-red-600 hover:text-red-800 delete-topic-btn"><i class="ri-delete-bin-line mr-1"></i>Xóa</button>
                        </div>
                    </div>

                    <div id="empty-topics-state" class="hidden text-center py-10 text-gray-500">
                        <i class="ri-question-fill text-5xl mb-3 text-gray-400"></i>
                        <p class="text-lg font-semibold">Không có chủ đề nào được tìm thấy.</p>
                        <p class="text-sm">Hãy thử điều chỉnh bộ lọc hoặc <button class="text-primary hover:underline font-medium" onclick="document.getElementById('createNewTopicBtn').click();">tạo chủ đề mới</button>.</p>
                    </div>
                </div>
            </section>
        </div>

        <div class="w-72 flex-shrink-0 lg:block hidden"> <div class="bg-white shadow rounded-lg p-4 mb-6">
                <h3 class="text-lg font-semibold text-gray-800 mb-4">Thống Kê Nhanh</h3>
                <ul class="space-y-2 text-sm text-gray-700">
                    <li class="flex justify-between items-center">
                        <span><i class="ri-chat-1-line mr-2"></i> Tổng số Chủ đề:</span>
                        <span class="font-medium text-gray-900">450</span>
                    </li>
                    <li class="flex justify-between items-center">
                        <span><i class="ri-message-2-line mr-2"></i> Tổng số Bài viết:</span>
                        <span class="font-medium text-gray-900">2,100</span>
                    </li>
                    <li class="flex justify-between items-center">
                        <span><i class="ri-user-line mr-2"></i> Người dùng Hoạt động:</span>
                        <span class="font-medium text-gray-900">75</span>
                    </li>
                </ul>
            </div>

            <div class="bg-white shadow rounded-lg p-4 mb-6 popular-tags">
                <h3 class="text-lg font-semibold text-gray-800 mb-4">Thẻ Phổ Biến</h3>
                <div>
                    <span class="tag-item">#HocTap</span>
                    <span class="tag-item">#KyThi</span>
                    <span class="tag-item">#ThongBao</span>
                    <span class="tag-item">#LichHoc</span>
                    <span class="tag-item">#DuHoc</span>
                    <span class="tag-item">#CLB</span>
                    <span class="tag-item">#IT</span>
                    <span class="tag-item">#KhoaHoc</span>
                </div>
            </div>

            <div class="bg-white shadow rounded-lg p-4 mb-6">
                <h3 class="text-lg font-semibold text-gray-800 mb-4">Hoạt Động Gần Đây</h3>
                <ul class="space-y-3 text-sm">
                    <li class="text-gray-700">
                        <span class="font-medium">User A</span> đã trả lời chủ đề "<span class="text-primary">Làm sao để học tốt?</span>"
                        <span class="block text-xs text-gray-500">5 phút trước</span>
                    </li>
                    <li class="text-gray-700">
                        <span class="font-medium">User B</span> đã tạo chủ đề mới "<span class="text-primary">Tìm bạn học nhóm</span>"
                        <span class="block text-xs text-gray-500">15 phút trước</span>
                    </li>
                    <li class="text-gray-700">
                        <span class="font-medium">User C</span> đã bình luận trong "<span class="text-primary">Hướng dẫn đăng ký môn học</span>"
                        <span class="block text-xs text-gray-500">30 phút trước</span>
                    </li>
                </ul>
            </div>

            <div class="bg-white shadow rounded-lg p-4">
                <h3 class="text-lg font-semibold text-gray-800 mb-4">Người Đóng Góp Hàng Đầu</h3>
                <ul class="space-y-3 text-sm">
                    <li class="flex items-center">
                        <div class="w-8 h-8 rounded-full bg-blue-100 text-blue-600 flex items-center justify-center font-medium mr-3">DA</div>
                        <div class="flex-1">
                            <p class="font-medium text-gray-800">David Allen</p>
                            <p class="text-xs text-gray-500">250 bài viết</p>
                        </div>
                    </li>
                    <li class="flex items-center">
                        <div class="w-8 h-8 rounded-full bg-green-100 text-green-600 flex items-center justify-center font-medium mr-3">SS</div>
                        <div class="flex-1">
                            <p class="font-medium text-gray-800">Sarah Stone</p>
                            <p class="text-xs text-gray-500">180 bài viết</p>
                        </div>
                    </li>
                    <li class="flex items-center">
                        <div class="w-8 h-8 rounded-full bg-purple-100 text-purple-600 flex items-center justify-center font-medium mr-3">MW</div>
                        <div class="flex-1">
                            <p class="font-medium text-gray-800">Michael White</p>
                            <p class="text-xs text-gray-500">150 bài viết</p>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </main>
</div>

<div id="newTopicModal" class="modal">
    <div class="modal-content">
        <span class="close-button">&times;</span>
        <h2 class="text-xl font-bold text-gray-800 mb-4">Tạo Chủ Đề Mới</h2>
        <form id="newTopicForm">
            <div class="mb-4">
                <label for="topicTitle" class="block text-sm font-medium text-gray-700 mb-1">Tiêu đề chủ đề</label>
                <input type="text" id="topicTitle" name="title" class="w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-primary focus:border-primary text-gray-900" placeholder="Nhập tiêu đề chủ đề..." required>
            </div>
            <div class="mb-4">
                <label for="topicCategory" class="block text-sm font-medium text-gray-700 mb-1">Danh mục</label>
                <select id="topicCategory" name="category" class="w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-primary focus:border-primary text-gray-900 bg-white" required>
                    <option value="">Chọn danh mục</option>
                    <option value="academic">Thảo luận Học thuật</option>
                    <option value="general">Thảo luận Chung</option>
                    <option value="course-specific">Diễn đàn Khóa học</option>
                </select>
            </div>
            <div class="mb-6">
                <label for="topicContent" class="block text-sm font-medium text-gray-700 mb-1">Nội dung</label>
                <textarea id="topicContent" name="content" rows="6" class="w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-primary focus:border-primary text-gray-900" placeholder="Viết nội dung chủ đề tại đây..." required></textarea>
            </div>
            <div class="flex justify-end space-x-3">
                <button type="button" id="cancelNewTopicBtn" class="bg-gray-200 text-gray-800 px-4 py-2 rounded-button hover:bg-gray-300">Hủy</button>
                <button type="submit" class="bg-primary text-white px-4 py-2 rounded-button hover:bg-primary/90">Đăng Chủ Đề</button>
            </div>
        </form>
    </div>
</div>


<script>
    document.addEventListener('DOMContentLoaded', function() {
        const createNewTopicBtn = document.getElementById('createNewTopicBtn');
        const newTopicModal = document.getElementById('newTopicModal');
        const closeButton = document.querySelector('#newTopicModal .close-button');
        const cancelNewTopicBtn = document.getElementById('cancelNewTopicBtn');
        const newTopicForm = document.getElementById('newTopicForm');

        // Show modal when 'Create New Topic' button is clicked
        if (createNewTopicBtn) {
            createNewTopicBtn.addEventListener('click', function() {
                newTopicForm.reset(); // Clear form fields
                newTopicModal.style.display = 'flex';
            });
        }

        // Close modal when 'x' or 'Hủy' button is clicked
        if (closeButton) {
            closeButton.addEventListener('click', function() {
                newTopicModal.style.display = 'none';
            });
        }

        if (cancelNewTopicBtn) {
            cancelNewTopicBtn.addEventListener('click', function() {
                newTopicModal.style.display = 'none';
            });
        }

        // Close modal when clicking outside of it
        window.addEventListener('click', function(event) {
            if (event.target == newTopicModal) {
                newTopicModal.style.display = 'none';
            }
        });

        // Handle form submission (for static demo, just console log)
        if (newTopicForm) {
            newTopicForm.addEventListener('submit', function(event) {
                event.preventDefault(); // Prevent actual form submission
                const formData = new FormData(newTopicForm);
                const data = {};
                for (let [key, value] of formData.entries()) {
                    data[key] = value;
                }
                console.log('New topic data submitted:', data);
                alert('Chủ đề đã được đăng (trong demo, không lưu dữ liệu thực tế). Xem trong console để biết chi tiết.');
                newTopicModal.style.display = 'none'; // Close modal after submission
            });
        }

        // Handle topic card click (view full topic)
        const topicCards = document.querySelectorAll('.topic-card');
        topicCards.forEach(card => {
            card.addEventListener('click', function() {
                // In a real application, this would navigate to a detailed topic view or open a modal
                console.log('View topic:', this.querySelector('h4').textContent.trim());
                alert('Bạn đã click vào chủ đề: "' + this.querySelector('h4').textContent.trim() + '". (Trong demo này, không có trang chi tiết riêng)');
                this.classList.add('read'); // Mark as read visually
                this.classList.remove('unread');
            });

            // Prevent card click when action buttons are clicked
            const editBtn = card.querySelector('.edit-topic-btn');
            if (editBtn) {
                editBtn.addEventListener('click', function(event) {
                    event.stopPropagation(); // Stop propagation to prevent card click
                    alert('Chỉnh sửa chủ đề: ' + card.querySelector('h4').textContent.trim());
                    // Implement edit logic here (e.g., open modal with pre-filled data)
                });
            }

            const deleteBtn = card.querySelector('.delete-topic-btn');
            if (deleteBtn) {
                deleteBtn.addEventListener('click', function(event) {
                    event.stopPropagation(); // Stop propagation to prevent card click
                    if (confirm('Bạn có chắc chắn muốn xóa chủ đề này?')) {
                        alert('Xóa chủ đề: ' + card.querySelector('h4').textContent.trim());
                        card.remove(); // Remove card from DOM for demo
                        updateEmptyTopicsState();
                    }
                });
            }
        });

        function updateEmptyTopicsState() {
            const currentTopics = document.querySelectorAll('.topic-card').length;
            const emptyStateDiv = document.getElementById('empty-topics-state');
            if (emptyStateDiv) {
                if (currentTopics === 0) {
                    emptyStateDiv.classList.remove('hidden');
                } else {
                    emptyStateDiv.classList.add('hidden');
                }
            }
        }
        updateEmptyTopicsState(); // Initial check on load
    });
</script>

</body>
</html>