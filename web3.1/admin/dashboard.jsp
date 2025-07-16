<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduLearn LMS - Dashboard</title>
    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
    <script>tailwind.config={theme:{extend:{colors:{primary:'#4F46E5',secondary:'#818CF8'},borderRadius:{'none':'0px','sm':'4px',DEFAULT:'8px','md':'12px','lg':'16px','xl':'20px','2xl':'24px','3xl':'32px','full':'9999px','button':'8px'}}}}</script>
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
                    <a href="dashboard.html" class="sidebar-link active flex items-center px-3 py-2 text-sm font-medium rounded-md">
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
                    <a href="announcements.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium text-gray-600 rounded-md hover:bg-gray-50">
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
    <!-- Main Content -->
    <div class="flex-1 flex flex-col overflow-hidden">
        <!-- Top Header -->
        <header class="bg-white shadow-sm z-10">
            <div class="flex items-center justify-between px-6 py-3">
                <div class="flex items-center">
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                            <div class="w-5 h-5 flex items-center justify-center text-gray-400">
                                <i class="ri-search-line"></i>
                            </div>
                        </div>
                        <input type="text" class="py-2 pl-10 pr-4 w-64 text-sm text-gray-700 bg-gray-50 rounded-lg border-none focus:outline-none focus:ring-2 focus:ring-primary focus:bg-white" placeholder="Search for courses, users...">
                    </div>
                </div>
                
                <div class="flex items-center space-x-4">
                    <div class="relative">
                        <button class="p-1 rounded-full text-gray-400 hover:text-gray-500 focus:outline-none">
                            <div class="w-6 h-6 flex items-center justify-center">
                                <i class="ri-notification-3-line"></i>
                            </div>
                        </button>
                        <span class="absolute top-0 right-0 h-4 w-4 bg-red-500 rounded-full flex items-center justify-center text-xs text-white">3</span>
                    </div>
                    
                    <div class="relative">
                        <button class="p-1 rounded-full text-gray-400 hover:text-gray-500 focus:outline-none">
                            <div class="w-6 h-6 flex items-center justify-center">
                                <i class="ri-message-2-line"></i>
                            </div>
                        </button>
                        <span class="absolute top-0 right-0 h-4 w-4 bg-primary rounded-full flex items-center justify-center text-xs text-white">5</span>
                    </div>
                    
                    <div class="flex items-center">
                        <button class="flex items-center space-x-2 focus:outline-none">
                            <div class="w-8 h-8 rounded-full bg-primary flex items-center justify-center text-white">
                                <span class="font-medium">JD</span>
                            </div>
                            <div class="hidden md:block text-left">
                                <span class="text-sm font-medium text-gray-700">John Doe</span>
                            </div>
                            <div class="w-5 h-5 flex items-center justify-center text-gray-400">
                                <i class="ri-arrow-down-s-line"></i>
                            </div>
                        </button>
                    </div>
                </div>
            </div>
            
            <div class="px-6 py-2 border-t border-gray-100">
                <div class="flex items-center space-x-2 text-sm">
                    <a href="#" class="text-gray-500 hover:text-gray-700">Dashboard</a>
                    <div class="w-4 h-4 flex items-center justify-center text-gray-400">
                        <i class="ri-arrow-right-s-line"></i>
                    </div>
                    <span class="text-gray-700 font-medium">Overview</span>
                </div>
            </div>
        </header>

        <!-- Main Content Area -->
        <main class="flex-1 overflow-y-auto p-6 custom-scrollbar">
            <div class="mb-6">
                <h1 class="text-2xl font-bold text-gray-800">Dashboard</h1>
                <p class="text-gray-600 mt-1">Welcome back, John! Here's what's happening with your university today.</p>
            </div>
            
            <!-- Stats Cards -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
                <div class="bg-white rounded-lg shadow-sm p-6 border border-gray-100">
                    <div class="flex items-center">
                        <div class="w-12 h-12 rounded-lg bg-blue-100 flex items-center justify-center text-primary">
                            <div class="w-6 h-6 flex items-center justify-center">
                                <i class="ri-user-line"></i>
                            </div>
                        </div>
                        <div class="ml-4">
                            <h3 class="text-lg font-semibold text-gray-800">2,543</h3>
                            <p class="text-sm text-gray-500">Total Students</p>
                        </div>
                    </div>
                    <div class="mt-4 flex items-center text-sm">
                        <span class="text-green-500 font-medium flex items-center">
                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                <i class="ri-arrow-up-line"></i>
                            </div>
                            12.5%
                        </span>
                        <span class="text-gray-500 ml-2">from last semester</span>
                    </div>
                </div>
                
                <div class="bg-white rounded-lg shadow-sm p-6 border border-gray-100">
                    <div class="flex items-center">
                        <div class="w-12 h-12 rounded-lg bg-purple-100 flex items-center justify-center text-purple-600">
                            <div class="w-6 h-6 flex items-center justify-center">
                                <i class="ri-user-star-line"></i>
                            </div>
                        </div>
                        <div class="ml-4">
                            <h3 class="text-lg font-semibold text-gray-800">187</h3>
                            <p class="text-sm text-gray-500">Total Lecturers</p>
                        </div>
                    </div>
                    <div class="mt-4 flex items-center text-sm">
                        <span class="text-green-500 font-medium flex items-center">
                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                <i class="ri-arrow-up-line"></i>
                            </div>
                            3.2%
                        </span>
                        <span class="text-gray-500 ml-2">from last semester</span>
                    </div>
                </div>
                
                <div class="bg-white rounded-lg shadow-sm p-6 border border-gray-100">
                    <div class="flex items-center">
                        <div class="w-12 h-12 rounded-lg bg-green-100 flex items-center justify-center text-green-600">
                            <div class="w-6 h-6 flex items-center justify-center">
                                <i class="ri-book-open-line"></i>
                            </div>
                        </div>
                        <div class="ml-4">
                            <h3 class="text-lg font-semibold text-gray-800">342</h3>
                            <p class="text-sm text-gray-500">Active Courses</p>
                        </div>
                    </div>
                    <div class="mt-4 flex items-center text-sm">
                        <span class="text-red-500 font-medium flex items-center">
                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                <i class="ri-arrow-down-line"></i>
                            </div>
                            1.8%
                        </span>
                        <span class="text-gray-500 ml-2">from last semester</span>
                    </div>
                </div>
                
                <div class="bg-white rounded-lg shadow-sm p-6 border border-gray-100">
                    <div class="flex items-center">
                        <div class="w-12 h-12 rounded-lg bg-amber-100 flex items-center justify-center text-amber-600">
                            <div class="w-6 h-6 flex items-center justify-center">
                                <i class="ri-file-list-3-line"></i>
                            </div>
                        </div>
                        <div class="ml-4">
                            <h3 class="text-lg font-semibold text-gray-800">1,287</h3>
                            <p class="text-sm text-gray-500">Assignments</p>
                        </div>
                    </div>
                    <div class="mt-4 flex items-center text-sm">
                        <span class="text-green-500 font-medium flex items-center">
                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                <i class="ri-arrow-up-line"></i>
                            </div>
                            8.3%
                        </span>
                        <span class="text-gray-500 ml-2">from last month</span>
                    </div>
                </div>
            </div>
            
            <!-- Main Content Grid -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <!-- Left Column -->
                <div class="lg:col-span-2 space-y-6">
                    <!-- Recent Activity -->
                    <div class="bg-white rounded-lg shadow-sm border border-gray-100">
                        <div class="px-6 py-4 border-b border-gray-100 flex justify-between items-center">
                            <h2 class="font-semibold text-gray-800">Recent Activity</h2>
                            <button class="text-sm text-primary hover:text-primary-dark whitespace-nowrap">View All</button>
                        </div>
                        <div class="p-6">
                            <div class="space-y-4">
                                <div class="flex items-start">
                                    <div class="w-10 h-10 rounded-full bg-blue-100 flex items-center justify-center text-primary flex-shrink-0">
                                        <div class="w-5 h-5 flex items-center justify-center">
                                            <i class="ri-file-upload-line"></i>
                                        </div>
                                    </div>
                                    <div class="ml-4">
                                        <p class="text-sm text-gray-800">
                                            <span class="font-medium">Dr. Emily Johnson</span> uploaded new materials for <span class="font-medium">Advanced Database Systems</span>
                                        </p>
                                        <p class="text-xs text-gray-500 mt-1">Today at 10:32 AM</p>
                                    </div>
                                </div>
                                
                                <div class="flex items-start">
                                    <div class="w-10 h-10 rounded-full bg-green-100 flex items-center justify-center text-green-600 flex-shrink-0">
                                        <div class="w-5 h-5 flex items-center justify-center">
                                            <i class="ri-user-add-line"></i>
                                        </div>
                                    </div>
                                    <div class="ml-4">
                                        <p class="text-sm text-gray-800">
                                            <span class="font-medium">Prof. Michael Chen</span> created a new course <span class="font-medium">Introduction to Artificial Intelligence</span>
                                        </p>
                                        <p class="text-xs text-gray-500 mt-1">Yesterday at 4:15 PM</p>
                                    </div>
                                </div>
                                
                                <div class="flex items-start">
                                    <div class="w-10 h-10 rounded-full bg-amber-100 flex items-center justify-center text-amber-600 flex-shrink-0">
                                        <div class="w-5 h-5 flex items-center justify-center">
                                            <i class="ri-calendar-event-line"></i>
                                        </div>
                                    </div>
                                    <div class="ml-4">
                                        <p class="text-sm text-gray-800">
                                            <span class="font-medium">System</span> scheduled final exams for <span class="font-medium">Spring Semester 2025</span>
                                        </p>
                                        <p class="text-xs text-gray-500 mt-1">May 24, 2025 at 9:00 AM</p>
                                    </div>
                                </div>
                                
                                <div class="flex items-start">
                                    <div class="w-10 h-10 rounded-full bg-purple-100 flex items-center justify-center text-purple-600 flex-shrink-0">
                                        <div class="w-5 h-5 flex items-center justify-center">
                                            <i class="ri-discuss-line"></i>
                                        </div>
                                    </div>
                                    <div class="ml-4">
                                        <p class="text-sm text-gray-800">
                                            <span class="font-medium">Sarah Williams</span> posted a new discussion in <span class="font-medium">Computer Networks Forum</span>
                                        </p>
                                        <p class="text-xs text-gray-500 mt-1">May 23, 2025 at 2:45 PM</p>
                                    </div>
                                </div>
                                
                                <div class="flex items-start">
                                    <div class="w-10 h-10 rounded-full bg-red-100 flex items-center justify-center text-red-600 flex-shrink-0">
                                        <div class="w-5 h-5 flex items-center justify-center">
                                            <i class="ri-alarm-warning-line"></i>
                                        </div>
                                    </div>
                                    <div class="ml-4">
                                        <p class="text-sm text-gray-800">
                                            <span class="font-medium">System</span> deadline reminder for <span class="font-medium">Research Methodology Assignment</span>
                                        </p>
                                        <p class="text-xs text-gray-500 mt-1">May 22, 2025 at 11:30 AM</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Enrollment Stats -->
                    <div class="bg-white rounded-lg shadow-sm border border-gray-100">
                        <div class="px-6 py-4 border-b border-gray-100">
                            <h2 class="font-semibold text-gray-800">Enrollment Statistics</h2>
                        </div>
                        <div class="p-6">
                            <div id="enrollment-chart" class="h-80"></div>
                        </div>
                    </div>
                </div>
                
                <!-- Right Column -->
                <div class="space-y-6">
                    <!-- Upcoming Events -->
                    <div class="bg-white rounded-lg shadow-sm border border-gray-100">
                        <div class="px-6 py-4 border-b border-gray-100 flex justify-between items-center">
                            <h2 class="font-semibold text-gray-800">Upcoming Events</h2>
                            <button class="text-sm text-primary hover:text-primary-dark whitespace-nowrap">View Calendar</button>
                        </div>
                        <div class="p-6">
                            <div class="space-y-4">
                                <div class="flex items-start">
                                    <div class="w-12 h-12 rounded-lg bg-primary bg-opacity-10 flex flex-col items-center justify-center flex-shrink-0">
                                        <span class="text-xs font-medium text-primary">MAY</span>
                                        <span class="text-lg font-bold text-primary">28</span>
                                    </div>
                                    <div class="ml-4">
                                        <h3 class="text-sm font-medium text-gray-800">Faculty Meeting</h3>
                                        <p class="text-xs text-gray-500 mt-1">10:00 AM - 12:00 PM</p>
                                        <div class="flex items-center mt-2">
                                            <div class="w-4 h-4 flex items-center justify-center text-gray-400">
                                                <i class="ri-map-pin-line"></i>
                                            </div>
                                            <span class="text-xs text-gray-500 ml-1">Conference Room A</span>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="flex items-start">
                                    <div class="w-12 h-12 rounded-lg bg-green-100 flex flex-col items-center justify-center flex-shrink-0">
                                        <span class="text-xs font-medium text-green-600">JUN</span>
                                        <span class="text-lg font-bold text-green-600">02</span>
                                    </div>
                                    <div class="ml-4">
                                        <h3 class="text-sm font-medium text-gray-800">Guest Lecture: AI Ethics</h3>
                                        <p class="text-xs text-gray-500 mt-1">2:00 PM - 4:00 PM</p>
                                        <div class="flex items-center mt-2">
                                            <div class="w-4 h-4 flex items-center justify-center text-gray-400">
                                                <i class="ri-map-pin-line"></i>
                                            </div>
                                            <span class="text-xs text-gray-500 ml-1">Auditorium B</span>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="flex items-start">
                                    <div class="w-12 h-12 rounded-lg bg-amber-100 flex flex-col items-center justify-center flex-shrink-0">
                                        <span class="text-xs font-medium text-amber-600">JUN</span>
                                        <span class="text-lg font-bold text-amber-600">10</span>
                                    </div>
                                    <div class="ml-4">
                                        <h3 class="text-sm font-medium text-gray-800">Final Exam: Database Systems</h3>
                                        <p class="text-xs text-gray-500 mt-1">9:00 AM - 12:00 PM</p>
                                        <div class="flex items-center mt-2">
                                            <div class="w-4 h-4 flex items-center justify-center text-gray-400">
                                                <i class="ri-map-pin-line"></i>
                                            </div>
                                            <span class="text-xs text-gray-500 ml-1">Examination Hall 3</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Quick Actions -->
                    <div class="bg-white rounded-lg shadow-sm border border-gray-100">
                        <div class="px-6 py-4 border-b border-gray-100">
                            <h2 class="font-semibold text-gray-800">Quick Actions</h2>
                        </div>
                        <div class="p-4">
                            <div class="grid grid-cols-2 gap-3">
                                <button class="flex flex-col items-center justify-center p-4 bg-gray-50 rounded-lg hover:bg-gray-100 transition-colors whitespace-nowrap">
                                    <div class="w-8 h-8 flex items-center justify-center text-primary mb-2">
                                        <i class="ri-user-add-line ri-lg"></i>
                                    </div>
                                    <span class="text-xs font-medium text-gray-700">Add User</span>
                                </button>
                                
                                <button class="flex flex-col items-center justify-center p-4 bg-gray-50 rounded-lg hover:bg-gray-100 transition-colors whitespace-nowrap">
                                    <div class="w-8 h-8 flex items-center justify-center text-primary mb-2">
                                        <i class="ri-book-open-line ri-lg"></i>
                                    </div>
                                    <span class="text-xs font-medium text-gray-700">New Course</span>
                                </button>
                                
                                <button class="flex flex-col items-center justify-center p-4 bg-gray-50 rounded-lg hover:bg-gray-100 transition-colors whitespace-nowrap">
                                    <div class="w-8 h-8 flex items-center justify-center text-primary mb-2">
                                        <i class="ri-calendar-line ri-lg"></i>
                                    </div>
                                    <span class="text-xs font-medium text-gray-700">Schedule</span>
                                </button>
                                
                                <button class="flex flex-col items-center justify-center p-4 bg-gray-50 rounded-lg hover:bg-gray-100 transition-colors whitespace-nowrap">
                                    <div class="w-8 h-8 flex items-center justify-center text-primary mb-2">
                                        <i class="ri-file-chart-line ri-lg"></i>
                                    </div>
                                    <span class="text-xs font-medium text-gray-700">Reports</span>
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- System Status -->
                    <div class="bg-white rounded-lg shadow-sm border border-gray-100">
                        <div class="px-6 py-4 border-b border-gray-100">
                            <h2 class="font-semibold text-gray-800">System Status</h2>
                        </div>
                        <div class="p-6">
                            <div class="space-y-4">
                                <div>
                                    <div class="flex justify-between items-center mb-1">
                                        <span class="text-sm text-gray-600">Storage Usage</span>
                                        <span class="text-sm font-medium text-gray-800">68%</span>
                                    </div>
                                    <div class="w-full bg-gray-200 rounded-full h-2">
                                        <div class="bg-primary h-2 rounded-full" style="width: 68%"></div>
                                    </div>
                                </div>
                                
                                <div>
                                    <div class="flex justify-between items-center mb-1">
                                        <span class="text-sm text-gray-600">User Accounts</span>
                                        <span class="text-sm font-medium text-gray-800">2,730 / 3,000</span>
                                    </div>
                                    <div class="w-full bg-gray-200 rounded-full h-2">
                                        <div class="bg-green-500 h-2 rounded-full" style="width: 91%"></div>
                                    </div>
                                </div>
                                
                                <div>
                                    <div class="flex justify-between items-center mb-1">
                                        <span class="text-sm text-gray-600">System Load</span>
                                        <span class="text-sm font-medium text-gray-800">42%</span>
                                    </div>
                                    <div class="w-full bg-gray-200 rounded-full h-2">
                                        <div class="bg-amber-500 h-2 rounded-full" style="width: 42%"></div>
                                    </div>
                                </div>
                                
                                <div class="pt-2">
                                    <div class="flex items-center justify-between">
                                        <div class="flex items-center">
                                            <div class="w-3 h-3 rounded-full bg-green-500 mr-2"></div>
                                            <span class="text-sm text-gray-600">All Systems Operational</span>
                                        </div>
                                        <span class="text-xs text-gray-500">Updated 5 min ago</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    
    <!-- AI Chatbot -->
    <div class="fixed bottom-6 right-6 z-50">
        <button id="chatbot-toggle" class="w-14 h-14 rounded-full bg-primary shadow-lg flex items-center justify-center text-white">
            <div class="w-6 h-6 flex items-center justify-center">
                <i class="ri-robot-line"></i>
            </div>
        </button>
        
        <div id="chatbot-panel" class="hidden absolute bottom-16 right-0 w-80 bg-white rounded-lg shadow-xl border border-gray-200 overflow-hidden">
            <div class="p-4 bg-primary text-white flex items-center justify-between">
                <div class="flex items-center">
                    <div class="w-8 h-8 rounded-full bg-white bg-opacity-20 flex items-center justify-center mr-3">
                        <div class="w-5 h-5 flex items-center justify-center">
                            <i class="ri-robot-line"></i>
                        </div>
                    </div>
                    <span class="font-medium">EduLearn Assistant</span>
                </div>
                <button id="chatbot-close" class="text-white hover:text-gray-200">
                    <div class="w-5 h-5 flex items-center justify-center">
                        <i class="ri-close-line"></i>
                    </div>
                </button>
            </div>
            
            <div class="h-80 p-4 overflow-y-auto custom-scrollbar" id="chat-messages">
                <div class="flex items-start mb-4">
                    <div class="w-8 h-8 rounded-full bg-primary flex items-center justify-center text-white flex-shrink-0">
                        <div class="w-5 h-5 flex items-center justify-center">
                            <i class="ri-robot-line"></i>
                        </div>
                    </div>
                    <div class="ml-3 bg-gray-100 rounded-lg py-2 px-3 max-w-[85%]">
                        <p class="text-sm text-gray-800">Hello! I'm your EduLearn Assistant. How can I help you today?</p>
                    </div>
                </div>
            </div>
            
            <div class="p-3 border-t">
                <div class="relative">
                    <input type="text" id="chat-input" class="w-full py-2 pl-4 pr-10 text-sm text-gray-700 bg-gray-50 rounded-lg border-none focus:outline-none focus:ring-2 focus:ring-primary focus:bg-white" placeholder="Type your message...">
                    <button id="send-message" class="absolute right-2 top-1/2 transform -translate-y-1/2 text-primary">
                        <div class="w-6 h-6 flex items-center justify-center">
                            <i class="ri-send-plane-line"></i>
                        </div>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.5.0/echarts.min.js"></script>
    
    <script id="enrollment-chart-script">
        document.addEventListener('DOMContentLoaded', function() {
            const enrollmentChart = document.getElementById('enrollment-chart');
            if (enrollmentChart) {
                const chart = echarts.init(enrollmentChart);
                
                const option = {
                    animation: false,
                    tooltip: {
                        trigger: 'axis',
                        backgroundColor: 'rgba(255, 255, 255, 0.9)',
                        borderColor: '#e5e7eb',
                        borderWidth: 1,
                        textStyle: {
                            color: '#1f2937'
                        }
                    },
                    legend: {
                        data: ['Science', 'Engineering', 'Business', 'Arts'],
                        bottom: 0
                    },
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '15%',
                        top: '3%',
                        containLabel: true
                    },
                    xAxis: {
                        type: 'category',
                        boundaryGap: false,
                        data: ['2020', '2021', '2022', '2023', '2024', '2025'],
                        axisLine: {
                            lineStyle: {
                                color: '#e5e7eb'
                            }
                        },
                        axisLabel: {
                            color: '#1f2937'
                        }
                    },
                    yAxis: {
                        type: 'value',
                        axisLine: {
                            show: false
                        },
                        axisLabel: {
                            color: '#1f2937'
                        },
                        splitLine: {
                            lineStyle: {
                                color: '#e5e7eb'
                            }
                        }
                    },
                    series: [
                        {
                            name: 'Science',
                            type: 'line',
                            smooth: true,
                            symbol: 'none',
                            lineStyle: {
                                width: 3
                            },
                            areaStyle: {
                                opacity: 0.1
                            },
                            emphasis: {
                                focus: 'series'
                            },
                            data: [320, 420, 520, 620, 720, 820],
                            color: 'rgba(87, 181, 231, 1)'
                        },
                        {
                            name: 'Engineering',
                            type: 'line',
                            smooth: true,
                            symbol: 'none',
                            lineStyle: {
                                width: 3
                            },
                            areaStyle: {
                                opacity: 0.1
                            },
                            emphasis: {
                                focus: 'series'
                            },
                            data: [420, 520, 620, 720, 820, 920],
                            color: 'rgba(141, 211, 199, 1)'
                        },
                        {
                            name: 'Business',
                            type: 'line',
                            smooth: true,
                            symbol: 'none',
                            lineStyle: {
                                width: 3
                            },
                            areaStyle: {
                                opacity: 0.1
                            },
                            emphasis: {
                                focus: 'series'
                            },
                            data: [220, 320, 420, 520, 620, 720],
                            color: 'rgba(251, 191, 114, 1)'
                        },
                        {
                            name: 'Arts',
                            type: 'line',
                            smooth: true,
                            symbol: 'none',
                            lineStyle: {
                                width: 3
                            },
                            areaStyle: {
                                opacity: 0.1
                            },
                            emphasis: {
                                focus: 'series'
                            },
                            data: [150, 220, 320, 420, 520, 620],
                            color: 'rgba(252, 141, 98, 1)'
                        }
                    ]
                };
                
                chart.setOption(option);
                
                window.addEventListener('resize', function() {
                    chart.resize();
                });
            }
        });
    </script>
    
    <script id="chatbot-script">
        document.addEventListener('DOMContentLoaded', function() {
            const chatbotToggle = document.getElementById('chatbot-toggle');
            const chatbotPanel = document.getElementById('chatbot-panel');
            const chatbotClose = document.getElementById('chatbot-close');
            const chatInput = document.getElementById('chat-input');
            const sendMessage = document.getElementById('send-message');
            const chatMessages = document.getElementById('chat-messages');
            
            if (chatbotToggle && chatbotPanel && chatbotClose) {
                chatbotToggle.addEventListener('click', function() {
                    chatbotPanel.classList.toggle('hidden');
                });
                
                chatbotClose.addEventListener('click', function() {
                    chatbotPanel.classList.add('hidden');
                });
                
                const sendChatMessage = function() {
                    const message = chatInput.value.trim();
                    if (message) {
                        // Add user message
                        const userMessageHTML = `
                            <div class="flex items-start justify-end mb-4">
                                <div class="mr-3 bg-primary text-white rounded-lg py-2 px-3 max-w-[85%]">
                                    <p class="text-sm">${message}</p>
                                </div>
                                <div class="w-8 h-8 rounded-full bg-gray-300 flex items-center justify-center text-gray-600 flex-shrink-0">
                                    <div class="w-5 h-5 flex items-center justify-center">
                                        <i class="ri-user-line"></i>
                                    </div>
                                </div>
                            </div>
                        `;
                        chatMessages.insertAdjacentHTML('beforeend', userMessageHTML);
                        
                        // Clear input
                        chatInput.value = '';
                        
                        // Scroll to bottom
                        chatMessages.scrollTop = chatMessages.scrollHeight;
                        
                        // Simulate AI response after a short delay
                        setTimeout(function() {
                            const responses = [
                                "I can help you with that! What specific information do you need?",
                                "Let me check that for you. Is there anything else you'd like to know?",
                                "That's a great question. Here's what I found...",
                                "I'm processing your request. This might take a moment.",
                                "I understand what you're looking for. Here are some resources that might help."
                            ];
                            
                            const randomResponse = responses[Math.floor(Math.random() * responses.length)];
                            
                            const botMessageHTML = `
                                <div class="flex items-start mb-4">
                                    <div class="w-8 h-8 rounded-full bg-primary flex items-center justify-center text-white flex-shrink-0">
                                        <div class="w-5 h-5 flex items-center justify-center">
                                            <i class="ri-robot-line"></i>
                                        </div>
                                    </div>
                                    <div class="ml-3 bg-gray-100 rounded-lg py-2 px-3 max-w-[85%]">
                                        <p class="text-sm text-gray-800">${randomResponse}</p>
                                    </div>
                                </div>
                            `;
                            chatMessages.insertAdjacentHTML('beforeend', botMessageHTML);
                            
                            // Scroll to bottom again
                            chatMessages.scrollTop = chatMessages.scrollHeight;
                        }, 1000);
                    }
                };
                
                if (sendMessage && chatInput) {
                    sendMessage.addEventListener('click', sendChatMessage);
                    
                    chatInput.addEventListener('keypress', function(e) {
                        if (e.key === 'Enter') {
                            sendChatMessage();
                        }
                    });
                }
            }
        });
    </script>
    
    <script id="sidebar-script">
        document.addEventListener('DOMContentLoaded', function() {
            const sidebarLinks = document.querySelectorAll('.sidebar-link');
            
            sidebarLinks.forEach(link => {
                link.addEventListener('click', function(e) {
                    // Remove active class from all links
                    sidebarLinks.forEach(l => l.classList.remove('active'));
                    
                    // Add active class to clicked link
                    this.classList.add('active');
                });
            });
        });
    </script>
</body>
</html>