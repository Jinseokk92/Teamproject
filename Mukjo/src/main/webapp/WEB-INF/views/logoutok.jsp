<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃</title>
</head>
<body>
<%
	int flag = (int)request.getAttribute("flag");

	out.println("<script type='text/javascript'>");
	if(flag == 1) {
		out.println( "alert('로그아웃에 성공했습니다.');" );
		out.println( "location.href='welcome';" );
	} else {
		out.println( "location.href='welcome';" );
	}
	out.println( "</script>" ); 
%>
</body>
</html>