<%@page import="java.util.ArrayList"%>
<%@page import="com.example.model1.NoticeTO"%>
<%@page import="com.example.model1.BoardTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
   String log = "LOGIN";
   
   HttpSession sess = request.getSession();
   
   String loginedMemberSeq = (String)sess.getAttribute("loginedMemberSeq");
   String welcome = "";
   
   if(loginedMemberSeq != null) {
      welcome = (String)sess.getAttribute("loginedMemberName")+"님 환영합니다.";
      log = "LOGOUT";
   } else {
         out.println ( "<script>");
         out.println ( "window.location.href = 'http://localhost/welcome'");
         out.println ( "</script>");
   }
   
   int cpage = (Integer)request.getAttribute("cpage");
   BoardTO to = (BoardTO)request.getAttribute("to");

   String bseq=to.getBseq();
   String subject=to.getSubject();
   String content=to.getContent();
   String fileName=to.getFilename();
   if (fileName==null) {
	   fileName="";
   }
   String trash="no";
   
   ArrayList<NoticeTO> noticeList=(ArrayList<NoticeTO>)request.getAttribute("noticeList");
   String noticeCount=(String)request.getAttribute("noticeCount").toString();
   
   StringBuilder sbh=new StringBuilder();
   for (int i=0; i<noticeList.size(); i++) {
      String words=noticeList.get(i).getWords();
      String ndate=noticeList.get(i).getNdate();
      
      sbh.append("<p style='padding-top:25px; margin-bottom:0px;'>"+words);
      sbh.append("<div>");
      sbh.append("	<span>"+ndate+"</span>");
      sbh.append("</div>");
      sbh.append("</p>");
   }
   
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지 수정</title>

<!-- 나눔스퀘어 폰트 -->
<link
   href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css"
   rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Sunflower:500" rel="stylesheet">
<!-- Bootstrap (for modal) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>


<style>
/** common **/
body,ul ,li, h1,h2,h3{
    margin: 0;
    padding: 0;
    font-family: 'Sunflower' !important;
}

p {
   color: black;
   font-family: 'Sunflower' !important;
}

input {
   writing-mode: horizontal-tb !important;
   text-rendering: auto;
   color: fieldtext;
   letter-spacing: normal;
   word-spacing: normal;
   line-height: normal;
   text-transform: none;
   text-indent: 0px;
   text-shadow: none;
   display: inline-block;
   text-align: start;
   appearance: auto;
   -webkit-rtl-ordering: logical;
   cursor: text;
   border: none;
   outline: none;
}

ul {
   list-style: none;
}

a:link {
   color : black;
   text-decoration: none
}

a:visited {
   color: black;
   text-decoration: none;
}

a:hover {
   color: #5c3018;
   text-decoration: none;
}

a:active {
   color: #de5f47;
   text-decoration: none;
}

img {
   width: 100%;
   padding-bottom: 5px;
}

table {
   text-align: center;
}

:root { -
   -button-color: #ffffff; -
   -button-bg-color: #5c3018; -
   -button-hover-bg-color: #5c3018;
}

button {
   -webkit-appearance: none;
   -moz-appearance: none;
   appearance: none;
   background: var(- -button-bg-color);
   color: var(- -button-color);
   margin: 0;
   padding: 0.5rem 1rem;
   font-family: 'Sunflower' !important;
   font-size: 1rem;
   font-weight: 400;
   text-align: center;
   text-decoration: none;
   text-transform: none;
   border: none;
   border-radius: 4px;
   display: inline-block;
   width: auto;
   cursor: pointer;
   transition: 0.5s;
}

button:active, button:hover, button:focus {
   background: var(- -button-hover-bg-color);
   outline: 0;
}

button:disabled {
   opacity: 0.5;
}

/** nav **/
nav {
   position: sticky;
   top: 0;
}

#header {
   border-bottom: #c7bebe 1px solid;
   z-index: 1050;
}

#header ul {
   display: flex;
   font-family: 'NanumSquareBold';
}

#header ul li {
   margin-left: 65px;
}

#header ul li b {
   line-height: 41.5px;
}

#logoSec {
   width: 8%;
}

