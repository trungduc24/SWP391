<%-- 
    Document   : dashboard
    Created on : Jun 22, 2025, 9:28:10 PM
    Author     : DUCK-KANCHOU
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Activity" %> <%-- hoặc tùy gói --%>
<!-- dashboard.jsp -->

<div class="mb-6">
    <h1 class="text-2xl font-bold text-gray-800">Dashboard</h1>
    <p class="text-gray-600 mt-1">
        Welcome back, <%= session.getAttribute("fullName") %>!
    </p>
</div>

<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
    <div class="bg-white rounded-lg shadow-sm p-6 border border-gray-100">
        <div class="flex items-center">
            <div class="w-12 h-12 rounded-lg bg-blue-100 flex items-center justify-center text-primary">
                <i class="ri-user-line"></i>
            </div>
            <div class="ml-4">
                <h3 class="text-lg font-semibold text-gray-800"><%= request.getAttribute("totalStudents") %></h3>
                <p class="text-sm text-gray-500">Total Students</p>
            </div>
        </div>
    </div>
    <!-- Thêm Lecturers, Courses, Assignments tương tự -->
</div>

<div class="bg-white rounded-lg shadow-sm p-6 border border-gray-100 mb-6">
    <h2 class="text-lg font-semibold text-gray-800">Recent Activities</h2>
    <ul class="mt-4 space-y-4">
        <%
            List<Activity> activities = (List<Activity>) request.getAttribute("recentActivities");
            if (activities != null) {
                for (Activity a : activities) {
        %>
        <li class="flex items-center">
            <div class="w-8 h-8 rounded-full bg-blue-100 flex items-center justify-center text-blue-600">
                <i class="ri-user-line"></i>
            </div>
            <div class="ml-3">
                <p class="text-gray-800"><%= a.getMessage() %></p>
                <span class="text-xs text-gray-500"><%= a.getTimeAgo() %></span>
            </div>
        </li>
        <% }} %>
    </ul>
</div>
