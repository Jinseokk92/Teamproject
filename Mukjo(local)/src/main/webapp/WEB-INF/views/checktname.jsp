<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	boolean result = (boolean)request.getAttribute("result");
	out.println(result);
%>