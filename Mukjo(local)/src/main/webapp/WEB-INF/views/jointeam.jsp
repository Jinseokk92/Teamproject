<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	int flag = (int)request.getAttribute("flag");
	out.println(flag);
%>