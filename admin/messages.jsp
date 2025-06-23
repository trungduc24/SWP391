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
        
                * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8fafc;
            height: 100vh;
            overflow: hidden;
        }

        .main-container {
            display: flex;
            height: 100vh;
        }

        /* Header */
        .header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            height: 64px;
            background: white;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 24px;
            z-index: 100;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .logo {
            font-size: 20px;
            font-weight: 700;
            color: #4F46E5;
        }

        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #64748b;
            font-size: 14px;
        }

        .breadcrumb a {
            color: #4F46E5;
            text-decoration: none;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .notification-btn, .profile-btn {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            border: none;
            background: #f1f5f9;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
        }

        .notification-btn:hover, .profile-btn:hover {
            background: #e2e8f0;
        }

        /* Sidebar */
        .sidebar {
            width: 280px;
            background: white;
            border-right: 1px solid #e2e8f0;
            margin-top: 64px;
            padding: 24px 0;
        }

        .sidebar-nav {
            padding: 0 16px;
        }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 16px;
            margin-bottom: 4px;
            border-radius: 8px;
            color: #64748b;
            text-decoration: none;
            transition: all 0.2s;
        }

        .nav-item:hover {
            background: #f1f5f9;
            color: #334155;
        }

        .nav-item.active {
            background: #4F46E5;
            color: white;
        }

        /* Main Content */
        .content {
            flex: 1;
            display: flex;
            margin-top: 64px;
            height: calc(100vh - 64px);
        }

        /* Left Panel - Conversations */
        .conversations-panel {
            width: 400px;
            background: white;
            border-right: 1px solid #e2e8f0;
            display: flex;
            flex-direction: column;
        }

        .conversations-header {
            padding: 24px;
            border-bottom: 1px solid #e2e8f0;
        }

        .conversations-title {
            font-size: 20px;
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 16px;
        }

        .search-bar {
            position: relative;
            margin-bottom: 16px;
        }

        .search-input {
            width: 100%;
            padding: 12px 16px 12px 44px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s;
        }

        .search-input:focus {
            border-color: #4F46E5;
        }

        .search-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #64748b;
        }

        .filter-tabs {
            display: flex;
            gap: 4px;
        }

        .filter-tab {
            padding: 8px 16px;
            border: none;
            background: none;
            color: #64748b;
            font-size: 14px;
            font-weight: 500;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .filter-tab.active {
            background: #4F46E5;
            color: white;
        }

        .filter-tab:hover:not(.active) {
            background: #f1f5f9;
        }

        .conversations-list {
            flex: 1;
            overflow-y: auto;
            padding: 8px 0;
        }

        .conversation-item {
            display: flex;
            align-items: center;
            padding: 16px 24px;
            cursor: pointer;
            transition: all 0.2s;
            border-left: 3px solid transparent;
        }

        .conversation-item:hover {
            background: #f8fafc;
        }

        .conversation-item.active {
            background: #f1f5f9;
            border-left-color: #4F46E5;
        }

        .conversation-avatar {
            position: relative;
            margin-right: 12px;
        }

        .avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            object-fit: cover;
        }

        .status-indicator {
            position: absolute;
            bottom: 2px;
            right: 2px;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            border: 2px solid white;
        }

        .status-online { background: #10b981; }
        .status-away { background: #f59e0b; }
        .status-offline { background: #6b7280; }

        .conversation-content {
            flex: 1;
            min-width: 0;
        }

        .conversation-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 4px;
        }

        .conversation-name {
            font-weight: 600;
            color: #1e293b;
            font-size: 14px;
        }

        .conversation-time {
            font-size: 12px;
            color: #64748b;
        }

        .conversation-preview {
            font-size: 14px;
            color: #64748b;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .unread-badge {
            background: #4F46E5;
            color: white;
            font-size: 12px;
            font-weight: 600;
            padding: 2px 6px;
            border-radius: 10px;
            min-width: 18px;
            text-align: center;
        }

        .compose-btn {
            position: fixed;
            bottom: 24px;
            left: 320px;
            width: 56px;
            height: 56px;
            background: #4F46E5;
            border: none;
            border-radius: 50%;
            color: white;
            font-size: 24px;
            cursor: pointer;
            box-shadow: 0 10px 25px rgba(79, 70, 229, 0.4);
            transition: all 0.2s;
            z-index: 50;
        }

        .compose-btn:hover {
            transform: scale(1.1);
            box-shadow: 0 15px 35px rgba(79, 70, 229, 0.5);
        }

        /* Right Panel - Message Thread */
        .message-panel {
            flex: 1;
            display: flex;
            flex-direction: column;
            background: white;
        }

        .message-header {
            padding: 20px 24px;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .recipient-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .recipient-name {
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 2px;
        }

        .recipient-status {
            font-size: 12px;
            color: #10b981;
        }

        .message-actions {
            display: flex;
            gap: 8px;
        }

        .action-btn {
            width: 40px;
            height: 40px;
            border: none;
            background: #f1f5f9;
            border-radius: 8px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s;
        }

        .action-btn:hover {
            background: #e2e8f0;
        }

        .messages-container {
            flex: 1;
            overflow-y: auto;
            padding: 24px;
            background: #f8fafc;
        }

        .message {
            display: flex;
            margin-bottom: 16px;
            max-width: 70%;
        }

        .message.sent {
            margin-left: auto;
            flex-direction: row-reverse;
        }

        .message-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            margin: 0 8px;
        }

        .message-content {
            background: white;
            padding: 12px 16px;
            border-radius: 18px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            position: relative;
        }

        .message.sent .message-content {
            background: #4F46E5;
            color: white;
        }

        .message-text {
            font-size: 14px;
            line-height: 1.4;
            margin-bottom: 4px;
        }

        .message-time {
            font-size: 11px;
            opacity: 0.7;
        }

        .message.sent .message-time {
            color: rgba(255, 255, 255, 0.8);
        }

        .message-status {
            font-size: 11px;
            color: #64748b;
            margin-top: 2px;
        }

        .typing-indicator {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 12px 16px;
            background: white;
            border-radius: 18px;
            margin-bottom: 16px;
            max-width: 80px;
        }

        .typing-dots {
            display: flex;
            gap: 3px;
        }

        .typing-dot {
            width: 6px;
            height: 6px;
            background: #64748b;
            border-radius: 50%;
            animation: typing 1.4s infinite ease-in-out;
        }

        .typing-dot:nth-child(2) { animation-delay: 0.2s; }
        .typing-dot:nth-child(3) { animation-delay: 0.4s; }

        @keyframes typing {
            0%, 60%, 100% { transform: translateY(0); }
            30% { transform: translateY(-10px); }
        }

        .file-attachment {
            display: flex;
            align-items: center;
            gap: 8px;
            background: #f1f5f9;
            padding: 8px 12px;
            border-radius: 8px;
            margin-top: 8px;
        }

        .link-preview {
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            overflow: hidden;
            margin-top: 8px;
        }

        .link-preview-image {
            width: 100%;
            height: 120px;
            object-fit: cover;
        }

        .link-preview-content {
            padding: 12px;
        }

        .link-preview-title {
            font-weight: 600;
            font-size: 14px;
            margin-bottom: 4px;
        }

        .link-preview-desc {
            font-size: 12px;
            color: #64748b;
        }

        /* Message Input */
        .message-input-area {
            padding: 20px 24px;
            border-top: 1px solid #e2e8f0;
            background: white;
        }

        .message-input-container {
            display: flex;
            align-items: flex-end;
            gap: 12px;
            background: #f8fafc;
            border-radius: 24px;
            padding: 8px;
        }

        .message-input {
            flex: 1;
            border: none;
            background: none;
            padding: 12px 16px;
            font-size: 14px;
            resize: none;
            outline: none;
            max-height: 120px;
            min-height: 20px;
        }

        .input-actions {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .input-btn {
            width: 36px;
            height: 36px;
            border: none;
            background: none;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s;
        }

        .input-btn:hover {
            background: #e2e8f0;
        }

        .send-btn {
            background: #4F46E5;
            color: white;
        }

        .send-btn:hover {
            background: #4338ca;
        }

        .emoji-picker {
            position: absolute;
            bottom: 80px;
            right: 24px;
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            display: none;
            z-index: 100;
        }

        .emoji-picker.active {
            display: block;
        }

        .emoji-grid {
            display: grid;
            grid-template-columns: repeat(8, 1fr);
            gap: 8px;
        }

        .emoji {
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .emoji:hover {
            background: #f1f5f9;
            transform: scale(1.2);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .sidebar {
                display: none;
            }
            
            .conversations-panel {
                width: 100%;
                display: block;
            }
            
            .message-panel {
                display: none;
            }
            
            .message-panel.active {
                display: flex;
            }
            
            .conversations-panel.hidden {
                display: none;
            }
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
            <a href="#" class="sidebar-link active flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-dashboard-line mr-2"></i> Dashboard
            </a>
            <a href="#" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-user-line mr-2"></i> Users
            </a>
            <a href="#" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-book-open-line mr-2"></i> Courses
            </a>
        </div>
        <div class="mt-6 px-4 space-y-1">
            <p class="text-xs font-semibold text-gray-400 uppercase tracking-wide">Academic</p>
            <a href="#" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-calendar-line mr-2"></i> Semesters
            </a>
            <a href="#" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-file-list-line mr-2"></i> Assignments
            </a>
            <a href="#" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-bar-chart-line mr-2"></i> Grades
            </a>
        </div>
        <div class="mt-6 px-4 space-y-1">
            <p class="text-xs font-semibold text-gray-400 uppercase tracking-wide">Communication</p>
            <a href="#" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-message-2-line mr-2"></i> Messages
            </a>
            <a href="#" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-discuss-line mr-2"></i> Forums
            </a>
            <a href="#" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-notification-3-line mr-2"></i> Announcements
            </a>
        </div>
        <div class="mt-6 px-4 space-y-1">
            <p class="text-xs font-semibold text-gray-400 uppercase tracking-wide">System</p>
            <a href="#" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-settings-3-line mr-2"></i> Settings
            </a>
            <a href="#" class="sidebar-link flex items-center px-3 py-2 text-sm font-medium rounded-md">
                <i class="ri-question-line mr-2"></i> Help Center
            </a>
        </div>
    </nav>
    <div class="p-4 border-t">
        <a href="/LMSS/login.jsp" class="flex items-center justify-center w-full px-4 py-2 text-sm font-medium text-gray-700 bg-gray-100 rounded-button hover:bg-gray-200 whitespace-nowrap" style="text-decoration:none;">
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
    <main class="flex-1 p-8 overflow-auto">
        <!-- PAGE-SPECIFIC CONTENT GOES HERE -->
        </head>
<body>
    <!-- Header -->
    <div class="header">
        <div class="header-left">
            <div class="logo">Dashboard</div>
            <nav class="breadcrumb">
                <a href="dashboard.jsp">Dashboard</a>
                <span>→</span>
                <span>Messages</span>
            </nav>
        </div>
        <div class="header-right">
            <button class="notification-btn">🔔</button>
            <button class="profile-btn">👤</button>
        </div>
    </div>

    <div class="main-container">
        <!-- Main Content -->
        <div class="content">
            <!-- Left Panel - Conversations -->
            <div class="conversations-panel">
                <div class="conversations-header">
                    <h2 class="conversations-title">Messages</h2>
                    <div class="search-bar">
                        <input type="text" class="search-input" placeholder="Search conversations...">
                        <div class="search-icon">🔍</div>
                    </div>
                    <div class="filter-tabs">
                        <button class="filter-tab active">All</button>
                        <button class="filter-tab">Unread</button>
                        <button class="filter-tab">Starred</button>
                    </div>
                </div>

                <div class="conversations-list">
                    <div class="conversation-item active">
                        <div class="conversation-avatar">
                            <img src="https://images.unsplash.com/photo-1494790108755-2616b9e04f4c?w=100&h=100&fit=crop&crop=face" alt="Sarah" class="avatar">
                            <div class="status-indicator status-online"></div>
                        </div>
                        <div class="conversation-content">
                            <div class="conversation-header">
                                <div class="conversation-name">Sarah Johnson</div>
                                <div class="conversation-time">2m</div>
                            </div>
                            <div class="conversation-preview">That sounds great! Let's schedule a meeting...</div>
                        </div>
                        <div class="unread-badge">2</div>
                    </div>

                    <div class="conversation-item">
                        <div class="conversation-avatar">
                            <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop&crop=face" alt="Mike" class="avatar">
                            <div class="status-indicator status-away"></div>
                        </div>
                        <div class="conversation-content">
                            <div class="conversation-header">
                                <div class="conversation-name">Mike Chen</div>
                                <div class="conversation-time">1h</div>
                            </div>
                            <div class="conversation-preview">Thanks for the update on the project status</div>
                        </div>
                    </div>

                    <div class="conversation-item">
                        <div class="conversation-avatar">
                            <img src="https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100&h=100&fit=crop&crop=face" alt="Emma" class="avatar">
                            <div class="status-indicator status-online"></div>
                        </div>
                        <div class="conversation-content">
                            <div class="conversation-header">
                                <div class="conversation-name">Emma Wilson</div>
                                <div class="conversation-time">3h</div>
                            </div>
                            <div class="conversation-preview">Can you review the design mockups?</div>
                        </div>
                        <div class="unread-badge">1</div>
                    </div>

                    <div class="conversation-item">
                        <div class="conversation-avatar">
                            <img src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100&h=100&fit=crop&crop=face" alt="David" class="avatar">
                            <div class="status-indicator status-offline"></div>
                        </div>
                        <div class="conversation-content">
                            <div class="conversation-header">
                                <div class="conversation-name">David Rodriguez</div>
                                <div class="conversation-time">1d</div>
                            </div>
                            <div class="conversation-preview">The client presentation went well yesterday</div>
                        </div>
                    </div>

                    <div class="conversation-item">
                        <div class="conversation-avatar">
                            <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&h=100&fit=crop&crop=face" alt="Lisa" class="avatar">
                            <div class="status-indicator status-online"></div>
                        </div>
                        <div class="conversation-content">
                            <div class="conversation-header">
                                <div class="conversation-name">Lisa Park</div>
                                <div class="conversation-time">2d</div>
                            </div>
                            <div class="conversation-preview">Let's catch up over coffee sometime</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Panel - Message Thread -->
            <div class="message-panel">
                <div class="message-header">
                    <div class="recipient-info">
                        <img src="https://images.unsplash.com/photo-1494790108755-2616b9e04f4c?w=100&h=100&fit=crop&crop=face" alt="Sarah" class="avatar">
                        <div>
                            <div class="recipient-name">Sarah Johnson</div>
                            <div class="recipient-status">Online now</div>
                        </div>
                    </div>
                    <div class="message-actions">
                        <button class="action-btn">📞</button>
                        <button class="action-btn">📹</button>
                        <button class="action-btn">⋯</button>
                    </div>
                </div>

                <div class="messages-container">
                    <div class="message">
                        <img src="https://images.unsplash.com/photo-1494790108755-2616b9e04f4c?w=100&h=100&fit=crop&crop=face" alt="Sarah" class="message-avatar">
                        <div class="message-content">
                            <div class="message-text">Hey! How's the project coming along?</div>
                            <div class="message-time">10:30 AM</div>
                        </div>
                    </div>

                    <div class="message sent">
                        <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop&crop=face" alt="You" class="message-avatar">
                        <div class="message-content">
                            <div class="message-text">It's going great! We're ahead of schedule actually.</div>
                            <div class="message-time">10:32 AM</div>
                            <div class="message-status">✓✓ Read</div>
                        </div>
                    </div>

                    <div class="message">
                        <img src="https://images.unsplash.com/photo-1494790108755-2616b9e04f4c?w=100&h=100&fit=crop&crop=face" alt="Sarah" class="message-avatar">
                        <div class="message-content">
                            <div class="message-text">That's amazing! Can you share the latest designs?</div>
                            <div class="message-time">10:35 AM</div>
                            <div class="file-attachment">
                                📎 Design_Brief_v2.pdf
                            </div>
                        </div>
                    </div>

                    <div class="message sent">
                        <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop&crop=face" alt="You" class="message-avatar">
                        <div class="message-content">
                            <div class="message-text">Sure! Here's the link to our latest work:</div>
                            <div class="message-time">10:38 AM</div>
                            <div class="link-preview">
                                <img src="https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=300&h=120&fit=crop" alt="Preview" class="link-preview-image">
                                <div class="link-preview-content">
                                    <div class="link-preview-title">Project Dashboard Design</div>
                                    <div class="link-preview-desc">Latest mockups and prototypes for the new dashboard interface</div>
                                </div>
                            </div>
                            <div class="message-status">✓✓ Read</div>
                        </div>
                    </div>

                    <div class="message">
                        <img src="https://images.unsplash.com/photo-1494790108755-2616b9e04f4c?w=100&h=100&fit=crop&crop=face" alt="Sarah" class="message-avatar">
                        <div class="message-content">
                            <div class="message-text">This looks fantastic! The color scheme is perfect 🎨</div>
                            <div class="message-time">10:42 AM</div>
                        </div>
                    </div>

                    <div class="message sent">
                        <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop&crop=face" alt="You" class="message-avatar">
                        <div class="message-content">
                            <div class="message-text">Thanks! Should we schedule a meeting to discuss the next steps?</div>
                            <div class="message-time">10:45 AM</div>
                            <div class="message-status">✓ Delivered</div>
                        </div>
                    </div>

                    <div class="typing-indicator">
                        <img src="https://images.unsplash.com/photo-1494790108755-2616b9e04f4c?w=100&h=100&fit=crop&crop=face" alt="Sarah" class="message-avatar">
                        <div class="typing-dots">
                            <div class="typing-dot"></div>
                            <div class="typing-dot"></div>
                            <div class="typing-dot"></div>
                        </div>
                    </div>
                </div>

                <div class="message-input-area">
                    <div class="message-input-container">
                        <textarea class="message-input" placeholder="Type a message..." rows="1"></textarea>
                        <div class="input-actions">
                            <button class="input-btn" onclick="toggleEmojiPicker()">😊</button>
                            <button class="input-btn">📎</button>
                            <button class="input-btn send-btn">➤</button>
                        </div>
                    </div>
                </div>

                <div class="emoji-picker" id="emojiPicker">
                    <div class="emoji-grid">
                        <div class="emoji" onclick="addEmoji('😊')">😊</div>
                        <div class="emoji" onclick="addEmoji('😂')">😂</div>
                        <div class="emoji" onclick="addEmoji('❤️')">❤️</div>
                        <div class="emoji" onclick="addEmoji('👍')">👍</div>
                        <div class="emoji" onclick="addEmoji('👏')">👏</div>
                        <div class="emoji" onclick="addEmoji('🎉')">🎉</div>
                        <div class="emoji" onclick="addEmoji('🔥')">🔥</div>
                        <div class="emoji" onclick="addEmoji('💯')">💯</div>
                        <div class="emoji" onclick="addEmoji('😍')">😍</div>
                        <div class="emoji" onclick="addEmoji('🤔')">🤔</div>
                        <div class="emoji" onclick="addEmoji('😭')">😭</div>
                        <div class="emoji" onclick="addEmoji('🙏')">🙏</div>
                        <div class="emoji" onclick="addEmoji('✨')">✨</div>
                        <div class="emoji" onclick="addEmoji('💪')">💪</div>
                        <div class="emoji" onclick="addEmoji('🎯')">🎯</div>
                        <div class="emoji" onclick="addEmoji('🚀')">🚀</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Compose Button -->
    <button class="compose-btn">✏️</button>

    <script>
        // Auto-resize textarea
        const messageInput = document.querySelector('.message-input');
        messageInput.addEventListener('input', function() {
            this.style.height = 'auto';
            this.style.height = (this.scrollHeight) + 'px';
        });

        // Filter tabs functionality
        document.querySelectorAll('.filter-tab').forEach(tab => {
            tab.addEventListener('click', function() {
                document.querySelectorAll('.filter-tab').forEach(t => t.classList.remove('active'));
                this.classList.add('active');
            });
        });

        // Conversation switching
        document.querySelectorAll('.conversation-item').forEach(item => {
            item.addEventListener('click', function() {
                document.querySelectorAll('.conversation-item').forEach(i => i.classList.remove('active'));
                this.classList.add('active');
                
        
    </main>
</div>
</body>
</html>
