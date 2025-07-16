<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="model.CourseDisplayModel" %>
<%@ page import="model.Semester" %>
<%@ page import="model.Student" %>
<%@ page import="model.User" %>
<%
    List<CourseDisplayModel> enrolledCourses = (List<CourseDisplayModel>) request.getAttribute("enrolledCourses");
    List<Semester> semesters = (List<Semester>) request.getAttribute("semesters");
    Student student = (Student) request.getAttribute("student");
    User currentUser = (User) request.getAttribute("currentUser");
    
    if (enrolledCourses == null) {
        enrolledCourses = new ArrayList<>();
    }
    if (semesters == null) {
        semesters = new ArrayList<>();
    }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hệ thống Quản lý Học tập - Sinh viên</title>
        <script src="https://cdn.tailwindcss.com/3.4.16"></script>
        <script>tailwind.config = {theme: {extend: {colors: {primary: '#4f46e5', secondary: '#818cf8'}, borderRadius: {'none': '0px', 'sm': '4px', DEFAULT: '8px', 'md': '12px', 'lg': '16px', 'xl': '20px', '2xl': '24px', '3xl': '32px', 'full': '9999px', 'button': '8px'}}}}</script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css">
        <style>
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
            progress.course-progress::-webkit-progress-bar {
                background-color: #e5e7eb;
                border-radius: 9999px;
            }
            progress.course-progress::-webkit-progress-value {
                background-color: #4f46e5;
                border-radius: 9999px;
            }
            :where([class^="ri-"])::before {
                content: "\f3c2";
            }
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
            .course-row {
                padding: 1rem;
                border-bottom: 1px solid #e5e7eb;
            }
            .course-row:last-child {
                border-bottom: none;
            }
            .course-name-mobile {
                font-weight: 500;
                color: #1f2937;
                font-size: 0.875rem; /* text-sm */
            }
            .course-info-mobile {
                color: #6b7280;
                font-size: 0.875rem; /* text-sm */
            }
            .course-actions-mobile {
                display: flex;
                gap: 0.5rem;
                justify-content: flex-end; /* Align to end */
            }

        </style>
    </head>
    <body class="bg-gray-100 font-sans text-gray-900">
        <div class="flex h-screen">
            <%@ include file="sidebar.jsp" %>

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
                                    <img src="https://readdy.ai/api/search-image?query=professional%20portrait%20photo%20of%20a%20young%20vietnamese%20male%20student%20with%20short%20black%20hair%2C%20casual%20outfit%2C%20neutral%20background%2C%20friendly%20smile&width=100&height=100&seq=1&orientation=squarish" alt="Avatar" class="w-8 h-8 rounded-full object-cover">
                                </button>
                            </div>
                        </div>
                    </div>
                </header>
                <main class="flex-1 overflow-y-auto bg-gray-50 p-4 md:p-6 custom-scrollbar">
                    <div class="max-w-7xl mx-auto" style="   margin-left: 300px;">
                        <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-4 mb-6">
                            <!-- Header section with title and join button -->
                            <div class="flex flex-col md:flex-row items-start md:items-center justify-between mb-4">
                                <h1 class="text-2xl font-bold text-gray-800 mb-4 md:mb-0">Khóa học của tôi</h1>
                                <a href="<%=request.getContextPath()%>/student/available-courses" 
                                   class="inline-flex items-center px-4 py-2 bg-green-600 text-white text-sm font-medium rounded-button hover:bg-green-700 transition-colors">
                                    <i class="ri-add-line mr-2"></i>
                                    Tham gia khóa học mới
                                </a>
                            </div>

                            <!-- Search and filter section -->
                            <div class="md:flex md:items-center md:justify-between">
                                <div class="relative flex-1 md:mr-4 mb-4 md:mb-0">
                                    <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                        <i class="ri-search-line text-gray-400"></i>
                                    </div>
                                    <input type="text" id="courseSearchInput" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg block w-full pl-10 p-2.5 focus:ring-primary/20 focus:border-primary" placeholder="Nhập tên môn học...">
                                </div>
                                <div class="flex flex-col md:flex-row items-stretch md:items-center gap-3">
                                    <select class="block w-full md:w-auto px-3 py-2 border border-gray-300 bg-white rounded-lg shadow-sm focus:outline-none focus:ring-primary/20 focus:border-primary text-sm">
                                        <option value="">Tất cả học kỳ</option>
                                        <% for (Semester semester : semesters) { %>
                                        <option value="<%= semester.getSemesterId() %>"><%= semester.getName() %></option>
                                        <% } %>
                                    </select>
                                    <div class="flex flex-grow md:flex-grow-0 gap-2">
                                        <button class="filter-btn flex-1 px-4 py-2 text-sm font-medium text-white bg-primary rounded-button whitespace-nowrap" data-filter="all">Tất cả</button>
                                        <button class="filter-btn flex-1 px-4 py-2 text-sm font-medium text-gray-700 bg-gray-100 rounded-button whitespace-nowrap hover:bg-gray-200" data-filter="studying">Đang học</button>
                                        <button class="filter-btn flex-1 px-4 py-2 text-sm font-medium text-gray-700 bg-gray-100 rounded-button whitespace-nowrap hover:bg-gray-200" data-filter="completed">Hoàn thành</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden table-responsive">
                            <table class="min-w-full divide-y divide-gray-200 hidden md:table">
                                <thead class="bg-gray-50">
                                    <tr>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Tên môn học
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Giảng viên
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Lịch học
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Tiến độ
                                        </th>
                                        <th scope="col" class="relative px-6 py-3">
                                            <span class="sr-only">Hành động</span>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody class="bg-white divide-y divide-gray-200">
                                    <% for (CourseDisplayModel course : enrolledCourses) { %>
                                    <tr data-progress="<%= course.getProgressPercentage() %>">
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="flex items-center">
                                                <div class="w-10 h-10 flex items-center justify-center rounded-lg <%= course.getCourseColorClass() %> mr-3 flex-shrink-0">
                                                    <i class="<%= course.getCourseIcon() %> text-lg"></i>
                                                </div>
                                                <div>
                                                    <div class="text-sm font-medium text-gray-900 course-name-desktop">
                                                        <%= course.getName() %>
                                                    </div>
                                                    <div class="text-sm text-gray-500"><%= course.getCode() %></div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="text-sm text-gray-900"><%= course.getLecturerName() %></div>
                                            <div class="text-sm text-gray-500"><%= course.getLecturerDepartment() %></div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="text-sm text-gray-900"><%= course.getSchedule() != null ? course.getSchedule() : "Chưa có lịch" %></div>
                                            <div class="text-sm text-gray-500"><%= course.getRoom() != null ? course.getRoom() : "Chưa có phòng" %></div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="flex items-center justify-between mb-1">
                                                <span class="text-xs text-gray-500"><%= course.getProgressPercentage() %>%</span>
                                                <span class="text-xs font-medium text-gray-700"><%= course.getProgressDisplay() %></span>
                                            </div>
                                            <progress class="course-progress w-full h-2" value="<%= course.getProgressPercentage() %>" max="100"></progress>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                            <div class="flex gap-2 justify-end">
                                                <a href="<%=request.getContextPath()%>/student/course-detail?id=<%= course.getCourseId() %>" class="px-3 py-1.5 bg-primary text-white text-xs rounded-button hover:bg-primary-dark">Vào học</a>
                                                <a href="<%=request.getContextPath()%>/student/course-detail?id=<%= course.getCourseId() %>&tab=materials" class="px-3 py-1.5 bg-gray-100 text-gray-700 text-xs rounded-button hover:bg-gray-200">Tài liệu</a>
                                                <a href="<%=request.getContextPath()%>/student/course-detail?id=<%= course.getCourseId() %>&tab=assignments" class="px-3 py-1.5 bg-gray-100 text-gray-700 text-xs rounded-button hover:bg-gray-200">Bài tập</a>
                                            </div>
                                        </td>
                                    </tr>
                                    <% } %>
                                    <% if (enrolledCourses.isEmpty()) { %>
                                    <tr>
                                        <td colspan="5" class="px-6 py-4 text-center text-gray-500">
                                            <div class="flex flex-col items-center">
                                                <i class="ri-book-line text-4xl text-gray-300 mb-2"></i>
                                                <p class="text-sm">Bạn chưa đăng ký khóa học nào</p>
                                                <a href="<%=request.getContextPath()%>/student/available-courses" class="mt-2 text-primary hover:text-primary-dark text-sm">Tìm khóa học</a>
                                            </div>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>

                            <div class="md:hidden p-4">
                                <% for (CourseDisplayModel course : enrolledCourses) { %>
                                <div class="course-row bg-white" data-progress="<%= course.getProgressPercentage() %>">
                                    <div class="flex items-center mb-2">
                                        <div class="w-10 h-10 flex items-center justify-center rounded-lg <%= course.getCourseColorClass() %> mr-3 flex-shrink-0">
                                            <i class="<%= course.getCourseIcon() %> text-lg"></i>
                                        </div>
                                        <div>
                                            <div class="course-name-mobile"><%= course.getName() %></div>
                                            <div class="course-info-mobile"><%= course.getCode() %></div>
                                        </div>
                                    </div>
                                    <div class="course-info-mobile mb-1">Giảng viên: <%= course.getLecturerName() %></div>
                                    <div class="course-info-mobile mb-3">Lịch học: <%= course.getSchedule() != null ? course.getSchedule() : "Chưa có lịch" %> • <%= course.getRoom() != null ? course.getRoom() : "Chưa có phòng" %></div>
                                    <div class="mb-2">
                                        <div class="flex items-center justify-between mb-1">
                                            <span class="text-xs text-gray-500">Tiến độ: <%= course.getProgressPercentage() %>%</span>
                                            <span class="text-xs font-medium text-gray-700"><%= course.getProgressDisplay() %></span>
                                        </div>
                                        <progress class="course-progress w-full h-2" value="<%= course.getProgressPercentage() %>" max="100"></progress>
                                    </div>
                                    <div class="course-actions-mobile">
                                        <a href="<%=request.getContextPath()%>/student/course-detail?id=<%= course.getCourseId() %>" class="px-3 py-1.5 bg-primary text-white text-xs rounded-button hover:bg-primary-dark">Vào học</a>
                                        <a href="<%=request.getContextPath()%>/student/course-documents?id=<%= course.getCourseId() %>" class="px-3 py-1.5 bg-gray-100 text-gray-700 text-xs rounded-button hover:bg-gray-200">Tài liệu</a>
                                        <a href="<%=request.getContextPath()%>/student/course-assignments?id=<%= course.getCourseId() %>" class="px-3 py-1.5 bg-gray-100 text-gray-700 text-xs rounded-button hover:bg-gray-200">Bài tập</a>
                                    </div>
                                </div>
                                <% } %>
                                <% if (enrolledCourses.isEmpty()) { %>
                                <div class="course-row bg-white text-center">
                                    <div class="flex flex-col items-center py-8">
                                        <i class="ri-book-line text-4xl text-gray-300 mb-2"></i>
                                        <p class="text-sm text-gray-500">Bạn chưa đăng ký khóa học nào</p>
                                        <a href="<%=request.getContextPath()%>/student/available-courses" class="mt-2 text-primary hover:text-primary-dark text-sm">Tìm khóa học</a>
                                    </div>
                                </div>
                                <% } %>
                            </div>
                        </div>

                        <div class="mt-6 flex flex-col md:flex-row items-center justify-between">
                            <div class="flex items-center text-sm text-gray-700 mb-4 md:mb-0">
                                <span class="mr-2">Hiển thị</span>
                                <select id="rowsPerPageSelect" class="px-2 py-1 border border-gray-300 rounded-md bg-white text-sm">
                                    <option value="10">10</option>
                                    <option value="20">20</option>
                                    <option value="50">50</option>
                                </select>
                                <span class="ml-2">khóa học mỗi trang</span>
                            </div>
                            <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                                <a href="#" class="pagination-link relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50" data-direction="prev">
                                    <span class="sr-only">Previous</span>
                                    <i class="ri-arrow-left-s-line"></i>
                                </a>
                                <a href="#" class="pagination-link relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50" data-direction="next">
                                    <span class="sr-only">Next</span>
                                    <i class="ri-arrow-right-s-line"></i>
                                </a>
                            </nav>
                            <button id="exportListBtn" class="mt-4 md:mt-0 px-4 py-2 text-sm font-medium text-gray-700 bg-gray-100 rounded-button whitespace-nowrap hover:bg-gray-200 flex items-center">
                                <div class="w-5 h-5 flex items-center justify-center mr-1">
                                    <i class="ri-file-download-line"></i>
                                </div>
                                <span>Xuất danh sách</span>
                            </button>
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
                <a href="./courses" class="flex flex-col items-center py-2 text-primary">
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
                <a href="./profile.jsp" class="flex flex-col items-center py-2 text-gray-500">
                    <div class="w-6 h-6 flex items-center justify-center">
                        <i class="ri-user-line"></i>
                    </div>
                    <span class="text-xs mt-1">Cá nhân</span>
                </a>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Mobile Menu Toggle
                const mobileMenuBtn = document.getElementById('mobileMenuBtn');
                const sidebar = document.querySelector('aside');
                mobileMenuBtn.addEventListener('click', function () {
                    sidebar.classList.toggle('hidden');
                    sidebar.classList.toggle('fixed');
                    sidebar.classList.toggle('z-50');
                    sidebar.classList.toggle('top-0');
                    sidebar.classList.toggle('left-0');
                    sidebar.classList.toggle('h-full');
                    sidebar.classList.toggle('w-64');
                });

                // Course Filtering
                const filterButtons = document.querySelectorAll('.filter-btn');
                const allCourseRows = Array.from(document.querySelectorAll('tbody tr, .md\\:hidden .course-row')); // Get all rows for both desktop and mobile

                filterButtons.forEach(button => {
                    button.addEventListener('click', function () {
                        const filter = this.dataset.filter;

                        // Update active button style
                        filterButtons.forEach(btn => {
                            btn.classList.remove('bg-primary', 'text-white');
                            btn.classList.add('bg-gray-100', 'text-gray-700');
                        });
                        this.classList.remove('bg-gray-100', 'text-gray-700');
                        this.classList.add('bg-primary', 'text-white');

                        allCourseRows.forEach(row => {
                            const progress = parseInt(row.dataset.progress);
                            if (filter === 'all') {
                                row.style.display = ''; // Show all
                            } else if (filter === 'studying') {
                                if (progress < 100) {
                                    row.style.display = '';
                                } else {
                                    row.style.display = 'none';
                                }
                            } else if (filter === 'completed') {
                                if (progress === 100) {
                                    row.style.display = '';
                                } else {
                                    row.style.display = 'none';
                                }
                            }
                        });
                        // After filtering, re-apply pagination for the visible rows
                        currentPage = 1; // Reset to first page after filtering
                        renderPagination();
                        showPage(currentPage);
                    });
                });

                // Course Search
                const courseSearchInput = document.getElementById('courseSearchInput');
                courseSearchInput.addEventListener('keyup', function () {
                    const searchTerm = this.value.toLowerCase();
                    allCourseRows.forEach(row => {
                        const desktopCourseName = row.querySelector('.course-name-desktop');
                        const mobileCourseName = row.querySelector('.course-name-mobile');
                        const courseName = (desktopCourseName ? desktopCourseName.innerText : (mobileCourseName ? mobileCourseName.innerText : '')).toLowerCase();

                        if (courseName.includes(searchTerm)) {
                            row.style.display = '';
                        } else {
                            row.style.display = 'none';
                        }
                    });
                    currentPage = 1; // Reset to first page after searching
                    renderPagination();
                    showPage(currentPage); // Re-apply pagination to the search results
                });

                // Export List Functionality
                const exportListBtn = document.getElementById('exportListBtn');
                exportListBtn.addEventListener('click', function () {
                    let csv = [];
                    // Add header row
                    const headerRow = [];
                    document.querySelectorAll('thead th').forEach(th => {
                        if (th.innerText.trim() !== 'Hành động') { // Exclude action column
                            headerRow.push(th.innerText.trim());
                        }
                    });
                    csv.push(headerRow.join(","));

                    // Add data rows from visible courses (after filters/search)
                    allCourseRows.forEach(row => {
                        if (row.style.display !== 'none') { // Only export visible rows
                            const rowData = [];
                            row.querySelectorAll('td').forEach((td, index) => {
                                // Assuming the last td is the action column, adjust if needed
                                if (index < row.querySelectorAll('td').length - 1) { // Exclude last column (actions)
                                    let textContent = td.innerText.trim();
                                    // Clean up text content (e.g., remove newlines from schedule)
                                    textContent = textContent.replace(/\s+/g, ' ').replace(/\n/g, ' ').trim();
                                    // For progress, just export the percentage
                                    if (td.querySelector('progress.course-progress')) {
                                        const progressSpan = td.querySelector('span.text-xs.text-gray-500');
                                        if (progressSpan) {
                                            rowData.push(progressSpan.innerText.replace('Tiến độ: ', ''));
                                        } else {
                                            rowData.push(''); // Or handle as needed if progress span not found
                                        }
                                    } else {
                                        rowData.push(`"${textContent}"`); // Quote to handle commas within text
                                    }
                                }
                            });
                            // Adjust for mobile view which has different td structure for details
                            if (row.classList.contains('course-row') && row.style.display !== 'none') { // Mobile view row
                                const courseNameMobile = row.querySelector('.course-name-mobile')?.innerText.replace(/\s+/g, ' ').trim() || '';
                                const courseCodeMobile = row.querySelector('.course-info-mobile:nth-of-type(2)')?.innerText.replace(/\s+/g, ' ').trim() || '';
                                const instructorMobile = row.querySelector('.course-info-mobile:nth-of-type(3)')?.innerText.replace('Giảng viên: ', '').replace(/\s+/g, ' ').trim() || '';
                                const scheduleMobile = row.querySelector('.course-info-mobile:nth-of-type(4)')?.innerText.replace('Lịch học: ', '').replace(/\s+/g, ' ').trim() || '';
                                const progressMobile = row.querySelector('span.text-xs.text-gray-500')?.innerText.replace('Tiến độ: ', '').replace(/\s+/g, ' ').trim() || '';

                                csv.push(`"${courseNameMobile} (${courseCodeMobile})","${instructorMobile}","${scheduleMobile}","${progressMobile}"`);
                            } else if (rowData.length > 0) { // Desktop view row
                                csv.push(rowData.join(","));
                            }
                        }
                    });

                    const csvFile = new Blob([csv.join("\n")], {type: "text/csv;charset=utf-8;"});
                    const downloadLink = document.createElement("a");
                    downloadLink.download = "danh_sach_khoa_hoc.csv";
                    downloadLink.href = window.URL.createObjectURL(csvFile);
                    downloadLink.style.display = "none";
                    document.body.appendChild(downloadLink);
                    downloadLink.click();
                    document.body.removeChild(downloadLink);
                });


                // Pagination Logic
                const paginationContainer = document.querySelector('nav[aria-label="Pagination"]');
                const prevButton = paginationContainer.querySelector('[data-direction="prev"]');
                const nextButton = paginationContainer.querySelector('[data-direction="next"]');
                const rowsPerPageSelect = document.getElementById('rowsPerPageSelect');

                let currentPage = 1;
                let rowsPerPage = parseInt(rowsPerPageSelect.value);

                function getVisibleRows() {
                    return allCourseRows.filter(row => row.style.display !== 'none');
                }

                function renderPagination() {
                    const visibleRows = getVisibleRows();
                    const totalPages = Math.ceil(visibleRows.length / rowsPerPage);

                    // Clear existing page numbers
                    const existingPageNumbers = paginationContainer.querySelectorAll('.page-number');
                    existingPageNumbers.forEach(node => node.remove());

                    // Add new page numbers
                    for (let i = 1; i <= totalPages; i++) {
                        const pageLink = document.createElement('a');
                        pageLink.href = '#';
                        pageLink.classList.add('pagination-link', 'relative', 'inline-flex', 'items-center', 'px-4', 'py-2', 'border', 'border-gray-300', 'bg-white', 'text-sm', 'font-medium', 'text-gray-700', 'hover:bg-gray-50', 'page-number');
                        pageLink.textContent = i;
                        pageLink.setAttribute('data-page', i);

                        if (i === currentPage) {
                            pageLink.classList.add('z-10', 'bg-primary/10', 'border-primary', 'text-primary');
                            pageLink.setAttribute('aria-current', 'page');
                        }

                        // Insert before the next button
                        paginationContainer.insertBefore(pageLink, nextButton);
                    }
                    updatePaginationButtons();
                }

                function showPage(page) {
                    const visibleRows = getVisibleRows();
                    const startIndex = (page - 1) * rowsPerPage;
                    const endIndex = startIndex + rowsPerPage;

                    visibleRows.forEach((row, index) => {
                        if (index >= startIndex && index < endIndex) {
                            row.style.display = row.classList.contains('md:hidden') ? 'block' : ''; // Show for mobile or desktop
                        } else {
                            row.style.display = 'none';
                        }
                    });

                    // Update active link style
                    paginationContainer.querySelectorAll('.pagination-link').forEach(link => {
                        link.classList.remove('z-10', 'bg-primary/10', 'border-primary', 'text-primary');
                        link.removeAttribute('aria-current');
                        if (link.textContent == page && link.dataset.direction === undefined) {
                            link.classList.add('z-10', 'bg-primary/10', 'border-primary', 'text-primary');
                            link.setAttribute('aria-current', 'page');
                        }
                    });
                    updatePaginationButtons();
                }

                function updatePaginationButtons() {
                    const totalPages = Math.ceil(getVisibleRows().length / rowsPerPage);
                    prevButton.style.display = (currentPage === 1) ? 'none' : 'inline-flex';
                    nextButton.style.display = (currentPage === totalPages || totalPages === 0) ? 'none' : 'inline-flex';
                }

                // Event listener for rows per page select
                rowsPerPageSelect.addEventListener('change', function () {
                    rowsPerPage = parseInt(this.value);
                    currentPage = 1; // Reset to first page
                    renderPagination();
                    showPage(currentPage);
                });

                // Event listeners for pagination links (dynamic and static)
                paginationContainer.addEventListener('click', function (e) {
                    if (e.target.closest('.pagination-link')) {
                        e.preventDefault();
                        const clickedLink = e.target.closest('.pagination-link');

                        if (clickedLink.dataset.page) {
                            currentPage = parseInt(clickedLink.dataset.page);
                        } else if (clickedLink.dataset.direction === 'prev') {
                            currentPage--;
                        } else if (clickedLink.dataset.direction === 'next') {
                            currentPage++;
                        }

                        showPage(currentPage);
                    }
                });

                // Initial rendering
                renderPagination();
                showPage(currentPage);
            });
        </script>
    </body>
</html>