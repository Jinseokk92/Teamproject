<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- SweetAlert창 바꾸기-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<%
	String email = request.getParameter("email");
	
	boolean result = (boolean)request.getAttribute("result");
	
	out.println("<script type='text/javascript'>");
	out.println("$().ready(function () {");
	if(result == true) {
		// 메일 주소가 있는 경우
		out.println("	Swal.fire({");
		out.println("		title: '중복 확인',");
		out.println("		text: '사용하실 수 없는 이메일입니다. 다른 이메일을 입력해주세요.',");
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
		// 메일 주소가 없는 경우
		out.println("	Swal.fire({");
		out.println("		title: '중복 확인',");
		out.println("		text: '사용하실 수 있는 이메일입니다. 회원가입을 진행해주세요.',");
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