#logout {
   color: grey;
   width: 10%;
   text-decoration: underline;
   margin-right: 17%;
}

#bell {
   width: 60px;
   display: flex;
   align-items: center;
   color: red;
}

#headerWap {
   width: 1280px;
   margin: auto;
   display: flex;
   justify-content: space-between;
   height: 98px;
   align-items: center;
   background-color: white;
}

#headerWap h3 {
   font-size: 15px;
   justify-content: left;
   position: absolute;
   margin-left: 120px;
}

/***** warp  *****/
#wrap{
    width: 1280px; 
    margin : auto;
}

/* 타이틀 섹션 */
#titSec strong {
   font-family: 'NanumSquareExtraBold';
   font-size: 35px;
   padding: 30px 0 30px 0;
   display: inline-block;
}

/* 버튼 섹션*/
#btnSec {
   border-bottom: 2px solid #5c3018;
   display: inline-flex;
   justify-content: space-between;
   width: 100%;
}

#btnSec button {
   margin-left: 10px;
   margin-bottom: 5px;
}

#btnSec strong {
   font-family: 'NanumSquareExtraBold';
   font-size: 25px;
   display: inline-block;
   padding-left: 50px;
}

#btnSec .search-wrap {
   margin-left: 50%;
}

#locationSec {
   width: 100%;
   background-color: #f7f7fd;
}

#locationSec button {
   font-weight: 500;
   background: none;
   cursor: default;
   outline: none;
   box-shadow: none;
}

#locationwrap {
   width: 1280px;
   margin: 0 auto;
   height: 55px;
   padding-top: 13px;
}

#locationwrap button {
   font-family: 'Sunflower' !important;
}

.allbtn {
   color: #333;
   position: relative;
}

.active {
   color: #de5f47;
}

/* 테이블 섹션 */
#tblSec table {
   width: 100%;
   border-collapse: collapse;
}

#tblSec table td {
   height: 45px;
   border-bottom: 1px solid #c7bebe;
}

#tblWrap {
   padding-top: 30px;
}

/***** pagingSec  *****/
#pagingSec ul {
   display: flex;
}

#pagingSec {
   display: flex;
   justify-content: center;
   margin-top: 30px;
   line-height: 2.5;
}

#btnSec .search-wrap {
   align-items: center;
   width: 282px;
   height: 36px;
   box-sizing: border-box;
   -webkit-border-radius: 24px;
   -moz-border-radius: 24px;
   border-radius: 24px;
   border: 2px solid #5c3018;
   display: inline-block;
   overflow: hidden;
   position: relative;
}

#pagingSec .search-wrap #search {
   height: 37.6px;
   margin-right: 4px;
}

.search-wrap input {
   height: 32px;
   width: 80%;
   color: #000;
   font-size: 16px;
   box-sizing: border-box;
   margin-left: 5px;
}

/* width : 30, height : 45 */
.search-wrap button {
   width: 30px;
   height: 25px;
   right: 5%;
   top: 10%;
   text-indent: -9999px;
   overflow: hidden;
   background: url( ./images/search2.png) no-repeat;
   position: absolute;
   background-size: 38px 25px;
}

#pagingSec ul li {
   width: 42px;
   height: 42px;
   text-align: center;
   line-height: 42px;
   margin-right: 10px;
   border: 1px solid #c4c4c4;
   border-radius: 10%;
}

#pagingSec .active {
   color: white;
   background-color: #de5f47;
}

.board_pagetab {
   text-align: center;
   display: inline-flex;
   position: relative;
}

.board_pagetab a {
   text-decoration: none;
   font: 12px verdana;
   color: #000;
   padding: 0 3px 0 3px;
}

.on a {
   font-weight: bold;
}

/***** footer  *****/
footer {
   width: 100%;
   height: 163px;
   background-color: #d7d7d7;
   margin-top: 5%;
}

.contents_sub {
   width: 100%;
   margin: 0;
}

.contents_sub table {
   width: 100%;
   border-collapse: collapse;
}

.contents_sub table img {
   padding-top: 2px;
}

.board_write {
   border-top: 1px #464646;
}

.board_write th, .board_write td {
   height: 25px;
   text-align: left;
   padding: 8px;
   border-bottom: 1px solid #dadada;
   font-family: 'Sunflower' !important;
}

