<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Điểm số - Hệ Thống LMS</title>
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

        /* Responsive Table (Card View on Mobile) */
        @media screen and (max-width: 767px) {
            .table-responsive thead {
                display: none;
            }
            .table-responsive tbody, .table-responsive tr {
                display: block;
                width: 100%;
            }
            .table-responsive tr {
                margin-bottom: 1rem;
                border: 1px solid #e5e7eb;
                border-radius: 0.5rem;
                overflow: hidden;
                box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            }
            .table-responsive td {
                display: block;
                width: 100%;
                border-bottom: 1px solid #e5e7eb;
                padding: 0.75rem 1rem;
                text-align: right;
                position: relative;
                padding-left: 50%; /* Space for the data-label */
            }
            .table-responsive td:last-child {
                border-bottom: 0;
            }
            .table-responsive td::before {
                content: attr(data-label);
                position: absolute;
                left: 1rem;
                width: calc(50% - 1rem);
                text-align: left;
                font-weight: 500;
                color: #4b5563;
            }
            .table-responsive td.actions-cell {
                text-align: left;
                padding-left: 1rem;
            }
            .table-responsive td.actions-cell::before {
                content: none;
            }
        }
        .editable-grade {
            border: 1px solid #d1d5db;
            border-radius: 4px;
            padding: 4px 8px;
            width: 60px; /* Adjust width as needed */
            text-align: center;
            outline: none;
            transition: border-color 0.2s;
        }
        .editable-grade:focus {
            border-color: #4f46e5;
            box-shadow: 0 0 0 2px rgba(79, 70, 229, 0.2);
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
                <h1 class="text-2xl font-bold text-gray-900">Quản lý Điểm số</h1>
                <p class="text-sm text-gray-500 mt-1">Tổng hợp và quản lý điểm số của sinh viên.</p>
            </div>
            <div class="flex flex-wrap items-center gap-3">
                <select class="px-4 py-2 border border-gray-300 rounded-button text-sm text-gray-700 focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent">
                    <option value="all-courses">Tất cả khóa học</option>
                    <option value="cs401">CS401 - Lập trình web nâng cao</option>
                    <option value="cs203">CS203 - Cơ sở dữ liệu</option>
                    <option value="cs202">CS202 - Lập trình Java</option>
                </select>
                <select class="px-4 py-2 border border-gray-300 rounded-button text-sm text-gray-700 focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent">
                    <option value="all-semesters">Tất cả học kỳ</option>
                    <option value="hk1-2024">Học kỳ 1 (2024-2025)</option>
                    <option value="hk2-2024">Học kỳ 2 (2024-2025)</option>
                    <option value="hk1-2025">Học kỳ 1 (2025-2026)</option>
                </select>
                <button id="saveGradesBtn" class="px-4 py-2 bg-primary text-white text-sm font-medium rounded-button hover:bg-primary/90 flex items-center gap-2 hidden" title="Lưu toàn bộ điểm vừa cập nhật">
                    <i class="ri-save-line"></i>
                    <span>Lưu điểm</span>
                </button>
                <button id="bulkImportBtn" class="px-4 py-2 bg-indigo-600 text-white text-sm font-medium rounded-button hover:bg-indigo-700 flex items-center gap-2" title="Cho phép chỉnh sửa điểm và hiển thị nút lưu">
                    <i class="ri-file-excel-line"></i>
                    <span>Nhập điểm</span>
                </button>
                <button id="exportGradesBtn" class="px-4 py-2 bg-emerald-600 text-white text-sm font-medium rounded-button hover:bg-emerald-700 flex items-center gap-2" title="Xuất bảng điểm ra file">
                    <i class="ri-download-line"></i>
                    <span>Xuất điểm</span>
                </button>
            </div>
        </div>

        <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-x-auto mb-6">
            <table class="min-w-full divide-y divide-gray-200 table-responsive">
                <thead class="bg-gray-50">
                    <tr>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tên môn</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Mã số SV</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Họ tên</th>
                        <th scope="col" class="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">QT1 (20%)</th>
                        <th scope="col" class="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">QT2 (20%)</th>
                        <th scope="col" class="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">Giữa kỳ (30%)</th>
                        <th scope="col" class="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">Cuối kỳ (30%)</th>
                        <th scope="col" class="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">Tổng kết</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Trạng thái</th>
                        <th scope="col" class="relative px-6 py-3">
                            <span class="sr-only">Thao tác</span>
                        </th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" data-label="Tên môn">CS203 - Cơ sở dữ liệu</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" data-label="Mã số SV">20210001</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900" data-label="Họ tên">Trần Minh Hiếu</td>
                        <td class="px-6 py-4 whitespace-nowrap text-center" data-label="QT1 (20%)">
                            <input type="number" step="0.1" min="0" max="10" value="9.0" class="editable-grade" readonly>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-center" data-label="QT2 (20%)">
                            <input type="number" step="0.1" min="0" max="10" value="8.5" class="editable-grade" readonly>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-center" data-label="Giữa kỳ (30%)">
                            <input type="number" step="0.1" min="0" max="10" value="8.8" class="editable-grade" readonly>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-center" data-label="Cuối kỳ (30%)">
                            <input type="number" step="0.1" min="0" max="10" value="9.2" class="editable-grade" readonly>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-bold text-gray-900" data-label="Tổng kết">8.9</td>
                        <td class="px-6 py-4 whitespace-nowrap" data-label="Trạng thái">
                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                Đạt
                            </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium actions-cell">
                            <button class="text-primary hover:text-primary/80 grade-history-btn" title="Lịch sử chỉnh sửa điểm">
                                <i class="ri-history-line"></i>
                            </button>
                            <button class="text-gray-600 hover:text-gray-900 ml-3 add-note-btn" title="Thêm ghi chú đánh giá">
                                <i class="ri-sticky-note-line"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" data-label="Tên môn">CS203 - Cơ sở dữ liệu</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" data-label="Mã số SV">20210002</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900" data-label="Họ tên">Lê Thị Thảo</td>
                        <td class="px-6 py-4 whitespace-nowrap text-center" data-label="QT1 (20%)">
                            <input type="number" step="0.1" min="0" max="10" value="7.5" class="editable-grade" readonly>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-center" data-label="QT2 (20%)">
                            <input type="number" step="0.1" min="0" max="10" value="6.8" class="editable-grade" readonly>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-center" data-label="Giữa kỳ (30%)">
                            <input type="number" step="0.1" min="0" max="10" value="7.0" class="editable-grade" readonly>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-center" data-label="Cuối kỳ (30%)">
                            <input type="number" step="0.1" min="0" max="10" value="6.5" class="editable-grade" readonly>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-bold text-gray-900" data-label="Tổng kết">6.9</td>
                        <td class="px-6 py-4 whitespace-nowrap" data-label="Trạng thái">
                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                Đạt
                            </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium actions-cell">
                            <button class="text-primary hover:text-primary/80 grade-history-btn" title="Lịch sử chỉnh sửa điểm">
                                <i class="ri-history-line"></i>
                            </button>
                            <button class="text-gray-600 hover:text-gray-900 ml-3 add-note-btn" title="Thêm ghi chú đánh giá">
                                <i class="ri-sticky-note-line"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" data-label="Tên môn">CS203 - Cơ sở dữ liệu</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" data-label="Mã số SV">20210003</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900" data-label="Họ tên">Nguyễn Văn An</td>
                        <td class="px-6 py-4 whitespace-nowrap text-center" data-label="QT1 (20%)">
                            <input type="number" step="0.1" min="0" max="10" value="4.0" class="editable-grade" readonly>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-center" data-label="QT2 (20%)">
                            <input type="number" step="0.1" min="0" max="10" value="5.5" class="editable-grade" readonly>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-center" data-label="Giữa kỳ (30%)">
                            <input type="number" step="0.1" min="0" max="10" value="4.8" class="editable-grade" readonly>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-center" data-label="Cuối kỳ (30%)">
                            <input type="number" step="0.1" min="0" max="10" value="4.2" class="editable-grade" readonly>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-bold text-red-600" data-label="Tổng kết">4.6</td>
                        <td class="px-6 py-4 whitespace-nowrap" data-label="Trạng thái">
                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800">
                                Không đạt
                            </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium actions-cell">
                            <button class="text-primary hover:text-primary/80 grade-history-btn" title="Lịch sử chỉnh sửa điểm">
                                <i class="ri-history-line"></i>
                            </button>
                            <button class="text-gray-600 hover:text-gray-900 ml-3 add-note-btn" title="Thêm ghi chú đánh giá">
                                <i class="ri-sticky-note-line"></i>
                            </button>
                        </td>
                    </tr>
                    <tr id="empty-state" class="hidden">
                        <td colspan="10" class="px-6 py-10 text-center text-gray-500">
                            <i class="ri-file-chart-line text-5xl mb-3 text-gray-400"></i>
                            <p class="text-lg font-medium mb-2">Không có dữ liệu điểm số nào được tìm thấy.</p>
                            <p class="text-sm">Vui lòng chọn khóa học/học kỳ khác hoặc nhập điểm mới.</p>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-5 mb-6">
            <h3 class="text-lg font-semibold text-gray-900 mb-4">Biểu đồ phân tích điểm</h3>
            <div class="h-64 flex items-center justify-center bg-gray-50 rounded-md border border-gray-200 text-gray-500">
                <p>Nơi hiển thị biểu đồ phân phối điểm (Histogram) và thống kê A, B, C, D, F, điểm trung bình...</p>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mt-4 text-sm text-gray-700">
                <div><strong>Điểm trung bình lớp:</strong> 7.8</div>
                <div><strong>Tỷ lệ đạt:</strong> 85%</div>
                <div><strong>Sinh viên cần quan tâm:</strong> 3</div>
            </div>
        </div>

    </div>
</main>

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

        // Action buttons
        const saveGradesBtn = document.getElementById('saveGradesBtn'); // New button
        const bulkImportBtn = document.getElementById('bulkImportBtn'); // Renamed to act as "Enable Editing"
        const exportGradesBtn = document.getElementById('exportGradesBtn');
        const notifyStudentsBtn = document.getElementById('notifyStudentsBtn'); // Note: This button does not exist in the provided HTML.
        const editableGrades = document.querySelectorAll('.editable-grade');
        const gradeHistoryBtns = document.querySelectorAll('.grade-history-btn');
        const addNoteBtns = document.querySelectorAll('.add-note-btn');

        // Function to export table to CSV
        function exportTableToCSV(filename) {
            const table = document.querySelector('.table-responsive');
            let csv = [];
            const rows = table.querySelectorAll('tr');

            for (let i = 0; i < rows.length; i++) {
                const row = [], cols = rows[i].querySelectorAll('td, th');
                for (let j = 0; j < cols.length; j++) {
                    let data = cols[j].innerText.replace(/(\r\n|\n|\r)/gm, '').replace(/(\s\s)/gm, ' ').trim();
                    data = data.replace(/"/g, '""'); // Escape double quotes
                    // If the cell contains an input, use its value
                    const inputElement = cols[j].querySelector('input[type="number"]');
                    if (inputElement) {
                        data = inputElement.value;
                    }
                    row.push('"' + data + '"');
                }
                csv.push(row.join(','));
            }

            const csvString = csv.join('\n');
            const blob = new Blob([csvString], { type: 'text/csv;charset=utf-8;' });
            const link = document.createElement('a');
            link.href = URL.createObjectURL(blob);
            link.setAttribute('download', filename);
            document.body.appendChild(link); // Required for Firefox
            link.click();
            document.body.removeChild(link); // Clean up
        }


        if (exportGradesBtn) {
            exportGradesBtn.addEventListener('click', function() {
                exportTableToCSV('bang_diem_LMS.csv');
                console.log('Xuất điểm clicked - CSV download initiated');
            });
        }

        if (bulkImportBtn) {
            bulkImportBtn.addEventListener('click', function() {
                // Hide "Nhập điểm" button
                bulkImportBtn.classList.add('hidden');
                // Show "Lưu điểm" button
                saveGradesBtn.classList.remove('hidden');

                // Enable editing for all grade inputs
                editableGrades.forEach(input => {
                    input.readOnly = false;
                });
                alert('Chế độ chỉnh sửa điểm đã được bật. Vui lòng chỉnh sửa và nhấn "Lưu điểm"!');
                console.log('Chế độ chỉnh sửa điểm đã được bật.');
            });
        }

        if (saveGradesBtn) {
            saveGradesBtn.addEventListener('click', function() {
                alert('Điểm đã được lưu thành công! (Đây là demo, không lưu thực tế)'); // Placeholder for actual save logic
                console.log('Lưu điểm clicked');

                // After saving, revert to read-only mode and switch buttons back
                editableGrades.forEach(input => {
                    input.readOnly = true;
                });
                saveGradesBtn.classList.add('hidden');
                bulkImportBtn.classList.remove('hidden');
            });
        }

        // Removed individual input change listener as per the new bulk save flow
        // editableGrades.forEach(input => {
        //     input.addEventListener('change', function() {
        //         const studentId = this.closest('tr').querySelector('[data-label="Mã số SV"]').textContent;
        //         const scoreType = this.closest('td').getAttribute('data-label');
        //         const newScore = this.value;
        //         alert(`Lưu điểm mới: Sinh viên ${studentId}, ${scoreType}: ${newScore}! (Đây là demo, không lưu thực tế)`);
        //         console.log(`Điểm của sinh viên ${studentId} cho ${scoreType} đã thay đổi thành ${newScore}`);
        //         // In a real application, you would send an AJAX request to update the database
        //     });
        // });

        gradeHistoryBtns.forEach(button => {
            button.addEventListener('click', function() {
                const studentId = this.closest('tr').querySelector('[data-label="Mã số SV"]').textContent;
                alert(`Mở cửa sổ lịch sử chỉnh sửa điểm của sinh viên ${studentId}!`); // Placeholder for actual history display
                console.log(`Lịch sử chỉnh sửa điểm của ${studentId} clicked`);
            });
        });

        addNoteBtns.forEach(button => {
            button.addEventListener('click', function() {
                const studentId = this.closest('tr').querySelector('[data-label="Mã số SV"]').textContent;
                alert(`Mở form/modal ghi chú đánh giá cho sinh viên ${studentId}!`); // Placeholder for actual form/modal
                console.log(`Thêm ghi chú đánh giá cho ${studentId} clicked`);
            });
        });

        // Example for "empty state" display
        // You would typically toggle this based on your data fetching results
        // const emptyStateRow = document.getElementById('empty-state');
        // if (someConditionForNoGrades) { // Replace 'someConditionForNoGrades' with actual logic
        //    emptyStateRow.classList.remove('hidden');
        // } else {
        //    emptyStateRow.classList.add('hidden');
        // }
    });
</script>

</body>
</html>