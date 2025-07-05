<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cài đặt - Hệ Thống LMS</title>
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

        /* Section accordion styles */
        .setting-section-header {
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid #e5e7eb;
        }
        .setting-section-header:hover {
            background-color: #f9fafb;
        }
        .setting-section-content {
            padding: 1.5rem;
            display: none; /* Hidden by default */
        }
        .setting-section-content.active {
            display: block;
        }
        .toggle-icon {
            transition: transform 0.2s ease-in-out;
        }
        .toggle-icon.rotated {
            transform: rotate(90deg);
        }

        /* Toggle switch */
        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 44px;
            height: 24px;
        }

        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .toggle-slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            -webkit-transition: .4s;
            transition: .4s;
            border-radius: 24px;
        }

        .toggle-slider:before {
            position: absolute;
            content: "";
            height: 18px;
            width: 18px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            -webkit-transition: .4s;
            transition: .4s;
            border-radius: 50%;
        }

        input:checked + .toggle-slider {
            background-color: #4f46e5; /* primary color */
        }

        input:focus + .toggle-slider {
            box-shadow: 0 0 1px #4f46e5;
        }

        input:checked + .toggle-slider:before {
            -webkit-transform: translateX(20px);
            -ms-transform: translateX(20px);
            transform: translateX(20px);
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
    <div class="max-w-4xl mx-auto">
        <div class="flex items-center mb-6">
            <h1 class="text-2xl font-semibold text-gray-900 flex items-center">
                <a href="dblecture.txt" class="p-2 text-gray-600 hover:text-primary rounded-full mr-2">
                    <i class="ri-arrow-left-line"></i>
                </a>
                Cài đặt
            </h1>
        </div>

        <div class="bg-white rounded-lg shadow-sm divide-y divide-gray-200">
            <div class="setting-section" id="personal-info">
                <div class="setting-section-header">
                    <h3 class="text-lg font-medium text-gray-900">Thông tin cá nhân</h3>
                    <i class="ri-arrow-right-s-line text-xl text-gray-500 toggle-icon"></i>
                </div>
                <div class="setting-section-content">
                    <div class="flex flex-col items-center mb-6">
                        <div class="relative w-24 h-24 rounded-full overflow-hidden bg-gray-100 border-2 border-gray-300">
                            <img src="https://readdy.ai/api/search-image?query=professional%20headshot%20of%20a%20Vietnamese%20female%20teacher%20with%20glasses%2C%20smiling%2C%20professional%20attire%2C%20neutral%20background%2C%20high%20quality%20portrait&width=200&height=200&seq=1&orientation=squarish" alt="Avatar" class="w-full h-full object-cover">
                            <button class="absolute bottom-0 right-0 bg-primary p-1 rounded-full text-white hover:bg-primary/90" title="Thay đổi ảnh đại diện">
                                <i class="ri-camera-line text-lg"></i>
                            </button>
                        </div>
                    </div>
                    <form onsubmit="event.preventDefault(); saveSettings('personal-info-form');">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                            <div>
                                <label for="fullName" class="block text-sm font-medium text-gray-700 mb-1">Họ tên</label>
                                <input type="text" id="fullName" value="Nguyễn Thị Minh" class="w-full px-3 py-2 border border-gray-300 rounded-button focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm">
                            </div>
                            <div>
                                <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                                <input type="email" id="email" value="minh.nt@example.com" class="w-full px-3 py-2 border border-gray-300 rounded-button focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm">
                            </div>
                            <div>
                                <label for="phone" class="block text-sm font-medium text-gray-700 mb-1">Số điện thoại</label>
                                <input type="text" id="phone" value="0912 345 678" class="w-full px-3 py-2 border border-gray-300 rounded-button focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm">
                            </div>
                            <div>
                                <label for="address" class="block text-sm font-medium text-gray-700 mb-1">Địa chỉ</label>
                                <input type="text" id="address" value="Số 10, Đường ABC, Hà Nội" class="w-full px-3 py-2 border border-gray-300 rounded-button focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm">
                            </div>
                            <div>
                                <label for="dob" class="block text-sm font-medium text-gray-700 mb-1">Ngày sinh</label>
                                <input type="date" id="dob" value="1985-05-15" class="w-full px-3 py-2 border border-gray-300 rounded-button focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm">
                            </div>
                            <div>
                                <label for="gender" class="block text-sm font-medium text-gray-700 mb-1">Giới tính</label>
                                <select id="gender" class="w-full px-3 py-2 border border-gray-300 rounded-button focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm">
                                    <option value="nu">Nữ</option>
                                    <option value="nam">Nam</option>
                                    <option value="khac">Khác</option>
                                </select>
                            </div>
                        </div>
                        <div class="flex justify-end">
                            <button type="submit" class="px-4 py-2 bg-primary text-white text-sm font-medium rounded-button hover:bg-primary/90">Lưu thay đổi</button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="setting-section" id="account-settings">
                <div class="setting-section-header">
                    <h3 class="text-lg font-medium text-gray-900">Cài đặt tài khoản</h3>
                    <i class="ri-arrow-right-s-line text-xl text-gray-500 toggle-icon"></i>
                </div>
                <div class="setting-section-content">
                    <form onsubmit="event.preventDefault(); saveSettings('password-form');">
                        <h4 class="text-base font-medium text-gray-800 mb-3">Đổi mật khẩu</h4>
                        <div class="mb-4">
                            <label for="currentPassword" class="block text-sm font-medium text-gray-700 mb-1">Mật khẩu hiện tại</label>
                            <input type="password" id="currentPassword" class="w-full px-3 py-2 border border-gray-300 rounded-button focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm">
                        </div>
                        <div class="mb-4">
                            <label for="newPassword" class="block text-sm font-medium text-gray-700 mb-1">Mật khẩu mới</label>
                            <input type="password" id="newPassword" class="w-full px-3 py-2 border border-gray-300 rounded-button focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm">
                        </div>
                        <div class="mb-6">
                            <label for="confirmNewPassword" class="block text-sm font-medium text-gray-700 mb-1">Xác nhận mật khẩu mới</label>
                            <input type="password" id="confirmNewPassword" class="w-full px-3 py-2 border border-gray-300 rounded-button focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm">
                        </div>
                        <div class="flex justify-end mb-6">
                            <button type="submit" class="px-4 py-2 bg-primary text-white text-sm font-medium rounded-button hover:bg-primary/90">Đổi mật khẩu</button>
                        </div>
                    </form>                    
                </div>
            </div>  
        </div>
    </div>
</main>

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

        // Settings Section Collapse/Expand
        const settingSections = document.querySelectorAll('.setting-section');

        settingSections.forEach(section => {
            const header = section.querySelector('.setting-section-header');
            const content = section.querySelector('.setting-section-content');
            const toggleIcon = section.querySelector('.toggle-icon');

            // Optionally, activate the first section by default
            if (section.id === 'personal-info') { // Or any other section you want open initially
                content.classList.add('active');
                toggleIcon.classList.add('rotated');
            }

            header.addEventListener('click', () => {
                const isActive = content.classList.toggle('active');
                if (isActive) {
                    toggleIcon.classList.add('rotated');
                } else {
                    toggleIcon.classList.remove('rotated');
                }
            });
        });

        // Function to simulate saving settings
        window.saveSettings = function(formId) {
            console.log(`Saving settings for form: ${formId}`);
            alert('Cài đặt đã được lưu thành công!');
            // In a real application, you would send form data to the server via AJAX here.
        };

        // Dark Mode Toggle (Client-side example)
        const darkModeToggle = document.getElementById('darkModeToggle');
        if (darkModeToggle) {
            // Check for saved preference or system preference
            const isDarkMode = localStorage.getItem('theme') === 'dark' || (window.matchMedia('(prefers-color-scheme: dark)').matches && !localStorage.getItem('theme'));
            if (isDarkMode) {
                document.documentElement.classList.add('dark');
                darkModeToggle.checked = true;
            }

            darkModeToggle.addEventListener('change', function() {
                if (this.checked) {
                    document.documentElement.classList.add('dark');
                    localStorage.setItem('theme', 'dark');
                } else {
                    document.documentElement.classList.remove('dark');
                    localStorage.setItem('theme', 'light');
                }
            });
        }
    });
</script>

</body>
</html>