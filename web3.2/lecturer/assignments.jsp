<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:include page="lecturer-template.jsp">
    <jsp:param name="title" value="Assignments Management" />
    <jsp:param name="content" value="assignments-content" />
</jsp:include>

<%@ include file="lecturer-template.jsp" %>
<%@ include file="assignments-content.jsp" %>