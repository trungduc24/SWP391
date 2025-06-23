<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Grades Management - Student Portal</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }

        .container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar */
        .sidebar {
            width: 280px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-right: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
            position: relative;
        }

        .sidebar.collapsed {
            width: 70px;
        }

        .sidebar-header {
            padding: 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logo {
            width: 40px;
            height: 40px;
            background: linear-gradient(45deg, #ff6b6b, #feca57);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 18px;
        }

        .logo-text {
            color: white;
            font-size: 20px;
            font-weight: 700;
            transition: opacity 0.3s ease;
        }

        .sidebar.collapsed .logo-text {
            opacity: 0;
        }

        .nav-menu {
            padding: 20px 0;
        }

        .nav-item {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: all 0.3s ease;
            position: relative;
        }

        .nav-item:hover, .nav-item.active {
            background: rgba(255, 255, 255, 0.1);
            color: white;
        }

        .nav-item.active::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 4px;
            background: #feca57;
        }

        .nav-item i {
            width: 20px;
            margin-right: 15px;
            text-align: center;
        }

        .sidebar.collapsed .nav-item span {
            display: none;
        }

        .toggle-btn {
            position: absolute;
            top: 20px;
            right: -15px;
            width: 30px;
            height: 30px;
            background: rgba(255, 255, 255, 0.2);
            border: none;
            border-radius: 50%;
            color: white;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }

        .toggle-btn:hover {
            background: rgba(255, 255, 255, 0.3);
        }

        /* Main Content */
        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        /* Header */
        .header {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .search-bar {
            flex: 1;
            max-width: 400px;
            position: relative;
        }

        .search-bar input {
            width: 100%;
            padding: 12px 20px 12px 45px;
            border: none;
            border-radius: 25px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            font-size: 14px;
        }

        .search-bar input::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .search-bar i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(255, 255, 255, 0.7);
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .notification-icon {
            width: 40px;
            height: 40px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            cursor: pointer;
            position: relative;
            transition: all 0.3s ease;
        }

        .notification-icon:hover {
            background: rgba(255, 255, 255, 0.3);
        }

        .badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #ff6b6b;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            font-size: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            padding: 8px 15px;
            border-radius: 25px;
            transition: all 0.3s ease;
        }

        .user-profile:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        .avatar {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background: linear-gradient(45deg, #ff6b6b, #feca57);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }

        .user-info {
            color: white;
        }

        .user-name {
            font-weight: 600;
            font-size: 14px;
        }

        .user-role {
            font-size: 12px;
            opacity: 0.8;
        }

        /* Content Area */
        .content-area {
            flex: 1;
            padding: 30px;
            overflow-y: auto;
        }

        /* Breadcrumb */
        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
            color: rgba(255, 255, 255, 0.8);
            font-size: 14px;
        }

        .breadcrumb a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .breadcrumb a:hover {
            color: white;
        }

        /* Page Header */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .page-title {
            color: white;
        }

        .page-title h1 {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .page-subtitle {
            font-size: 16px;
            opacity: 0.8;
        }

        .add-btn {
            background: linear-gradient(45deg, #ff6b6b, #feca57);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 25px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
        }

        .add-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }

        /* Filters Section */
        .filters-section {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 30px;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .filters-row {
            display: grid;
            grid-template-columns: 1fr 200px 200px 200px 200px auto;
            gap: 20px;
            align-items: center;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .filter-label {
            color: white;
            font-size: 14px;
            font-weight: 500;
        }

        .filter-input {
            padding: 12px 15px;
            border: none;
            border-radius: 12px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            font-size: 14px;
        }

        .filter-input::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .filter-select {
            padding: 12px 15px;
            border: none;
            border-radius: 12px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            font-size: 14px;
            cursor: pointer;
        }

        .clear-btn {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .clear-btn:hover {
            background: rgba(255, 255, 255, 0.3);
        }

        /* Statistics Cards */
        .stats-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 25px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
        }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .stat-title {
            color: rgba(255, 255, 255, 0.8);
            font-size: 14px;
            font-weight: 500;
        }

        .stat-icon {
            width: 40px;
            height: 40px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 18px;
        }

        .stat-value {
            font-size: 28px;
            font-weight: 700;
            color: white;
            margin-bottom: 5px;
        }

        .stat-trend {
            font-size: 12px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .trend-up {
            color: #4ecdc4;
        }

        .trend-down {
            color: #ff6b6b;
        }

        /* Charts Section */
        .charts-section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 30px;
        }

        .chart-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 25px;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .chart-title {
            color: white;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .chart-container {
            height: 300px;
            position: relative;
        }

        /* Data Table */
        .table-section {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 25px;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .table-title {
            color: white;
            font-size: 20px;
            font-weight: 600;
        }

        .table-actions {
            display: flex;
            gap: 10px;
        }

        .table-container {
            overflow-x: auto;
            border-radius: 12px;
            background: rgba(255, 255, 255, 0.05);
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table th {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .data-table td {
            padding: 15px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            color: rgba(255, 255, 255, 0.9);
        }

        .data-table tr:hover {
            background: rgba(255, 255, 255, 0.05);
        }

        .status-badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-submitted {
            background: rgba(78, 205, 196, 0.2);
            color: #4ecdc4;
        }

        .status-graded {
            background: rgba(254, 202, 87, 0.2);
            color: #feca57;
        }

        .status-pending {
            background: rgba(255, 107, 107, 0.2);
            color: #ff6b6b;
        }

        .action-btn {
            background: none;
            border: none;
            color: rgba(255, 255, 255, 0.7);
            cursor: pointer;
            padding: 5px;
            margin: 0 2px;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .action-btn:hover {
            background: rgba(255, 255, 255, 0.1);
            color: white;
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        .pagination-info {
            color: rgba(255, 255, 255, 0.8);
            font-size: 14px;
        }

        .pagination-controls {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .page-btn {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .page-btn:hover {
            background: rgba(255, 255, 255, 0.2);
        }

        .page-btn.active {
            background: linear-gradient(45deg, #ff6b6b, #feca57);
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(10px);
            z-index: 1000;
        }

        .modal.show {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 30px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            max-width: 500px;
            width: 90%;
            color: white;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .modal-title {
            font-size: 20px;
            font-weight: 600;
        }

        .close-btn {
            background: none;
            border: none;
            color: white;
            font-size: 24px;
            cursor: pointer;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .form-input {
            width: 100%;
            padding: 12px 15px;
            border: none;
            border-radius: 12px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            font-size: 14px;
        }

        .form-input::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .modal-actions {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            margin-top: 20px;
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.3);
        }

        .btn-primary {
            background: linear-gradient(45deg, #ff6b6b, #feca57);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .charts-section {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                position: fixed;
                left: -280px;
                z-index: 100;
            }

            .sidebar.show {
                left: 0;
            }

            .main-content {
                margin-left: 0;
            }

            .filters-row {
                grid-template-columns: 1fr;
            }

            .stats-section {
                grid-template-columns: 1fr;
            }

            .header {
                padding: 15px 20px;
            }

            .content-area {
                padding: 20px;
            }

            .table-container {
                font-size: 14px;
            }

            .data-table th,
            .data-table td {
                padding: 10px 8px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar" id="sidebar">
            <button class="toggle-btn" onclick="toggleSidebar()">
                <i class="fas fa-chevron-left"></i>
            </button>
            
            <div class="sidebar-header">
                <div class="logo">
                    <i class="fas fa-graduation-cap"></i>
                </div>
                <div class="logo-text">EduPortal</div>
            </div>
            
            <nav class="nav-menu">
                <a href="#" class="nav-item">
                    <i class="fas fa-home"></i>
                    <span>Dashboard</span>
                </a>
                <a href="#" class="nav-item">
                    <i class="fas fa-users"></i>
                    <span>Students</span>
                </a>
                <a href="#" class="nav-item">
                    <i class="fas fa-book"></i>
                    <span>Courses</span>
                </a>
                <a href="#" class="nav-item active">
                    <i class="fas fa-chart-line"></i>
                    <span>Grades</span>
                </a>
                <a href="#" class="nav-item">
                    <i class="fas fa-calendar"></i>
                    <span>Schedule</span>
                </a>
                <a href="#" class="nav-item">
                    <i class="fas fa-file-alt"></i>
                    <span>Assignments</span>
                </a>
                <a href="#" class="nav-item">
                    <i class="fas fa-cog"></i>
                    <span>Settings</span>
                </a>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Header -->
            <header class="header">
                <div class="search-bar">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search students, courses, grades...">
                </div>
                
                <div class="header-actions">
                    <div class="notification-icon">
                        <i class="fas fa-bell"></i>
                        <span class="badge">3</span>
                    </div>
                    <div class="notification-icon">
                        <i class="fas fa-envelope"></i>
                        <span class="badge">7</span>
                    </div>
                    <div class="user-profile" onclick="toggleUserMenu()">
                        <div class="avatar">JD</div>
                        <div class="user-info">
                            <div class="user-name">John Doe</div>
                            <div class="user-role">Teacher</div>
                        </div>
                        <i class="fas fa-chevron-down"></i>
                    </div>
                </div>
            </header>

            <!-- Content Area -->
            <div class="content-area">
                <!-- Breadcrumb -->
                <nav class="breadcrumb">
                    <a href="#">Dashboard</a>
                    <i class="fas fa-chevron-right"></i>
                    <span>Grades Management</span>
                </nav>

                <!-- Page Header -->
                <div class="page-header">
                    <div class="page-title">
                        <h1>Grades Management</h1>
                        <p class="page-subtitle">Manage and track student grades across all courses</p>
                    </div>
                    <button class="add-btn" onclick="showAddGradeModal()">
                        <i class="fas fa-plus"></i>
                        Add New Grade
                    </button>
                </div>

                <!-- Filters Section -->
                <div class="filters-section">
                    <div class="filters-row">
                        <div class="filter-group">
                            <label class="filter-label">Search Grades</label>
                            <input type="text" class="filter-input" placeholder="Search by student name or course...">
                        </div>
                        <div class="filter-group">
                            <label class="filter-label">Course</label>
                            <select class="filter-select">
                                <option>All Courses</option>
                                <option>Mathematics</option>
                                <option>Physics</option>
                                <option>Chemistry</option>
                                <option>Biology</option>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label class="filter-label">Semester</label>
                            <select class="filter-select">
                                <option>Current Semester</option>
                                <option>Fall 2024</option>
                                <option>Spring 2024</option>
                                <option>Summer 2024</option>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label class="filter-label">Grade Range</label>
                            <select class="filter-select">
                                <option>All Grades</option>
                                <option>A (90-100)</option>
                                <option>B (80-89)</option>
                                <option>C (70-79)</option>
                                <option>D (60-69)</option>
                                <option>F (Below 60)</option>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label class="filter-label">Sort By</label>
                            <select class="filter-select">
                                <option>Recent First</option>
                                <option>Grade (High to Low)</option>
                                <option>Grade (Low to High)</option>
                                <option>Student Name</option>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label class="filter-label">&nbsp;</label>
                            <button class="clear-btn">Clear Filters</button>
                        </div>
                    </div>
                </div>

                <!-- Statistics Cards -->
                <div class="stats-section">
                    <div class="stat-card">
                        <div class="stat-header">
                            <span class="stat-title">Class Average</span>
                            <div class="stat-icon" style="background: linear-gradient(45deg, #4ecdc4, #44a08d);">
                                <i class="fas fa-chart-bar"></i>
                            </div>
                        </div>
                        <div class="stat-value">85.2</div>
                        <div class="stat-trend trend-up">
                            <i class="fas fa-arrow-up"></i>
                            +2.3% from last week
                        </div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-header">
                            <span class="stat-title">Highest Grade</span>
                            <div class="stat-icon" style="background: linear-gradient(45deg, #feca57, #ff9ff3);">
                                <i class="fas fa-trophy"></i>
                            </div>
                        </div>
                        <div class="stat-value">98</div>
                        <div class="stat-trend trend-up">
                            <i class="fas fa-star"></i>
                            Excellent performance
                        </div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-header">
                            <span class="stat-title">Lowest Grade</span>
                            <div class="stat-icon" style="background: linear-gradient(45deg, #ff6b6b, #ffa726);">
                                <i class="fas fa-exclamation-triangle"></i>
                            </div>
                        </div>
                        <div class="stat-value">42</div>
                        <div class="stat-trend trend-down">
                            <i class="fas fa-arrow-down"></i>
                            Needs attention
                        </div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-header">
                            <span class="stat-title">Total Grades</span>
                            <div class="stat-icon" style="background: linear-gradient(45deg, #a8edea, #fed6e3);">
                                <i class="fas fa-list-alt"></i>
                            </div>
                        </div>
                        <div class="stat-value">847</div>
                        <div class="stat-trend trend-up">
                            <i class="fas fa-plus"></i>
                            12 new this week
                        </div>
                    </div>
                </div>

                <!-- Charts Section -->
                <div class="charts-section">
                    <div class="chart-card">
                        <h3 class="chart-title">Grade Distribution</h3>
                        <div class="chart-container">
                            <canvas id="gradeDistributionChart"></canvas>
                        </div>
                    </div>
                    
                    <div class="chart-card">
                        <h3 class="chart-title">Performance Trend</h3>
                        <div class="chart-container">
                            <canvas id="performanceTrendChart"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Data Table Section -->
                <div class="table-section">
                    <div class="table-header">
                        <h3 class="table-title">Student Grades</h3>
                        <div class="table-actions">
                            <button class="btn-secondary">
                                <i class="fas fa-download"></i>
                                Export
                            </button>
                            <button class="btn-secondary">
                                <i class="fas fa-print"></i>
                                Print
                            </button>
                        </div>
                    </div>
                    
                    <div class="table-container">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>
                                        <input type="checkbox" id="selectAll">
                                    </th>
                                    <th>Student Name <i class="fas fa-sort"></i></th>
                                    <th>Course <i class="fas fa-sort"></i></th>
                                    <th>Assignment/Test <i class="fas fa-sort"></i></th>
                                    <th>Grade <i class="fas fa-sort"></i></th>
                                    <th>Submission Date <i class="fas fa-sort"></i></th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><input type="checkbox"></td>
                                    <td>Alice Johnson</td>
                                    <td>Mathematics</td>
                                    <td>Midterm Exam</td>
                                    <td><strong>95</strong></td>
                                    <td>2024-05-15</td>
                                    <td><span class="status-badge status-graded">Graded</span></td>
                                    <td>
                                        <button class="action-btn" onclick="viewGradeDetails()" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="action-btn" onclick="editGrade()" title="Edit Grade">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="action-btn" onclick="deleteGrade()" title="Delete Grade">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox"></td>
                                    <td>Bob Smith</td>
                                    <td>Physics</td>
                                    <td>Lab Report #3</td>
                                    <td><strong>88</strong></td>
                                    <td>2024-05-14</td>
                                    <td><span class="status-badge status-graded">Graded</span></td>
                                    <td>
                                        <button class="action-btn" onclick="viewGradeDetails()" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="action-btn" onclick="editGrade()" title="Edit Grade">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="action-btn" onclick="deleteGrade()" title="Delete Grade">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox"></td>
                                    <td>Carol Davis</td>
                                    <td>Chemistry</td>
                                    <td>Quiz #5</td>
                                    <td><strong>92</strong></td>
                                    <td>2024-05-13</td>
                                    <td><span class="status-badge status-graded">Graded</span></td>
                                    <td>
                                        <button class="action-btn" onclick="viewGradeDetails()" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="action-btn" onclick="editGrade()" title="Edit Grade">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="action-btn" onclick="deleteGrade()" title="Delete Grade">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox"></td>
                                    <td>David Wilson</td>
                                    <td>Biology</td>
                                    <td>Assignment #2</td>
                                    <td><strong>-</strong></td>
                                    <td>2024-05-16</td>
                                    <td><span class="status-badge status-submitted">Submitted</span></td>
                                    <td>
                                        <button class="action-btn" onclick="viewGradeDetails()" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="action-btn" onclick="editGrade()" title="Edit Grade">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="action-btn" onclick="deleteGrade()" title="Delete Grade">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox"></td>
                                    <td>Eva Martinez</td>
                                    <td>Mathematics</td>
                                    <td>Homework #8</td>
                                    <td><strong>76</strong></td>
                                    <td>2024-05-12</td>
                                    <td><span class="status-badge status-graded">Graded</span></td>
                                    <td>
                                        <button class="action-btn" onclick="viewGradeDetails()" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="action-btn" onclick="editGrade()" title="Edit Grade">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="action-btn" onclick="deleteGrade()" title="Delete Grade">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox"></td>
                                    <td>Frank Brown</td>
                                    <td>Physics</td>
                                    <td>Final Project</td>
                                    <td><strong>-</strong></td>
                                    <td>2024-05-18</td>
                                    <td><span class="status-badge status-pending">Pending</span></td>
                                    <td>
                                        <button class="action-btn" onclick="viewGradeDetails()" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="action-btn" onclick="editGrade()" title="Edit Grade">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="action-btn" onclick="deleteGrade()" title="Delete Grade">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox"></td>
                                    <td>Grace Lee</td>
                                    <td>Chemistry</td>
                                    <td>Midterm Exam</td>
                                    <td><strong>89</strong></td>
                                    <td>2024-05-11</td>
                                    <td><span class="status-badge status-graded">Graded</span></td>
                                    <td>
                                        <button class="action-btn" onclick="viewGradeDetails()" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="action-btn" onclick="editGrade()" title="Edit Grade">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="action-btn" onclick="deleteGrade()" title="Delete Grade">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox"></td>
                                    <td>Henry Taylor</td>
                                    <td>Biology</td>
                                    <td>Lab Practical</td>
                                    <td><strong>84</strong></td>
                                    <td>2024-05-10</td>
                                    <td><span class="status-badge status-graded">Graded</span></td>
                                    <td>
                                        <button class="action-btn" onclick="viewGradeDetails()" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="action-btn" onclick="editGrade()" title="Edit Grade">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="action-btn" onclick="deleteGrade()" title="Delete Grade">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- Pagination -->
                    <div class="pagination">
                        <div class="pagination-info">
                            Showing 1-8 of 847 grades
                        </div>
                        <div class="pagination-controls">
                            <select class="filter-select" style="margin-right: 20px;">
                                <option>10 per page</option>
                                <option>25 per page</option>
                                <option>50 per page</option>
                                <option>100 per page</option>
                            </select>
                            <button class="page-btn">
                                <i class="fas fa-chevron-left"></i>
                            </button>
                            <button class="page-btn active">1</button>
                            <button class="page-btn">2</button>
                            <button class="page-btn">3</button>
                            <button class="page-btn">...</button>
                            <button class="page-btn">85</button>
                            <button class="page-btn">
                                <i class="fas fa-chevron-right"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Add/Edit Grade Modal -->
    <div class="modal" id="addGradeModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Add New Grade</h3>
                <button class="close-btn" onclick="closeModal('addGradeModal')">&times;</button>
            </div>
            
            <form>
                <div class="form-group">
                    <label class="form-label">Student</label>
                    <select class="form-input">
                        <option>Select Student</option>
                        <option>Alice Johnson</option>
                        <option>Bob Smith</option>
                        <option>Carol Davis</option>
                        <option>David Wilson</option>
                        <option>Eva Martinez</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Course</label>
                    <select class="form-input"  style="background-color: #5a5e70">
                        <option>Select Course</option>
                        <option>Mathematics</option>
                        <option>Physics</option>
                        <option>Chemistry</option>
                        <option>Biology</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Assignment/Test</label>
                    <input type="text" class="form-input" placeholder="Enter assignment or test name">
                </div>
                
                <div class="form-group">
                    <label class="form-label">Grade</label>
                    <input type="number" class="form-input" placeholder="Enter grade (0-100)" min="0" max="100">
                </div>
                
                <div class="form-group">
                    <label class="form-label">Submission Date</label>
                    <input type="date" class="form-input">
                </div>
                
                <div class="form-group">
                    <label class="form-label">Comments</label>
                    <textarea class="form-input" rows="4" placeholder="Enter additional comments..."></textarea>
                </div>
            </form>
            
            <div class="modal-actions">
                <button class="btn-secondary" onclick="closeModal('addGradeModal')">Cancel</button>
                <button class="btn-primary">Save Grade</button>
            </div>
        </div>
    </div>

    <!-- Grade Details Modal -->
    <div class="modal" id="gradeDetailsModal">
        <div class="modal-content" style="max-width: 600px;">
            <div class="modal-header">
                <h3 class="modal-title">Grade Details</h3>
                <button class="close-btn" onclick="closeModal('gradeDetailsModal')">&times;</button>
            </div>
            
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px;">
                <div>
                    <strong>Student:</strong> Alice Johnson<br>
                    <strong>Course:</strong> Mathematics<br>
                    <strong>Assignment:</strong> Midterm Exam<br>
                    <strong>Grade:</strong> 95/100
                </div>
                <div>
                    <strong>Submission Date:</strong> May 15, 2024<br>
                    <strong>Graded Date:</strong> May 16, 2024<br>
                    <strong>Status:</strong> <span class="status-badge status-graded">Graded</span>
                </div>
            </div>
            
            <div class="form-group">
                <label class="form-label">Teacher Comments</label>
                <div style="background: rgba(255, 255, 255, 0.1); padding: 15px; border-radius: 12px;">
                    Excellent work! Shows strong understanding of algebraic concepts. Minor arithmetic error in question 7, but overall exceptional performance.
                </div>
            </div>
            
            <div class="form-group">
                <label class="form-label">Performance History</label>
                <div style="background: rgba(255, 255, 255, 0.1); padding: 15px; border-radius: 12px;">
                    <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                        <span>Quiz #1</span>
                        <span><strong>92</strong></span>
                    </div>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                        <span>Homework #1-5</span>
                        <span><strong>88</strong></span>
                    </div>
                    <div style="display: flex; justify-content: space-between;">
                        <span>Midterm Exam</span>
                        <span><strong>95</strong></span>
                    </div>
                </div>
            </div>
            
            <div class="modal-actions">
                <button class="btn-secondary" onclick="closeModal('gradeDetailsModal')">Close</button>
                <button class="btn-primary">Edit Grade</button>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal" id="deleteModal">
        <div class="modal-content" style="max-width: 400px;">
            <div class="modal-header">
                <h3 class="modal-title">Confirm Delete</h3>
                <button class="close-btn" onclick="closeModal('deleteModal')">&times;</button>
            </div>
            
            <p style="margin-bottom: 20px;">Are you sure you want to delete this grade? This action cannot be undone.</p>
            
            <div class="modal-actions">
                <button class="btn-secondary" onclick="closeModal('deleteModal')">Cancel</button>
                <button class="btn-primary" style="background: linear-gradient(45deg, #ff6b6b, #ff8e8e);">Delete</button>
            </div>
        </div>
    </div>

    <script>
        // Global variables for charts
        let gradeDistributionChart;
        let performanceTrendChart;

        // Initialize charts when page loads
        document.addEventListener('DOMContentLoaded', function() {
            initializeCharts();
            setupEventListeners();
        });

        // Toggle sidebar
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const toggleBtn = document.querySelector('.toggle-btn i');
            
            sidebar.classList.toggle('collapsed');
            
            if (sidebar.classList.contains('collapsed')) {
                toggleBtn.className = 'fas fa-chevron-right';
            } else {
                toggleBtn.className = 'fas fa-chevron-left';
            }
        }

        // Initialize charts
        function initializeCharts() {
            // Grade Distribution Chart
            const gradeDistCtx = document.getElementById('gradeDistributionChart').getContext('2d');
            gradeDistributionChart = new Chart(gradeDistCtx, {
                type: 'doughnut',
                data: {
                    labels: ['A (90-100)', 'B (80-89)', 'C (70-79)', 'D (60-69)', 'F (0-59)'],
                    datasets: [{
                        data: [245, 312, 156, 89, 45],
                        backgroundColor: [
                            'rgba(78, 205, 196, 0.8)',
                            'rgba(254, 202, 87, 0.8)',
                            'rgba(255, 154, 162, 0.8)',
                            'rgba(255, 183, 77, 0.8)',
                            'rgba(255, 107, 107, 0.8)'
                        ],
                        borderColor: [
                            'rgba(78, 205, 196, 1)',
                            'rgba(254, 202, 87, 1)',
                            'rgba(255, 154, 162, 1)',
                            'rgba(255, 183, 77, 1)',
                            'rgba(255, 107, 107, 1)'
                        ],
                        borderWidth: 2
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: {
                                color: 'rgba(255, 255, 255, 0.8)',
                                padding: 20,
                                usePointStyle: true
                            }
                        }
                    }
                }
            });

            // Performance Trend Chart
            const perfTrendCtx = document.getElementById('performanceTrendChart').getContext('2d');
            performanceTrendChart = new Chart(perfTrendCtx, {
                type: 'line',
                data: {
                    labels: ['Week 1', 'Week 2', 'Week 3', 'Week 4', 'Week 5', 'Week 6', 'Week 7', 'Week 8'],
                    datasets: [{
                        label: 'Class Average',
                        data: [82, 84, 83, 85, 87, 86, 88, 85],
                        borderColor: 'rgba(78, 205, 196, 1)',
                        backgroundColor: 'rgba(78, 205, 196, 0.1)',
                        borderWidth: 3,
                        fill: true,
                        tension: 0.4,
                        pointBackgroundColor: 'rgba(78, 205, 196, 1)',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 6
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        x: {
                            grid: {
                                color: 'rgba(255, 255, 255, 0.1)'
                            },
                            ticks: {
                                color: 'rgba(255, 255, 255, 0.8)'
                            }
                        },
                        y: {
                            grid: {
                                color: 'rgba(255, 255, 255, 0.1)'
                            },
                            ticks: {
                                color: 'rgba(255, 255, 255, 0.8)'
                            },
                            min: 70,
                            max: 95
                        }
                    }
                }
            });
        }

        // Setup event listeners
        function setupEventListeners() {
            // Select all checkbox functionality
            document.getElementById('selectAll').addEventListener('change', function() {
                const checkboxes = document.querySelectorAll('tbody input[type="checkbox"]');
                checkboxes.forEach(checkbox => {
                    checkbox.checked = this.checked;
                });
            });

            // Mobile sidebar toggle
            if (window.innerWidth <= 768) {
                document.addEventListener('click', function(e) {
                    const sidebar = document.getElementById('sidebar');
                    if (!sidebar.contains(e.target) && !e.target.closest('.toggle-btn')) {
                        sidebar.classList.remove('show');
                    }
                });
            }
        }

        // Modal functions
        function showAddGradeModal() {
            document.getElementById('addGradeModal').classList.add('show');
            document.querySelector('#addGradeModal .modal-title').textContent = 'Add New Grade';
        }

        function editGrade() {
            document.getElementById('addGradeModal').classList.add('show');
            document.querySelector('#addGradeModal .modal-title').textContent = 'Edit Grade';
            
            // Pre-fill form with existing data (example)
            // In a real application, you would fetch this data from your backend
        }

        function viewGradeDetails() {
            document.getElementById('gradeDetailsModal').classList.add('show');
        }

        function deleteGrade() {
            document.getElementById('deleteModal').classList.add('show');
        }

        function closeModal(modalId) {
            document.getElementById(modalId).classList.remove('show');
        }

        function toggleUserMenu() {
            // User menu toggle functionality
            // In a real application, this would show/hide a dropdown menu
            alert('User menu functionality would be implemented here');
        }

        // Close modals when clicking outside
        document.addEventListener('click', function(e) {
            if (e.target.classList.contains('modal')) {
                e.target.classList.remove('show');
            }
        });

        // Handle window resize for responsive design
        window.addEventListener('resize', function() {
            const sidebar = document.getElementById('sidebar');
            if (window.innerWidth <= 768) {
                sidebar.classList.remove('collapsed');
                sidebar.classList.remove('show');
            } else {
                sidebar.classList.remove('show');
            }
        });

        // Add mobile sidebar toggle for small screens
        if (window.innerWidth <= 768) {
            const mobileToggle = document.createElement('button');
            mobileToggle.innerHTML = '<i class="fas fa-bars"></i>';
            mobileToggle.className = 'mobile-toggle';
            mobileToggle.style.cssText = `
                position: fixed;
                top: 20px;
                left: 20px;
                z-index: 1001;
                background: rgba(255, 255, 255, 0.2);
                border: none;
                border-radius: 8px;
                color: white;
                width: 40px;
                height: 40px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
            `;
            
            mobileToggle.addEventListener('click', function() {
                document.getElementById('sidebar').classList.toggle('show');
            });
            
            document.body.appendChild(mobileToggle);
        }
    </script>
</body>
</html>
                        