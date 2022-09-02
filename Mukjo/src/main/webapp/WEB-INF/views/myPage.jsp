<%@page import="com.example.model1.NoticeTO"%>
<%@page import="com.example.model1.BoardListTO"%>
<%@page import="com.example.model1.BoardTO"%>
<%@page import="java.util.ArrayList"%>
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
    
    BoardListTO boardListTO = (BoardListTO)request.getAttribute("boardListTO");
      int cpage = boardListTO.getCpage();
      int recordPerPage = boardListTO.getRecordPerPage();
      int totalRecord = boardListTO.getTotalRecord();
      int totalPage = boardListTO.getTotalPage();
      int blockPerPage = boardListTO.getBlockPerPage();
      int startBlock = boardListTO.getStartBlock();
      int endBlock = boardListTO.getEndBlock();
      ArrayList<BoardTO> boardLists = boardListTO.getBoardLists();
      
      StringBuilder sb = new StringBuilder();
      int num=1;
      
      for (int j=0; j<boardLists.size(); j=j+20) {
         num=(boardListTO.getCpage()-1)*20+1;
         for (int i=j; i<j+20; i++) {
            
            if (i>=boardLists.size()) {

            } else {
               String bseq=boardLists.get(i).getBseq();
               String tseq=boardLists.get(i).getTseq();
               String tname=boardLists.get(i).getTname();
               String subject=boardLists.get(i).getSubject();
               String wdate=boardLists.get(i).getWdate();
               String hit=boardLists.get(i).getHit();
               int cmtcount=boardLists.get(i).getCmtCount();

               sb.append("<tr>");
               sb.append("<td>"+num+"</td>");
               sb.append("<td>"+tname+"</td>");               
               sb.append("<td><a href='mypage/view?cpage="+cpage+"&bseq="+bseq+"'>"+subject+"</a> &nbsp;&nbsp;<span class='numspan'>["+cmtcount+"]</span></td>");
               sb.append("<td>"+wdate+"</td>");
               sb.append("<td>"+hit+"</td>");
               sb.append("</tr>");
               
               num+=1;
            }
         }
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
    <title>내가 쓴 글 보기</title>
    <style href="css/common.css"></style>
    <!-- 나눔스퀘어 폰트 -->
    <link href="https://fonts.googleapis.com/css?family=Sunflower:500" rel="stylesheet">
    <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">

   <!-- Bootstrap (for modal) -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
   

<style>
body,ul ,li, h1,h2,h3{
    margin: 0;
    padding: 0;
    font-family: 'Sunflower' !important;
}

.numspan{
   display: inline-block;
   line-height:1px;
   margin-left : 5px;
   color : black;
   font-weight: bold;
   font-size: 13px;
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

a:link { color: black;
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
   font-family: 'Noto Sans KR', sans-serif;
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
#wrap {
   width: 1280px;
   margin: auto;
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
   display: inline-flex;
   justify-content: right;
   width: 1280px;
   margin-left: 120px;
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

#locationwrap button{
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
   padding-top: 10px;
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
    right: 0;
    font-size: 0; 
    margin-bottom : 8px;
}

.select{
    display: inline-block;
    vertical-align: top;
    position: relative;
}
.form-select{
   font-size: 14px;
    font-weight: 600;
}

#btnSec .search-wrap .select select{
    border: 2px solid #5c3018;
    border-radius: 10px;
    height: 36px;
    width: 130px;
    box-sizing: border-box;
    padding-left: 10px;
}

#pagingSec .search-wrap #search {
   height: 37.6px;
   margin-right: 4px;
}

.search-wrap .input{
    width: 282px;
    height: 36px;
    box-sizing: border-box;
    -webkit-border-radius: 24px;
    -moz-border-radius: 24px;
    border-radius: 24px;
    border: 2px solid #5c3018;
    display: inline-block;
    overflow: hidden;
    vertical-align: top;
    position: relative;
    padding-left: 14px;
    padding-right: 42px;
    margin-left: 10px;
}

.search-wrap .input input{
    height: 32px;
    width: 100%;
    color: #000;
    font-size: 16px;
    box-sizing: border-box;
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
   width: 1280px;
   margin: 0;
}

