<%@page import="com.example.model1.NoticeTO"%>
<%@page import="com.example.model1.BoardTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.example.model1.BoardDAO"%>
<%@page import="com.example.model1.BoardListTO"%>
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
    
      String tseq = request.getParameter("tseq");
       String seq=(String)request.getAttribute("seq");
       String jangseq=(String)request.getAttribute("jangseq");
       String tname=(String)request.getAttribute("tname");

        StringBuilder sbHtml=new StringBuilder();
      
        if (seq.equals(jangseq)) {
           sbHtml.append("<p style='margin-top:25px;'>소모임장은 소모임을 탈퇴할 수 없습니다.</p>");
           sbHtml.append("<p style=' margin-top:30px;'>그래도 탈퇴를 원하시면 다른 회원에게 소모임장 권한을 위임하세요.</p>");
        } else if (seq.equals("1")) {
           sbHtml.append("<p style='margin-top:45px;'>관리자는 소모임을 탈퇴할 수 없습니다.</p>");
        } else {
           sbHtml.append("<p style='margin-top:10px; margin-bottom:10px;>'>소모임 탈퇴시 작성하신 모든 게시물들은 삭제됩니다.</p>");
           sbHtml.append("<p>그래도 탈퇴하시겠습니까?</p>");
           sbHtml.append("<div class='btn_area'>");
           sbHtml.append("<div class='align'>");
           sbHtml.append("<button class='allbtn' id='bsabtn'><a href='../../main/quitgroup/success?tseq="+tseq+"' style='color : #fff'>탈퇴</a></button>");
        }   
        
        ArrayList<NoticeTO> noticeList=(ArrayList<NoticeTO>)request.getAttribute("noticeList");
        String noticeCount=(String)request.getAttribute("noticeCount").toString();
        
        StringBuilder sbh=new StringBuilder();
        for (int i=0; i<noticeList.size(); i++) {
           String words=noticeList.get(i).getWords();
           String ndate=noticeList.get(i).getNdate();
           
           sbh.append("<p style='padding-top:25px; margin-bottom:0px;'>"+words);
           sbh.append("<div>");
           sbh.append("   <span>"+ndate+"</span>");
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
    <title>소모임 탈퇴</title>
    <style href="css/common.css"></style>
    <!-- 나눔스퀘어 폰트 -->
    <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Sunflower:500" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
   
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

 button{
    font-family: 'Sunflower' !important;
}


input{
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

ul{
    list-style:none;
}

a:link {  color : black; text-decoration: none }
    a:visited {color: black; text-decoration: none;}
    a:hover {color: #5c3018; text-decoration: none;}
    a:active {color: #de5f47; text-decoration: none;}


img{
    width: 100%;
    padding-bottom: 5px;
}

table{
    text-align: center;
}

:root {
  --button-color: #ffffff;
  --button-bg-color: #5c3018;
  --button-hover-bg-color: #5c3018;
}

button {
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  
  background: var(--button-bg-color);
  color: var(--button-color);
  
  margin: 0;
  padding: 0.5rem 1rem;
  
  font-family: 'Noto Sans KR', sans-serif;
  font-size: 1rem;
  font-weight: 400;
  text-align: center;
  text-decoration: none;
  text-transform : none;
  
  border: none;
  border-radius: 4px;
  
  display: inline-block;
  width: auto;
  
  cursor: pointer;
  
  transition: 0.5s;
}

.btn_list {
   display: inline-block;
   background: #5c3018;
   border: 1px solid #404144;
   padding: 6px 17px 7px 17px;
}

.btn_txt02 {
   color: white;
   font-weight: 600;
}


button:active,
button:hover,
button:focus {
  background: var(--button-hover-bg-color);
  outline: 0;
}
button:disabled {
  opacity: 0.5;
}


/** nav **/

nav{
    position: sticky;
    top : 0;
}

#header{
    z-index: 1050;
}


#header ul{
    display: flex;
    font-family: 'NanumSquareBold';
}

#header ul li{
    margin-left: 65px;
}

#header ul li b{
    line-height: 41.5px;
}

#logoSec{
    width: 8%;
}

#logout{
    color : grey;
    width:10%;
    text-decoration: underline;
    margin-right: 17%;
}

#bell{
    width: 60px;
    display:flex;
    align-items: center;
    color: red;
}




#headerWap{
    width:1280px;
    margin: auto;
    display: flex;
    justify-content: space-between;
    height: 98px;
    align-items : center;
    background-color: white;
}

#headerWap h3 {
  
   font-size: 15px;
   justify-content: left;
   position: absolute;
   margin-left: 120px;
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

#form_boss {
   height: 180px;
   border: 2px solid black;
   text-align: center;
}

#form_boss input {
   width: 400px;
   height: 30px;
   margin-bottom: 60px;
   border: 1px solid black;
}

