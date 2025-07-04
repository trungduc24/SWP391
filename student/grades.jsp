<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Điểm số - Hệ thống Quản lý Học tập</title>
    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
    <script>tailwind.config={theme:{extend:{colors:{primary:'#4f46e5',secondary:'#818cf8'},borderRadius:{'none':'0px','sm':'4px',DEFAULT:'8px','md':'12px','lg':'16px','xl':'20px','2xl':'24px','3xl':'32px','full':'9999px','button':'8px'}}}}</script>
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

        /* Responsive table for grades */
        @media screen and (max-width: 768px) {
            .grades-table thead {
                display: none;
            }
            .grades-table, .grades-table tbody, .grades-table tr, .grades-table td {
                display: block;
                width: 100%;
            }
            .grades-table tr {
                margin-bottom: 1rem;
                border: 1px solid #e5e7eb;
                border-radius: 0.5rem;
                overflow: hidden;
            }
            .grades-table td {
                text-align: right;
                padding-left: 50%;
                position: relative;
            }
            .grades-table td::before {
                content: attr(data-label);
                position: absolute;
                left: 0;
                width: 50%;
                padding-left: 1rem;
                font-weight: 600;
                text-align: left;
                color: #4b5563;
            }
        }
    </style>
</head>
<body>
<div class="min-h-screen flex">
    <aside class="hidden md:flex flex-col w-64 bg-white border-r border-gray-200 shadow-sm">
        <div class="p-4 border-b border-gray-200 flex items-center">
            <span class="text-2xl font-['Pacifico'] text-primary">logo</span>
            <span class="ml-2 text-lg font-semibold text-gray-800">LMS</span>
        </div>
        <nav class="flex-1 pt-4 pb-4 overflow-y-auto custom-scrollbar">
            <ul>
                <li class="px-4 py-2">
                    <a href="./dashboard.jsp" class="flex items-center text-gray-600 hover:text-primary">
                        <div class="w-6 h-6 flex items-center justify-center mr-3">
                            <i class="ri-dashboard-line"></i>
                        </div>
                        <span>Trang chủ</span>
                    </a>
                </li>
                <li class="px-4 py-2">
                    <a href="./courses.jsp" class="flex items-center text-gray-600 hover:text-primary">
                        <div class="w-6 h-6 flex items-center justify-center mr-3">
                            <i class="ri-book-open-line"></i>
                        </div>
                        <span>Khóa học của tôi</span>
                    </a>
                </li>
                <li class="px-4 py-2">
                    <a href="./calendar.jsp" class="flex items-center text-gray-600 hover:text-primary">
                        <div class="w-6 h-6 flex items-center justify-center mr-3">
                            <i class="ri-calendar-line"></i>
                        </div>
                        <span>Lịch học</span>
                    </a>
                </li>
                <li class="px-4 py-2">
                    <a href="./assignments.jsp" class="flex items-center text-gray-600 hover:text-primary">
                        <div class="w-6 h-6 flex items-center justify-center mr-3">
                            <i class="ri-file-list-3-line"></i>
                        </div>
                        <span>Bài tập/Kiểm tra</span>
                    </a>
                </li>
                <li class="px-4 py-2">
                    <a href="./grades.jsp" class="flex items-center text-primary font-medium">
                        <div class="w-6 h-6 flex items-center justify-center mr-3">
                            <i class="ri-bar-chart-line"></i>
                        </div>
                        <span>Điểm số</span>
                    </a>
                </li>
                <li class="px-4 py-2">
                    <a href="./forum.jsp" class="flex items-center text-gray-600 hover:text-primary">
                        <div class="w-6 h-6 flex items-center justify-center mr-3">
                            <i class="ri-discuss-line"></i>
                        </div>
                        <span>Diễn đàn</span>
                    </a>
                </li>
                <li class="px-4 py-2">
                    <a href="./documents.jsp" class="flex items-center text-gray-600 hover:text-primary">
                        <div class="w-6 h-6 flex items-center justify-center mr-3">
                            <i class="ri-file-paper-2-line"></i>
                        </div>
                        <span>Tài liệu</span>
                    </a>
                </li>
                <li class="px-4 py-2">
                    <a href="./settings.jsp" class="flex items-center text-gray-600 hover:text-primary">
                        <div class="w-6 h-6 flex items-center justify-center mr-3">
                            <i class="ri-settings-3-line"></i>
                        </div>
                        <span>Cài đặt</span>
                    </a>
                </li>
            </ul>
        </nav>
        <div class="p-4 border-t border-gray-200">
            <div class="flex items-center">
                <img src="https://readdy.ai/api/search-image?query=professional%2520portrait%2520photo%2520of%2520a%2520young%2520vietnamese%2520male%2520student%2520with%2520short%2520black%2520hair%252C%2520casual%2520outfit%252C%2520neutral%2520background%252C%2520friendly%2520smile&width=100&height=100&seq=1&orientation=squarish" alt="Avatar" class="w-10 h-10 rounded-full object-cover">
                <div class="ml-3">
                    <p class="text-sm font-medium text-gray-800">Nguyễn Văn Minh</p>
                    <p class="text-xs text-gray-500">SV2023405</p>
                </div>
            </div>
            <button class="mt-3 w-full flex items-center justify-center gap-2 text-sm text-gray-600 hover:text-primary !rounded-button">
                <div class="w-4 h-4 flex items-center justify-center">
                    <i class="ri-logout-box-line"></i>
                </div>
                <span class="whitespace-nowrap">Đăng xuất</span>
            </button>
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
            <div class="max-w-7xl mx-auto">
                <h1 class="text-2xl font-bold text-gray-800 mb-2">Điểm số</h1>
                <p class="text-gray-600 mb-6">Tổng quan về kết quả học tập của bạn qua các môn.</p>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
                    <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-4">
                        <h2 class="text-lg font-semibold text-gray-800 mb-3">Điểm trung bình tích lũy (GPA)</h2>
                        <div class="text-4xl font-bold text-primary text-center">3.25</div>
                        <p class="text-sm text-gray-500 text-center">trên thang điểm 4.0</p>
                    </div>
                    <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-4">
                        <h2 class="text-lg font-semibold text-gray-800 mb-3">Số môn học đã hoàn thành</h2>
                        <div class="flex justify-around items-center">
                            <div class="text-center">
                                <p class="text-3xl font-bold text-green-600">8</p>
                                <p class="text-sm text-gray-500">Đạt</p>
                            </div>
                            <div class="text-center">
                                <p class="text-3xl font-bold text-red-600">0</p>
                                <p class="text-sm text-gray-500">Không đạt</p>
                            </div>
                        </div>
                    </div>
                    <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-4">
                        <h2 class="text-lg font-semibold text-gray-800 mb-3">Xu hướng điểm số</h2>
                        <div class="w-full h-28 bg-gray-100 flex items-center justify-center text-gray-500 rounded-md">
                            Biểu đồ xu hướng điểm số (placeholder)
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-4 mb-6 flex flex-col md:flex-row items-center justify-between gap-4">
                    <div class="relative flex-1 w-full md:w-auto">
                        <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                            <i class="ri-search-line text-gray-400"></i>
                        </div>
                        <input type="text" id="gradeSearchInput" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg block w-full pl-10 p-2.5 focus:ring-primary/20 focus:border-primary" placeholder="Tìm kiếm môn học...">
                    </div>
                    <select id="semesterFilter" class="block w-full md:w-auto px-3 py-2 border border-gray-300 bg-white rounded-lg shadow-sm focus:outline-none focus:ring-primary/20 focus:border-primary text-sm">
                        <option value="all">Tất cả học kỳ</option>
                        <option value="HK1_2024-2025">Học kỳ 1, 2024-2025</option>
                        <option value="HK2_2024-2025">Học kỳ 2, 2024-2025</option>
                        <option value="HKS_2024">Học kỳ hè, 2024</option>
                    </select>
                    <select id="gradeTypeFilter" class="block w-full md:w-auto px-3 py-2 border border-gray-300 bg-white rounded-lg shadow-sm focus:outline-none focus:ring-primary/20 focus:border-primary text-sm">
                        <option value="all">Tất cả loại điểm</option>
                        <option value="process">Điểm quá trình</option>
                        <option value="midterm">Điểm giữa kỳ</option>
                        <option value="final">Điểm cuối kỳ</option>
                        <option value="total">Điểm tổng kết</option>
                    </select>
                    <select id="sortOrderFilter" class="block w-full md:w-auto px-3 py-2 border border-gray-300 bg-white rounded-lg shadow-sm focus:outline-none focus:ring-primary/20 focus:border-primary text-sm">
                        <option value="asc">Sắp xếp: A-Z (Môn học)</option>
                        <option value="desc">Sắp xếp: Z-A (Môn học)</option>
                        <option value="grade_desc">Điểm tổng kết: Cao - Thấp</option>
                        <option value="grade_asc">Điểm tổng kết: Thấp - Cao</option>
                    </select>
                </div>

                <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden">
                    <table class="min-w-full divide-y divide-gray-200 grades-table">
                        <thead class="bg-gray-50">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Tên môn học
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Điểm quá trình
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Điểm giữa kỳ
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Điểm cuối kỳ
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Điểm tổng kết
                            </th>
                        </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200" id="gradesTableBody">
                        <tr data-semester="HK1_2024-2025" data-course="Lập trình hướng đối tượng" data-total-grade="8.5">
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Tên môn học">
                                <div class="text-sm font-medium text-gray-900">Lập trình hướng đối tượng</div>
                                <div class="text-sm text-gray-500">CS201</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Điểm quá trình">
                                <span class="text-sm text-gray-900">8.0</span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Điểm giữa kỳ">
                                <span class="text-sm text-gray-900">8.5</span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Điểm cuối kỳ">
                                <span class="text-sm text-gray-900">9.0</span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Điểm tổng kết">
                                <span class="text-sm font-bold text-primary">8.5</span>
                            </td>
                        </tr>
                        <tr data-semester="HK1_2024-2025" data-course="Cơ sở dữ liệu" data-total-grade="7.8">
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Tên môn học">
                                <div class="text-sm font-medium text-gray-900">Cơ sở dữ liệu</div>
                                <div class="text-sm text-gray-500">IT305</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Điểm quá trình">
                                <span class="text-sm text-gray-900">7.5</span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Điểm giữa kỳ">
                                <span class="text-sm text-gray-900">8.0</span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Điểm cuối kỳ">
                                <span class="text-sm text-gray-900">7.8</span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Điểm tổng kết">
                                <span class="text-sm font-bold text-primary">7.8</span>
                            </td>
                        </tr>
                        <tr data-semester="HK1_2024-2025" data-course="Mạng máy tính" data-total-grade="6.5">
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Tên môn học">
                                <div class="text-sm font-medium text-gray-900">Mạng máy tính</div>
                                <div class="text-sm text-gray-500">NET202</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Điểm quá trình">
                                <span class="text-sm text-gray-900">6.0</span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Điểm giữa kỳ">
                                <span class="text-sm text-gray-900">6.5</span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Điểm cuối kỳ">
                                <span class="text-sm text-gray-900">7.0</span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Điểm tổng kết">
                                <span class="text-sm font-bold text-primary">6.5</span>
                            </td>
                        </tr>
                        <tr data-semester="HK2_2024-2025" data-course="Thiết kế Web" data-total-grade="9.2">
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Tên môn học">
                                <div class="text-sm font-medium text-gray-900">Thiết kế Web</div>
                                <div class="text-sm text-gray-500">WEB301</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Điểm quá trình">
                                <span class="text-sm text-gray-900">9.0</span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Điểm giữa kỳ">
                                <span class="text-sm text-gray-900">9.5</span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Điểm cuối kỳ">
                                <span class="text-sm text-gray-900">9.0</span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Điểm tổng kết">
                                <span class="text-sm font-bold text-primary">9.2</span>
                            </td>
                        </tr>
                        <tr data-semester="HK2_2024-2025" data-course="Trí tuệ nhân tạo" data-total-grade="7.0">
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Tên môn học">
                                <div class="text-sm font-medium text-gray-900">Trí tuệ nhân tạo</div>
                                <div class="text-sm text-gray-500">AI401</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Điểm quá trình">
                                <span class="text-sm text-gray-900">7.0</span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Điểm giữa kỳ">
                                <span class="text-sm text-gray-900">6.5</span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Điểm cuối kỳ">
                                <span class="text-sm text-gray-900">7.5</span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap" data-label="Điểm tổng kết">
                                <span class="text-sm font-bold text-primary">7.0</span>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>

                <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-4 mt-6">
                    <h2 class="text-lg font-semibold text-gray-800 mb-3">Đề xuất cải thiện điểm</h2>
                    <p class="text-sm text-gray-600">
                        Dựa trên kết quả học tập của bạn, chúng tôi đề xuất bạn nên dành thêm thời gian ôn tập môn "Mạng máy tính" để cải thiện điểm tổng kết. Bạn có thể xem lại tài liệu học tập, tham gia nhóm học, hoặc tìm kiếm sự hỗ trợ từ giảng viên.
                    </p>
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
        <a href="./grades.jsp" class="flex flex-col items-center py-2 text-primary">
            <div class="w-6 h-6 flex items-center justify-center">
                <i class="ri-bar-chart-line"></i>
            </div>
            <span class="text-xs mt-1">Điểm</span>
        </a>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Mobile Menu Toggle (reused from previous pages)
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

        // Grades Table Filtering and Search
        const gradeSearchInput = document.getElementById('gradeSearchInput');
        const semesterFilter = document.getElementById('semesterFilter');
        const gradeTypeFilter = document.getElementById('gradeTypeFilter');
        const sortOrderFilter = document.getElementById('sortOrderFilter');
        const gradesTableBody = document.getElementById('gradesTableBody');
        let allGradeRows = Array.from(gradesTableBody.querySelectorAll('tr'));

        function filterAndSortGrades() {
            const searchTerm = gradeSearchInput.value.toLowerCase();
            const selectedSemester = semesterFilter.value;
            const selectedGradeType = gradeTypeFilter.value; // Not fully implemented for display, but for logic
            const selectedSortOrder = sortOrderFilter.value;

            let filteredRows = allGradeRows.filter(row => {
                const courseName = row.querySelector('td[data-label="Tên môn học"] .text-sm.font-medium').textContent.toLowerCase();
                const courseCode = row.querySelector('td[data-label="Tên môn học"] .text-sm.text-gray-500').textContent.toLowerCase();
                const semester = row.dataset.semester;

                const matchesSearch = courseName.includes(searchTerm) || courseCode.includes(searchTerm);
                const matchesSemester = selectedSemester === 'all' || semester === selectedSemester;

                return matchesSearch && matchesSemester;
            });

            // Sorting logic
            filteredRows.sort((a, b) => {
                const courseA = a.dataset.course.toLowerCase();
                const courseB = b.dataset.course.toLowerCase();
                const gradeA = parseFloat(a.dataset.totalGrade);
                const gradeB = parseFloat(b.dataset.totalGrade);

                if (selectedSortOrder === 'asc') {
                    return courseA.localeCompare(courseB);
                } else if (selectedSortOrder === 'desc') {
                    return courseB.localeCompare(courseA);
                } else if (selectedSortOrder === 'grade_desc') {
                    return gradeB - gradeA;
                } else if (selectedSortOrder === 'grade_asc') {
                    return gradeA - gradeB;
                }
                return 0;
            });

            // Clear current table and append sorted/filtered rows
            gradesTableBody.innerHTML = '';
            filteredRows.forEach(row => {
                gradesTableBody.appendChild(row);
            });
        }

        // Add event listeners
        gradeSearchInput.addEventListener('keyup', filterAndSortGrades);
        semesterFilter.addEventListener('change', filterAndSortGrades);
        gradeTypeFilter.addEventListener('change', filterAndSortGrades); // This filter will need more complex logic to show/hide specific grade columns if desired
        sortOrderFilter.addEventListener('change', filterAndSortGrades);

        // Initial filter and sort application
        filterAndSortGrades();
    });
</script>
</body>
</html>