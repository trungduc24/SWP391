<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cài đặt - Hệ thống Quản lý Học tập</title>
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
        .custom-toggle-switch {
            position: relative;
            display: inline-block;
            width: 48px;
            height: 28px;
        }
        .custom-toggle-switch input {
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
            border-radius: 28px;
        }
        .slider:before {
            position: absolute;
            content: "";
            height: 20px;
            width: 20px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }
        input:checked + .slider {
            background-color: #4f46e5;
        }
        input:checked + .slider:before {
            transform: translateX(20px);
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
                    <a href="./documents.jsp" class="flex items-center text-gray-600 hover:text-primary">
                        <div class="w-6 h-6 flex items-center justify-center mr-3">
                            <i class="ri-file-paper-2-line"></i>
                        </div>
                        <span>Tài liệu</span>
                    </a>
                </li>
                <li class="px-4 py-2">
                    <a href="./settings.jsp" class="flex items-center text-primary font-medium">
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
        <header class="bg-white border-b border-gray-200 shadow-sm sticky top-0 z-10">
            <div class="flex items-center justify-between px-4 py-3">
                <button class="md:hidden w-10 h-10 flex items-center justify-center text-gray-600" id="mobileMenuBtn">
                    <i class="ri-menu-line text-xl"></i>
                </button>
                <a href="./dashboard.jsp" class="flex items-center text-gray-600 hover:text-primary">
                    <div class="w-8 h-8 flex items-center justify-center">
                        <i class="ri-arrow-left-line text-xl"></i>
                    </div>
                    <span class="ml-1 text-sm font-medium hidden md:block">Quay lại</span>
                </a>
                <h1 class="text-lg md:text-xl font-bold text-gray-800 flex-1 text-center pr-10 md:pr-0">Cài đặt</h1>
                <button id="saveChangesBtn" class="px-4 py-2 bg-primary text-white text-sm font-medium rounded-button hover:bg-indigo-600 flex items-center justify-center whitespace-nowrap">
                    <i class="ri-save-line mr-1"></i> Lưu thay đổi
                </button>
            </div>
        </header>

        <main class="flex-1 overflow-y-auto bg-gray-50 p-4 md:p-6 custom-scrollbar">
            <div class="max-w-3xl mx-auto bg-white rounded-lg shadow-sm border border-gray-100 divide-y divide-gray-200">

                <section class="p-6">
                    <h2 class="text-xl font-semibold text-gray-800 mb-4">Thông tin cá nhân</h2>
                    <div class="flex flex-col items-center mb-6">
                        <div class="relative w-28 h-28 mb-3 group">
                            <img src="https://readdy.ai/api/search-image?query=professional%2520portrait%2520photo%2520of%2520a%2520young%2520vietnamese%2520male%2520student%2520with%2520short%2520black%2520hair%252C%2520casual%2520outfit%252C%2520neutral%2520background%252C%2520friendly%2520smile&width=100&height=100&seq=1&orientation=squarish" alt="Avatar" class="w-full h-full rounded-full object-cover border-4 border-white shadow-sm">
                            <button class="absolute inset-0 flex items-center justify-center bg-black bg-opacity-50 text-white rounded-full opacity-0 group-hover:opacity-100 transition-opacity" title="Thay đổi ảnh đại diện">
                                <i class="ri-camera-line text-2xl"></i>
                            </button>
                            <input type="file" class="absolute inset-0 opacity-0 cursor-pointer" accept="image/*">
                        </div>
                        <p class="text-sm text-gray-600">Click vào ảnh để thay đổi</p>
                    </div>

                    <form class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="fullName" class="block text-sm font-medium text-gray-700 mb-1">Họ và tên</label>
                            <input type="text" id="fullName" class="w-full p-2 border border-gray-300 rounded-md focus:ring-primary/20 focus:border-primary text-sm" value="Nguyễn Văn Minh">
                        </div>
                        <div>
                            <label for="phoneNumber" class="block text-sm font-medium text-gray-700 mb-1">Số điện thoại</label>
                            <input type="tel" id="phoneNumber" class="w-full p-2 border border-gray-300 rounded-md focus:ring-primary/20 focus:border-primary text-sm" value="0912345678">
                        </div>
                        <div>
                            <label for="dob" class="block text-sm font-medium text-gray-700 mb-1">Ngày sinh</label>
                            <input type="date" id="dob" class="w-full p-2 border border-gray-300 rounded-md focus:ring-primary/20 focus:border-primary text-sm" value="2003-05-15">
                        </div>
                        <div>
                            <label for="gender" class="block text-sm font-medium text-gray-700 mb-1">Giới tính</label>
                            <select id="gender" class="w-full p-2 border border-gray-300 rounded-md focus:ring-primary/20 focus:border-primary text-sm">
                                <option value="male">Nam</option>
                                <option value="female">Nữ</option>
                                <option value="other">Khác</option>
                            </select>
                        </div>
                        <div class="md:col-span-2">
                            <label for="address" class="block text-sm font-medium text-gray-700 mb-1">Địa chỉ</label>
                            <input type="text" id="address" class="w-full p-2 border border-gray-300 rounded-md focus:ring-primary/20 focus:border-primary text-sm" value="123 Đường ABC, Quận XYZ, TP Đà Nẵng">
                        </div>
                    </form>
                </section>

                <section class="p-6">
                    <h2 class="text-xl font-semibold text-gray-800 mb-4">Cài đặt tài khoản</h2>
                    <div class="mb-6">
                        <h3 class="text-lg font-medium text-gray-800 mb-3">Đổi mật khẩu</h3>
                        <form class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div class="md:col-span-2">
                                <label for="currentPassword" class="block text-sm font-medium text-gray-700 mb-1">Mật khẩu hiện tại</label>
                                <input type="password" id="currentPassword" class="w-full p-2 border border-gray-300 rounded-md focus:ring-primary/20 focus:border-primary text-sm">
                            </div>
                            <div>
                                <label for="newPassword" class="block text-sm font-medium text-gray-700 mb-1">Mật khẩu mới</label>
                                <input type="password" id="newPassword" class="w-full p-2 border border-gray-300 rounded-md focus:ring-primary/20 focus:border-primary text-sm">
                            </div>
                            <div>
                                <label for="confirmNewPassword" class="block text-sm font-medium text-gray-700 mb-1">Xác nhận mật khẩu mới</label>
                                <input type="password" id="confirmNewPassword" class="w-full p-2 border border-gray-300 rounded-md focus:ring-primary/20 focus:border-primary text-sm">
                            </div>
                        </form>
                    </div>

                    <div>
                        <h3 class="text-lg font-medium text-gray-800 mb-3">Quản lý email</h3>
                        <div class="space-y-3">
                            <div class="flex items-center justify-between p-3 bg-gray-50 rounded-md border border-gray-200">
                                <div>
                                    <p class="text-sm font-medium text-gray-900">Email chính:</p>
                                    <p class="text-sm text-gray-600">minh.nv@example.com <span class="text-green-600 ml-2">(Đã xác thực)</span></p>
                                </div>
                                <button class="px-3 py-1 bg-gray-200 text-gray-700 text-xs rounded-md hover:bg-gray-300">Thay đổi</button>
                            </div>
                            <div class="flex items-center justify-between p-3 bg-gray-50 rounded-md border border-gray-200">
                                <div>
                                    <p class="text-sm font-medium text-gray-900">Email phụ:</p>
                                    <p class="text-sm text-gray-600">minh.nv.2@example.com <span class="text-orange-600 ml-2">(Chưa xác thực)</span></p>
                                </div>
                                <button class="px-3 py-1 bg-yellow-500 text-white text-xs rounded-md hover:bg-yellow-600">Xác thực</button>
                            </div>
                            <button class="px-4 py-2 border border-gray-300 text-gray-700 text-sm font-medium rounded-button hover:bg-gray-100">Thêm email phụ</button>
                        </div>
                    </div>
                </section>

                <section class="p-6">
                    <h2 class="text-xl font-semibold text-gray-800 mb-4">Tùy chọn thông báo</h2>
                    <div class="space-y-4">
                        <div class="flex items-center justify-between">
                            <label for="emailNotifications" class="text-sm font-medium text-gray-700">Thông báo qua email</label>
                            <label class="custom-toggle-switch">
                                <input type="checkbox" id="emailNotifications" checked>
                                <span class="slider"></span>
                            </label>
                        </div>
                        <div class="flex items-center justify-between">
                            <label for="pushNotifications" class="text-sm font-medium text-gray-700">Thông báo push</label>
                            <label class="custom-toggle-switch">
                                <input type="checkbox" id="pushNotifications" checked>
                                <span class="slider"></span>
                            </label>
                        </div>
                        <div class="flex items-center justify-between">
                            <label for="messageNotifications" class="text-sm font-medium text-gray-700">Thông báo tin nhắn</label>
                            <label class="custom-toggle-switch">
                                <input type="checkbox" id="messageNotifications">
                                <span class="slider"></span>
                            </label>
                        </div>
                        <div class="flex items-center justify-between">
                            <label for="activityNotifications" class="text-sm font-medium text-gray-700">Thông báo hoạt động</label>
                            <label class="custom-toggle-switch">
                                <input type="checkbox" id="activityNotifications" checked>
                                <span class="slider"></span>
                            </label>
                        </div>
                    </div>
                </section>

                <section class="p-6">
                    <h2 class="text-xl font-semibold text-gray-800 mb-4">Quyền riêng tư</h2>
                    <div class="space-y-4">
                        <div>
                            <label for="viewPersonalInfo" class="block text-sm font-medium text-gray-700 mb-1">Ai có thể xem thông tin cá nhân của bạn?</label>
                            <select id="viewPersonalInfo" class="w-full p-2 border border-gray-300 rounded-md focus:ring-primary/20 focus:border-primary text-sm">
                                <option value="everyone">Mọi người</option>
                                <option value="friends">Bạn bè</option>
                                <option value="only_me">Chỉ mình tôi</option>
                            </select>
                        </div>
                        <div>
                            <label for="messageYou" class="block text-sm font-medium text-gray-700 mb-1">Ai có thể nhắn tin cho bạn?</label>
                            <select id="messageYou" class="w-full p-2 border border-gray-300 rounded-md focus:ring-primary/20 focus:border-primary text-sm">
                                <option value="everyone">Mọi người</option>
                                <option value="friends">Bạn bè</option>
                            </select>
                        </div>
                        <div class="flex items-center justify-between">
                            <label for="showActivityStatus" class="text-sm font-medium text-gray-700">Hiển thị trạng thái hoạt động</label>
                            <label class="custom-toggle-switch">
                                <input type="checkbox" id="showActivityStatus" checked>
                                <span class="slider"></span>
                            </label>
                        </div>
                        <div class="flex items-center justify-between">
                            <label for="showContactInfo" class="text-sm font-medium text-gray-700">Hiển thị thông tin liên hệ</label>
                            <label class="custom-toggle-switch">
                                <input type="checkbox" id="showContactInfo" checked>
                                <span class="slider"></span>
                            </label>
                        </div>
                    </div>
                </section>

                <section class="p-6">
                    <h2 class="text-xl font-semibold text-gray-800 mb-4">Ngôn ngữ và giao diện</h2>
                    <div class="space-y-4">
                        <div>
                            <label for="language" class="block text-sm font-medium text-gray-700 mb-1">Ngôn ngữ</label>
                            <select id="language" class="w-full p-2 border border-gray-300 rounded-md focus:ring-primary/20 focus:border-primary text-sm">
                                <option value="vi">Tiếng Việt</option>
                                <option value="en">English</option>
                            </select>
                        </div>
                        <div>
                            <h3 class="text-sm font-medium text-gray-700 mb-2">Chế độ hiển thị</h3>
                            <div class="flex items-center space-x-4">
                                <label class="flex items-center">
                                    <input type="radio" name="themeMode" value="light" class="form-radio text-primary" checked>
                                    <span class="ml-2 text-sm text-gray-700">Chế độ sáng</span>
                                </label>
                                <label class="flex items-center">
                                    <input type="radio" name="themeMode" value="dark" class="form-radio text-primary">
                                    <span class="ml-2 text-sm text-gray-700">Chế độ tối</span>
                                </label>
                            </div>
                        </div>
                        <div>
                            <label for="primaryColor" class="block text-sm font-medium text-gray-700 mb-1">Màu sắc chủ đạo</label>
                            <input type="color" id="primaryColor" class="w-24 h-10 border border-gray-300 rounded-md cursor-pointer" value="#4f46e5">
                        </div>
                        <div>
                            <label for="fontStyle" class="block text-sm font-medium text-gray-700 mb-1">Kiểu chữ</label>
                            <select id="fontStyle" class="w-full p-2 border border-gray-300 rounded-md focus:ring-primary/20 focus:border-primary text-sm">
                                <option value="Inter">Inter (Mặc định)</option>
                                <option value="Arial">Arial</option>
                                <option value="Verdana">Verdana</option>
                            </select>
                        </div>
                    </div>
                </section>

                <section class="p-6">
                    <h2 class="text-xl font-semibold text-gray-800 mb-4">Tích hợp dịch vụ</h2>
                    <div class="space-y-4">
                        <div class="flex items-center justify-between p-3 bg-gray-50 rounded-md border border-gray-200">
                            <div class="flex items-center">
                                <i class="ri-google-fill text-xl text-red-500 mr-3"></i>
                                <div>
                                    <p class="text-sm font-medium text-gray-900">Google Drive</p>
                                    <p class="text-xs text-gray-600">Trạng thái: Đã kết nối</p>
                                </div>
                            </div>
                            <button class="px-3 py-1 bg-red-500 text-white text-xs rounded-md hover:bg-red-600">Ngắt kết nối</button>
                        </div>
                        <div class="flex items-center justify-between p-3 bg-gray-50 rounded-md border border-gray-200">
                            <div class="flex items-center">
                                <i class="ri-microsoft-fill text-xl text-blue-600 mr-3"></i>
                                <div>
                                    <p class="text-sm font-medium text-gray-900">Microsoft 365</p>
                                    <p class="text-xs text-gray-600">Trạng thái: Chưa kết nối</p>
                                </div>
                            </div>
                            <button class="px-3 py-1 bg-green-500 text-white text-xs rounded-md hover:bg-green-600">Kết nối</button>
                        </div>
                    </div>
                </section>

            </div>

            <div class="fixed bottom-4 right-4 md:bottom-6 md:right-6 z-20">
                <button id="floatingSaveChangesBtn" class="hidden md:flex items-center px-5 py-3 bg-primary text-white text-base font-medium rounded-full shadow-lg hover:bg-indigo-600 transition-colors">
                    <i class="ri-save-line mr-2"></i> Lưu thay đổi
                </button>
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
        <a href="./settings.jsp" class="flex flex-col items-center py-2 text-primary">
            <div class="w-6 h-6 flex items-center justify-center">
                <i class="ri-settings-3-line"></i>
            </div>
            <span class="text-xs mt-1">Cài đặt</span>
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

        // Save Changes Button Functionality
        const saveChangesBtn = document.getElementById('saveChangesBtn');
        const floatingSaveChangesBtn = document.getElementById('floatingSaveChangesBtn');

        function handleSaveChanges() {
            alert('Cài đặt đã được lưu thành công!');
            // In a real application, you would collect form data here
            // and send it to the server for processing.
            // Example:
            // const fullName = document.getElementById('fullName').value;
            // console.log('Full Name:', fullName);
        }

        saveChangesBtn.addEventListener('click', handleSaveChanges);
        floatingSaveChangesBtn.addEventListener('click', handleSaveChanges);

        // Optional: Show/hide floating save button based on scroll position
        const mainContent = document.querySelector('main');
        mainContent.addEventListener('scroll', function() {
            if (this.scrollHeight - this.scrollTop > this.clientHeight + 200) { // Show if enough scrollable content below
                floatingSaveChangesBtn.classList.remove('hidden');
            } else {
                floatingSaveChangesBtn.classList.add('hidden');
            }
        });
    });
</script>
</body>
</html>