/* 타이틀 섹션 */
#titSec strong{
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

#btnSec button{
    margin-left: 10px;
    margin-bottom: 5px;
}

#btnSec strong{
  font-family: 'NanumSquareExtraBold';
  font-size: 20px;
  display: inline-block;
  padding-left: 20px;
}

#locationSec{
    width: 100%;
    background-color: #f7f7fd;
    overflow: hidden;
}

#locationSec button{
    font-weight: 500;
    background: none;
    cursor: default;
    outline: none;
  box-shadow: none;
}

#locationwrap{
    width: 1280px;
    margin: 0 auto;
    height: 55px;
    padding-top: 13px;
}

#locationwrap button{
    font-family: 'NanumSquareBold';
}

.allbtn{
    color : #333;
    position : relative;
}

.active{
    color: #de5f47;
}

/* 테이블 섹션 */
#tblSec table{
    width: 100%;
    border-collapse: collapse;
    
}

#tblSec table td{
   height: 45px;
   border-bottom : 1px solid #c7bebe;
}

#tblWrap{
    padding-top: 30px;
}
.notice {
   background-color: #F2F2F2;
}

.notice td>a:first-child{

    font-weight: bold;
}

/***** footer  *****/
footer{
    width: 100%;
    height: 163px;
    background-color: #d7d7d7;
    margin-top: 5%;
}

.board-table th  {
   padding-bottom: 10px;
   border-bottom: 1px solid black;
}

.btn_area {
   display; inline-block;
}

.ex p{
  font-family: 'Sunflower' !important;
 }

.modal-dialog {
    position: fixed;
    margin: auto;
    width: 320px;
    height: 100%;
    right: 0px;
}


.modal-body {
   padding-top: 0px;
   height: 100%;
}

.modal-content {
   border: 1px solid black;
    height: 100%;
}
#noticelogo {
   width: 25%;
}

.modal-body span {
   float: right;
}


/* button */
.logoclick:active {
  top: 3px;
  border-color: rgba(0,0,0,0.34) rgba(0,0,0,0.21) rgba(0,0,0,0.21);
  box-shadow: 0 1px 0 rgba(255,255,255,0.89),0 1px rgba(0,0,0,0.05) inset;
  position: relative;
}

</style>

<script>
$('.logoclick').click(function(event){

  });
    </script>

</head>
<body>
    <nav id="header">
        <div class="headermake" style="width:100%; background-color: #fff;">
        <div id="headerWap">
            <h1 id="logoSec">
                 <a href="../../main" class="logoclick"><img src="../../images/logo.png" alt="logo"></a>
            </h1>
            <h3><%=welcome %><a href="../../bye" id="logout" style="color : gray"><br/><%=log %></a></h3>
            <ul>
                <li><b><a href="../../mypage" class="logoclick">마이페이지</a></b></li>
                <li><b><a href="../../adgroups" class="logoclick">소모임장페이지</a></b></li>
                <li><b><a href="../../admin" class="logoclick">관리자페이지</b></li></a>
               <li><b><a href="../../favorite" class="logoclick">즐겨찾기</b></li></a>
                <li id="bell" style="margin-left: 20px;">
                   <button type="button" id="modalBtn" class="btn" data-bs-toggle="modal" data-bs-target="#exampleModal">
                  <img src="../../images/bell.png">
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
          <span id="noticelogo"><img src="../../images/logo.png"></span>
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
             <button class="active"><a href="../../main/board?tseq=<%=tseq %>" >게시판</a></button>
             <button class="allbtn"><a href="../../main/search?tseq=<%=tseq %>" >식당 검색</a></button>
             <button class="allbtn"><a href="../../main/members?tseq=<%=tseq %> ">소모임 회원 목록</a></button>
             <button class="allbtn" id="bsbtn"><a href="../../main/quitgroup?tseq=<%=tseq %>"  style="color : #de5f47">소모임 탈퇴</a></button>
        </div>
      </section>
      <div class="ex" style="width: 1280px; margin:auto">
      <form action="" method="post" name="" id="form_boss" style="width: 800px;
          margin-top: 100px; margin-left: 210px; height:210px;">           
               <span style="  font-family: 'Sunflower' !important; font-size:20px; display:inline-block; margin-top:30px;"><b>소모임 : <%=tname %></b></span>
               <%=sbHtml.toString() %>
               <!--  
               <p>소모임 탈퇴시 작성하신 모든 게시물들은 삭제됩니다.</p>
               <p>그래도 탈퇴하시겠습니까?</p>
               <div class="btn_area">
               
                  <div class="align">
                  <button class="allbtn" id="bsabtn"><a href="./somoimboard_memberexitok.do?tseq=<%=tseq %>" style="color : #fff">탈퇴</a></button>
            -->
               </div>
                     
               </div>
            </form>
            </div>

    </nav>  

   

</body>
</html>