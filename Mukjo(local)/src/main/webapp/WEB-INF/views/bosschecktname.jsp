<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- SweetAlert창 바꾸기-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<link href="https://fonts.googleapis.com/css?family=Sunflower:500" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
body,ul ,li, h1,h2,h3{
    margin: 0;
    padding: 0;
    font-family: 'Sunflower' !important;
}

button {
	font-family: 'Sunflower' !important;
}
</style>
<%
	String email = request.getParameter("email");
	
	boolean result = (boolean)request.getAttribute("result");
	
	out.println("<script type='text/javascript'>");
	out.println("$().ready(function () {");
	if(result == true) {
		// 이름 있는 경우
		out.println("	Swal.fire({");
		out.println("		title: '중복 확인',");
		out.println("		text: '이미 존재하는 이름입니다. 다른 이름을 입력해주세요.',");
		out.println("		icon: 'error',");
		out.println("		showCancelButton: true,");
		out.println("		confirmButtonColor: '#3085d6',");
		out.println("		cancelButtonColor: '#d33',");
		out.println("		confirmButtonText: '확인',");
		out.println("		cancelButtonText: '취소',");
		out.println("		reverseButtons: false,");
		out.println("	}).then((result) => {");
		out.println("		if (result.isConfirmed) {");
		out.println("			history.back();");
		out.println("		} else {");
		out.println("			history.back();");
		out.println("		}");
		out.println("	})");
	} else {
		// 이름이 없는 경우
		out.println("	Swal.fire({");
		out.println("		title: '중복 확인',");
		out.println("		text: '사용하실 수 있는 이름입니다.',");
		out.println("		icon: 'success',");
		out.println("		showCancelButton: true,");
		out.println("		confirmButtonColor: '#3085d6',");
		out.println("		cancelButtonColor: '#d33',");
		out.println("		confirmButtonText: '확인',");
		out.println("		cancelButtonText: '취소',");
		out.println("		reverseButtons: false,");
		out.println("	}).then((result) => {");
		out.println("		if (result.isConfirmed) {");
		out.println("			history.back();");
		out.println("		} else {");
		out.println("			history.back();");
		out.println("		}");
		out.println("	})");
	}
	out.println("})");
	out.println("</script>");
%>