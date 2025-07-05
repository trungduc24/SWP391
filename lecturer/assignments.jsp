<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Bài tập - Hệ Thống LMS</title>
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

        /* Modal specific styles */
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
        }
        .modal-content {
            background-color: #fff;
            padding: 1.5rem;
            border-radius: 0.5rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 90%;
            max-height: 90%;
            overflow-y: auto;
            position: relative;
        }
        @media (min-width: 768px) {
            .modal-content {
                width: 600px; /* Example fixed width for larger screens */
            }
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
                <h1 class="text-2xl font-bold text-gray-900">Quản lý Bài tập</h1>
                <p class="text-sm text-gray-500 mt-1">Danh sách các bài tập của các khóa học.</p>
            </div>
            <button id="createAssignmentBtn" class="px-4 py-2 bg-primary text-white text-sm font-medium rounded-button hover:bg-primary/90 flex items-center gap-2">
                <i class="ri-add-line"></i>
                <span>Tạo bài tập mới</span>
            </button>
        </div>

        <div class="bg-white rounded-lg shadow-sm p-5 border border-gray-100 mb-6 flex flex-col md:flex-row items-center justify-between gap-4">
            <div class="flex flex-col sm:flex-row gap-4 w-full md:w-auto">
                <select class="w-full sm:w-auto px-4 py-2 border border-gray-300 rounded-button text-sm text-gray-700 focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent">
                    <option value="all-courses">Tất cả khóa học</option>
                    <option value="cs401">CS401 - Lập trình web nâng cao</option>
                    <option value="cs203">CS203 - Cơ sở dữ liệu</option>
                    <option value="cs202">CS202 - Lập trình Java</option>
                </select>
                <select class="w-full sm:w-auto px-4 py-2 border border-gray-300 rounded-button text-sm text-gray-700 focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent">
                    <option value="all-status">Tất cả trạng thái</option>
                    <option value="due-soon">Sắp đến hạn</option>
                    <option value="overdue">Quá hạn</option>
                    <option value="submitted">Đã nộp</option>
                    <option value="not-submitted">Chưa nộp</option>
                    <option value="graded">Đã chấm</option>
                    <option value="not-graded">Chưa chấm</option>
                </select>
            </div>
            <div class="relative w-full md:w-1/3">
                <input type="text" placeholder="Tìm kiếm bài tập..." class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-button focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm">
                <i class="ri-search-line absolute left-3 top-1/2 -translate-y-1/2 text-gray-400"></i>
            </div>
        </div>

        <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-x-auto mb-6">
            <table class="min-w-full divide-y divide-gray-200 table-responsive">
                <thead class="bg-gray-50">
                    <tr>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tên bài tập</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Khóa học</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Nộp bài</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Thời hạn nộp</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Trạng thái</th>
                        <th scope="col" class="relative px-6 py-3">
                            <span class="sr-only">Thao tác</span>
                        </th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900" data-label="Tên bài tập">Bài tập lớn giữa kỳ</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" data-label="Khóa học">CS401 - Lập trình web nâng cao</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" data-label="Nộp bài">55/60</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" data-label="Thời hạn nộp">20/05/2025 23:59</td>
                        <td class="px-6 py-4 whitespace-nowrap" data-label="Trạng thái">
                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-blue-100 text-blue-800" title="Bài tập đã được chấm điểm">
                                Đã chấm
                            </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium actions-cell">
                            <button class="text-primary hover:text-primary/80 mr-3 assignment-detail-btn" data-assignment-name="Bài tập lớn giữa kỳ" title="Xem chi tiết bài tập">Xem chi tiết</button>
                            <button class="text-indigo-600 hover:text-indigo-900 mr-3 grade-assignment-btn" data-assignment-name="Bài tập lớn giữa kỳ" title="Chấm điểm các bài nộp">Chấm điểm</button>
                            <button class="text-emerald-600 hover:text-emerald-900 export-grade-btn" data-course-id="CS401" data-assignment-id="BTGK" title="Xuất điểm bài tập">Xuất điểm</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900" data-label="Tên bài tập">Bài tập 2 - Array & ArrayList</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" data-label="Khóa học">CS202 - Lập trình Java</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" data-label="Nộp bài">48/55</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-red-600 font-semibold" data-label="Thời hạn nộp">15/06/2025 23:59 (Quá hạn)</td>
                        <td class="px-6 py-4 whitespace-nowrap" data-label="Trạng thái">
                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800" title="Bài tập đã quá hạn và chưa được chấm">
                                Quá hạn / Chưa chấm
                            </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium actions-cell">
                            <button class="text-primary hover:text-primary/80 mr-3 assignment-detail-btn" data-assignment-name="Bài tập 2 - Array & ArrayList" title="Xem chi tiết bài tập">Xem chi tiết</button>
                            <button class="text-indigo-600 hover:text-indigo-900 mr-3 grade-assignment-btn" data-assignment-name="Bài tập 2 - Array & ArrayList" title="Chấm điểm các bài nộp">Chấm điểm</button>
                            <button class="text-emerald-600 hover:text-emerald-900 export-grade-btn" data-course-id="CS202" data-assignment-id="BT2" title="Xuất điểm bài tập">Xuất điểm</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900" data-label="Tên bài tập">Đồ án cuối kỳ</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" data-label="Khóa học">CS401 - Lập trình web nâng cao</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" data-label="Nộp bài">0/60</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" data-label="Thời hạn nộp">30/07/2025 23:59</td>
                        <td class="px-6 py-4 whitespace-nowrap" data-label="Trạng thái">
                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800" title="Bài tập chưa đến hạn nộp">
                                Sắp đến hạn
                            </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium actions-cell">
                            <button class="text-primary hover:text-primary/80 mr-3 assignment-detail-btn" data-assignment-name="Đồ án cuối kỳ" title="Xem chi tiết bài tập">Xem chi tiết</button>
                            <button class="text-indigo-600 hover:text-indigo-900 mr-3 grade-assignment-btn" data-assignment-name="Đồ án cuối kỳ" title="Chấm điểm các bài nộp">Chấm điểm</button>
                            <button class="text-emerald-600 hover:text-emerald-900 export-grade-btn" data-course-id="CS401" data-assignment-id="DA_CK" title="Xuất điểm bài tập">Xuất điểm</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900" data-label="Tên bài tập">Bài tập 1 - SQL Cơ bản</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" data-label="Khóa học">CS203 - Cơ sở dữ liệu</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" data-label="Nộp bài">45/48</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" data-label="Thời hạn nộp">01/05/2025 23:59</td>
                        <td class="px-6 py-4 whitespace-nowrap" data-label="Trạng thái">
                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-blue-100 text-blue-800" title="Bài tập đã được chấm điểm">
                                Đã chấm
                            </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium actions-cell">
                            <button class="text-primary hover:text-primary/80 mr-3 assignment-detail-btn" data-assignment-name="Bài tập 1 - SQL Cơ bản" title="Xem chi tiết bài tập">Xem chi tiết</button>
                            <button class="text-indigo-600 hover:text-indigo-900 mr-3 grade-assignment-btn" data-assignment-name="Bài tập 1 - SQL Cơ bản" title="Chấm điểm các bài nộp">Chấm điểm</button>
                            <button class="text-emerald-600 hover:text-emerald-900 export-grade-btn" data-course-id="CS203" data-assignment-id="BT1" title="Xuất điểm bài tập">Xuất điểm</button>
                        </td>
                    </tr>
                    <tr id="empty-state" class="hidden">
                        <td colspan="6" class="px-6 py-10 text-center text-gray-500">
                            <i class="ri-file-search-line text-5xl mb-3 text-gray-400"></i>
                            <p class="text-lg font-medium mb-2">Không có bài tập nào được tìm thấy.</p>
                            <p class="text-sm">Vui lòng thử điều chỉnh bộ lọc hoặc tạo bài tập mới.</p>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="flex flex-col sm:flex-row justify-between items-center gap-4 py-4">
            <div class="text-sm text-gray-700">
                Hiển thị <span class="font-semibold">1-4</span> trong tổng số <span class="font-semibold">8</span> bài tập
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

<div id="createAssignmentModal" class="modal hidden">
    <div class="modal-content w-full md:w-2/3 lg:w-1/2">
        <div class="flex justify-between items-center border-b pb-3 mb-4">
            <h2 class="text-xl font-semibold text-gray-800">Tạo Bài Tập Mới</h2>
            <button class="text-gray-500 hover:text-gray-700 close-modal-btn" data-modal="createAssignmentModal">
                <i class="ri-close-line text-2xl"></i>
            </button>
        </div>
        <form action="submitAssignment.jsp" method="post" enctype="multipart/form-data" class="space-y-4">
            <div>
                <label for="assignmentName" class="block text-sm font-medium text-gray-700 mb-1">Tên bài tập</label>
                <input type="text" id="assignmentName" name="assignmentName" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:ring-primary focus:border-primary" placeholder="Nhập tên bài tập" required>
            </div>
            <div>
                <label for="courseSelect" class="block text-sm font-medium text-gray-700 mb-1">Khóa học</label>
                <select id="courseSelect" name="courseId" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:ring-primary focus:border-primary">
                    <option value="">Chọn khóa học</option>
                    <option value="cs401">CS401 - Lập trình web nâng cao</option>
                    <option value="cs203">CS203 - Cơ sở dữ liệu</option>
                    <option value="cs202">CS202 - Lập trình Java</option>
                </select>
            </div>
            <div>
                <label for="dueDate" class="block text-sm font-medium text-gray-700 mb-1">Thời hạn nộp</label>
                <input type="datetime-local" id="dueDate" name="dueDate" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:ring-primary focus:border-primary">
            </div>
            <div>
                <label for="description" class="block text-sm font-medium text-gray-700 mb-1">Mô tả</label>
                <textarea id="description" name="description" rows="4" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:ring-primary focus:border-primary" placeholder="Mô tả chi tiết bài tập..."></textarea>
            </div>
            <div>
                <label for="maxScore" class="block text-sm font-medium text-gray-700 mb-1">Điểm tối đa</label>
                <input type="number" id="maxScore" name="maxScore" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:ring-primary focus:border-primary" value="100">
            </div>

            <div class="mb-6">
                <label for="assignmentFile" class="block text-sm font-medium text-gray-700 mb-1">Tệp đính kèm (nếu có)</label>
                <input type="file" id="assignmentFile" name="assignmentFile"
                       class="mt-1 block w-full text-sm text-gray-500
                              file:mr-4 file:py-2 file:px-4
                              file:rounded-md file:border-0
                              file:text-sm file:font-semibold
                              file:bg-primary/10 file:text-primary
                              hover:file:bg-primary/20">
                <p class="mt-1 text-xs text-gray-500">Kích thước tệp tối đa: 5MB. Định dạng cho phép: PDF, DOCX, ZIP.</p>
            </div>

            <div class="flex justify-end gap-3 pt-4 border-t mt-4">
                <button type="button" class="px-4 py-2 bg-gray-200 text-gray-700 text-sm font-medium rounded-button hover:bg-gray-300 close-modal-btn" data-modal="createAssignmentModal">Hủy</button>
                <button type="submit" class="px-4 py-2 bg-primary text-white text-sm font-medium rounded-button hover:bg-primary/90">Tạo Bài Tập</button>
            </div>
        </form>
    </div>
</div>

<div id="assignmentDetailModal" class="modal hidden">
    <div class="modal-content">
        <div class="flex justify-between items-center border-b pb-3 mb-4">
            <h2 class="text-xl font-semibold text-gray-800">Chi tiết Bài tập: <span id="detailAssignmentName"></span></h2>
            <button class="text-gray-500 hover:text-gray-700 close-modal-btn" data-modal="assignmentDetailModal">
                <i class="ri-close-line text-2xl"></i>
            </button>
        </div>
        <div class="space-y-3 text-gray-700">
            <p><strong>Tên bài tập:</strong> <span id="detailAssignmentNameDisplay"></span></p>
            <p><strong>Khóa học:</strong> CS401 - Lập trình web nâng cao</p>
            <p><strong>Thời hạn nộp:</strong> 20/05/2025 23:59</p>
            <p><strong>Mô tả:</strong> Đây là bài tập lớn giữa kỳ của môn Lập trình web nâng cao. Sinh viên cần hoàn thành một dự án web nhỏ theo yêu cầu. (Mô tả thực tế sẽ được tải từ DB)</p>
            <p><strong>Điểm tối đa:</strong> 100</p>
            <p><strong>Số lượng đã nộp:</strong> 55/60</p>
            <p><strong>Trạng thái:</strong> Đã chấm</p>
        </div>
        <div class="flex justify-end gap-3 pt-4 border-t mt-4">
            <button type="button" class="px-4 py-2 bg-gray-200 text-gray-700 text-sm font-medium rounded-button hover:bg-gray-300 close-modal-btn" data-modal="assignmentDetailModal">Đóng</button>
        </div>
    </div>
</div>

<div id="gradeAssignmentModal" class="modal hidden">
    <div class="modal-content w-full md:w-3/4 lg:w-2/3">
        <div class="flex justify-between items-center border-b pb-3 mb-4">
            <h2 class="text-xl font-semibold text-gray-800">Chấm điểm Bài tập: <span id="gradeAssignmentName"></span></h2>
            <button class="text-gray-500 hover:text-gray-700 close-modal-btn" data-modal="gradeAssignmentModal">
                <i class="ri-close-line text-2xl"></i>
            </button>
        </div>
        <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-x-auto mb-6">
            <table class="min-w-full divide-y divide-gray-200 table-responsive">
                <thead class="bg-gray-50">
                <tr>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Mã sinh viên</th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tên sinh viên</th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Trạng thái nộp</th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Điểm</th>
                    <th scope="col" class="relative px-6 py-3">
                        <span class="sr-only">Thao tác</span>
                    </th>
                </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                <tr>
                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900" data-label="Mã sinh viên">SV001</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" data-label="Tên sinh viên">Trần Văn A</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm" data-label="Trạng thái nộp">
                        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">Đã nộp</span>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" data-label="Điểm">
                        <input type="number" value="90" min="0" max="100" class="w-20 px-2 py-1 border border-gray-300 rounded-md text-sm focus:ring-primary focus:border-primary">
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium actions-cell">
                        <button class="text-primary hover:text-primary/80">Xem bài nộp</button>
                    </td>
                </tr>
                <tr>
                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900" data-label="Mã sinh viên">SV002</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" data-label="Tên sinh viên">Lê Thị B</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm" data-label="Trạng thái nộp">
                        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800">Chưa nộp</span>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" data-label="Điểm">
                        <input type="number" value="" min="0" max="100" class="w-20 px-2 py-1 border border-gray-300 rounded-md text-sm focus:ring-primary focus:border-primary" placeholder="N/A">
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium actions-cell">
                        <button class="text-gray-400 cursor-not-allowed" disabled>Xem bài nộp</button>
                    </td>
                </tr>
                <tr>
                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900" data-label="Mã sinh viên">SV003</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" data-label="Tên sinh viên">Nguyễn Văn C</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm" data-label="Trạng thái nộp">
                        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">Đã nộp</span>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" data-label="Điểm">
                        <input type="number" value="75" min="0" max="100" class="w-20 px-2 py-1 border border-gray-300 rounded-md text-sm focus:ring-primary focus:border-primary">
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium actions-cell">
                        <button class="text-primary hover:text-primary/80">Xem bài nộp</button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="flex justify-end gap-3 pt-4 border-t mt-4">
            <button type="button" class="px-4 py-2 bg-gray-200 text-gray-700 text-sm font-medium rounded-button hover:bg-gray-300 close-modal-btn" data-modal="gradeAssignmentModal">Hủy</button>
            <button type="submit" class="px-4 py-2 bg-primary text-white text-sm font-medium rounded-button hover:bg-primary/90">Lưu điểm</button>
        </div>
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

        // Get modal elements
        const createAssignmentModal = document.getElementById('createAssignmentModal');
        const assignmentDetailModal = document.getElementById('assignmentDetailModal');
        const gradeAssignmentModal = document.getElementById('gradeAssignmentModal');

        // Get buttons
        const createAssignmentBtn = document.getElementById('createAssignmentBtn');
        const assignmentDetailBtns = document.querySelectorAll('.assignment-detail-btn');
        const gradeAssignmentBtns = document.querySelectorAll('.grade-assignment-btn');
        const exportGradeBtns = document.querySelectorAll('.export-grade-btn');
        const closeModalBtns = document.querySelectorAll('.close-modal-btn'); // All close buttons

        // Function to open a modal
        function openModal(modalElement) {
            modalElement.classList.remove('hidden');
            modalElement.classList.add('flex');
            document.body.style.overflow = 'hidden'; // Prevent scrolling background
        }

        // Function to close a modal
        function closeModal(modalElement) {
            modalElement.classList.remove('flex');
            modalElement.classList.add('hidden');
            document.body.style.overflow = ''; // Restore scrolling
        }

        // Event listener for Create Assignment button
        if (createAssignmentBtn) {
            createAssignmentBtn.addEventListener('click', function() {
                openModal(createAssignmentModal);
                console.log('Mở form tạo bài tập mới!');
            });
        }

        // Event listeners for Assignment Detail buttons
        assignmentDetailBtns.forEach(button => {
            button.addEventListener('click', function(event) {
                event.preventDefault(); // Prevent default link behavior if it were a link
                const assignmentName = this.dataset.assignmentName; // Get data from data-attribute
                document.getElementById('detailAssignmentName').textContent = assignmentName;
                document.getElementById('detailAssignmentNameDisplay').textContent = assignmentName; // Update display
                openModal(assignmentDetailModal);
                console.log('Chuyển đến trang chi tiết của bài tập: ' + assignmentName);
            });
        });
        // Event listeners for Grade Assignment buttons
        gradeAssignmentBtns.forEach(button => {
            button.addEventListener('click', function() {
                const assignmentName = this.dataset.assignmentName; // Get data from data-attribute
                document.getElementById('gradeAssignmentName').textContent = assignmentName;
                openModal(gradeAssignmentModal);
                console.log('Mở giao diện chấm điểm cho bài tập: ' + assignmentName);
            });
        });

        // Event listeners for Export Grade buttons
        exportGradeBtns.forEach(button => {
            button.addEventListener('click', function() {
                const courseId = this.dataset.courseId; // Giả định có data-course-id trên nút
                const assignmentId = this.dataset.assignmentId; // Giả định có data-assignment-id trên nút
                // URL giả định cho backend để xuất CSV
                const exportUrl = `/api/grades/export?courseId=${courseId}&assignmentId=${assignmentId}`;
                
                // Kích hoạt tải file bằng cách điều hướng trình duyệt
                window.location.href = exportUrl;
                
                console.log('Đang xuất file điểm cho bài tập:', assignmentId, 'của khóa học:', courseId);
            });
        });

        // Event listeners for all close modal buttons
        closeModalBtns.forEach(button => {
            button.addEventListener('click', function() {
                const modalId = this.dataset.modal;
                const modalToClose = document.getElementById(modalId);
                if (modalToClose) {
                    closeModal(modalToClose);
                }
            });
        });
        // Close modal when clicking outside the modal content
        [createAssignmentModal, assignmentDetailModal, gradeAssignmentModal].forEach(modal => {
            modal.addEventListener('click', function(event) {
                if (event.target === modal) { // Check if the click was directly on the modal overlay
                    closeModal(modal);
                }
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
        // const noResultsRow = document.getElementById('empty-state');
        // if (someConditionForNoAssignments) { // Replace 'someConditionForNoAssignments' with actual logic
        //     noResultsRow.classList.remove('hidden');
        // } else {
        //     noResultsRow.classList.add('hidden');
        // }
    });
</script>

</body>
</html>