.contents_sub table {
   width: 100%;
   border-collapse: collapse;
}

.contents_sub table img {
   padding-top: 2px;
}

.board_view {
   border-top: 0px solid #464646;
}

.board_view table {
    border-collapse: collapse;
}

.board_view th {
   height: 25px;
   text-align: center;
   padding: 8px;
   border-bottom: 1px solid #dadada;
   color: #464646;
   font-weight: 600;
   background-color: #f2f2f2;
}

.board_view td {
   font-family: 'NanumSquareBold';
   height: 25px;
   text-align: left;
   padding: 8px;
   border-bottom: 1px solid #dadada;
   color: black;
}

.board_view_input {
   border: 1px solid #d1d1d1;
}

.board_view_input {
   height: 20px;
   width: 500px;
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
   font-weight: 600;
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
   font-weight: 600;
}

.board_view_input {
   border: 1px solid #d1d1d1;
   font-weight: 600;
}

.btn_txt01 {
   color: white;
   font-weight: 600;
}

.btn_txt02 {
   color: white;
   font-weight: 600;
}

.align_center {
   margin-top: 20px;
}

.btn_list {
   display: inline-block;
   background: #5c3018;
   border: 1px solid #404144;
   padding: 6px 17px 7px 17px;
}

.img_size {
   width: 1280px;
   height: 400px;
   overflow: auto;
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

#somoimp {
   font-size: 15px;
   color: black;
}

#modalBtn:hover {
   background-color: #5c3018;
}

.board-table th  {
   padding-bottom: 10px;
   border-bottom: 1px solid black;
}

.board-table th  {
   padding-bottom: 10px;
   border-bottom: 1px solid black;
}

.logoclick:active {
  top: 3px;
  border-color: rgba(0,0,0,0.34) rgba(0,0,0,0.21) rgba(0,0,0,0.21);
  box-shadow: 0 1px 0 rgba(255,255,255,0.89),0 1px rgba(0,0,0,0.05) inset;
  position: relative;
}

</style>

