<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
<%
	int flag = (int)request.getAttribute("flag");

	out.println("<script type='text/javascript'>");
	if(flag == 1) {
		out.println( "alert('로그인에 성공했습니다.');" );
		out.println( "location.href='http://localhost/main'" );
	} else if(flag == 2) {
		out.println( "alert('비밀번호가 틀렸습니다.');" );
		out.println( "history.back();");
	} else {
		out.println( "alert('존재하지 않는 회원입니다.');" );
		out.println( "history.back();");
	}
	out.println( "</script>" ); 
%>
</body>
</html>