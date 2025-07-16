<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="model.CourseDisplayModel" %>
<%@ page import="model.Semester" %>
<%@ page import="model.Student" %>
<%@ page import="model.User" %>
<%
    List<CourseDisplayModel> availableCourses = (List<CourseDisplayModel>) request.getAttribute("availableCourses");
    List<Semester> semesters = (List<Semester>) request.getAttribute("semesters");
    Student student = (Student) request.getAttribute("student");
    User currentUser = (User) request.getAttribute("currentUser");
    String keyword = (String) request.getAttribute("keyword");
    Integer selectedSemester = (Integer) request.getAttribute("selectedSemester");
    
    if (availableCourses == null) {
        availableCourses = new ArrayList<>();
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
        <title>Khóa học có thể đăng ký - Sinh viên</title>
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
                font-size: 0.875rem;
            }
            .course-info-mobile {
                color: #6b7280;
                font-size: 0.875rem;
            }
            .course-actions-mobile {
                display: flex;
                gap: 0.5rem;
                justify-content: flex-end;
            }
            .availability-badge {
                display: inline-flex;
                align-items: center;
                gap: 0.25rem;
                padding: 0.25rem 0.5rem;
                border-radius: 9999px;
                font-size: 0.75rem;
                font-weight: 500;
            }
            .availability-available {
                background-color: #dcfce7;
                color: #166534;
            }
            .availability-full {
                background-color: #fef2f2;
                color: #991b1b;
            }
            .availability-limited {
                background-color: #fef3c7;
                color: #a16207;
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
                        <a href="<%=request.getContextPath()%>/student/courses" class="hidden md:flex items-center text-gray-600 hover:text-primary">
                            <div class="w-8 h-8 flex items-center justify-center">
                                <i class="ri-arrow-left-line text-xl"></i>
                            </div>
                            <span class="ml-1 text-sm font-medium">Quay lại khóa học</span>
                        </a>
                        <div class="md:hidden flex items-center">
                            <span class="text-xl font-['Pacifico'] text-primary">logo</span>
                            <span class="ml-1 text-base font-semibold text-gray-800">LMS</span>
                        </div>
                        <div class="hidden md:flex items-center flex-1 max-w-lg mx-4">
                            <form action="<%=request.getContextPath()%>/student/available-courses" method="GET" class="relative w-full">
                                <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                    <i class="ri-search-line text-gray-400"></i>
                                </div>
                                <input type="text" name="keyword" value="<%= keyword != null ? keyword : "" %>" class="bg-gray-50 border-none text-gray-900 text-sm rounded-lg block w-full pl-10 p-2.5 focus:ring-2 focus:ring-primary/20 focus:outline-none" placeholder="Tìm kiếm khóa học...">
                            </form>
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
                    <div class="max-w-7xl mx-auto" style="margin-left: 300px;">
                        <div class="flex items-center justify-between mb-6">
                            <h1 class="text-2xl font-bold text-gray-800">Khóa học có thể đăng ký</h1>
                            <div class="text-sm text-gray-600">
                                <span class="font-medium"><%= availableCourses.size() %></span> khóa học có sẵn
                            </div>
                        </div>

                        <!-- Search and Filter Section -->
                        <form action="<%=request.getContextPath()%>/student/available-courses" method="GET" class="bg-white rounded-lg shadow-sm border border-gray-100 p-4 mb-6">
                            <div class="md:flex md:items-center md:justify-between">
                                <div class="relative flex-1 md:mr-4 mb-4 md:mb-0">
                                    <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                        <i class="ri-search-line text-gray-400"></i>
                                    </div>
                                    <input type="text" name="keyword" value="<%= keyword != null ? keyword : "" %>" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg block w-full pl-10 p-2.5 focus:ring-primary/20 focus:border-primary" placeholder="Nhập tên môn học, mã môn hoặc tên giảng viên...">
                                </div>
                                <div class="flex flex-col md:flex-row items-stretch md:items-center gap-3">
                                    <select name="semester" class="block w-full md:w-auto px-3 py-2 border border-gray-300 bg-white rounded-lg shadow-sm focus:outline-none focus:ring-primary/20 focus:border-primary text-sm">
                                        <option value="">Tất cả học kỳ</option>
                                        <% for (Semester semester : semesters) { %>
                                            <option value="<%= semester.getSemesterId() %>" <%= selectedSemester != null && selectedSemester.equals(semester.getSemesterId()) ? "selected" : "" %>>
                                                <%= semester.getName() %>
                                            </option>
                                        <% } %>
                                    </select>
                                    <div class="flex gap-2">
                                        <button type="submit" class="px-4 py-2 text-sm font-medium text-white bg-primary rounded-button hover:bg-primary-dark">
                                            <i class="ri-search-line mr-1"></i>Tìm kiếm
                                        </button>
                                        <a href="<%=request.getContextPath()%>/student/available-courses" class="px-4 py-2 text-sm font-medium text-gray-700 bg-gray-100 rounded-button hover:bg-gray-200">
                                            <i class="ri-refresh-line mr-1"></i>Làm mới
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </form>

                        <!-- Courses Table -->
                        <div class="bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden">
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
                                            Tình trạng
                                        </th>
                                        <th scope="col" class="relative px-6 py-3">
                                            <span class="sr-only">Hành động</span>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody class="bg-white divide-y divide-gray-200">
                                    <% for (CourseDisplayModel course : availableCourses) { 
                                        double occupancyRate = (double) course.getEnrolledStudents() / course.getMaxStudents();
                                        String availabilityClass = "";
                                        String availabilityText = "";
                                        String availabilityIcon = "";
                                        
                                        if (occupancyRate >= 0.9) {
                                            availabilityClass = "availability-limited";
                                            availabilityText = "Sắp đầy";
                                            availabilityIcon = "ri-error-warning-line";
                                        } else if (occupancyRate >= 0.7) {
                                            availabilityClass = "availability-limited";
                                            availabilityText = "Còn ít chỗ";
                                            availabilityIcon = "ri-time-line";
                                        } else {
                                            availabilityClass = "availability-available";
                                            availabilityText = "Còn chỗ";
                                            availabilityIcon = "ri-checkbox-circle-line";
                                        }
                                    %>
                                    <tr>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="flex items-center">
                                                <div class="w-10 h-10 flex items-center justify-center rounded-lg <%= course.getCourseColorClass() %> mr-3 flex-shrink-0">
                                                    <i class="<%= course.getCourseIcon() %> text-lg"></i>
                                                </div>
                                                <div>
                                                    <div class="text-sm font-medium text-gray-900 course-name-desktop">
                                                        <%= course.getName() %>
                                                    </div>
                                                    <div class="text-sm text-gray-500">
                                                        <%= course.getCode() %> • <%= course.getCredits() %> tín chỉ • <%= course.getSemesterName() %>
                                                    </div>
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
                                            <div class="availability-badge <%= availabilityClass %>">
                                                <i class="<%= availabilityIcon %>"></i>
                                                <%= availabilityText %>
                                            </div>
                                            <div class="text-xs text-gray-500 mt-1">
                                                <%= course.getEnrolledStudents() %>/<%= course.getMaxStudents() %> sinh viên
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                            <div class="flex gap-2 justify-end">
                                                <button onclick="enrollCourse(<%= course.getCourseId() %>)" class="px-3 py-1.5 bg-primary text-white text-xs rounded-button hover:bg-primary-dark">
                                                    <i class="ri-add-line mr-1"></i>Đăng ký
                                                </button>
                                                <button onclick="viewCourseDetails(<%= course.getCourseId() %>)" class="px-3 py-1.5 bg-gray-100 text-gray-700 text-xs rounded-button hover:bg-gray-200">
                                                    <i class="ri-eye-line mr-1"></i>Xem chi tiết
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                    <% } %>
                                    <% if (availableCourses.isEmpty()) { %>
                                    <tr>
                                        <td colspan="5" class="px-6 py-4 text-center text-gray-500">
                                            <div class="flex flex-col items-center py-8">
                                                <i class="ri-search-line text-4xl text-gray-300 mb-2"></i>
                                                <p class="text-sm">
                                                    <% if (keyword != null && !keyword.trim().isEmpty()) { %>
                                                        Không tìm thấy khóa học nào với từ khóa "<%= keyword %>"
                                                    <% } else { %>
                                                        Hiện tại không có khóa học nào có thể đăng ký
                                                    <% } %>
                                                </p>
                                                <% if (keyword != null && !keyword.trim().isEmpty()) { %>
                                                <a href="<%=request.getContextPath()%>/student/available-courses" class="mt-2 text-primary hover:text-primary-dark text-sm">Xem tất cả khóa học</a>
                                                <% } %>
                                            </div>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>

                            <!-- Mobile View -->
                            <div class="md:hidden p-4">
                                <% for (CourseDisplayModel course : availableCourses) { 
                                    double occupancyRate = (double) course.getEnrolledStudents() / course.getMaxStudents();
                                    String availabilityClass = "";
                                    String availabilityText = "";
                                    String availabilityIcon = "";
                                    
                                    if (occupancyRate >= 0.9) {
                                        availabilityClass = "availability-limited";
                                        availabilityText = "Sắp đầy";
                                        availabilityIcon = "ri-error-warning-line";
                                    } else if (occupancyRate >= 0.7) {
                                        availabilityClass = "availability-limited";
                                        availabilityText = "Còn ít chỗ";
                                        availabilityIcon = "ri-time-line";
                                    } else {
                                        availabilityClass = "availability-available";
                                        availabilityText = "Còn chỗ";
                                        availabilityIcon = "ri-checkbox-circle-line";
                                    }
                                %>
                                <div class="course-row bg-white">
                                    <div class="flex items-center mb-2">
                                        <div class="w-10 h-10 flex items-center justify-center rounded-lg <%= course.getCourseColorClass() %> mr-3 flex-shrink-0">
                                            <i class="<%= course.getCourseIcon() %> text-lg"></i>
                                        </div>
                                        <div class="flex-1">
                                            <div class="course-name-mobile"><%= course.getName() %></div>
                                            <div class="course-info-mobile"><%= course.getCode() %> • <%= course.getCredits() %> tín chỉ</div>
                                        </div>
                                        <div class="availability-badge <%= availabilityClass %>">
                                            <i class="<%= availabilityIcon %>"></i>
                                            <%= availabilityText %>
                                        </div>
                                    </div>
                                    <div class="course-info-mobile mb-1">Giảng viên: <%= course.getLecturerName() %></div>
                                    <div class="course-info-mobile mb-1">Học kỳ: <%= course.getSemesterName() %></div>
                                    <div class="course-info-mobile mb-3">Lịch học: <%= course.getSchedule() != null ? course.getSchedule() : "Chưa có lịch" %> • <%= course.getRoom() != null ? course.getRoom() : "Chưa có phòng" %></div>
                                    <div class="course-info-mobile mb-3">Đã đăng ký: <%= course.getEnrolledStudents() %>/<%= course.getMaxStudents() %> sinh viên</div>
                                    <div class="course-actions-mobile">
                                        <button onclick="enrollCourse(<%= course.getCourseId() %>)" class="px-3 py-1.5 bg-primary text-white text-xs rounded-button hover:bg-primary-dark">
                                            <i class="ri-add-line mr-1"></i>Đăng ký
                                        </button>
                                        <button onclick="viewCourseDetails(<%= course.getCourseId() %>)" class="px-3 py-1.5 bg-gray-100 text-gray-700 text-xs rounded-button hover:bg-gray-200">
                                            <i class="ri-eye-line mr-1"></i>Chi tiết
                                        </button>
                                    </div>
                                </div>
                                <% } %>
                                <% if (availableCourses.isEmpty()) { %>
                                <div class="course-row bg-white text-center">
                                    <div class="flex flex-col items-center py-8">
                                        <i class="ri-search-line text-4xl text-gray-300 mb-2"></i>
                                        <p class="text-sm text-gray-500">
                                            <% if (keyword != null && !keyword.trim().isEmpty()) { %>
                                                Không tìm thấy khóa học nào với từ khóa "<%= keyword %>"
                                            <% } else { %>
                                                Hiện tại không có khóa học nào có thể đăng ký
                                            <% } %>
                                        </p>
                                        <% if (keyword != null && !keyword.trim().isEmpty()) { %>
                                        <a href="<%=request.getContextPath()%>/student/available-courses" class="mt-2 text-primary hover:text-primary-dark text-sm">Xem tất cả khóa học</a>
                                        <% } %>
                                    </div>
                                </div>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <!-- Mobile Bottom Navigation -->
        <div class="md:hidden fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 z-10">
            <div class="flex items-center justify-around">
                <a href="<%=request.getContextPath()%>/student/dashboard" class="flex flex-col items-center py-2 text-gray-500">
                    <div class="w-6 h-6 flex items-center justify-center">
                        <i class="ri-dashboard-line"></i>
                    </div>
                    <span class="text-xs mt-1">Trang chủ</span>
                </a>
                <a href="<%=request.getContextPath()%>/student/courses" class="flex flex-col items-center py-2 text-primary">
                    <div class="w-6 h-6 flex items-center justify-center">
                        <i class="ri-book-open-line"></i>
                    </div>
                    <span class="text-xs mt-1">Khóa học</span>
                </a>
                <a href="<%=request.getContextPath()%>/student/calendar" class="flex flex-col items-center py-2 text-gray-500">
                    <div class="w-6 h-6 flex items-center justify-center">
                        <i class="ri-calendar-line"></i>
                    </div>
                    <span class="text-xs mt-1">Lịch</span>
                </a>
                <a href="<%=request.getContextPath()%>/student/assignments" class="flex flex-col items-center py-2 text-gray-500">
                    <div class="w-6 h-6 flex items-center justify-center">
                        <i class="ri-file-list-3-line"></i>
                    </div>
                    <span class="text-xs mt-1">Bài tập</span>
                </a>
                <a href="<%=request.getContextPath()%>/student/profile" class="flex flex-col items-center py-2 text-gray-500">
                    <div class="w-6 h-6 flex items-center justify-center">
                        <i class="ri-user-line"></i>
                    </div>
                    <span class="text-xs mt-1">Cá nhân</span>
                </a>
            </div>
        </div>

        <!-- JavaScript -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Mobile Menu Toggle
                const mobileMenuBtn = document.getElementById('mobileMenuBtn');
                const sidebar = document.querySelector('aside');
                if (mobileMenuBtn) {
                    mobileMenuBtn.addEventListener('click', function () {
                        sidebar.classList.toggle('hidden');
                    });
                }
            });

            // Function to enroll in a course
            function enrollCourse(courseId) {
                if (confirm('Bạn có chắc chắn muốn đăng ký khóa học này?')) {
                    // Show loading
                    const buttons = document.querySelectorAll(`button[onclick="enrollCourse(${courseId})"]`);
                    buttons.forEach(btn => {
                        btn.disabled = true;
                        btn.innerHTML = '<i class="ri-loader-2-line animate-spin mr-1"></i>Đang xử lý...';
                    });

                    // Send AJAX request
                    fetch('<%=request.getContextPath()%>/enroll-course', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: 'courseId=' + courseId
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            alert('Đăng ký khóa học thành công!');
                            // Reload page or redirect to my courses
                            window.location.href = '<%=request.getContextPath()%>/student/courses';
                        } else {
                            alert('Lỗi đăng ký: ' + data.message);
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('Có lỗi xảy ra khi đăng ký khóa học');
                    })
                    .finally(() => {
                        // Reset buttons
                        buttons.forEach(btn => {
                            btn.disabled = false;
                            btn.innerHTML = '<i class="ri-add-line mr-1"></i>Đăng ký';
                        });
                    });
                }
            }

            // Function to view course details
            function viewCourseDetails(courseId) {
                // You can implement a modal or redirect to course details page
                window.location.href = '<%=request.getContextPath()%>/student/course-preview?id=' + courseId;
            }
        </script>
    </body>
</html>