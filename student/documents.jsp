<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>  
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tài liệu - Hệ thống Quản lý Học tập</title>
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
                    <a href="./grades.jsp" class="flex items-center text-gray-600 hover:text-primary">
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
                    <a href="./documents.jsp" class="flex items-center text-primary font-medium">
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
                <nav class="flex mb-4" aria-label="Breadcrumb">
                    <ol class="inline-flex items-center space-x-1 md:space-x-2 rtl:space-x-reverse">
                        <li class="inline-flex items-center">
                            <a href="./dashboard.jsp" class="inline-flex items-center text-sm font-medium text-gray-700 hover:text-primary">
                                <i class="ri-home-line mr-2"></i>
                                Trang chủ
                            </a>
                        </li>
                        <li aria-current="page">
                            <div class="flex items-center">
                                <i class="ri-arrow-right-s-line text-gray-400 mx-1"></i>
                                <span class="text-sm font-medium text-gray-500">Tài liệu</span>
                            </div>
                        </li>
                    </ol>
                </nav>

                <h1 class="text-2xl font-bold text-gray-800 mb-6">Tài liệu học tập</h1>

                <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-4 mb-6 flex flex-col md:flex-row items-center justify-between gap-4">
                    <div class="relative flex-1 w-full md:w-auto">
                        <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                            <i class="ri-search-line text-gray-400"></i>
                        </div>
                        <input type="text" id="documentSearchInput" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg block w-full pl-10 p-2.5 focus:ring-primary/20 focus:border-primary" placeholder="Tìm kiếm tài liệu...">
                    </div>
                    <select id="subjectFilter" class="block w-full md:w-auto px-3 py-2 border border-gray-300 bg-white rounded-lg shadow-sm focus:outline-none focus:ring-primary/20 focus:border-primary text-sm">
                        <option value="all">Tất cả môn học</option>
                        <option value="CS201">Lập trình hướng đối tượng</option>
                        <option value="IT305">Cơ sở dữ liệu</option>
                        <option value="NET202">Mạng máy tính</option>
                        <option value="WEB301">Thiết kế Web</option>
                    </select>
                    <select id="typeFilter" class="block w-full md:w-auto px-3 py-2 border border-gray-300 bg-white rounded-lg shadow-sm focus:outline-none focus:ring-primary/20 focus:border-primary text-sm">
                        <option value="all">Tất cả loại tài liệu</option>
                        <option value="lecture">Bài giảng</option>
                        <option value="reference">Tài liệu tham khảo</option>
                        <option value="assignment">Bài tập</option>
                        <option value="solution">Đáp án</option>
                    </select>
                    <select id="timeFilter" class="block w-full md:w-auto px-3 py-2 border border-gray-300 bg-white rounded-lg shadow-sm focus:outline-none focus:ring-primary/20 focus:border-primary text-sm">
                        <option value="latest">Thời gian đăng tải (Mới nhất)</option>
                        <option value="oldest">Thời gian đăng tải (Cũ nhất)</option>
                    </select>
                    <button id="resetFiltersBtn" class="px-4 py-2 text-sm font-medium text-gray-700 bg-gray-100 rounded-button whitespace-nowrap hover:bg-gray-200 flex items-center justify-center">
                        <i class="ri-filter-off-line mr-1"></i> Đặt lại
                    </button>
                </div>

                <div id="documentListContainer">
                    <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-4 mb-6" data-subject="CS201">
                        <h2 class="text-xl font-semibold text-gray-800 mb-4 flex items-center">
                            <i class="ri-book-open-line mr-2 text-primary"></i> Lập trình hướng đối tượng
                        </h2>
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4" id="documents_CS201">
                            <div class="document-item bg-gray-50 p-3 rounded-lg border border-gray-200 hover:shadow-md transition-shadow" data-type="lecture" data-time="2025-06-28">
                                <div class="flex items-center mb-2">
                                    <i class="ri-file-text-line text-2xl text-blue-500 mr-2"></i>
                                    <h3 class="text-base font-medium text-gray-900">Bài giảng Chương 1: Giới thiệu OOP</h3>
                                </div>
                                <p class="text-sm text-gray-600 mb-2 line-clamp-2">Tổng quan về lập trình hướng đối tượng, khái niệm cơ bản về class, object, encapsulation...</p>
                                <div class="text-xs text-gray-500 mb-3">
                                    <span class="mr-2"><i class="ri-user-line"></i> GV. Trần Minh Tuấn</span>
                                    <span><i class="ri-time-line"></i> 28/06/2025</span>
                                </div>
                                <button class="download-btn w-full flex items-center justify-center gap-2 py-2 px-3 bg-primary text-white text-sm font-medium rounded-button hover:bg-indigo-600">
                                    <i class="ri-download-line"></i> Tải xuống
                                </button>
                            </div>
                            <div class="document-item bg-gray-50 p-3 rounded-lg border border-gray-200 hover:shadow-md transition-shadow" data-type="assignment" data-time="2025-07-01">
                                <div class="flex items-center mb-2">
                                    <i class="ri-file-list-3-line text-2xl text-green-500 mr-2"></i>
                                    <h3 class="text-base font-medium text-gray-900">Bài tập tuần 2: Kế thừa và Đa hình</h3>
                                </div>
                                <p class="text-sm text-gray-600 mb-2 line-clamp-2">Các bài tập thực hành về kế thừa, đa hình trong Java. Hạn nộp 10/07/2025.</p>
                                <div class="text-xs text-gray-500 mb-3">
                                    <span class="mr-2"><i class="ri-user-line"></i> GV. Trần Minh Tuấn</span>
                                    <span><i class="ri-time-line"></i> 01/07/2025</span>
                                </div>
                                <button class="download-btn w-full flex items-center justify-center gap-2 py-2 px-3 bg-primary text-white text-sm font-medium rounded-button hover:bg-indigo-600">
                                    <i class="ri-download-line"></i> Tải xuống
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-4 mb-6" data-subject="IT305">
                        <h2 class="text-xl font-semibold text-gray-800 mb-4 flex items-center">
                            <i class="ri-database-line mr-2 text-primary"></i> Cơ sở dữ liệu
                        </h2>
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4" id="documents_IT305">
                            <div class="document-item bg-gray-50 p-3 rounded-lg border border-gray-200 hover:shadow-md transition-shadow" data-type="reference" data-time="2025-06-20">
                                <div class="flex items-center mb-2">
                                    <i class="ri-booklet-line text-2xl text-purple-500 mr-2"></i>
                                    <h3 class="text-base font-medium text-gray-900">Tài liệu tham khảo: SQL Nâng cao</h3>
                                </div>
                                <p class="text-sm text-gray-600 mb-2 line-clamp-2">Tài liệu chi tiết về các câu lệnh SQL nâng cao, tối ưu hóa truy vấn.</p>
                                <div class="text-xs text-gray-500 mb-3">
                                    <span class="mr-2"><i class="ri-user-line"></i> GV. Lê Thị Hương</span>
                                    <span><i class="ri-time-line"></i> 20/06/2025</span>
                                </div>
                                <button class="download-btn w-full flex items-center justify-center gap-2 py-2 px-3 bg-primary text-white text-sm font-medium rounded-button hover:bg-indigo-600">
                                    <i class="ri-download-line"></i> Tải xuống
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-4 mb-6" data-subject="NET202">
                        <h2 class="text-xl font-semibold text-gray-800 mb-4 flex items-center">
                            <i class="ri-router-line mr-2 text-primary"></i> Mạng máy tính
                        </h2>
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4" id="documents_NET202">
                            <div class="document-item bg-gray-50 p-3 rounded-lg border border-gray-200 hover:shadow-md transition-shadow" data-type="lecture" data-time="2025-07-02">
                                <div class="flex items-center mb-2">
                                    <i class="ri-file-text-line text-2xl text-blue-500 mr-2"></i>
                                    <h3 class="text-base font-medium text-gray-900">Bài giảng về TCP/IP Model</h3>
                                </div>
                                <p class="text-sm text-gray-600 mb-2 line-clamp-2">Bài giảng chi tiết về mô hình TCP/IP, các tầng và giao thức.</p>
                                <div class="text-xs text-gray-500 mb-3">
                                    <span class="mr-2"><i class="ri-user-line"></i> GV. Phạm Văn Đức</span>
                                    <span><i class="ri-time-line"></i> 02/07/2025</span>
                                </div>
                                <button class="download-btn w-full flex items-center justify-center gap-2 py-2 px-3 bg-primary text-white text-sm font-medium rounded-button hover:bg-indigo-600">
                                    <i class="ri-download-line"></i> Tải xuống
                                </button>
                            </div>
                            <div class="document-item bg-gray-50 p-3 rounded-lg border border-gray-200 hover:shadow-md transition-shadow" data-type="solution" data-time="2025-07-03">
                                <div class="flex items-center mb-2">
                                    <i class="ri-check-double-line text-2xl text-yellow-600 mr-2"></i>
                                    <h3 class="text-base font-medium text-gray-900">Đáp án bài tập chương 3</h3>
                                </div>
                                <p class="text-sm text-gray-600 mb-2 line-clamp-2">Đáp án chi tiết cho các bài tập cuối chương 3 môn Mạng máy tính.</p>
                                <div class="text-xs text-gray-500 mb-3">
                                    <span class="mr-2"><i class="ri-user-line"></i> GV. Phạm Văn Đức</span>
                                    <span><i class="ri-time-line"></i> 03/07/2025</span>
                                </div>
                                <button class="download-btn w-full flex items-center justify-center gap-2 py-2 px-3 bg-primary text-white text-sm font-medium rounded-button hover:bg-indigo-600">
                                    <i class="ri-download-line"></i> Tải xuống
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="flex justify-center mt-8">
                        <nav class="flex items-center space-x-2">
                            <a href="#" class="px-3 py-2 rounded-lg text-sm font-medium text-gray-600 bg-white border border-gray-300 hover:bg-gray-100">Trước</a>
                            <a href="#" class="px-3 py-2 rounded-lg text-sm font-medium text-white bg-primary">1</a>
                            <a href="#" class="px-3 py-2 rounded-lg text-sm font-medium text-gray-600 bg-white border border-gray-300 hover:bg-gray-100">2</a>
                            <a href="#" class="px-3 py-2 rounded-lg text-sm font-medium text-gray-600 bg-white border border-gray-300 hover:bg-gray-100">3</a>
                            <a href="#" class="px-3 py-2 rounded-lg text-sm font-medium text-gray-600 bg-white border border-gray-300 hover:bg-gray-100">Sau</a>
                        </nav>
                    </div>
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
        <a href="./documents.jsp" class="flex flex-col items-center py-2 text-primary">
            <div class="w-6 h-6 flex items-center justify-center">
                <i class="ri-file-paper-2-line"></i>
            </div>
            <span class="text-xs mt-1">Tài liệu</span>
        </a>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Mobile Menu Toggle
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

        // Document Filtering and Search
        const documentSearchInput = document.getElementById('documentSearchInput');
        const subjectFilter = document.getElementById('subjectFilter');
        const typeFilter = document.getElementById('typeFilter');
        const timeFilter = document.getElementById('timeFilter');
        const resetFiltersBtn = document.getElementById('resetFiltersBtn');
        const documentListContainer = document.getElementById('documentListContainer');

        function applyFilters() {
            const searchTerm = documentSearchInput.value.toLowerCase();
            const selectedSubject = subjectFilter.value;
            const selectedType = typeFilter.value;
            const selectedTimeOrder = timeFilter.value;

            // Get all subject sections
            const subjectSections = Array.from(documentListContainer.querySelectorAll('div[data-subject]'));

            subjectSections.forEach(subjectSection => {
                const subjectId = subjectSection.dataset.subject;
                const documentsInSubject = Array.from(subjectSection.querySelectorAll('.document-item'));

                let hasVisibleDocsInSubject = false;
                let visibleDocsForSorting = [];

                documentsInSubject.forEach(docItem => {
                    const docName = docItem.querySelector('h3').textContent.toLowerCase();
                    const docDescription = docItem.querySelector('p.text-sm').textContent.toLowerCase();
                    const docType = docItem.dataset.type;
                    const docTime = docItem.dataset.time; // Format YYYY-MM-DD for easy comparison

                    const matchesSearch = docName.includes(searchTerm) || docDescription.includes(searchTerm);
                    const matchesSubject = selectedSubject === 'all' || subjectId === selectedSubject;
                    const matchesType = selectedType === 'all' || docType === selectedType;

                    if (matchesSearch && matchesSubject && matchesType) {
                        docItem.style.display = 'block';
                        hasVisibleDocsInSubject = true;
                        visibleDocsForSorting.push({ element: docItem, time: new Date(docTime) });
                    } else {
                        docItem.style.display = 'none';
                    }
                });

                // Sort visible documents within each subject section
                visibleDocsForSorting.sort((a, b) => {
                    if (selectedTimeOrder === 'latest') {
                        return b.time - a.time; // Newest first
                    } else {
                        return a.time - b.time; // Oldest first
                    }
                });

                // Re-append sorted documents to their subject section
                const docGrid = subjectSection.querySelector('.grid');
                if (docGrid) {
                    docGrid.innerHTML = ''; // Clear current display
                    visibleDocsForSorting.forEach(doc => {
                        docGrid.appendChild(doc.element);
                    });
                }

                // Hide subject section if no documents are visible within it after filtering
                if (hasVisibleDocsInSubject) {
                    subjectSection.style.display = 'block';
                } else {
                    subjectSection.style.display = 'none';
                }
            });
        }

        function resetFilters() {
            documentSearchInput.value = '';
            subjectFilter.value = 'all';
            typeFilter.value = 'all';
            timeFilter.value = 'latest';
            applyFilters();
        }

        // Add event listeners for filters and search
        documentSearchInput.addEventListener('keyup', applyFilters);
        subjectFilter.addEventListener('change', applyFilters);
        typeFilter.addEventListener('change', applyFilters);
        timeFilter.addEventListener('change', applyFilters);
        resetFiltersBtn.addEventListener('click', resetFilters);

        // Initial application of filters
        applyFilters();

        // Handle Download Buttons (simple alert for demonstration)
        const downloadButtons = document.querySelectorAll('.download-btn');
        downloadButtons.forEach(button => {
            button.addEventListener('click', function() {
                const docTitle = this.closest('.document-item').querySelector('h3').textContent;
                alert(`Đang tải xuống: "${docTitle}"... (Chức năng này cần được triển khai ở backend)`);
                // In a real application, you would trigger a file download or show a loading indicator
                // Example of a simple loading indicator (CSS needed for .loading-state)
                // this.innerHTML = '<i class="ri-loader-4-line animate-spin"></i> Đang tải...';
                // setTimeout(() => {
                //     this.innerHTML = '<i class="ri-download-line"></i> Tải xuống';
                //     alert(`Tải xuống "${docTitle}" thành công!`);
                // }, 2000); // Simulate download time
            });
        });
    });
</script>
</body>
</html>