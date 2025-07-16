<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="lecturer-template.jsp">
    <jsp:param name="pageTitle" value="Quản lý sinh viên" />
    <jsp:param name="contentPage" value="courses-content.jsp" />
</jsp:include>