</head>
<body>
    <nav id="header">
      <div class="headermake" style="width:100%; background-color: #fff;">
        <div id="headerWap">
            <h1 id="logoSec">
                <a href="../main" class="logoclick"><img src="images/logo.png" alt="logo"></a>
            </h1>
            <h3><%=welcome %><a href="bye" id="logout" style="color : gray"><br/><%=log %></a></h3>
            <ul>
                <li><b><a href="mypage" style="color : #de5f47;" class="logoclick">마이페이지</a></b></li>
                <li><b><a href="adgroups" class="logoclick">소모임장페이지</a></b></li>
                <li><b><a href="admin" class="logoclick">관리자페이지</b></li></a>
                <li><b><a href="favorite" class="logoclick">즐겨찾기</b></li></a>
                <li id="bell" style="margin-left: 20px;">
                   <button type="button" id="modalBtn" class="btn" data-bs-toggle="modal" data-bs-target="#exampleModal">
                  <img src="images/bell.png">
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
          <span id="noticelogo"><img src="images/logo.png"></span>
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
          <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal"><a href="notice/read"><b>읽음</b></button>
          <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal"><a href=""><b>닫기</b></button>
        </div>
      </div>
    </div>
  </div>
   
   
      <!--locationSec -->
      <section id="locationSec">
        <div id = "locationwrap">
             <button class="allbtn"><a href="#" style="color : #de5f47;">내가 쓴 글 보기</a></button>
             <button class="active"><a href="mypage/change" >내 정보 수정</a></button>
        </div>
      </section>
    </nav>

   <section id="btnSec">
      <div class="search-wrap">
         <form action="" method="post" name="sfrm">
            <div class="select">

               <select class="form-select" aria-label="Default select example"
                  name="which">
                  <option value="subject">&nbsp;제목</option>
                  <option value="tname">&nbsp;소모임 이름</option>
               </select>


            </div>
            <!-- select-->
            <div class="input">
               <input type="text" title="검색어 입력" name="search" value="">
               <button type="submit">검색</button>
            </div>
            <!-- input -->
         </form>
      </div>
      <!-- search-wrap -->
   </section>

   <!-- 전체 요소를 감싸는 div -->
    <div id="wrap">
        <!-- 테이블 목록이 있는 섹션입니다 -->
        <section id="tblSec">
            <div id="tblWrap">
                <table class="board-table">
                    <thead>
                        <tr>
                            <th scope="col" class="th-num">번호</th>
                            <th scope="col" class="th-tname">소모임 이름</th>
                            <th scope="col" class="th-title">제목</th>
                            <th scope="col" class="th-date">등록일</th>
                            <th scope="col">조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%=sb %>
                    <!--  
                        <tr>
                            <td>1</td>
                            <td>맞찾사</td>
                            <td><a href="#">여기 맛있나요?</a></td>
                            <td>2022-07-25 08:11</td>
                            <td>12</td>
                        </tr>

                        <tr>
                            <td>2</td>
                            <td>먹사모</td>
                            <td><a href="#">맛집 추천목록</a></td>
                            <td>2022-07-25 08:11</td>
                            <td>12</td>
                        </tr>         

                        <tr>
                            <td>3</td>
                            <td>삼쏘파</td>
                            <td><a href="#">5명 가기 좋은 곳 추천 좀</a></td>
                            <td>2022-07-25 08:11</td>
                            <td>12</td>
                        </tr>   
                        <tr>
                            <td>4</td>
                            <td>산소먹방</td>
                            <td><a href="#">여기 가지마여</a></td>
                            <td>2022-07-25 08:11</td>
                            <td>12</td>
                        </tr>   
                        <tr>
                            <td>5</td>
                            <td>먹진남</td>
                            <td><a href="#">여기 꼭 가셈</a></td>
                            <td>2022-07-25 08:11</td>
                            <td>12</td>
                        </tr>
                        -->   
                    </tbody>
                </table>
            </div>
        </section><!--tblSec-->

        <section id="pagingSec">


            <div class="paginate_regular">
                <div class="board_pagetab">
                <!--  
                    <span class="off"><a href="#">&lt;&lt;</a>&nbsp;&nbsp;</span>
                    <span class="off"><a href="#">&lt;</a>&nbsp;&nbsp;</span>
                <ul>
                    <li class="active"><a href="#">1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                    <li><a href="#">5</a></li>
                </ul>
                    <span class="off">&nbsp;&nbsp;<a href="#">&gt;</a></span>
                    <span class="off">&nbsp;&nbsp;<a href="#">&gt;&gt;</a></span>
            -->
<%   
   if (startBlock==1) { //<<
      out.println("<span><a>&lt;&lt;</a>&nbsp;&nbsp;</span>");
   } else {
      out.println("<span><a href='mypage?cpage="+(startBlock-blockPerPage)+"'>&lt;&lt;</a>&nbsp;&nbsp;</span>");
   }

   if (cpage==1) { //<
      out.println("<span><a>&lt;</a>&nbsp;&nbsp;</span>");
   } else {
      out.println("<span><a href='mypage?cpage="+(cpage-1)+"'>&lt;</a>&nbsp;&nbsp;</span>");
   }
   
   out.println("<ul>");
   for (int i=startBlock;i<=endBlock;i++) {
      if (cpage==i) {
         out.println("<li class='active'><a>"+i+"</a></li>");
      } else {
         out.println("<li><a href='mypage?cpage="+i+"'>"+i+"</a></span>");
      }
   }
   
   out.println("</ul>");
   
   if (cpage==totalPage) { //>
      out.println("<span><a>&gt;</a></span>");
   } else {
      out.println("<span><a href='mypage?cpage="+(cpage+1)+"'>&gt;</a></span>");
   }
   
   if (endBlock==totalPage) { //>>
      out.println("<span>&nbsp;&nbsp;<a>&gt;&gt;</a></span>");
   } else {
      out.println("<span>&nbsp;&nbsp;<a href='mypage?cpage="+(startBlock+blockPerPage)+"'>&gt;&gt;</a></span>");
   }
%>                   
                </div><!-- board_pagetab -->
                
            
            </div><!-- paginate_regular -->
            
            
            
        </section>
    
    </div>

    <!-- footer 
    <footer>

    </footer>
    -->

</body>
</html>