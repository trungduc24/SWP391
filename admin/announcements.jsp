<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduLearn LMS - Dashboard</title>
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
            <a href="dashboard.htmlcoursers" class="sidebar-link active flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-dashboard-line mr-2"></i> Dashboard
            </a>
            <a href="users.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-user-line mr-2"></i> Users
            </a>
            <a href="coursers.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-book-open-line mr-2"></i> Courses
            </a>
        </div>
        <div class="mt-6 px-4 space-y-1">
            <p class="text-xs font-semibold text-gray-400 uppercase tracking-wide">Academic</p>
            <a href="semesters.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-calendar-line mr-2"></i> Semesters
            </a>
            <a href="assignments.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-file-list-line mr-2"></i> Assignments
            </a>
            <a href="grades.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-bar-chart-line mr-2"></i> Grades
            </a>
        </div>
        <div class="mt-6 px-4 space-y-1">
            <p class="text-xs font-semibold text-gray-400 uppercase tracking-wide">Communication</p>
            <a href="messages.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-message-2-line mr-2"></i> Messages
            </a>
            <a href="forums.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-discuss-line mr-2"></i> Forums
            </a>
            <a href="announcements.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-notification-3-line mr-2"></i> Announcements
            </a>
        </div>
        <div class="mt-6 px-4 space-y-1">
            <p class="text-xs font-semibold text-gray-400 uppercase tracking-wide">System</p>
            <a href="settings.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-settings-3-line mr-2"></i> Settings
            </a>
            <a href="helpcenter.jsp" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-question-line mr-2"></i> Help Center
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
            <input type="text" placeholder="Search for courses, users..." class="w-full border border-gray-300 rounded px-3 py-2 text-sm" />
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


<head>
    <meta charset="UTF-8">
    <title>Announcements Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/remixicon/fonts/remixicon.css" rel="stylesheet">
</head>
<body class="p-8 bg-gray-50">
    <div class="flex justify-between items-center mb-6">
        <div>
            <h1 class="text-2xl font-bold">Announcements</h1>
            <p class="text-sm text-gray-500">Manage announcements for students, teachers, and admins.</p>
        </div>
        <button class="bg-primary text-white px-4 py-2 rounded hover:bg-indigo-700">
            + Create Announcement
        </button>
    </div>

    <div class="flex gap-4 mb-4">
        <input type="text" placeholder="Search by title..." class="border px-3 py-2 rounded w-1/3 text-sm">
        <select class="border px-3 py-2 rounded text-sm">
            <option>All Audiences</option>
            <option>Students</option>
            <option>Teachers</option>
            <option>Admins</option>
        </select>
        <select class="border px-3 py-2 rounded text-sm">
            <option>All Statuses</option>
            <option>Active</option>
            <option>Inactive</option>
        </select>
        <button class="text-sm text-blue-600 underline">Clear Filters</button>
    </div>

    <div class="bg-white shadow rounded-lg overflow-hidden">
        <table class="w-full text-sm">
            <thead class="bg-gray-100 text-left">
                <tr>
                    <th class="px-4 py-3">Title</th>
                    <th class="px-4 py-3">Date</th>
                    <th class="px-4 py-3">Audience</th>
                    <th class="px-4 py-3">Status</th>
                    <th class="px-4 py-3 text-center">Actions</th>
                </tr>
            </thead>
            <tbody class="divide-y">
                <tr>
                    <td class="px-4 py-3">Midterm Exam Reminder</td>
                    <td class="px-4 py-3">2024-11-01</td>
                    <td class="px-4 py-3">Students</td>
                    <td class="px-4 py-3">
                        <label class="switch">
                            <input type="checkbox" checked>
                            <span class="slider"></span>
                        </label>
                    </td>
                    <td class="px-4 py-3 text-center">
                        <i class="ri-eye-line text-gray-600 hover:text-blue-600 cursor-pointer mr-2"></i>
                        <i class="ri-edit-line text-gray-600 hover:text-green-600 cursor-pointer mr-2"></i>
                        <i class="ri-delete-bin-6-line text-gray-600 hover:text-red-600 cursor-pointer"></i>
                    </td>
                </tr>
                <tr>
                    <td class="px-4 py-3">System Maintenance</td>
                    <td class="px-4 py-3">2024-10-25</td>
                    <td class="px-4 py-3">All</td>
                    <td class="px-4 py-3">
                        <label class="switch">
                            <input type="checkbox">
                            <span class="slider"></span>
                        </label>
                    </td>
                    <td class="px-4 py-3 text-center">
                        <i class="ri-eye-line text-gray-600 hover:text-blue-600 cursor-pointer mr-2"></i>
                        <i class="ri-edit-line text-gray-600 hover:text-green-600 cursor-pointer mr-2"></i>
                        <i class="ri-delete-bin-6-line text-gray-600 hover:text-red-600 cursor-pointer"></i>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>