.board_write th {
   color: #464646;
   text-align: center;
   font-weight: 600;
   background-color: #f9f9fb;
}

.board_write td {
   color: #797979;
   font-family: 'Noto Sans KR', sans-serif;
}

.board_view_input {
   height: 20px;
   width: 700px;
   border: 1px solid #cecece;
}

.board_editor_area {
   width: 100%;
   height: 200px;
}

.btn_area {
   overflow: hidden;
   margin: 10px 0;
}

.align_left {
   float: left;
}

.align_right {
   float: right;
}

.btn_write {
   display: inline-block;
   background: #5c3018;
   border: 1px solid #404144;
   padding: 6px 17px 7px 17px;
}

.btn_list {
   display: inline-block;
   background: #5c3018;
   border: 1px solid #404144;
   padding: 6px 17px 7px 17px;
}

.board {
   width: 100%;
}

.board th {
   height: 41px;
   border-bottom: 1px solid #dadada;
   background-color: #f9f9fb;
   color: #464646;
   word-wrap: break-word;
   border-top: 1px solid #464646;
   word-break: break-all;
}

.board td {
   height: 30px;
   border-bottom: 1px solid #dadada;
   color: #797979;
   text-align: center;
   padding: 5px;
   word-wrap: break-word;
   word-break: break-all;
}

.board td.left {
   text-align: center;
}

.board td.category {
   font-weight: bold;
}

table {
   border-collapse: collapse;
   border-spacing: 0;
}

textarea {
   width: 100%;
   height: 120px;
   border: 1px solid #cecece;
}

.board_view_input {
   border: 1px solid #d1d1d1;
}

.btn_txt01 {
   color: white;
}

.btn_txt02 {
   color: white;
}

.modal-dialog {
    position: fixed;
    margin: auto;
    width: 320px;
    height: 100%;
    right: 0px;
}

.modal-content {
   border: 1px solid black;
    height: 100%;
}

#noticelogo {
   width: 25%;
}

.modal-body {
	padding-top: 0px;
	height: 100%;
}

.modal-body span {
   float: right;
}

#modalBtn:hover {
   background-color: #5c3018;
}

.logoclick:active {
  top: 3px;
  border-color: rgba(0,0,0,0.34) rgba(0,0,0,0.21) rgba(0,0,0,0.21);
  box-shadow: 0 1px 0 rgba(255,255,255,0.89),0 1px rgba(0,0,0,0.05) inset;
  position: relative;
}

.checkbox {
   display: inline-block;
   height: 18%;
}
input[type="checkbox"]+label {
    display: flex;
    width: 20px;
    height: 20px;
    background: url('../../../images/trash1.png') no-repeat 0 0px / contain;
}
input[type='checkbox']:checked+label {
    background: url('../../../images/trash2.png') no-repeat 0 1px / contain;
}
input[type="checkbox"] {
    display: none;
}
</style>

