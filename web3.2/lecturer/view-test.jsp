<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="lecturer-template.jsp">
    <jsp:param name="pageTitle" value="Chi tiết bài kiểm tra" />
    <jsp:param name="contentPage" value="view-test-content.jsp" />
</jsp:include> 