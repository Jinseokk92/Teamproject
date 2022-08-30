<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<link href="https://fonts.googleapis.com/css?family=Sunflower:500" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<style>

body,ul ,li, h1,h2,h3 {
    margin: 0;
    padding: 0;
    font-family: 'Sunflower' !important;
}

 button{
    font-family: 'Sunflower' !important;
}
</style>

<%
   int flag = (int)request.getAttribute("flag");
   String tseq = request.getParameter("tseq");
   String bseq = request.getParameter("bseq");
   String cseq = request.getParameter("cseq");
   String cpage = request.getParameter("cpage");
   
   out.println("<script type='text/javascript'>");
   out.println("$().ready(function () {");

   
   if(flag == 1) {
      out.println("   Swal.fire({");
      out.println("      title: '댓글 삭제 성공',");
      out.println("      text: '댓글 삭제를 완료되었습니다.',");
      out.println("      icon: 'success',");
      out.println("      confirmButtonColor: '#3085d6',");
      out.println("      confirmButtonText: '확인',");
      out.println("      reverseButtons: false,");
      out.println("   }).then((result) => {");
      out.println("      if (result.isConfirmed) {");
      out.println("      location.href='../../../mypage/view?cpage="+cpage+"&bseq="+bseq+"'");
      out.println("      }");
      out.println("   })");
   } else {
      out.println("   Swal.fire({");
      out.println("      title: '댓글 삭제 실패',");
      out.println("      text: '댓글 삭제를 실패했습니다.',");
      out.println("      icon: 'error',");
      out.println("      confirmButtonColor: '#3085d6',");
      out.println("      confirmButtonText: '확인',");
      out.println("      reverseButtons: false,");
      out.println("   }).then((result) => {");
      out.println("      if (result.isConfirmed) {");
      out.println("         history.back();");
      out.println("      }");
      out.println("   })");
   }
   out.println("})");
   out.println("</script>");
%>