</head>
<body>
   <nav id="header">
        <div class="headermake" style="width:100%; background-color: #fff;">
        <div id="headerWap">
            <h1 id="logoSec">
                <a href="../../../main" class="logoclick"><img src="../../../images/logo.png" alt="logo"></a>
            </h1>
            <h3><%=welcome %><a href="../../../bye" id="logout" style="color : gray"><br/><%=log %></a></h3>
            <ul>
                <li><b><a href="mypage" style="color : #de5f47;" class="logoclick">마이페이지</a></b></li>
                <li><b><a href="../../../adgroups" class="logoclick">소모임장페이지</a></b></li>
                <li><b><a href="../../../admin" class="logoclick">관리자페이지</b></li></a>
                <li><b><a href="../../../favorite" class="logoclick">즐겨찾기</b></li></a>
                <li id="bell" style="margin-left: 20px;">
                   <button type="button" id="modalBtn" class="btn" data-bs-toggle="modal" data-bs-target="#exampleModal">
                  <img src="../../../images/bell.png">
               </button><%=noticeCount %>
            </li>
            </ul>
          </div>
        </div> <!--headerWap-->
        
         <!-- Modal -->
  <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" id="exampleModalLabel"><b>알림</b></h4>
          <span id="noticelogo"><img src="../../../images/logo.png"></span>
        </div>

        <div class="modal-body">
  <%=sbh %>
        <!-- 
          <p>[맥크리] 소모임 가입 승인이 완료되었습니다.
             <span>2022.07.13</span>
          </p>
          <hr />
          <p>[맥크리] 소모임 가입 승인이 완료되었습니다.
             <span>2022.07.13</span>
          </p>
          <hr />
          <p>[맥크리] 소모임 가입 승인이 완료되었습니다.
             <span>2022.07.13</span>
          </p>
          -->
          
        </div>

        <div class="modal-footer">
          <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal"><a href="../../notice/read"><b>읽음</b></button>
          <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal"><a href=""><b>닫기</b></button>
        </div>
      </div>
    </div>
  </div>
   
   
      <!--locationSec -->
      <section id="locationSec">
        <div id = "locationwrap">
             <button class="allbtn"><a href="../../../mypage" style="color : #de5f47;">내가 쓴 글 보기</a></button>
             <button class="active"><a href="../../../mypage/change" >내 정보 수정</a></button>
        </div>
      </section>
   </nav>

   <!-- 전체 요소를 감싸는 div -->
   <div id="wrap">
      <div class="con_txt">
         <form action="./modify/success" method="post" name="mfrm" enctype="multipart/form-data">
         <input type="hidden" name="bseq" value="<%=bseq %>" />
         <input type="hidden" name="cpage" value="<%=cpage %>" />
         <input type="hidden" name="trash" value=<%=trash %> >
            
            <div class="contents_sub">
               <!--게시판-->
               <div class="board_write">
                  <table>
                     <tr>
                        <th>제&nbsp;&nbsp;목</th>
                        <td><input type="text" name="subject" value="<%=subject %>"
                           class="board_view_input" /></td>
                     </tr>
                     <tr>
                        <th>내&nbsp;&nbsp;용</th>
                        <td><textarea name="content" class="board_editor_area"><%=content %></textarea></td>
                     </tr>
                     <tr>
                        <th>파일첨부</th>
                        <td class="textdeco">기존이미지 : <%=fileName %> 
								<div class="checkbox">
                               		<input type="checkbox" id="delCheck">
                               		<label for="delCheck"></label>
                             	</div>
								<br /> <br />
                           <input type="file" name="upload" value=""
                           class="board_view_point">
                        </td>
                     </tr>
                  </table>
                  
                     <div class="btn_area">
                        <div class="align_left">
                           <input type="button" value="목록" class="btn_list btn_txt02"
                              style="cursor: pointer;"
                              onclick="location.href='../../mypage?cpage=<%=cpage %>&bseq=<%=bseq %>'" /> <input
                              type="button" value="보기" class="btn_list btn_txt02"
                              style="cursor: pointer;"
                              onclick="location.href='../../mypage/view?cpage=<%=cpage %>&bseq=<%=bseq %>'" />
                        </div>
                        <div class="align_right">
                           <input type="button" id="mbtn" value="완료"
                              class="btn_write btn_txt01" style="cursor: pointer;" />
                        </div>
                     </div>
                     <!--//게시판-->
                  
               </div>
         </form>
      </div>
   </div>
   <script type="text/javascript">
window.onload = function() {
	  var str='<%=fileName %>';
  document.getElementById( 'mbtn' ).onclick = function() {

     if( document.mfrm.subject.value.trim() == "" ) {
        alert( '제목을 입력하셔야 합니다.' );
        return false;            
     }
     if( document.mfrm.content.value.trim() == "" ) {
        alert( '내용을 입력하셔야 합니다.' );
        return false;
     }
     if (document.querySelector('#delCheck').checked == true && str!="") {
    	 document.mfrm.trash.value="deleteImage";
     }
     document.mfrm.submit(); 
  };
  
  document.getElementById( 'delCheck' ).onclick = function() {
     let x = document.getElementsByClassName("textdeco")[0];        
     if (document.querySelector('#delCheck').checked == true && str!="") {
    	 x.style.textDecoration = "line-through";  
     } else {
        x.style.textDecoration = "none";
     }
      
   };
};
</script>
</body>

   </html>