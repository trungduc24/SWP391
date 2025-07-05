<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Tài liệu - Hệ Thống LMS</title>
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
            border-radius: 0.75rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            width: 90%;
            max-width: 600px;
            max-height: 90vh;
            overflow-y: auto;
            position: relative;
        }

        @media (max-width: 767px) { /* Mobile styles for modal */
            .modal-content {
                width: 100%;
                height: 100%;
                margin: 0;
                border-radius: 0;
                padding: 1rem;
                display: flex;
                flex-direction: column;
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

<main class="flex-1 pt-20 pb-8 px-4 md:px-6 lg:ml-64">
    <div class="max-w-7xl mx-auto">
        <div class="flex items-center justify-between mb-6">
            <h1 class="text-2xl font-semibold text-gray-900 flex items-center">
                <a href="dblecture.txt" class="p-2 text-gray-600 hover:text-primary rounded-full mr-2">
                    <i class="ri-arrow-left-line"></i>
                </a>
                Quản lý Tài liệu
            </h1>
            <button id="uploadDocumentBtn" class="px-4 py-2 bg-primary text-white text-sm font-medium rounded-button hover:bg-primary/90 flex items-center gap-2">
                <i class="ri-upload-cloud-line"></i>
                Tải lên tài liệu mới
            </button>
        </div>

        <div class="bg-white p-4 rounded-lg shadow-sm mb-6">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end">
                <div>
                    <label for="course-filter" class="block text-sm font-medium text-gray-700 mb-1">Khóa học</label>
                    <select id="course-filter" class="w-full px-3 py-2 border border-gray-300 rounded-button focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm">
                        <option value="">Tất cả khóa học</option>
                        <option value="web-nang-cao">Lập trình Web Nâng cao</option>
                        <option value="csdl">Cơ sở dữ liệu</option>
                        <option value="java-co-ban">Java Cơ bản</option>
                    </select>
                </div>
                <div>
                    <label for="type-filter" class="block text-sm font-medium text-gray-700 mb-1">Loại tài liệu</label>
                    <select id="type-filter" class="w-full px-3 py-2 border border-gray-300 rounded-button focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm">
                        <option value="">Tất cả</option>
                        <option value="bai-giang">Bài giảng</option>
                        <option value="tai-lieu-tham-khao">Tài liệu tham khảo</option>
                        <option value="bai-tap">Bài tập</option>
                    </select>
                </div>
                <div class="relative">
                    <label for="search-input" class="block text-sm font-medium text-gray-700 mb-1">Tìm kiếm theo tên</label>
                    <input type="text" id="search-input" placeholder="Nhập tên tài liệu..." class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-button focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm">
                    <i class="ri-search-line absolute left-3 top-1/2 mt-1 -translate-y-1/2 text-gray-400"></i>
                </div>
            </div>
        </div>

        <div class="hidden md:block bg-white p-6 rounded-lg shadow-sm overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                    <tr>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tên tài liệu</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Loại</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Khóa học</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Người tạo</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Ngày tạo</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Lượt tải</th>
                        <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Thao tác</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <div class="flex items-center">
                                <i class="ri-file-text-line text-lg text-blue-500 mr-2"></i>
                                <span class="text-sm font-medium text-gray-900">Bài giảng HTML cơ bản</span>
                            </div>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">Bài giảng</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">Lập trình Web Nâng cao</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">Nguyễn Thị Minh</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">2024-01-15</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">125</td>
                        <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                            <button class="text-indigo-600 hover:text-indigo-900 mr-2" title="Tải xuống"><i class="ri-download-line"></i></button>
                            <button class="text-blue-600 hover:text-blue-900 mr-2 edit-btn" title="Chỉnh sửa"><i class="ri-pencil-line"></i></button>
                            <button class="text-red-600 hover:text-red-900" title="Xóa"><i class="ri-delete-bin-line"></i></button>
                        </td>
                    </tr>
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <div class="flex items-center">
                                <i class="ri-file-pdf-line text-lg text-red-500 mr-2"></i>
                                <span class="text-sm font-medium text-gray-900">Tài liệu tham khảo CSS nâng cao</span>
                            </div>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">Tài liệu tham khảo</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">Lập trình Web Nâng cao</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">Phạm Văn A</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">2024-02-01</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">80</td>
                        <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                            <button class="text-indigo-600 hover:text-indigo-900 mr-2" title="Tải xuống"><i class="ri-download-line"></i></button>
                            <button class="text-blue-600 hover:text-blue-900 mr-2 edit-btn" title="Chỉnh sửa"><i class="ri-pencil-line"></i></button>
                            <button class="text-red-600 hover:text-red-900" title="Xóa"><i class="ri-delete-bin-line"></i></button>
                        </td>
                    </tr>
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <div class="flex items-center">
                                <i class="ri-file-zip-line text-lg text-yellow-500 mr-2"></i>
                                <span class="text-sm font-medium text-gray-900">Bài tập lớn cuối kỳ</span>
                            </div>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">Bài tập</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">Cơ sở dữ liệu</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">Lê Thị B</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">2024-03-10</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">55</td>
                        <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                            <button class="text-indigo-600 hover:text-indigo-900 mr-2" title="Tải xuống"><i class="ri-download-line"></i></button>
                            <button class="text-blue-600 hover:text-blue-900 mr-2 edit-btn" title="Chỉnh sửa"><i class="ri-pencil-line"></i></button>
                            <button class="text-red-600 hover:text-red-900" title="Xóa"><i class="ri-delete-bin-line"></i></button>
                        </td>
                    </tr>
                </tbody>
            </table>
            <nav class="mt-4 flex items-center justify-between border-t border-gray-200 px-4 py-3 sm:px-6">
                <div class="flex flex-1 justify-between sm:hidden">
                    <a href="#" class="relative inline-flex items-center rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50">Trước</a>
                    <a href="#" class="relative ml-3 inline-flex items-center rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50">Sau</a>
                </div>
                <div class="hidden sm:flex sm:flex-1 sm:items-center sm:justify-between">
                    <div>
                        <p class="text-sm text-gray-700">
                            Hiển thị
                            <span class="font-medium">1</span>
                            đến
                            <span class="font-medium">3</span>
                            của
                            <span class="font-medium">10</span>
                            kết quả
                        </p>
                    </div>
                    <div>
                        <nav class="isolate inline-flex -space-x-px rounded-md shadow-sm" aria-label="Pagination">
                            <a href="#" class="relative inline-flex items-center rounded-l-md px-2 py-2 text-gray-400 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0">
                                <span class="sr-only">Previous</span>
                                <i class="ri-arrow-left-s-line h-5 w-5"></i>
                            </a>
                            <a href="#" aria-current="page" class="relative z-10 inline-flex items-center bg-primary px-4 py-2 text-sm font-semibold text-white focus:z-20 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-primary">1</a>
                            <a href="#" class="relative inline-flex items-center px-4 py-2 text-sm font-semibold text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0">2</a>
                            <a href="#" class="relative inline-flex items-center px-4 py-2 text-sm font-semibold text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0">3</a>
                            <a href="#" class="relative inline-flex items-center rounded-r-md px-2 py-2 text-gray-400 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0">
                                <span class="sr-only">Next</span>
                                <i class="ri-arrow-right-s-line h-5 w-5"></i>
                            </a>
                        </nav>
                    </div>
                </div>
            </nav>
        </div>

        <div class="md:hidden grid grid-cols-1 gap-4">
            <div id="empty-state" class="hidden text-center p-8 bg-white rounded-lg shadow-sm">
                <i class="ri-folder-open-line text-6xl text-gray-400 mb-4"></i>
                <p class="text-lg font-medium text-gray-600">Chưa có tài liệu nào.</p>
                <p class="text-sm text-gray-500 mt-2">Hãy tải lên tài liệu đầu tiên của bạn!</p>
            </div>

            <div class="bg-white p-4 rounded-lg shadow-sm border border-gray-200">
                <div class="flex items-center mb-3">
                    <i class="ri-file-text-line text-2xl text-blue-500 mr-3"></i>
                    <h3 class="text-base font-semibold text-gray-900 flex-1">Bài giảng HTML cơ bản</h3>
                </div>
                <p class="text-sm text-gray-600 mb-1"><span class="font-medium">Loại:</span> Bài giảng</p>
                <p class="text-sm text-gray-600 mb-1"><span class="font-medium">Khóa học:</span> Lập trình Web Nâng cao</p>
                <p class="text-sm text-gray-600 mb-1"><span class="font-medium">Người tạo:</span> Nguyễn Thị Minh</p>
                <p class="text-sm text-gray-600 mb-1"><span class="font-medium">Ngày tạo:</span> 2024-01-15</p>
                <p class="text-sm text-gray-600 mb-3"><span class="font-medium">Lượt tải:</span> 125</p>
                <div class="flex justify-end gap-2">
                    <button class="px-3 py-1 bg-indigo-100 text-indigo-700 text-xs font-medium rounded-button hover:bg-indigo-200 flex items-center gap-1">
                        <i class="ri-download-line"></i> Tải xuống
                    </button>
                    <button class="px-3 py-1 bg-blue-100 text-blue-700 text-xs font-medium rounded-button hover:bg-blue-200 flex items-center gap-1 edit-btn">
                        <i class="ri-pencil-line"></i> Chỉnh sửa
                    </button>
                    <button class="px-3 py-1 bg-red-100 text-red-700 text-xs font-medium rounded-button hover:bg-red-200 flex items-center gap-1">
                        <i class="ri-delete-bin-line"></i> Xóa
                    </button>
                </div>
            </div>
            <div class="bg-white p-4 rounded-lg shadow-sm border border-gray-200">
                <div class="flex items-center mb-3">
                    <i class="ri-file-pdf-line text-2xl text-red-500 mr-3"></i>
                    <h3 class="text-base font-semibold text-gray-900 flex-1">Tài liệu tham khảo CSS nâng cao</h3>
                </div>
                <p class="text-sm text-gray-600 mb-1"><span class="font-medium">Loại:</span> Tài liệu tham khảo</p>
                <p class="text-sm text-gray-600 mb-1"><span class="font-medium">Khóa học:</span> Lập trình Web Nâng cao</p>
                <p class="text-sm text-gray-600 mb-1"><span class="font-medium">Người tạo:</span> Phạm Văn A</p>
                <p class="text-sm text-gray-600 mb-1"><span class="font-medium">Ngày tạo:</span> 2024-02-01</p>
                <p class="text-sm text-gray-600 mb-3"><span class="font-medium">Lượt tải:</span> 80</p>
                <div class="flex justify-end gap-2">
                    <button class="px-3 py-1 bg-indigo-100 text-indigo-700 text-xs font-medium rounded-button hover:bg-indigo-200 flex items-center gap-1">
                        <i class="ri-download-line"></i> Tải xuống
                    </button>
                    <button class="px-3 py-1 bg-blue-100 text-blue-700 text-xs font-medium rounded-button hover:bg-blue-200 flex items-center gap-1 edit-btn">
                        <i class="ri-pencil-line"></i> Chỉnh sửa
                    </button>
                    <button class="px-3 py-1 bg-red-100 text-red-700 text-xs font-medium rounded-button hover:bg-red-200 flex items-center gap-1">
                        <i class="ri-delete-bin-line"></i> Xóa
                    </button>
                </div>
            </div>
        </div>
        <nav class="md:hidden mt-4 flex items-center justify-between border-t border-gray-200 px-4 py-3 sm:px-6">
            <div class="flex flex-1 justify-between">
                <a href="#" class="relative inline-flex items-center rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50">Trước</a>
                <a href="#" class="relative ml-3 inline-flex items-center rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50">Sau</a>
            </div>
        </nav>
    </div>
</main>

<div id="documentModal" class="modal hidden">
    <div class="modal-content">
        <h2 id="modalTitle" class="text-xl font-semibold text-gray-900 mb-4">Tải lên tài liệu mới</h2>
        <form>
            <div class="mb-4">
                <label for="documentName" class="block text-sm font-medium text-gray-700 mb-1">Tên tài liệu</label>
                <input type="text" id="documentName" name="documentName" class="w-full px-3 py-2 border border-gray-300 rounded-button focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm" placeholder="Nhập tên tài liệu" required>
            </div>
            <div class="mb-4">
                <label for="documentCourse" class="block text-sm font-medium text-gray-700 mb-1">Khóa học</label>
                <select id="documentCourse" name="documentCourse" class="w-full px-3 py-2 border border-gray-300 rounded-button focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm" required>
                    <option value="">Chọn khóa học</option>
                    <option value="web-nang-cao">Lập trình Web Nâng cao</option>
                    <option value="csdl">Cơ sở dữ liệu</option>
                    <option value="java-co-ban">Java Cơ bản</option>
                </select>
            </div>
            <div class="mb-4">
                <label for="documentType" class="block text-sm font-medium text-gray-700 mb-1">Loại tài liệu</label>
                <select id="documentType" name="documentType" class="w-full px-3 py-2 border border-gray-300 rounded-button focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm" required>
                    <option value="">Chọn loại tài liệu</option>
                    <option value="bai-giang">Bài giảng</option>
                    <option value="tai-lieu-tham-khao">Tài liệu tham khảo</option>
                    <option value="bai-tap">Bài tập</option>
                </select>
            </div>
            <div class="mb-4">
                <label for="documentFile" class="block text-sm font-medium text-gray-700 mb-1">Tải lên file</label>
                <input type="file" id="documentFile" name="documentFile" class="w-full px-3 py-2 border border-gray-300 rounded-button focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm">
            </div>
            <div class="mb-6">
                <label for="documentDescription" class="block text-sm font-medium text-gray-700 mb-1">Mô tả (tùy chọn)</label>
                <textarea id="documentDescription" name="documentDescription" rows="3" class="w-full px-3 py-2 border border-gray-300 rounded-button resize-y focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm" placeholder="Nhập mô tả tài liệu..."></textarea>
            </div>
            <div class="flex justify-end gap-3">
                <button type="button" id="cancelModalBtn" class="px-4 py-2 bg-gray-200 text-gray-800 text-sm font-medium rounded-button hover:bg-gray-300">Hủy</button>
                <button type="submit" class="px-4 py-2 bg-primary text-white text-sm font-medium rounded-button hover:bg-primary/90">Lưu</button>
            </div>
        </form>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Mobile menu toggle
        const mobileMenuButton = document.querySelector('header .lg\\:hidden button');
        const sidebar = document.querySelector('aside');

        if (mobileMenuButton && sidebar) {
            mobileMenuButton.addEventListener('click', function() {
                sidebar.classList.toggle('hidden');
                sidebar.classList.toggle('flex');
            });
        }

        // Modal functionality
        const uploadDocumentBtn = document.getElementById('uploadDocumentBtn');
        const documentModal = document.getElementById('documentModal');
        const cancelModalBtn = document.getElementById('cancelModalBtn');
        const modalTitle = document.getElementById('modalTitle');
        const editButtons = document.querySelectorAll('.edit-btn');
        const documentForm = document.querySelector('#documentModal form');

        function openModal(isEdit = false, documentData = {}) {
            documentModal.classList.remove('hidden');
            if (isEdit) {
                modalTitle.textContent = 'Chỉnh sửa tài liệu';
                // Populate form with documentData (placeholder for actual data binding)
                document.getElementById('documentName').value = documentData.name || '';
                document.getElementById('documentCourse').value = documentData.course || '';
                document.getElementById('documentType').value = documentData.type || '';
                document.getElementById('documentDescription').value = documentData.description || '';
                document.getElementById('documentFile').value = ''; // File input cannot be pre-filled for security
            } else {
                modalTitle.textContent = 'Tải lên tài liệu mới';
                documentForm.reset(); // Clear form for new upload
            }
        }

        function closeModal() {
            documentModal.classList.add('hidden');
        }

        uploadDocumentBtn.addEventListener('click', () => openModal(false));
        cancelModalBtn.addEventListener('click', closeModal);

        editButtons.forEach(button => {
            button.addEventListener('click', () => {
                // In a real application, you'd fetch document data by ID
                // For demonstration, let's use some dummy data
                const dummyDocumentData = {
                    name: "Tài liệu mẫu đã chỉnh sửa",
                    course: "web-nang-cao",
                    type: "tai-lieu-tham-khao",
                    description: "Đây là mô tả cho tài liệu mẫu đã được chỉnh sửa."
                };
                openModal(true, dummyDocumentData);
            });
        });

        // Close modal when clicking outside
        documentModal.addEventListener('click', function(event) {
            if (event.target === documentModal) {
                closeModal();
            }
        });

        // Handle form submission (placeholder)
        documentForm.addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(this);
            console.log('Form data submitted:', Object.fromEntries(formData.entries()));
            alert('Tài liệu đã được lưu thành công (giả lập)!');
            closeModal();
            // In a real app, send data to server via AJAX
        });

        // Empty state demonstration (toggle visibility if needed)
        // const emptyState = document.getElementById('empty-state');
        // const documentTable = document.querySelector('.hidden.md\\:block'); // Table view
        // const documentCards = document.querySelector('.md\\:hidden.grid'); // Card view
        //
        // // To show empty state, add 'hidden' to documentTable and documentCards, remove from emptyState
        // function toggleEmptyState(isEmpty) {
        //     if (isEmpty) {
        //         documentTable.classList.add('hidden');
        //         documentCards.classList.add('hidden');
        //         emptyState.classList.remove('hidden');
        //     } else {
        //         documentTable.classList.remove('hidden');
        //         documentCards.classList.remove('hidden');
        //         emptyState.classList.add('hidden');
        //     }
        // }
        // // Example: toggleEmptyState(true); // Call this if there are no documents
    });
</script>

</body>
</html>