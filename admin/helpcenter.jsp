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
                    <a href="dashboard.html" class="sidebar-link  flex items-center px-3 py-2 text-sm font-medium rounded-md">
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
                    <a href="helpcenter.jsp" class="sidebar-link active flex items-center px-3 py-2 text-sm font-medium text-gray-600 rounded-md hover:bg-gray-50">
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
    
        <!-- PAGE-SPECIFIC CONTENT GOES HERE -->
<main class="flex-1 p-8 overflow-auto">
    <header class="bg-white px-8 py-6 shadow-sm flex items-center justify-between">
        <div>
            <h1 class="text-2xl font-bold">Help Center</h1>
            <nav class="text-sm text-gray-500">Dashboard > Help Center</nav>
        </div>
        <a href="dashboard.html" class="text-sm text-blue-600 hover:underline">← Back to Dashboard</a>
    </header>

    <div class="p-8">
        <div class="mb-8">
            <input type="text" placeholder="Search help articles..." class="w-full border border-gray-300 px-4 py-3 rounded-lg shadow-sm text-sm" />
        </div>

        <div class="flex flex-col lg:flex-row gap-8">
            <div class="lg:w-2/3 w-full space-y-12">

                <section id="documentation-browser">
                    <h2 class="text-lg font-semibold mb-4">Browse Documentation</h2>
                    <ul class="space-y-4">
                        <li class="border-b pb-4">
                            <h3 class="text-base font-medium text-primary cursor-pointer article-link" data-article-id="reset-password">How to reset your password</h3>
                            <p class="text-xs text-gray-500">Updated 2 days ago • 3 min read • 842 views</p>
                        </li>
                        <li class="border-b pb-4">
                            <h3 class="text-base font-medium text-primary cursor-pointer article-link" data-article-id="course-setup">Setting up your course page</h3>
                            <p class="text-xs text-gray-500">Updated 5 days ago • 5 min read • 632 views</p>
                        </li>
                        <li class="border-b pb-4">
                            <h3 class="text-base font-medium text-primary cursor-pointer article-link" data-article-id="manage-notifications">Managing notifications and alerts</h3>
                            <p class="text-xs text-gray-500">Updated 1 week ago • 4 min read • 509 views</p>
                        </li>
                    </ul>
                </section>

                <section id="article-content" class="hidden bg-white p-6 rounded shadow">
                    <button id="back-to-docs" class="text-sm text-blue-600 hover:underline mb-4">← Back to Documentation</button>
                    <h2 id="article-title" class="text-xl font-bold mb-4"></h2>
                    <div id="article-body" class="prose max-w-none">
                        </div>
                </section>
            </div>  
        </div>
    </div>
</main>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const articleLinks = document.querySelectorAll('.article-link');
        const documentationBrowser = document.getElementById('documentation-browser');
        const articleContentSection = document.getElementById('article-content');
        const articleTitle = document.getElementById('article-title');
        const articleBody = document.getElementById('article-body');
        const backToDocsButton = document.getElementById('back-to-docs');

        const articles = {
            'reset-password': {
                title: 'How to reset your password',
                body: `
                    <p>To reset your password, please follow these steps:</p>
                    <ol>
                        <li>Go to the login page.</li>
                        <li>Click on the "Forgot Password" link.</li>
                        <li>Enter your registered email address.</li>
                        <li>You will receive a password reset link in your email.</li>
                        <li>Click on the link and follow the instructions to set a new password.</li>
                    </ol>
                    <p>If you encounter any issues, please contact support.</p>
                `
            },
            'course-setup': {
                title: 'Setting up your course page',
                body: `
                    <p>Setting up your course page involves several key steps:</p>
                    <ol>
                        <li>Log in to your instructor account.</li>
                        <li>Navigate to the "Courses" section from the sidebar.</li>
                        <li>Click on "Create New Course" or select an existing course to edit.</li>
                        <li>Fill in all required details, including course title, description, and syllabus.</li>
                        <li>Upload course materials such as lectures, readings, and assignments.</li>
                        <li>Set visibility and access permissions for your students.</li>
                        <li>Publish your course to make it available to students.</li>
                    </ol>
                    <p>Remember to regularly update your course content to keep it current.</p>
                `
            },
            'manage-notifications': {
                title: 'Managing notifications and alerts',
                body: `
                    <p>You can customize your notification settings to receive alerts that matter most to you:</p>
                    <ol>
                        <li>Go to "Settings" from your profile dropdown.</li>
                        <li>Select "Notifications" from the settings menu.</li>
                        <li>Toggle specific notification types on or off (e.g., new messages, assignment deadlines, forum replies).</li>
                        <li>Choose your preferred notification method (email, in-app, or both).</li>
                        <li>Save your changes.</li>
                    </ol>
                    <p>Review your settings periodically to ensure they meet your current needs.</p>
                `
            }
        };

        articleLinks.forEach(link => {
            link.addEventListener('click', function () {
                const articleId = this.dataset.articleId;
                const article = articles[articleId];

                if (article) {
                    articleTitle.textContent = article.title;
                    articleBody.innerHTML = article.body;
                    documentationBrowser.classList.add('hidden');
                    articleContentSection.classList.remove('hidden');
                }
            });
        });

        backToDocsButton.addEventListener('click', function () {
            articleContentSection.classList.add('hidden');
            documentationBrowser.classList.remove('hidden');
        });
    });
</script>
</div>
</body>
</html>
