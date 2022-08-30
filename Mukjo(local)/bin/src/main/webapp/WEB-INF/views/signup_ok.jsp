<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- SweetAlert창 바꾸기-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<%
	int flag = (Integer)request.getAttribute("flag");
	
	out.println("<script type='text/javascript'>");
	if(flag == 0) {
		out.println("$().ready(function () {");
		out.println("	Swal.fire(");
		out.println("		'가입이 완료되었습니다.',");
		out.println("		'Welcome to Mukjo',");
		out.println("		'success'");
		out.println("	).then(() => {");
		out.println("		location.href='./login.do'");
		out.println("	})");
		out.println("});");
	} else {
		out.println("$().ready(function () {");
		out.println("	Swal.fire(");
		out.println("		'회원가입을 다시 시도해주십시오.',");
		out.println("		'이메일 중복확인은 하셨나요?',");
		out.println("		'error'");
		out.println("	).then(() => {");
		out.println("		history.back();");
		out.println("	})");
		out.println("});");
		
		//out.println("alert('이메일 중복확인 및 회원가입을 다시 시도해주십시오.');");
		//out.println("history.back();");
	}
	out.println( "</script>" );
%>