<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="lecturer-template.jsp">
    <jsp:param name="pageTitle" value="Quản lý bài kiểm tra" />
    <jsp:param name="contentPage" value="tests-content.jsp" />
</jsp:include>
