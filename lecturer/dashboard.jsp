<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard Giáo Viên - Hệ Thống LMS</title>
        <script src="https://cdn.tailwindcss.com/3.4.16"></script>
        <script>tailwind.config = {theme: {extend: {colors: {primary: '#4f46e5', secondary: '#6366f1'}, borderRadius: {'none': '0px', 'sm': '4px', DEFAULT: '8px', 'md': '12px', 'lg': '16px', 'xl': '20px', '2xl': '24px', '3xl': '32px', 'full': '9999px', 'button': '8px'}}}}</script>
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
            .echarts-tooltip {
                border-radius: 0.5rem !important;
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06) !important;
                padding: 0.75rem 1rem !important;
                border: none !important;
            }
            .echarts-tooltip h4 {
                font-weight: 600 !important;
                color: #111827 !important;
                margin-bottom: 0.25rem !important;
            }
            .echarts-tooltip-marker {
                width: 10px !important;
                height: 10px !important;
                border-radius: 50% !important;
                margin-right: 0.5rem !important;
                display: inline-block !important;
            }
            .echarts-tooltip p {
                font-size: 0.875rem !important; /* text-sm */
                color: #4b5563 !important; /* text-gray-700 */
                line-height: 1.5 !important;
            }
        </style>
    </head>
    <body class="min-h-screen flex">
        <aside class="fixed top-0 left-0 h-screen w-64 bg-white border-r border-gray-200 z-50 hidden lg:flex flex-col justify-between">
            <div class="flex items-center px-6 py-3 border-b border-gray-200">
                <div class="text-2xl font-['Pacifico'] text-primary">logo</div>
            </div>
            <nav class="p-4 space-y-1 flex-1">
                <a href="dashboard.jsp" class="w-full px-3 py-2 text-sm font-medium text-primary bg-primary/5 rounded-button">
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
                            <i class="ri-file-list-line"></i>
                        </div>
                        <span>Bài tập</span>
                    </div>
                </a>
                <a href="grades.jsp" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button">
                    <div class="flex items-center">
                        <div class="w-5 h-5 flex items-center justify-center mr-3">
                            <i class="ri-bar-chart-line"></i>
                        </div>
                        <span>Điểm số</span>
                    </div>
                </a>
                <a href="forum.jsp" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button">
                    <div class="flex items-center">
                        <div class="w-5 h-5 flex items-center justify-center mr-3">
                            <i class="ri-discuss-line"></i>
                        </div>
                        <span>Diễn đàn</span>
                    </div>
                </a>
                <a href="materials.jsp" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button">
                    <div class="flex items-center">
                        <div class="w-5 h-5 flex items-center justify-center mr-3">
                            <i class="ri-folder-line"></i>
                        </div>
                        <span>Tài liệu</span>
                    </div>
                </a>
                <a href="settings.jsp" class="w-full px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-button">
                    <div class="flex items-center">
                        <div class="w-5 h-5 flex items-center justify-center mr-3">
                            <i class="ri-settings-3-line"></i>
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

        <header class="bg-white shadow-sm fixed top-0 left-0 right-0 z-50 lg:ml-64">
            <div class="flex items-center justify-between px-6 py-3">
                <div class="flex items-center">
                    <button class="p-2 text-gray-600 hover:text-primary rounded-full lg:hidden">
                        <div class="w-6 h-6 flex items-center justify-center">
                            <i class="ri-menu-line"></i>
                        </div>
                    </button>
                    <div class="text-2xl font-['Pacifico'] text-primary ml-2 lg:hidden">logo</div>
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
                </div>
            </div>
        </header>

        <main class="flex-1 pt-20 pb-8 px-4 md:px-6 lg:ml-64">
            <div class="max-w-7xl mx-auto">
                <h1 class="text-3xl font-bold text-gray-900 mb-6">Dashboard Giáo Viên</h1>

                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                    <div class="bg-white rounded-lg shadow-sm p-5 border border-gray-100 flex items-center">
                        <div class="p-3 bg-primary/10 text-primary rounded-full mr-4">
                            <i class="ri-book-open-line text-2xl"></i>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">Tổng số khóa học</p>
                            <p class="text-2xl font-bold text-gray-900">12</p>
                        </div>
                    </div>
                    <div class="bg-white rounded-lg shadow-sm p-5 border border-gray-100 flex items-center">
                        <div class="p-3 bg-green-100 text-green-700 rounded-full mr-4">
                            <i class="ri-user-line text-2xl"></i>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">Sinh viên đăng ký</p>
                            <p class="text-2xl font-bold text-gray-900">450</p>
                        </div>
                    </div>
                    <div class="bg-white rounded-lg shadow-sm p-5 border border-gray-100 flex items-center">
                        <div class="p-3 bg-yellow-100 text-yellow-700 rounded-full mr-4">
                            <i class="ri-file-list-line text-2xl"></i>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">Bài tập cần chấm</p>
                            <p class="text-2xl font-bold text-gray-900">18</p>
                        </div>
                    </div>
                    <div class="bg-white rounded-lg shadow-sm p-5 border border-gray-100 flex items-center">
                        <div class="p-3 bg-red-100 text-red-700 rounded-full mr-4">
                            <i class="ri-notification-3-line text-2xl"></i>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">Thông báo mới</p>
                            <p class="text-2xl font-bold text-gray-900">5</p>
                        </div>
                    </div>
                </div>

                <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                    <div class="lg:col-span-2 bg-white rounded-lg shadow-sm border border-gray-100 p-5">
                        <h2 class="text-lg font-semibold text-gray-800 mb-4">Hoạt động sinh viên</h2>
                        <div id="activity-chart" class="h-80 w-full"></div>
                    </div>

                    <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-5">
                        <h2 class="text-lg font-semibold text-gray-800 mb-4">Hoạt động gần đây</h2>
                        <ul class="space-y-4">
                            <li class="flex items-start">
                                <div class="p-2 bg-blue-100 text-blue-700 rounded-full mr-3">
                                    <i class="ri-file-text-line text-lg"></i>
                                </div>
                                <div class="flex-1">
                                    <p class="text-sm font-medium text-gray-900">Sinh viên Nguyễn Văn A đã nộp bài tập "Bài tập 1"</p>
                                    <p class="text-xs text-gray-500">1 giờ trước - CS401</p>
                                </div>
                            </li>
                            <li class="flex items-start">
                                <div class="p-2 bg-green-100 text-green-700 rounded-full mr-3">
                                    <i class="ri-check-circle-line text-lg"></i>
                                </div>
                                <div class="flex-1">
                                    <p class="text-sm font-medium text-gray-900">Bạn đã chấm điểm "Bài tập lớn giữa kỳ" cho 5 sinh viên</p>
                                    <p class="text-xs text-gray-500">3 giờ trước - CS203</p>
                                </div>
                            </li>
                            <li class="flex items-start">
                                <div class="p-2 bg-purple-100 text-purple-700 rounded-full mr-3">
                                    <i class="ri-question-answer-line text-lg"></i>
                                </div>
                                <div class="flex-1">
                                    <p class="text-sm font-medium text-gray-900">Sinh viên Lê Thị B đăng bài mới trên diễn đàn</p>
                                    <p class="text-xs text-gray-500">Hôm qua - Diễn đàn chung</p>
                                </div>
                            </li>
                            <li class="flex items-start">
                                <div class="p-2 bg-orange-100 text-orange-700 rounded-full mr-3">
                                    <i class="ri-add-line text-lg"></i>
                                </div>
                                <div class="flex-1">
                                    <p class="text-sm font-medium text-gray-900">Đã tạo bài tập mới: "Bài tập về nhà tuần 3"</p>
                                    <p class="text-xs text-gray-500">2 ngày trước - CS401</p>
                                </div>
                            </li>
                        </ul>
                        <button class="w-full mt-4 py-2 text-primary border border-primary rounded-button text-sm font-medium hover:bg-primary/5">Xem tất cả</button>
                    </div>
                </div>

                <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-5 mt-6">
                    <h2 class="text-lg font-semibold text-gray-800 mb-4">Bài tập sắp đến hạn</h2>
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tên bài tập</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Khóa học</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Thời hạn nộp</th>
                                    <th scope="col" class="relative px-6 py-3">
                                        <span class="sr-only">Thao tác</span>
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">Bài tập 3 - CSS Flexbox</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">CS401 - Lập trình web nâng cao</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">10/07/2025 23:59</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                        <button class="text-primary hover:text-primary/80">Chi tiết</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">Đồ án cuối kỳ - Cơ sở dữ liệu</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">CS203 - Cơ sở dữ liệu</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">25/07/2025 23:59</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                        <button class="text-primary hover:text-primary/80">Chi tiết</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">Bài tập nhóm - JavaFX</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">CS202 - Lập trình Java</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">01/08/2025 23:59</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                        <button class="text-primary hover:text-primary/80">Chi tiết</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/echarts@5.3.3/dist/echarts.min.js"></script>
        <script>
            // Sidebar mobile toggle
            document.addEventListener('DOMContentLoaded', function() {
                const mobileMenuButton = document.querySelector('header .lg\\:hidden button');
                const sidebar = document.querySelector('aside');

                if (mobileMenuButton && sidebar) {
                    mobileMenuButton.addEventListener('click', function() {
                        sidebar.classList.toggle('hidden');
                        sidebar.classList.toggle('flex');
                    });
                }
            });

            // Echarts for Student Activity
            document.addEventListener('DOMContentLoaded', function () {
                var chartDom = document.getElementById('activity-chart');
                var myChart = echarts.init(chartDom);
                var option;

                option = {
                    tooltip: {
                        trigger: 'axis',
                        formatter: function (params) {
                            let tooltipContent = `<h4 class="font-semibold text-gray-900 mb-1">${params[0].name}</h4>`;
                            params.forEach(function (item) {
                                tooltipContent += `
                                <div class="flex items-center text-sm text-gray-700">
                                    <span class="echarts-tooltip-marker" style="background-color: ${item.color};"></span>
                                    ${item.seriesName}: <span class="font-medium ml-1">${item.value}</span>
                                </div>
                                `;
                            });
                            return tooltipContent;
                        },
                        extraCssText: 'border-radius: 0.5rem; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -1px rgba(0,0,0,0.06); padding: 0.75rem 1rem; border: none;'
                    },
                    legend: {
                        data: ['Tham gia lớp học', 'Nộp bài tập', 'Tương tác diễn đàn'],
                        bottom: '0',
                        textStyle: {
                            color: '#6b7280'
                        }
                    },
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '15%',
                        containLabel: true
                    },
                    xAxis: {
                        type: 'category',
                        boundaryGap: false,
                        data: ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'Chủ nhật'],
                        axisLine: {
                            show: false
                        },
                        axisLabel: {
                            color: '#6b7280'
                        }
                    },
                    yAxis: {
                        type: 'value',
                        axisLine: {
                            show: false
                        },
                        axisLabel: {
                            color: '#6b7280'
                        },
                        splitLine: {
                            lineStyle: {
                                color: '#f3f4f6'
                            }
                        }
                    },
                    series: [
                        {
                            name: 'Tham gia lớp học',
                            type: 'line',
                            smooth: true,
                            symbol: 'none',
                            lineStyle: {
                                width: 3
                            },
                            areaStyle: {
                                opacity: 0.1,
                                color: {
                                    type: 'linear',
                                    x: 0,
                                    y: 0,
                                    x2: 0,
                                    y2: 1,
                                    colorStops: [{
                                            offset: 0, color: 'rgba(87, 181, 231, 0.2)'
                                        }, {
                                            offset: 1, color: 'rgba(87, 181, 231, 0.01)'
                                        }]
                                }
                            },
                            data: [120, 132, 101, 134, 90, 30, 20],
                            color: 'rgba(87, 181, 231, 1)'
                        },
                        {
                            name: 'Nộp bài tập',
                            type: 'line',
                            smooth: true,
                            symbol: 'none',
                            lineStyle: {
                                width: 3
                            },
                            areaStyle: {
                                opacity: 0.1,
                                color: {
                                    type: 'linear',
                                    x: 0,
                                    y: 0,
                                    x2: 0,
                                    y2: 1,
                                    colorStops: [{
                                            offset: 0, color: 'rgba(76, 209, 55, 0.2)'
                                        }, {
                                            offset: 1, color: 'rgba(76, 209, 55, 0.01)'
                                        }]
                                }
                            },
                            data: [220, 182, 191, 234, 290, 330, 310],
                            color: 'rgba(76, 209, 55, 1)'
                        },
                        {
                            name: 'Tương tác diễn đàn',
                            type: 'line',
                            smooth: true,
                            symbol: 'none',
                            lineStyle: {
                                width: 3
                            },
                            areaStyle: {
                                opacity: 0.1,
                                color: {
                                    type: 'linear',
                                    x: 0,
                                    y: 0,
                                    x2: 0,
                                    y2: 1,
                                    colorStops: [{
                                            offset: 0, color: 'rgba(251, 191, 114, 0.2)'
                                        }, {
                                            offset: 1, color: 'rgba(251, 191, 114, 0.01)'
                                        }]
                                }
                            },
                            data: [150, 232, 201, 154, 190, 330, 410],
                            color: 'rgba(251, 191, 114, 1)'
                        }
                    ]
                };
                myChart.setOption(option);
                window.addEventListener('resize', function () {
                    myChart.resize();
                });
            });
        </script>
    </body>
</html>