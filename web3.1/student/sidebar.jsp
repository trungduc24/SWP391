<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="model.User" %>
<%@ page import="dao.NotificationDAO" %>
<%
    // Lấy thông tin người dùng từ session
    User user = (User) session.getAttribute("user");
    
    // Fallback values
    String userName = "Sinh viên";
    String userCode = "N/A";
    int unreadNotificationCount = 0;
    
    if (user != null) {
        userName = user.getFullName() != null ? user.getFullName() : user.getUsername();
        userCode = user.getUsername();
        
        // Lấy số lượng thông báo chưa đọc
        NotificationDAO notificationDAO = new NotificationDAO();
        unreadNotificationCount = notificationDAO.getUnreadNotificationCount(user.getUserId());
    }
    
    // Lấy thông tin trang hiện tại để highlight menu
    String currentPage = request.getRequestURI();
    String pageName = currentPage.substring(currentPage.lastIndexOf("/") + 1);
    if (pageName.indexOf("?") != -1) {
        pageName = pageName.substring(0, pageName.indexOf("?"));
    }
%>

<aside class="fixed inset-y-0 left-0 z-50 w-64 bg-white border-r border-gray-200 shadow-lg hidden md:flex flex-col">
    <div class="flex items-center px-6 py-3 border-b border-gray-200">
        <div class="text-2xl font-['Pacifico'] text-primary">logo</div>
    </div>
    <nav class="p-4 space-y-1 flex-1">
        <a href="dashboard" class="w-full px-3 py-2 text-sm font-medium <%= pageName.equals("dashboard.jsp") ? "text-primary bg-primary/5" : "text-gray-700 hover:bg-gray-50" %> rounded-button block">
            <div class="flex items-center">
                <div class="w-5 h-5 flex items-center justify-center mr-3">
                    <i class="ri-dashboard-line"></i>
                </div>
                <span>Dashboard</span>
            </div>
        </a>
        <a href="courses" class="w-full px-3 py-2 text-sm font-medium <%= currentPage.contains("courses") ? "text-primary bg-primary/5" : "text-gray-700 hover:bg-gray-50" %> rounded-button block">
            <div class="flex items-center">
                <div class="w-5 h-5 flex items-center justify-center mr-3">
                    <i class="ri-book-open-line"></i>
                </div>
                <span>Khóa học</span>
            </div>
        </a>
        <a href="assignments" class="w-full px-3 py-2 text-sm font-medium <%= pageName.equals("assignments.jsp") || pageName.equals("assignment-submit.jsp") ? "text-primary bg-primary/5" : "text-gray-700 hover:bg-gray-50" %> rounded-button block">
            <div class="flex items-center">
                <div class="w-5 h-5 flex items-center justify-center mr-3">
                    <i class="ri-file-list-line"></i>
                </div>
                <span>Bài tập</span>
            </div>
        </a>
        <!-- Thêm option "Kết quả bài kiểm tra" vào sidebar -->
        <a href="<%=request.getContextPath()%>/student/test-results" class="w-full px-3 py-2 text-sm font-medium <%= currentPage.contains("test-results") ? "text-primary bg-primary/5" : "text-gray-700 hover:bg-gray-50" %> rounded-button block">
            <div class="flex items-center">
                <div class="w-5 h-5 flex items-center justify-center mr-3">
                    <i class="ri-file-list-line"></i>
                </div>
                <span>Kết quả bài kiểm tra</span>
            </div>
        </a>
        <!-- Thêm option "Thông báo" vào sidebar -->
        <a href="<%=request.getContextPath()%>/student/notifications" class="w-full px-3 py-2 text-sm font-medium <%= currentPage.contains("notifications") ? "text-primary bg-primary/5" : "text-gray-700 hover:bg-gray-50" %> rounded-button block relative">
            <div class="flex items-center">
                <div class="w-5 h-5 flex items-center justify-center mr-3">
                    <i class="ri-notification-line"></i>
                </div>
                <span>Thông báo</span>
                <% if (unreadNotificationCount > 0) { %>
                <span class="ml-auto bg-red-500 text-white text-xs rounded-full px-2 py-1 min-w-[20px] text-center">
                    <%= unreadNotificationCount > 99 ? "99+" : unreadNotificationCount %>
                </span>
                <% } %>
            </div>
        </a>

        <a href="documents" class="w-full px-3 py-2 text-sm font-medium <%= pageName.equals("documents.jsp") ? "text-primary bg-primary/5" : "text-gray-700 hover:bg-gray-50" %> rounded-button block">
            <div class="flex items-center">
                <div class="w-5 h-5 flex items-center justify-center mr-3">
                    <i class="ri-file-text-line"></i>
                </div>
                <span>Tài Liệu</span>
            </div>
        </a>
        <a href="settings.jsp" class="w-full px-3 py-2 text-sm font-medium <%= pageName.equals("settings.jsp") ? "text-primary bg-primary/5" : "text-gray-700 hover:bg-gray-50" %> rounded-button block">
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
                <p class="text-sm font-medium text-gray-800"><%= userName %></p>
                <p class="text-xs text-gray-500"><%= userCode %></p>
            </div>
        </div>
        <a href="<%= request.getContextPath() %>/logout" class="w-full flex items-center justify-center gap-2 px-3 py-2 text-sm font-medium text-red-600 hover:bg-red-50 rounded-button">
            <div class="w-5 h-5 flex items-center justify-center">
                <i class="ri-logout-box-line"></i>
            </div>
            <span>Đăng xuất</span>
        </a>
    </div>
</aside>