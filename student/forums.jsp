<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Diễn đàn - Hệ thống Quản lý Học tập</title>
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
</style>
</head>
<body>
<div class="min-h-screen flex">
<!-- Sidebar -->
<aside class="hidden md:flex flex-col w-64 bg-white border-r border-gray-200 shadow-sm">
<div class="p-4 border-b border-gray-200 flex items-center">
<span class="text-2xl font-['Pacifico'] text-primary">logo</span>
<span class="ml-2 text-lg font-semibold text-gray-800">LMS</span>
</div>
<nav class="flex-1 pt-4 pb-4 overflow-y-auto custom-scrollbar">
<ul>
<li class="px-4 py-2">
<a href="#" class="flex items-center text-gray-600 hover:text-primary">
<div class="w-6 h-6 flex items-center justify-center mr-3">
<i class="ri-dashboard-line"></i>
</div>
<span>Trang chủ</span>
</a>
</li>
<li class="px-4 py-2">
<a href="#" class="flex items-center text-gray-600 hover:text-primary">
<div class="w-6 h-6 flex items-center justify-center mr-3">
<i class="ri-book-open-line"></i>
</div>
<span>Khóa học của tôi</span>
</a>
</li>
<li class="px-4 py-2">
<a href="#" class="flex items-center text-gray-600 hover:text-primary">
<div class="w-6 h-6 flex items-center justify-center mr-3">
<i class="ri-calendar-line"></i>
</div>
<span>Lịch học</span>
</a>
</li>
<li class="px-4 py-2">
<a href="https://readdy.ai/home/44822aa2-ec31-40dc-a6fd-6e72476f29bf/24e307a8-ee95-42b8-a2af-c45a6f95f5f1" data-readdy="true" class="flex items-center text-gray-600 hover:text-primary">
<div class="w-6 h-6 flex items-center justify-center mr-3">
<i class="ri-file-list-3-line"></i>
</div>
<span>Bài tập/Kiểm tra</span>
</a>
</li>
<li class="px-4 py-2">
<a href="#" class="flex items-center text-gray-600 hover:text-primary">
<div class="w-6 h-6 flex items-center justify-center mr-3">
<i class="ri-bar-chart-line"></i>
</div>
<span>Điểm số</span>
</a>
</li>
<li class="px-4 py-2">
<a href="https://readdy.ai/home/44822aa2-ec31-40dc-a6fd-6e72476f29bf/31109599-8904-4910-847d-30d83bcb28c5" data-readdy="true" class="flex items-center text-primary font-medium">
<div class="w-6 h-6 flex items-center justify-center mr-3">
<i class="ri-discuss-line"></i>
</div>
<span>Diễn đàn</span>
</a>
</li>
<li class="px-4 py-2">
<a href="#" class="flex items-center text-gray-600 hover:text-primary">
<div class="w-6 h-6 flex items-center justify-center mr-3">
<i class="ri-file-paper-2-line"></i>
</div>
<span>Tài liệu</span>
</a>
</li>
<li class="px-4 py-2">
<a href="#" class="flex items-center text-gray-600 hover:text-primary">
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
<!-- Main Content -->
<div class="flex-1 flex flex-col">
<!-- Top Navigation -->
<header class="bg-white border-b border-gray-200 shadow-sm">
<div class="flex items-center justify-between px-4 py-3">
<!-- Mobile Menu Button -->
<button class="md:hidden w-10 h-10 flex items-center justify-center text-gray-600">
<i class="ri-menu-line text-xl"></i>
</button>
<!-- Logo for Mobile -->
<div class="md:hidden flex items-center">
<span class="text-xl font-['Pacifico'] text-primary">logo</span>
<span class="ml-1 text-base font-semibold text-gray-800">LMS</span>
</div>
<!-- Search Bar -->
<div class="hidden md:flex items-center flex-1 max-w-lg mx-4">
<div class="relative w-full">
<div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
<i class="ri-search-line text-gray-400"></i>
</div>
<input type="text" class="bg-gray-50 border-none text-gray-900 text-sm rounded-lg block w-full pl-10 p-2.5 focus:ring-2 focus:ring-primary/20 focus:outline-none" placeholder="Tìm kiếm khóa học, tài liệu...">
</div>
</div>
<!-- Right Navigation Items -->
<div class="flex items-center space-x-4">
<!-- Notifications -->
<div class="relative">
<button class="w-10 h-10 flex items-center justify-center text-gray-600 hover:text-primary hover:bg-gray-100 rounded-full">
<i class="ri-notification-3-line"></i>
</button>
<span class="absolute top-1 right-1 w-5 h-5 flex items-center justify-center bg-red-500 text-white text-xs rounded-full">3</span>
</div>
<!-- Messages -->
<button class="w-10 h-10 flex items-center justify-center text-gray-600 hover:text-primary hover:bg-gray-100 rounded-full">
<i class="ri-message-3-line"></i>
</button>
<!-- User Menu (Mobile) -->
<div class="md:hidden">
<button class="w-10 h-10 flex items-center justify-center">
<img src="https://readdy.ai/api/search-image?query=professional%2520portrait%2520photo%2520of%2520a%2520young%2520vietnamese%2520male%2520student%2520with%2520short%2520black%2520hair%252C%2520casual%2520outfit%252C%2520neutral%2520background%252C%2520friendly%2520smile&width=100&height=100&seq=1&orientation=squarish" alt="Avatar" class="w-8 h-8 rounded-full object-cover">
</button>
</div>
</div>
</div>
</header>
<!-- Forum Content -->
<main class="flex-1 overflow-y-auto bg-gray-50 p-4 md:p-6 custom-scrollbar">
<div class="max-w-7xl mx-auto">
<!-- Forum Header -->
<div class="flex flex-col md:flex-row md:items-center justify-between mb-6">
<div>
<h1 class="text-2xl font-bold text-gray-800 mb-1">Diễn đàn thảo luận</h1>
<p class="text-gray-600">Đặt câu hỏi, chia sẻ kiến thức và tham gia thảo luận với giảng viên và sinh viên khác</p>
</div>
<button class="mt-4 md:mt-0 bg-primary text-white px-4 py-2 rounded-button flex items-center gap-2 whitespace-nowrap">
<div class="w-5 h-5 flex items-center justify-center">
<i class="ri-add-line"></i>
</div>
<span>Tạo chủ đề mới</span>
</button>
</div>
<!-- Search and Filter -->
<div class="bg-white rounded-lg shadow-sm border border-gray-100 p-4 mb-6">
<div class="flex flex-col md:flex-row gap-4">
<div class="relative flex-1">
<div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
<i class="ri-search-line text-gray-400"></i>
</div>
<input type="text" class="bg-gray-50 border border-gray-200 text-gray-900 text-sm rounded-lg block w-full pl-10 p-2.5 focus:ring-2 focus:ring-primary/20 focus:outline-none" placeholder="Tìm kiếm chủ đề thảo luận...">
</div>
<div class="flex flex-col md:flex-row gap-4">
<div class="relative dropdown">
<button class="bg-white border border-gray-200 text-gray-700 text-sm rounded-lg px-4 py-2.5 flex items-center justify-between min-w-[200px] !rounded-button">
<span>Tất cả môn học</span>
<div class="w-5 h-5 flex items-center justify-center">
<i class="ri-arrow-down-s-line"></i>
</div>
</button>
<div class="dropdown-content bg-white shadow-lg rounded-lg mt-1 border border-gray-100">
<ul class="py-2">
<li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Tất cả môn học</a></li>
<li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Lập trình hướng đối tượng</a></li>
<li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Cơ sở dữ liệu</a></li>
<li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Mạng máy tính</a></li>
<li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Trí tuệ nhân tạo</a></li>
<li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Phát triển ứng dụng web</a></li>
</ul>
</div>
</div>
<div class="relative dropdown">
<button class="bg-white border border-gray-200 text-gray-700 text-sm rounded-lg px-4 py-2.5 flex items-center justify-between min-w-[200px] !rounded-button">
<span>Sắp xếp: Mới nhất</span>
<div class="w-5 h-5 flex items-center justify-center">
<i class="ri-arrow-down-s-line"></i>
</div>
</button>
<div class="dropdown-content bg-white shadow-lg rounded-lg mt-1 border border-gray-100">
<ul class="py-2">
<li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Mới nhất</a></li>
<li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Nhiều lượt xem nhất</a></li>
<li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Nhiều phản hồi nhất</a></li>
<li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Chưa giải quyết</a></li>
<li><a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">Đã giải quyết</a></li>
</ul>
</div>
</div>
</div>
</div>
</div>
<!-- Discussion Topics by Subject -->
<!-- Lập trình hướng đối tượng -->
<div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden mb-6">
<div class="p-4 md:p-6 border-b border-gray-100 flex items-center justify-between">
<div class="flex items-center">
<div class="w-10 h-10 flex items-center justify-center rounded-lg bg-blue-100 text-blue-600 mr-4 flex-shrink-0">
<i class="ri-code-s-slash-line"></i>
</div>
<div>
<h2 class="text-lg font-semibold text-gray-800">Lập trình hướng đối tượng</h2>
<p class="text-sm text-gray-500">CS201 - 24 chủ đề thảo luận</p>
</div>
</div>
<a href="#" class="text-sm text-primary hover:underline hidden md:block">Xem tất cả</a>
</div>
<div class="divide-y divide-gray-100">
<!-- Topic 1 -->
<div class="p-4 md:p-6 hover:bg-gray-50">
<div class="flex items-start">
<img src="https://readdy.ai/api/search-image?query=professional%2520portrait%2520photo%2520of%2520a%2520young%2520vietnamese%2520female%2520student%2520with%2520long%2520black%2520hair%252C%2520casual%2520outfit%252C%2520neutral%2520background%252C%2520friendly%2520smile&width=100&height=100&seq=2&orientation=squarish" alt="Avatar" class="w-10 h-10 rounded-full object-cover mr-4">
<div class="flex-1">
<div class="flex flex-wrap gap-2 mb-2">
<span class="px-2.5 py-1 bg-green-100 text-green-700 text-xs rounded-full">Đã giải quyết</span>
<span class="px-2.5 py-1 bg-blue-100 text-blue-700 text-xs rounded-full">Lập trình hướng đối tượng</span>
</div>
<a href="#" class="text-lg font-medium text-gray-800 hover:text-primary">Làm thế nào để áp dụng tính kế thừa trong Java một cách hiệu quả?</a>
<div class="flex flex-wrap items-center text-sm text-gray-500 mt-2 gap-4">
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-user-line"></i>
</div>
Trần Thị Hương
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-time-line"></i>
</div>
2 ngày trước
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-message-2-line"></i>
</div>
12 phản hồi
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-eye-line"></i>
</div>
56 lượt xem
</span>
</div>
</div>
</div>
</div>
<!-- Topic 2 -->
<div class="p-4 md:p-6 hover:bg-gray-50">
<div class="flex items-start">
<img src="https://readdy.ai/api/search-image?query=professional%2520portrait%2520photo%2520of%2520a%2520young%2520vietnamese%2520male%2520student%2520with%2520glasses%252C%2520casual%2520outfit%252C%2520neutral%2520background%252C%2520friendly%2520smile&width=100&height=100&seq=3&orientation=squarish" alt="Avatar" class="w-10 h-10 rounded-full object-cover mr-4">
<div class="flex-1">
<div class="flex flex-wrap gap-2 mb-2">
<span class="px-2.5 py-1 bg-yellow-100 text-yellow-700 text-xs rounded-full">Chưa giải quyết</span>
<span class="px-2.5 py-1 bg-blue-100 text-blue-700 text-xs rounded-full">Lập trình hướng đối tượng</span>
</div>
<a href="#" class="text-lg font-medium text-gray-800 hover:text-primary">Gặp lỗi khi sử dụng đa hình trong bài tập lớn</a>
<div class="flex flex-wrap items-center text-sm text-gray-500 mt-2 gap-4">
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-user-line"></i>
</div>
Phạm Văn Tuấn
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-time-line"></i>
</div>
Hôm qua
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-message-2-line"></i>
</div>
5 phản hồi
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-eye-line"></i>
</div>
28 lượt xem
</span>
</div>
</div>
</div>
</div>
<!-- Topic 3 -->
<div class="p-4 md:p-6 hover:bg-gray-50">
<div class="flex items-start">
<img src="https://readdy.ai/api/search-image?query=professional%2520portrait%2520photo%2520of%2520a%2520young%2520vietnamese%2520male%2520student%2520with%2520short%2520black%2520hair%252C%2520casual%2520outfit%252C%2520neutral%2520background%252C%2520friendly%2520smile&width=100&height=100&seq=1&orientation=squarish" alt="Avatar" class="w-10 h-10 rounded-full object-cover mr-4">
<div class="flex-1">
<div class="flex flex-wrap gap-2 mb-2">
<span class="px-2.5 py-1 bg-yellow-100 text-yellow-700 text-xs rounded-full">Chưa giải quyết</span>
<span class="px-2.5 py-1 bg-blue-100 text-blue-700 text-xs rounded-full">Lập trình hướng đối tượng</span>
</div>
<a href="#" class="text-lg font-medium text-gray-800 hover:text-primary">So sánh giữa abstract class và interface trong Java</a>
<div class="flex flex-wrap items-center text-sm text-gray-500 mt-2 gap-4">
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-user-line"></i>
</div>
Nguyễn Văn Minh
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-time-line"></i>
</div>
3 giờ trước
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-message-2-line"></i>
</div>
2 phản hồi
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-eye-line"></i>
</div>
17 lượt xem
</span>
</div>
</div>
</div>
</div>
</div>
<div class="p-4 border-t border-gray-100 text-center md:hidden">
<a href="#" class="text-sm text-primary hover:underline">Xem tất cả</a>
</div>
</div>
<!-- Cơ sở dữ liệu -->
<div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden mb-6">
<div class="p-4 md:p-6 border-b border-gray-100 flex items-center justify-between">
<div class="flex items-center">
<div class="w-10 h-10 flex items-center justify-center rounded-lg bg-purple-100 text-purple-600 mr-4 flex-shrink-0">
<i class="ri-database-2-line"></i>
</div>
<div>
<h2 class="text-lg font-semibold text-gray-800">Cơ sở dữ liệu</h2>
<p class="text-sm text-gray-500">IT305 - 18 chủ đề thảo luận</p>
</div>
</div>
<a href="#" class="text-sm text-primary hover:underline hidden md:block">Xem tất cả</a>
</div>
<div class="divide-y divide-gray-100">
<!-- Topic 1 -->
<div class="p-4 md:p-6 hover:bg-gray-50">
<div class="flex items-start">
<img src="https://readdy.ai/api/search-image?query=professional%2520portrait%2520photo%2520of%2520a%2520young%2520vietnamese%2520female%2520student%2520with%2520short%2520black%2520hair%252C%2520casual%2520outfit%252C%2520neutral%2520background%252C%2520friendly%2520smile&width=100&height=100&seq=4&orientation=squarish" alt="Avatar" class="w-10 h-10 rounded-full object-cover mr-4">
<div class="flex-1">
<div class="flex flex-wrap gap-2 mb-2">
<span class="px-2.5 py-1 bg-green-100 text-green-700 text-xs rounded-full">Đã giải quyết</span>
<span class="px-2.5 py-1 bg-purple-100 text-purple-700 text-xs rounded-full">Cơ sở dữ liệu</span>
</div>
<a href="#" class="text-lg font-medium text-gray-800 hover:text-primary">Cách tối ưu hóa truy vấn SQL trong hệ thống có nhiều bảng liên kết</a>
<div class="flex flex-wrap items-center text-sm text-gray-500 mt-2 gap-4">
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-user-line"></i>
</div>
Lê Thị Mai Anh
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-time-line"></i>
</div>
1 tuần trước
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-message-2-line"></i>
</div>
18 phản hồi
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-eye-line"></i>
</div>
124 lượt xem
</span>
</div>
</div>
</div>
</div>
<!-- Topic 2 -->
<div class="p-4 md:p-6 hover:bg-gray-50">
<div class="flex items-start">
<img src="https://readdy.ai/api/search-image?query=professional%2520portrait%2520photo%2520of%2520a%2520young%2520vietnamese%2520male%2520student%2520with%2520glasses%2520and%2520short%2520black%2520hair%252C%2520casual%2520outfit%252C%2520neutral%2520background%252C%2520friendly%2520smile&width=100&height=100&seq=5&orientation=squarish" alt="Avatar" class="w-10 h-10 rounded-full object-cover mr-4">
<div class="flex-1">
<div class="flex flex-wrap gap-2 mb-2">
<span class="px-2.5 py-1 bg-yellow-100 text-yellow-700 text-xs rounded-full">Chưa giải quyết</span>
<span class="px-2.5 py-1 bg-purple-100 text-purple-700 text-xs rounded-full">Cơ sở dữ liệu</span>
</div>
<a href="#" class="text-lg font-medium text-gray-800 hover:text-primary">Thiết kế mô hình ER cho hệ thống quản lý thư viện</a>
<div class="flex flex-wrap items-center text-sm text-gray-500 mt-2 gap-4">
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-user-line"></i>
</div>
Trần Quốc Bảo
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-time-line"></i>
</div>
2 ngày trước
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-message-2-line"></i>
</div>
7 phản hồi
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-eye-line"></i>
</div>
42 lượt xem
</span>
</div>
</div>
</div>
</div>
<!-- Topic 3 -->
<div class="p-4 md:p-6 hover:bg-gray-50">
<div class="flex items-start">
<img src="https://readdy.ai/api/search-image?query=professional%2520portrait%2520photo%2520of%2520a%2520young%2520vietnamese%2520female%2520student%2520with%2520glasses%2520and%2520long%2520black%2520hair%252C%2520casual%2520outfit%252C%2520neutral%2520background%252C%2520friendly%2520smile&width=100&height=100&seq=6&orientation=squarish" alt="Avatar" class="w-10 h-10 rounded-full object-cover mr-4">
<div class="flex-1">
<div class="flex flex-wrap gap-2 mb-2">
<span class="px-2.5 py-1 bg-yellow-100 text-yellow-700 text-xs rounded-full">Chưa giải quyết</span>
<span class="px-2.5 py-1 bg-purple-100 text-purple-700 text-xs rounded-full">Cơ sở dữ liệu</span>
</div>
<a href="#" class="text-lg font-medium text-gray-800 hover:text-primary">Sự khác biệt giữa NoSQL và SQL trong các ứng dụng thực tế</a>
<div class="flex flex-wrap items-center text-sm text-gray-500 mt-2 gap-4">
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-user-line"></i>
</div>
Nguyễn Thị Hồng Nhung
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-time-line"></i>
</div>
5 giờ trước
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-message-2-line"></i>
</div>
3 phản hồi
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-eye-line"></i>
</div>
31 lượt xem
</span>
</div>
</div>
</div>
</div>
</div>
<div class="p-4 border-t border-gray-100 text-center md:hidden">
<a href="#" class="text-sm text-primary hover:underline">Xem tất cả</a>
</div>
</div>
<!-- Mạng máy tính -->
<div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden mb-6">
<div class="p-4 md:p-6 border-b border-gray-100 flex items-center justify-between">
<div class="flex items-center">
<div class="w-10 h-10 flex items-center justify-center rounded-lg bg-green-100 text-green-600 mr-4 flex-shrink-0">
<i class="ri-global-line"></i>
</div>
<div>
<h2 class="text-lg font-semibold text-gray-800">Mạng máy tính</h2>
<p class="text-sm text-gray-500">NET202 - 15 chủ đề thảo luận</p>
</div>
</div>
<a href="#" class="text-sm text-primary hover:underline hidden md:block">Xem tất cả</a>
</div>
<div class="divide-y divide-gray-100">
<!-- Topic 1 -->
<div class="p-4 md:p-6 hover:bg-gray-50">
<div class="flex items-start">
<img src="https://readdy.ai/api/search-image?query=professional%2520portrait%2520photo%2520of%2520a%2520young%2520vietnamese%2520male%2520student%2520with%2520short%2520black%2520hair%252C%2520casual%2520outfit%252C%2520neutral%2520background%252C%2520friendly%2520smile&width=100&height=100&seq=7&orientation=squarish" alt="Avatar" class="w-10 h-10 rounded-full object-cover mr-4">
<div class="flex-1">
<div class="flex flex-wrap gap-2 mb-2">
<span class="px-2.5 py-1 bg-green-100 text-green-700 text-xs rounded-full">Đã giải quyết</span>
<span class="px-2.5 py-1 bg-green-100 text-green-700 text-xs rounded-full">Mạng máy tính</span>
</div>
<a href="#" class="text-lg font-medium text-gray-800 hover:text-primary">Phân tích và so sánh các giao thức định tuyến trong mạng WAN</a>
<div class="flex flex-wrap items-center text-sm text-gray-500 mt-2 gap-4">
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-user-line"></i>
</div>
Lê Minh Đức
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-time-line"></i>
</div>
3 ngày trước
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-message-2-line"></i>
</div>
14 phản hồi
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-eye-line"></i>
</div>
89 lượt xem
</span>
</div>
</div>
</div>
</div>
<!-- Topic 2 -->
<div class="p-4 md:p-6 hover:bg-gray-50">
<div class="flex items-start">
<img src="https://readdy.ai/api/search-image?query=professional%2520portrait%2520photo%2520of%2520a%2520young%2520vietnamese%2520female%2520student%2520with%2520medium%2520black%2520hair%252C%2520casual%2520outfit%252C%2520neutral%2520background%252C%2520friendly%2520smile&width=100&height=100&seq=8&orientation=squarish" alt="Avatar" class="w-10 h-10 rounded-full object-cover mr-4">
<div class="flex-1">
<div class="flex flex-wrap gap-2 mb-2">
<span class="px-2.5 py-1 bg-yellow-100 text-yellow-700 text-xs rounded-full">Chưa giải quyết</span>
<span class="px-2.5 py-1 bg-green-100 text-green-700 text-xs rounded-full">Mạng máy tính</span>
</div>
<a href="#" class="text-lg font-medium text-gray-800 hover:text-primary">Cấu hình VLAN trên thiết bị Cisco - gặp lỗi khi ping giữa các VLAN</a>
<div class="flex flex-wrap items-center text-sm text-gray-500 mt-2 gap-4">
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-user-line"></i>
</div>
Vũ Thị Thanh Hà
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-time-line"></i>
</div>
1 ngày trước
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-message-2-line"></i>
</div>
8 phản hồi
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-eye-line"></i>
</div>
47 lượt xem
</span>
</div>
</div>
</div>
</div>
<!-- Topic 3 -->
<div class="p-4 md:p-6 hover:bg-gray-50">
<div class="flex items-start">
<img src="https://readdy.ai/api/search-image?query=professional%2520portrait%2520photo%2520of%2520a%2520young%2520vietnamese%2520male%2520student%2520with%2520short%2520black%2520hair%252C%2520casual%2520outfit%252C%2520neutral%2520background%252C%2520friendly%2520smile&width=100&height=100&seq=1&orientation=squarish" alt="Avatar" class="w-10 h-10 rounded-full object-cover mr-4">
<div class="flex-1">
<div class="flex flex-wrap gap-2 mb-2">
<span class="px-2.5 py-1 bg-yellow-100 text-yellow-700 text-xs rounded-full">Chưa giải quyết</span>
<span class="px-2.5 py-1 bg-green-100 text-green-700 text-xs rounded-full">Mạng máy tính</span>
</div>
<a href="#" class="text-lg font-medium text-gray-800 hover:text-primary">Bảo mật mạng không dây trong môi trường doanh nghiệp</a>
<div class="flex flex-wrap items-center text-sm text-gray-500 mt-2 gap-4">
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-user-line"></i>
</div>
Nguyễn Văn Minh
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-time-line"></i>
</div>
8 giờ trước
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-message-2-line"></i>
</div>
4 phản hồi
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-eye-line"></i>
</div>
23 lượt xem
</span>
</div>
</div>
</div>
</div>
</div>
<div class="p-4 border-t border-gray-100 text-center md:hidden">
<a href="#" class="text-sm text-primary hover:underline">Xem tất cả</a>
</div>
</div>
<!-- Hoạt động câu lạc bộ -->
<div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden mb-6">
<div class="p-4 md:p-6 border-b border-gray-100 flex items-center justify-between">
<div class="flex items-center">
<div class="w-10 h-10 flex items-center justify-center rounded-lg bg-orange-100 text-orange-600 mr-4 flex-shrink-0">
<i class="ri-team-line"></i>
</div>
<div>
<h2 class="text-lg font-semibold text-gray-800">Hoạt động câu lạc bộ</h2>
<p class="text-sm text-gray-500">12 chủ đề thảo luận</p>
</div>
</div>
<a href="#" class="text-sm text-primary hover:underline hidden md:block">Xem tất cả</a>
</div>
<div class="divide-y divide-gray-100">
<!-- Topic 1 -->
<div class="p-4 md:p-6 hover:bg-gray-50">
<div class="flex items-start">
<img src="https://readdy.ai/api/search-image?query=professional%2520portrait%2520photo%2520of%2520a%2520young%2520vietnamese%2520female%2520student%2520leader%2520with%2520confident%2520expression%252C%2520business%2520casual%2520outfit%252C%2520neutral%2520background&width=100&height=100&seq=9&orientation=squarish" alt="Avatar" class="w-10 h-10 rounded-full object-cover mr-4">
<div class="flex-1">
<div class="flex flex-wrap gap-2 mb-2">
<span class="px-2.5 py-1 bg-orange-100 text-orange-700 text-xs rounded-full">CLB Công nghệ</span>
<span class="px-2.5 py-1 bg-blue-100 text-blue-700 text-xs rounded-full">Sự kiện</span>
</div>
<a href="#" class="text-lg font-medium text-gray-800 hover:text-primary">Thông báo: Hackathon Mùa xuân 2025 - Đăng ký tham gia</a>
<div class="flex flex-wrap items-center text-sm text-gray-500 mt-2 gap-4">
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-user-line"></i>
</div>
Trần Thu Thảo
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-time-line"></i>
</div>
1 ngày trước
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-message-2-line"></i>
</div>
25 phản hồi
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-eye-line"></i>
</div>
156 lượt xem
</span>
</div>
</div>
</div>
</div>
<!-- Topic 2 -->
<div class="p-4 md:p-6 hover:bg-gray-50">
<div class="flex items-start">
<img src="https://readdy.ai/api/search-image?query=professional%2520portrait%2520photo%2520of%2520a%2520young%2520vietnamese%2520male%2520student%2520leader%2520with%2520friendly%2520smile%252C%2520casual%2520outfit%252C%2520neutral%2520background&width=100&height=100&seq=10&orientation=squarish" alt="Avatar" class="w-10 h-10 rounded-full object-cover mr-4">
<div class="flex-1">
<div class="flex flex-wrap gap-2 mb-2">
<span class="px-2.5 py-1 bg-orange-100 text-orange-700 text-xs rounded-full">CLB Tiếng Anh</span>
<span class="px-2.5 py-1 bg-blue-100 text-blue-700 text-xs rounded-full">Hoạt động</span>
</div>
<a href="#" class="text-lg font-medium text-gray-800 hover:text-primary">English Speaking Contest 2025 - Tuyển thành viên ban tổ chức</a>
<div class="flex flex-wrap items-center text-sm text-gray-500 mt-2 gap-4">
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-user-line"></i>
</div>
Nguyễn Hoàng Nam
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-time-line"></i>
</div>
2 ngày trước
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-message-2-line"></i>
</div>
16 phản hồi
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-eye-line"></i>
</div>
98 lượt xem
</span>
</div>
</div>
</div>
</div>
<!-- Topic 3 -->
<div class="p-4 md:p-6 hover:bg-gray-50">
<div class="flex items-start">
<img src="https://readdy.ai/api/search-image?query=professional%2520portrait%2520photo%2520of%2520a%2520young%2520vietnamese%2520female%2520student%2520with%2520creative%2520style%252C%2520artistic%2520outfit%252C%2520neutral%2520background&width=100&height=100&seq=11&orientation=squarish" alt="Avatar" class="w-10 h-10 rounded-full object-cover mr-4">
<div class="flex-1">
<div class="flex flex-wrap gap-2 mb-2">
<span class="px-2.5 py-1 bg-orange-100 text-orange-700 text-xs rounded-full">CLB Media</span>
<span class="px-2.5 py-1 bg-blue-100 text-blue-700 text-xs rounded-full">Tuyển thành viên</span>
</div>
<a href="#" class="text-lg font-medium text-gray-800 hover:text-primary">Tuyển CTV Content Creator - Mùa tuyển sinh 2025</a>
<div class="flex flex-wrap items-center text-sm text-gray-500 mt-2 gap-4">
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-user-line"></i>
</div>
Phạm Minh Châu
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-time-line"></i>
</div>
4 giờ trước
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-message-2-line"></i>
</div>
8 phản hồi
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-eye-line"></i>
</div>
67 lượt xem
</span>
</div>
</div>
</div>
</div>
</div>
<div class="p-4 border-t border-gray-100 text-center md:hidden">
<a href="#" class="text-sm text-primary hover:underline">Xem tất cả</a>
</div>
</div>
<!-- Thảo luận chung -->
<div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden mb-6">
<div class="p-4 md:p-6 border-b border-gray-100 flex items-center justify-between">
<div class="flex items-center">
<div class="w-10 h-10 flex items-center justify-center rounded-lg bg-pink-100 text-pink-600 mr-4 flex-shrink-0">
<i class="ri-chat-3-line"></i>
</div>
<div>
<h2 class="text-lg font-semibold text-gray-800">Thảo luận chung</h2>
<p class="text-sm text-gray-500">8 chủ đề thảo luận</p>
</div>
</div>
<a href="#" class="text-sm text-primary hover:underline hidden md:block">Xem tất cả</a>
</div>
<div class="divide-y divide-gray-100">
<!-- Topic 1 -->
<div class="p-4 md:p-6 hover:bg-gray-50">
<div class="flex items-start">
<img src="https://readdy.ai/api/search-image?query=professional%2520portrait%2520photo%2520of%2520a%2520young%2520vietnamese%2520student%2520with%2520casual%2520style%252C%2520friendly%2520expression%252C%2520neutral%2520background&width=100&height=100&seq=12&orientation=squarish" alt="Avatar" class="w-10 h-10 rounded-full object-cover mr-4">
<div class="flex-1">
<div class="flex flex-wrap gap-2 mb-2">
<span class="px-2.5 py-1 bg-pink-100 text-pink-700 text-xs rounded-full">Chia sẻ</span>
<span class="px-2.5 py-1 bg-blue-100 text-blue-700 text-xs rounded-full">Kinh nghiệm</span>
</div>
<a href="#" class="text-lg font-medium text-gray-800 hover:text-primary">Chia sẻ kinh nghiệm thực tập tại các công ty công nghệ lớn</a>
<div class="flex flex-wrap items-center text-sm text-gray-500 mt-2 gap-4">
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-user-line"></i>
</div>
Đỗ Thanh Tùng
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-time-line"></i>
</div>
3 ngày trước
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-message-2-line"></i>
</div>
32 phản hồi
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-eye-line"></i>
</div>
245 lượt xem
</span>
</div>
</div>
</div>
</div>
<!-- Topic 2 -->
<div class="p-4 md:p-6 hover:bg-gray-50">
<div class="flex items-start">
<img src="https://readdy.ai/api/search-image?query=professional%2520portrait%2520photo%2520of%2520a%2520young%2520vietnamese%2520female%2520student%2520with%2520modern%2520style%252C%2520casual%2520outfit%252C%2520neutral%2520background&width=100&height=100&seq=13&orientation=squarish" alt="Avatar" class="w-10 h-10 rounded-full object-cover mr-4">
<div class="flex-1">
<div class="flex flex-wrap gap-2 mb-2">
<span class="px-2.5 py-1 bg-pink-100 text-pink-700 text-xs rounded-full">Tâm sự</span>
<span class="px-2.5 py-1 bg-blue-100 text-blue-700 text-xs rounded-full">Sinh viên</span>
</div>
<a href="#" class="text-lg font-medium text-gray-800 hover:text-primary">Cân bằng giữa học tập và các hoạt động ngoại khóa</a>
<div class="flex flex-wrap items-center text-sm text-gray-500 mt-2 gap-4">
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-user-line"></i>
</div>
Lê Thị Quỳnh Anh
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-time-line"></i>
</div>
1 ngày trước
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-message-2-line"></i>
</div>
21 phản hồi
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-eye-line"></i>
</div>
178 lượt xem
</span>
</div>
</div>
</div>
</div>
<!-- Topic 3 -->
<div class="p-4 md:p-6 hover:bg-gray-50">
<div class="flex items-start">
<img src="https://readdy.ai/api/search-image?query=professional%2520portrait%2520photo%2520of%2520a%2520young%2520vietnamese%2520male%2520student%2520with%2520sporty%2520style%252C%2520athletic%2520outfit%252C%2520neutral%2520background&width=100&height=100&seq=14&orientation=squarish" alt="Avatar" class="w-10 h-10 rounded-full object-cover mr-4">
<div class="flex-1">
<div class="flex flex-wrap gap-2 mb-2">
<span class="px-2.5 py-1 bg-pink-100 text-pink-700 text-xs rounded-full">Thể thao</span>
<span class="px-2.5 py-1 bg-blue-100 text-blue-700 text-xs rounded-full">Giải trí</span>
</div>
<a href="#" class="text-lg font-medium text-gray-800 hover:text-primary">Tổ chức giải bóng đá sinh viên - Mùa hè 2025</a>
<div class="flex flex-wrap items-center text-sm text-gray-500 mt-2 gap-4">
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-user-line"></i>
</div>
Hoàng Minh Tuấn
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-time-line"></i>
</div>
6 giờ trước
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-message-2-line"></i>
</div>
15 phản hồi
</span>
<span class="flex items-center">
<div class="w-4 h-4 flex items-center justify-center mr-1">
<i class="ri-eye-line"></i>
</div>
112 lượt xem
</span>
</div>
</div>
</div>
</div>
</div>
<div class="p-4 border-t border-gray-100 text-center md:hidden">
<a href="#" class="text-sm text-primary hover:underline">Xem tất cả</a>
</div>
</div>
<!-- Pagination -->
<div class="flex justify-center my-6">
<nav class="flex items-center">
<a href="#" class="w-10 h-10 flex items-center justify-center rounded-lg border border-gray-200 text-gray-500 hover:bg-gray-50 mr-2">
<i class="ri-arrow-left-s-line"></i>
</a>
<a href="#" class="w-10 h-10 flex items-center justify-center rounded-lg bg-primary text-white mr-2">1</a>
<a href="#" class="w-10 h-10 flex items-center justify-center rounded-lg border border-gray-200 text-gray-700 hover:bg-gray-50 mr-2">2</a>
<a href="#" class="w-10 h-10 flex items-center justify-center rounded-lg border border-gray-200 text-gray-700 hover:bg-gray-50 mr-2">3</a>
<span class="mx-2 text-gray-500">...</span>
<a href="#" class="w-10 h-10 flex items-center justify-center rounded-lg border border-gray-200 text-gray-700 hover:bg-gray-50 mr-2">8</a>
<a href="#" class="w-10 h-10 flex items-center justify-center rounded-lg border border-gray-200 text-gray-500 hover:bg-gray-50">
<i class="ri-arrow-right-s-line"></i>
</a>
</nav>
</div>
</div>
</main>
</div>
</div>
<!-- Mobile Navigation -->
<div class="md:hidden fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 z-10">
<div class="flex items-center justify-around">
<a href="#" class="flex flex-col items-center py-2 text-gray-500">
<div class="w-6 h-6 flex items-center justify-center">
<i class="ri-dashboard-line"></i>
</div>
<span class="text-xs mt-1">Trang chủ</span>
</a>
<a href="#" class="flex flex-col items-center py-2 text-gray-500">
<div class="w-6 h-6 flex items-center justify-center">
<i class="ri-book-open-line"></i>
</div>
<span class="text-xs mt-1">Khóa học</span>
</a>
<a href="#" class="flex flex-col items-center py-2 text-primary">
<div class="w-6 h-6 flex items-center justify-center">
<i class="ri-discuss-line"></i>
</div>
<span class="text-xs mt-1">Diễn đàn</span>
</a>
<a href="#" class="flex flex-col items-center py-2 text-gray-500">
<div class="w-6 h-6 flex items-center justify-center">
<i class="ri-file-list-3-line"></i>
</div>
<span class="text-xs mt-1">Bài tập</span>
</a>
<a href="#" class="flex flex-col items-center py-2 text-gray-500">
<div class="w-6 h-6 flex items-center justify-center">
<i class="ri-user-line"></i>
</div>
<span class="text-xs mt-1">Cá nhân</span>
</a>
</div>
</div>
<script id="mobileMenuScript">
document.addEventListener('DOMContentLoaded', function() {
const menuButton = document.querySelector('.md\\:hidden .ri-menu-line').parentElement;
const sidebar = document.querySelector('aside');
menuButton.addEventListener('click', function() {
sidebar.classList.toggle('hidden');
sidebar.classList.toggle('fixed');
sidebar.classList.toggle('z-50');
sidebar.classList.toggle('top-0');
sidebar.classList.toggle('left-0');
sidebar.classList.toggle('h-full');
});
});
</script>
<script id="dropdownScript">
document.addEventListener('DOMContentLoaded', function() {
// Handling dropdown on mobile
const dropdowns = document.querySelectorAll('.dropdown');
dropdowns.forEach(dropdown => {
const button = dropdown.querySelector('button');
const content = dropdown.querySelector('.dropdown-content');
// For mobile, toggle on click instead of hover
if (window.innerWidth < 768) {
button.addEventListener('click', function(e) {
e.stopPropagation();
// Close all other dropdowns
dropdowns.forEach(otherDropdown => {
if (otherDropdown !== dropdown) {
otherDropdown.querySelector('.dropdown-content').style.display = 'none';
}
});
// Toggle current dropdown
if (content.style.display === 'block') {
content.style.display = 'none';
} else {
content.style.display = 'block';
}
});
// Close dropdown when clicking outside
document.addEventListener('click', function() {
content.style.display = 'none';
});
}
});
});
</script>
</body>
</html>