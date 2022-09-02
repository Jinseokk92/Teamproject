<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
	int flag = (int)request.getAttribute("flag");

		out.println("<script type='text/javascript'>");
		if(flag == 1) {
			out.println( "alert('메일로 임시 비밀번호를 보냈습니다.');" );
			out.println( "location.href='welcome';" );
		} else {
			out.println( "alert('존재하지 않는 회원입니다.');" );
			out.println( "history.back();");
		}
		out.println( "</script>" ); 

%>
<html>
<head>
<meta charset="UTF-8">
<title>Forgot Password</title>
</head>
<body>
	

	
</body>
</html>