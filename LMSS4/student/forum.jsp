<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Diễn đàn - Hệ Thống LMS</title>
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
        <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
        <style>
            body {
                font-family: 'Inter', sans-serif;
            }
            /* Style cho nội dung chủ đề chi tiết */
            .prose img {
                max-width: 100%;
                height: auto;
                border-radius: 8px;
                margin-top: 1rem;
                margin-bottom: 1rem;
            }
            .prose blockquote {
                border-left: 4px solid #4f46e5;
                padding-left: 1rem;
                margin-left: 0;
                font-style: italic;
                color: #555;
            }
            .prose ul, .prose ol {
                list-style-position: inside;
                padding-left: 1.5rem; /* Add padding for list markers */
            }
            .prose ul li, .prose ol li {
                margin-bottom: 0.5rem;
            }
            .prose a {
                color: #4f46e5;
                text-decoration: underline;
            }
            /* Ẩn các phần không được chọn */
            .view-section {
                display: none;
            }
            .view-section.active {
                display: block;
            }
        </style>
    </head>
    <body class="bg-gray-100 font-sans text-gray-900">
        <div class="flex h-screen">
            <aside class="fixed inset-y-0 left-0 z-50 w-64 bg-white border-r border-gray-200 shadow-lg hidden md:flex flex-col">
                <div class="flex items-center px-6 py-3 border-b border-gray-200">
                    <div class="text-2xl font-['Pacifico'] text-primary">logo</div>
                </div>
                <nav class="p-4 space-y-1 flex-1">
                    <a href="dashboard.jsp" class="w-full px-3 py-2 text-sm font-medium text-primary bg-primary/5 rounded-button block">
                        <div class="flex items-center">
                            <div class="w-5 h-5 flex items-center justify-center mr-3">
                                <i class="ri-dashboard-line"></i>
                            </div>
                            <span>Dashboard</span>
                        </div>
                    </a>
                    <a href="courses" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button block">
                        <div class="flex items-center">
                            <div class="w-5 h-5 flex items-center justify-center mr-3">
                                <i class="ri-book-open-line"></i>
                            </div>
                            <span>Khóa học</span>
                        </div>
                    </a>
                    <a href="assignments.jsp" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button block">
                        <div class="flex items-center">
                            <div class="w-5 h-5 flex items-center justify-center mr-3">
                                <i class="ri-file-list-line"></i>
                            </div>
                            <span>Bài tập</span>
                        </div>
                    </a>
                    <a href="grades.jsp" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button block">
                        <div class="flex items-center">
                            <div class="w-5 h-5 flex items-center justify-center mr-3">
                                <i class="ri-bar-chart-line"></i>
                            </div>
                            <span>Điểm số</span>
                        </div>
                    </a>
                    <a href="forum.jsp" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button block">
                        <div class="flex items-center">
                            <div class="w-5 h-5 flex items-center justify-center mr-3">
                                <i class="ri-question-answer-line"></i>
                            </div>
                            <span>Diễn đàn</span>
                        </div>
                    </a>
                    <a href="calendar.jsp" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button block">
                        <div class="flex items-center">
                            <div class="w-5 h-5 flex items-center justify-center mr-3">
                                <i class="ri-calendar-line"></i>
                            </div>
                            <span>Lịch</span>
                        </div>
                    </a>
                    <a href="documents.jsp" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button block">
                        <div class="flex items-center">
                            <div class="w-5 h-5 flex items-center justify-center mr-3">
                                <i class="ri-calendar-line"></i>
                            </div>
                            <span>Tài Liệu</span>
                        </div>
                    </a>
                    <a href="settings.jsp" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button block">
                        <div class="flex items-center">
                            <div class="w-5 h-5 flex items-center justify-center mr-3">
                                <i class="ri-settings-line"></i>
                            </div>
                            <span>Cài đặt</span>
                        </div>
                    </a>
                </nav>
                <div class="p-4 border-t border-gray-200">
                    <div class="flex items-center">
                        <img src="https://readdy.ai/api/search-image?query=professional%2520portrait%2520photo%2520of%2520a%2520young%2520vietnamese%2520male%2520student%2520with%2520short%2520black%2520hair%252C%2520casual%2520outfit%252C%2520neutral%2520background%252C%2520friendly%2520smile&width=100&height=100&seq=1&orientation=squarish" alt="Avatar" class="w-10 h-10 rounded-full object-cover">
                        <div class="ml-3">
                            <p class="text-sm font-medium text-gray-800">Nguyễn Văn Minh</p>
                            <p class="text-xs text-gray-500">SV2023405</p>
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

            <div class="flex-1 flex flex-col md:ml-64">
                <header class="bg-white border-b border-gray-200 shadow-sm fixed top-0 z-40 w-full md:w-[calc(100%-16rem)] md:left-64">
                    <div class="flex items-center justify-between px-4 py-3">
                        <button class="md:hidden w-10 h-10 flex items-center justify-center text-gray-600">
                            <i class="ri-menu-line text-xl"></i>
                        </button>
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
                                    <img src="https://readdy.ai/api/search-image?query=professional%20portrait%20photo%20of%20a%20young%20vietnamese%20male%20student%20with%20short%20black%20hair%2C%20casual%20outfit%2C%20neutral%20background%2C%20friendly%20smile&amp;width=100&amp;height=100&amp;seq=1&amp;orientation=squarish" alt="Avatar" class="w-8 h-8 rounded-full object-cover">
                                </button>
                            </div>
                        </div>
                    </div>
                </header>

                <main class="md:ml-64 p-4 md:p-6 min-h-screen" style="  margin-left: 15px;">
                    <div id="forumListingView" class="view-section active" style="   margin-top: 60px;">
                        <div class="flex flex-col md:flex-row md:items-center justify-between mb-6">
                            <div>
                                <h1 class="text-2xl font-bold text-gray-800 mb-1">Diễn đàn thảo luận</h1>
                                <p class="text-gray-600">Đặt câu hỏi, chia sẻ kiến thức và tham gia thảo luận với giảng viên và sinh viên khác</p>
                            </div>
                            <button id="createTopicButton" class="mt-4 md:mt-0 bg-primary text-white px-4 py-2 rounded-button flex items-center gap-2 whitespace-nowrap">
                                <div class="w-5 h-5 flex items-center justify-center">
                                    <i class="ri-add-line"></i>
                                </div>
                                <span>Tạo chủ đề mới</span>
                            </button>
                        </div>

                        <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-4 mb-6 flex flex-col md:flex-row items-center gap-4">
                            <input type="text" placeholder="Tìm kiếm chủ đề..." class="flex-grow px-3 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-primary focus:border-primary text-gray-900">
                            <select class="px-3 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-primary focus:border-primary text-gray-900 bg-white">
                                <option value="">Lọc theo môn học</option>
                                <option value="Lập trình hướng đối tượng">Lập trình hướng đối tượng</option>
                                <option value="Cơ sở dữ liệu">Cơ sở dữ liệu</option>
                                <option value="Mạng máy tính">Mạng máy tính</option>
                                <option value="Trí tuệ nhân tạo">Trí tuệ nhân tạo</option>
                            </select>
                            <select class="px-3 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-primary focus:border-primary text-gray-900 bg-white">
                                <option value="">Sắp xếp theo</option>
                                <option value="newest">Mới nhất</option>
                                <option value="most_comments">Nhiều bình luận nhất</option>
                                <option value="most_views">Nhiều lượt xem nhất</option>
                            </select>
                        </div>

                        <div id="topicList" class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <a href="#" class="topic-card block bg-white rounded-lg shadow-sm border border-gray-100 p-5 hover:border-primary transition-all duration-200 unread" data-topic-id="1">
                                <div class="flex justify-between items-start mb-2">
                                    <h3 class="text-lg font-semibold text-gray-800 line-clamp-2">Làm sao để hiểu sâu về thuật toán Sắp xếp Nổi bọt?</h3>
                                    <button class="favorite-button text-gray-400 hover:text-yellow-500 transition-colors duration-200 ml-3 flex-shrink-0" data-topic-id="1">
                                        <i class="ri-star-line text-xl"></i>
                                    </button>
                                </div>
                                <p class="text-sm text-gray-600 mb-3 line-clamp-2">Mình đang học về các thuật toán sắp xếp và gặp chút khó khăn trong việc nắm vững thuật toán Sắp xếp Nổi bọt (Bubble Sort)...</p>
                                <div class="flex items-center text-xs text-gray-500">
                                    <div class="flex items-center mr-4">
                                        <i class="ri-user-line mr-1"></i>
                                        <span>Nguyễn Văn A</span>
                                    </div>
                                    <div class="flex items-center mr-4">
                                        <i class="ri-time-line mr-1"></i>
                                        <span>10:30 01/07/2025</span>
                                    </div>
                                    <div class="flex items-center">
                                        <i class="ri-chat-3-line mr-1"></i>
                                        <span>3 Bình luận</span>
                                    </div>
                                    <div class="flex items-center ml-auto">
                                        <i class="ri-book-2-line mr-1"></i>
                                        <span>Cấu trúc dữ liệu</span>
                                    </div>
                                </div>
                            </a>

                            <a href="#" class="topic-card block bg-white rounded-lg shadow-sm border border-gray-100 p-5 hover:border-primary transition-all duration-200 read" data-topic-id="2">
                                <div class="flex justify-between items-start mb-2">
                                    <h3 class="text-lg font-semibold text-gray-800 line-clamp-2">Hướng dẫn sử dụng hiệu quả GitHub cho project nhóm</h3>
                                    <button class="favorite-button text-gray-400 hover:text-yellow-500 transition-colors duration-200 ml-3 flex-shrink-0" data-topic-id="2">
                                        <i class="ri-star-line text-xl"></i>
                                    </button>
                                </div>
                                <p class="text-sm text-gray-600 mb-3 line-clamp-2">Chào mọi người, nhóm em đang gặp vấn đề khi làm việc nhóm trên GitHub. Có ai có kinh nghiệm chia sẻ về quy trình làm việc hiệu quả không ạ?</p>
                                <div class="flex items-center text-xs text-gray-500">
                                    <div class="flex items-center mr-4">
                                        <i class="ri-user-line mr-1"></i>
                                        <span>Trần Thị B</span>
                                    </div>
                                    <div class="flex items-center mr-4">
                                        <i class="ri-time-line mr-1"></i>
                                        <span>09:00 30/06/2025</span>
                                    </div>
                                    <div class="flex items-center">
                                        <i class="ri-chat-3-line mr-1"></i>
                                        <span>7 Bình luận</span>
                                    </div>
                                    <div class="flex items-center ml-auto">
                                        <i class="ri-book-2-line mr-1"></i>
                                        <span>Phát triển Web</span>
                                    </div>
                                </div>
                            </a>

                            <a href="#" class="topic-card block bg-white rounded-lg shadow-sm border border-gray-100 p-5 hover:border-primary transition-all duration-200 read" data-topic-id="3">
                                <div class="flex justify-between items-start mb-2">
                                    <h3 class="text-lg font-semibold text-gray-800 line-clamp-2">Thắc mắc về cách hoạt động của Polymorphism trong Java</h3>
                                    <button class="favorite-button text-yellow-500 hover:text-yellow-600 transition-colors duration-200 ml-3 flex-shrink-0" data-topic-id="3">
                                        <i class="ri-star-fill text-xl"></i>
                                    </button>
                                </div>
                                <p class="text-sm text-gray-600 mb-3 line-clamp-2">Em đang học OOP và hơi bối rối về tính đa hình. Có ai giải thích rõ hơn kèm ví dụ thực tế không ạ?</p>
                                <div class="flex items-center text-xs text-gray-500">
                                    <div class="flex items-center mr-4">
                                        <i class="ri-user-line mr-1"></i>
                                        <span>Lê Thị C</span>
                                    </div>
                                    <div class="flex items-center mr-4">
                                        <i class="ri-time-line mr-1"></i>
                                        <span>15:45 29/06/2025</span>
                                    </div>
                                    <div class="flex items-center">
                                        <i class="ri-chat-3-line mr-1"></i>
                                        <span>12 Bình luận</span>
                                    </div>
                                    <div class="flex items-center ml-auto">
                                        <i class="ri-book-2-line mr-1"></i>
                                        <span>Lập trình Hướng đối tượng</span>
                                    </div>
                                </div>
                            </a>
                        </div>

                        <div id="empty-state" class="hidden text-center py-10 text-gray-500">
                            <i class="ri-file-list-3-line text-5xl mb-3"></i>
                            <p class="text-lg font-semibold">Chưa có chủ đề nào được tạo.</p>
                            <p class="text-sm">Hãy là người đầu tiên đặt câu hỏi hoặc chia sẻ kiến thức!</p>
                        </div>

                        <div class="flex justify-center mt-8 space-x-2">
                            <button class="bg-white text-gray-600 px-4 py-2 rounded-lg border border-gray-300 hover:bg-gray-100 transition-colors duration-200 disabled:opacity-50 disabled:cursor-not-allowed" disabled>
                                Trước
                            </button>
                            <button class="bg-primary text-white px-4 py-2 rounded-lg border border-primary transition-colors duration-200">
                                1
                            </button>
                            <button class="bg-white text-gray-600 px-4 py-2 rounded-lg border border-gray-300 hover:bg-gray-100 transition-colors duration-200">
                                2
                            </button>
                            <button class="bg-white text-gray-600 px-4 py-2 rounded-lg border border-gray-300 hover:bg-gray-100 transition-colors duration-200">
                                3
                            </button>
                            <button class="bg-white text-gray-600 px-4 py-2 rounded-lg border border-gray-300 hover:bg-gray-100 transition-colors duration-200">
                                Tiếp
                            </button>
                        </div>
                    </div>
                    <div id="createTopicView" class="view-section">
                        <div class="mb-4">
                            <button id="backToForumListFromCreate" class="flex items-center text-primary hover:text-primary/80 transition-colors duration-200">
                                <i class="ri-arrow-left-line mr-2"></i>
                                <span>Quay lại diễn đàn</span>
                            </button>
                        </div>
                        <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-6 mb-6">
                            <h2 class="text-xl font-bold text-gray-800 mb-4">Tạo chủ đề mới</h2>
                            <form action="#" method="POST"> <div class="mb-4">
                                    <label for="newTopicTitle" class="block text-sm font-medium text-gray-700 mb-1">Tiêu đề chủ đề</label>
                                    <input type="text" id="newTopicTitle" name="topicTitle" class="w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-primary focus:border-primary text-gray-900" placeholder="Nhập tiêu đề chủ đề..." required>
                                </div>
                                <div class="mb-4">
                                    <label for="newTopicSubject" class="block text-sm font-medium text-gray-700 mb-1">Môn học/Khóa học</label>
                                    <select id="newTopicSubject" name="topicSubject" class="w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-primary focus:border-primary text-gray-900 bg-white" required>
                                        <option value="">Chọn môn học</option>
                                        <option value="Lập trình hướng đối tượng">Lập trình hướng đối tượng</option>
                                        <option value="Cơ sở dữ liệu">Cơ sở dữ liệu</option>
                                        <option value="Mạng máy tính">Mạng máy tính</option>
                                        <option value="Trí tuệ nhân tạo">Trí tuệ nhân tạo</option>
                                        <option value="Phát triển ứng dụng web">Phát triển ứng dụng web</option>
                                    </select>
                                </div>
                                <div class="mb-6">
                                    <label for="newTopicContent" class="block text-sm font-medium text-gray-700 mb-1">Nội dung</label>
                                    <textarea id="newTopicContent" name="topicContent" rows="8" class="w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-primary focus:border-primary text-gray-900" placeholder="Viết nội dung chủ đề của bạn tại đây..." required></textarea>
                                </div>
                                <div class="flex justify-end space-x-3">
                                    <button type="button" id="cancelCreateTopic" class="bg-gray-200 text-gray-800 px-4 py-2 rounded-button hover:bg-gray-300">Hủy</button>
                                    <button type="submit" class="bg-primary text-white px-4 py-2 rounded-button hover:bg-primary/90">Đăng chủ đề</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div id="topicDetailView" class="view-section">
                        <div class="mb-4">
                            <button id="backToForumListFromDetail" class="flex items-center text-primary hover:text-primary/80 transition-colors duration-200">
                                <i class="ri-arrow-left-line mr-2"></i>
                                <span>Quay lại diễn đàn</span>
                            </button>
                        </div>

                        <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-6 mb-6">
                            <h1 class="text-3xl font-bold text-gray-800 mb-3" id="detailTopicTitle">Làm sao để hiểu sâu về thuật toán Sắp xếp Nổi bọt?</h1>
                            <div class="flex flex-wrap items-center text-sm text-gray-500 mb-4 gap-x-4 gap-y-1">
                                <div class="flex items-center">
                                    <i class="ri-user-line mr-1 text-base"></i>
                                    <span class="font-medium" id="detailTopicAuthor">Tác giả: Nguyễn Văn A</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="ri-time-line mr-1 text-base"></i>
                                    <span id="detailTopicTime">Đăng vào: 10:30 01/07/2025</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="ri-book-2-line mr-1 text-base"></i>
                                    <span id="detailTopicSubject">Môn học: Cấu trúc dữ liệu và giải thuật</span>
                                </div>
                            </div>
                            <div class="prose max-w-none text-gray-700 leading-relaxed break-words" id="detailTopicContent">
                                <p>Chào mọi người,</p>
                                <p>Mình đang học về các thuật toán sắp xếp và gặp chút khó khăn trong việc nắm vững thuật toán Sắp xếp Nổi bọt (Bubble Sort). Mặc dù đã đọc tài liệu và xem video, mình vẫn cảm thấy chưa thực sự "thấm" được cách nó hoạt động một cách hiệu quả nhất, đặc biệt là trong các trường hợp phức tạp.</p>
                                <p>Có ai có kinh nghiệm hay mẹo nào để hiểu sâu hơn về thuật toán này không? Ví dụ như:</p>
                                <ul>
                                    <li>Cách hình dung quá trình trao đổi phần tử một cách trực quan?</li>
                                    <li>Có bài tập thực hành nào đặc biệt hữu ích không?</li>
                                    <li>Tài liệu nào giải thích một cách dễ hiểu và chi tiết?</li>
                                </ul>
                                <p>Rất mong nhận được sự chia sẻ từ mọi người! Cảm ơn.</p>
                                <p>Trân trọng,</p>
                                <p>A.</p>
                            </div>
                        </div>

                        <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-6">
                            <h2 class="text-xl font-bold text-gray-800 mb-4">Bình luận (<span id="detailCommentCount">3</span>)</h2>

                            <div class="mb-6 border-b border-gray-100 pb-6">
                                <h3 class="text-lg font-semibold text-gray-700 mb-3">Thêm bình luận của bạn</h3>
                                <form action="#" method="POST"> <input type="hidden" name="topicId" value="123"> 
                                    <textarea id="detailNewCommentContent" name="commentContent" rows="4" class="w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-primary focus:border-primary text-gray-900" placeholder="Viết bình luận của bạn tại đây..." required></textarea>
                                    <div class="flex justify-end mt-3">
                                        <button type="submit" class="bg-primary text-white px-4 py-2 rounded-button hover:bg-primary/90">Đăng bình luận</button>
                                    </div>
                                </form>
                            </div>

                            <div id="detailCommentsList">
                                <div class="border-b border-gray-100 pb-4 mb-4 last:border-b-0 last:pb-0 last:mb-0">
                                    <div class="flex items-center text-sm text-gray-600 mb-2">
                                        <i class="ri-user-line mr-1 text-base"></i>
                                        <span class="font-semibold mr-2">Trần Thị B</span>
                                        <span class="mx-1">•</span>
                                        <i class="ri-time-line ml-1 mr-1 text-base"></i>
                                        <span>11:00 01/07/2025</span>
                                    </div>
                                    <p class="text-gray-800 break-words">Chào A, về Bubble Sort thì quan trọng nhất là bạn hình dung được quá trình "nổi bọt" của phần tử lớn nhất/nhỏ nhất về đúng vị trí sau mỗi lần lặp qua mảng. Thử vẽ ra giấy hoặc dùng các công cụ mô phỏng trực quan trên mạng nhé!</p>
                                </div>
                                <div class="border-b border-gray-100 pb-4 mb-4 last:border-b-0 last:pb-0 last:mb-0">
                                    <div class="flex items-center text-sm text-gray-600 mb-2">
                                        <i class="ri-user-line mr-1 text-base"></i>
                                        <span class="font-semibold mr-2">Lê Văn C</span>
                                        <span class="mx-1">•</span>
                                        <i class="ri-time-line ml-1 mr-1 text-base"></i>
                                        <span>14:15 01/07/2025</span>
                                    </div>
                                    <p class="text-gray-800 break-words">Bạn có thể xem video của kênh "CodeLearn" trên YouTube, họ có giải thích rất trực quan và có ví dụ code kèm theo. Ngoài ra, thử tự cài đặt thuật toán này với một mảng nhỏ để xem từng bước thay đổi của mảng, sẽ giúp bạn hiểu rõ hơn về các vòng lặp và điều kiện dừng.</p>
                                </div>
                                <div class="border-b border-gray-100 pb-4 mb-4 last:border-b-0 last:pb-0 last:mb-0">
                                    <div class="flex items-center text-sm text-gray-600 mb-2">
                                        <i class="ri-user-line mr-1 text-base"></i>
                                        <span class="font-semibold mr-2">Phạm Thị D</span>
                                        <span class="mx-1">•</span>
                                        <i class="ri-time-line ml-1 mr-1 text-base"></i>
                                        <span>09:40 02/07/2025</span>
                                    </div>
                                    <p class="text-gray-800 break-words">Đồng ý với B và C. Một cách khác là bạn nên hiểu về độ phức tạp thời gian O(n^2) của nó, và tại sao nó lại không hiệu quả cho mảng lớn. Khi hiểu được nhược điểm, bạn sẽ càng thấy rõ cách nó hoạt động.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>

                <%-- <jsp:include page="footer.jsp" /> --%>

                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        // Lấy các phần tử view chính
                        const forumListingView = document.getElementById('forumListingView');
                        const createTopicView = document.getElementById('createTopicView');
                        const topicDetailView = document.getElementById('topicDetailView');

                        // Lấy các nút điều khiển
                        const createTopicButton = document.getElementById('createTopicButton');
                        const cancelCreateTopicButton = document.getElementById('cancelCreateTopic');
                        const backToForumListFromCreate = document.getElementById('backToForumListFromCreate');
                        const backToForumListFromDetail = document.getElementById('backToForumListFromDetail');
                        const topicCards = document.querySelectorAll('.topic-card'); // Các thẻ chủ đề trong danh sách
                        const favoriteButtons = document.querySelectorAll('.favorite-button');

                        // Hàm để hiển thị một view và ẩn các view khác
                        function showView(viewToShow) {
                            [forumListingView, createTopicView, topicDetailView].forEach(view => {
                                if (view) { // Kiểm tra xem phần tử có tồn tại không
                                    view.classList.remove('active');
                                }
                            });
                            if (viewToShow) {
                                viewToShow.classList.add('active');
                                window.scrollTo({top: 0, behavior: 'smooth'}); // Cuộn lên đầu trang
                            }
                        }

                        // --- Event Listeners ---

                        // Nút "Tạo chủ đề mới"
                        if (createTopicButton) {
                            createTopicButton.addEventListener('click', function () {
                                showView(createTopicView);
                            });
                        }

                        // Nút "Hủy" trong form tạo chủ đề
                        if (cancelCreateTopicButton) {
                            cancelCreateTopicButton.addEventListener('click', function () {
                                showView(forumListingView);
                            });
                        }

                        // Nút "Quay lại diễn đàn" từ form tạo chủ đề
                        if (backToForumListFromCreate) {
                            backToForumListFromCreate.addEventListener('click', function () {
                                showView(forumListingView);
                            });
                        }

                        // Click vào thẻ chủ đề để xem chi tiết
                        topicCards.forEach(card => {
                            card.addEventListener('click', function (event) {
                                // Ngăn chặn sự kiện click của nút yêu thích lan truyền ra thẻ cha
                                if (event.target.closest('.favorite-button')) {
                                    return;
                                }
                                // Đánh dấu đã đọc khi click (chỉ thay đổi giao diện)
                                this.classList.remove('unread');
                                this.classList.add('read');

                                // Hiển thị view chi tiết chủ đề
                                showView(topicDetailView);

                                // Tùy chỉnh: Cập nhật nội dung chi tiết nếu bạn có nhiều chủ đề tĩnh
                                // Đối với bản tĩnh mẫu này, chúng ta chỉ hiển thị một chủ đề mẫu duy nhất.
                                // Nếu muốn hiển thị nhiều chủ đề tĩnh khác nhau, bạn cần tạo các div detailTopicView
                                // riêng cho từng chủ đề hoặc dùng JavaScript để thay đổi nội dung detailTopicView
                                // dựa trên data-topic-id của thẻ được click.
                                // Ví dụ (cho bản tĩnh phức tạp hơn):
                                // const topicId = this.dataset.topicId;
                                // const topicData = getStaticTopicData(topicId); // Hàm giả định trả về dữ liệu của chủ đề
                                // if (topicData) {
                                //     document.getElementById('detailTopicTitle').textContent = topicData.title;
                                //     document.getElementById('detailTopicAuthor').textContent = `Tác giả: ${topicData.author}`;
                                //     // ... cập nhật các phần khác
                                // }
                            });
                        });

                        // Nút "Quay lại diễn đàn" từ chi tiết chủ đề
                        if (backToForumListFromDetail) {
                            backToForumListFromDetail.addEventListener('click', function () {
                                showView(forumListingView);
                            });
                        }

                        // Chức năng đánh dấu quan trọng (favorite)
                        favoriteButtons.forEach(button => {
                            button.addEventListener('click', function (event) {
                                event.preventDefault(); // Ngăn chặn thẻ <a> cha chuyển hướng
                                event.stopPropagation(); // Ngăn chặn sự kiện click lan truyền lên thẻ <a> cha (topic-card)
                                const icon = this.querySelector('i');
                                if (icon.classList.contains('ri-star-line')) {
                                    icon.classList.remove('ri-star-line');
                                    icon.classList.add('ri-star-fill');
                                    this.classList.remove('text-gray-400', 'hover:text-yellow-500');
                                    this.classList.add('text-yellow-500', 'hover:text-yellow-600');
                                } else {
                                    icon.classList.remove('ri-star-fill');
                                    icon.classList.add('ri-star-line');
                                    this.classList.remove('text-yellow-500', 'hover:text-yellow-600');
                                    this.classList.add('text-gray-400', 'hover:text-yellow-500');
                                }
                                console.log('Đánh dấu quan trọng clicked cho topic ID:', this.dataset.topicId);
                            });
                        });

                        // Pagination buttons (placeholder actions)
                        const paginationButtons = document.querySelectorAll('.flex.items-center.space-x-2 button');
                        paginationButtons.forEach(button => {
                            button.addEventListener('click', function () {
                                if (!this.disabled) {
                                    console.log('Pagination button clicked:', this.textContent.trim());
                                    // In a real app, this would trigger data loading for the selected page
                                }
                            });
                        });

                        // Cập nhật số lượng bình luận cho view chi tiết
                        const detailCommentsList = document.getElementById('detailCommentsList');
                        const detailCommentCountSpan = document.getElementById('detailCommentCount');
                        if (detailCommentsList && detailCommentCountSpan) {
                            const comments = detailCommentsList.querySelectorAll('.border-b');
                            detailCommentCountSpan.textContent = comments.length;
                        }
                    });
                </script>
                </body>
                </html>