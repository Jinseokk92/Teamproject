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
    
    
      BoardListTO listTO = new BoardListTO();
   
      
      BoardDAO dao = new BoardDAO();
      listTO = (BoardListTO)request.getAttribute("listTO");
      int cpage = listTO.getCpage();
      int recordPerPage = listTO.getRecordPerPage();
      
      int totalRecord = listTO.getTotalRecord();
      int totalPage = listTO.getTotalPage();
      
      int blockPerPage = listTO.getBlockPerPage();
      int startBlock = listTO.getStartBlock();
      int endBlock = listTO.getEndBlock();
      
      ArrayList<BoardTO> boardLists = listTO.getBoardLists();
      
      StringBuilder sb = new StringBuilder();
      
      String bseq = "";
      String subject = "";
      String content = "";
      String writer = "";
      String wdate = "";
      String hit = "";
      String filename = "";
      int cmtcount=0;
      
      String tseq = (String)request.getAttribute("tseq");
      String tname = (String)request.getAttribute("tname");

      for( int i = 0 ; i < boardLists.size(); i++ ) {
         BoardTO to = boardLists.get(i);
         bseq = to.getBseq();
         // 이거 바꿔야함
         tseq = to.getTseq();
         subject = to.getSubject();
         content = to.getContent();
         writer = to.getWriter();
         wdate = to.getWdate();
         hit = to.getHit();
         filename = to.getFilename();
         cmtcount=to.getCmtCount();

         if (filename==null) {
            sb.append("<tr>");
             sb.append("      <td>일반</a></td>");
             sb.append("      <td>"+ writer+"</a></td>");
             sb.append("      <td><a href='../../main/board/view?tseq="+tseq+"&bseq="+bseq+"&cpage="+cpage+"'>"+ subject+"</a> &nbsp;&nbsp;<span class='numspan'>["+cmtcount+"]</span></td>");
             sb.append("      <td>"+ wdate+"</a></td>");
             sb.append("      <td>"+ hit+"</a></td>");
             sb.append("</tr>");
         } else {
            sb.append("<tr>");
             sb.append("      <td>일반</a></td>");
             sb.append("      <td>"+ writer+"</a></td>");
             sb.append("      <td><a href='../../main/board/view?tseq="+tseq+"&bseq="+bseq+"&cpage="+cpage+"'>"+ subject+"</a>&nbsp;<img src='../images/Img_show.png'>&nbsp;&nbsp;<span class='numspan'>["+cmtcount+"]</span></td>");
             sb.append("      <td>"+ wdate+"</a></td>");
             sb.append("      <td>"+ hit+"</a></td>");
             sb.append("</tr>");
         }   
      }
      tseq = request.getParameter("tseq");
 
      ArrayList<BoardTO> noticeLists = (ArrayList)request.getAttribute("noticeLists");
      
      StringBuilder noticeSb = new StringBuilder();
      if(cpage == 1) {
      for( BoardTO to : noticeLists ) {
        bseq = to.getBseq();
        subject = to.getSubject();
        content = to.getContent();
        writer = to.getWriter();
        wdate = to.getWdate();
        hit = to.getHit();
        filename = to.getFilename();
        
        if (filename==null) {
               noticeSb.append("<tr class='notice'>");
            noticeSb.append("      <td><a href='#'>공지</a></td>");
            noticeSb.append("      <td><a href='#'>"+ writer+"</a></td>");
            noticeSb.append("      <td><a href='../../main/board/view/notice?tseq="+tseq+"&bseq="+bseq+"&cpage="+cpage+"'>"+ subject+"</a></td>");
            noticeSb.append("      <td><a href='#'>"+ wdate+"</a></td>");
            noticeSb.append("      <td><a href='#'>"+ hit+"</a></td>");
            noticeSb.append("</tr>");
        } else {
           noticeSb.append("<tr class='notice'>");
            noticeSb.append("      <td><a href='#'>공지</a></td>");
            noticeSb.append("      <td><a href='#'>"+ writer+"</a></td>");
            noticeSb.append("      <td><a href='../../main/board/view/notice?tseq="+tseq+"&bseq="+bseq+"&cpage="+cpage+"'>"+ subject+"</a>&nbsp;<img src='../images/Img_show.png'></td>");
            noticeSb.append("      <td><a href='#'>"+ wdate+"</a></td>");
            noticeSb.append("      <td><a href='#'>"+ hit+"</a></td>");
            noticeSb.append("</tr>");
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
    <title>소모임게시판</title>
    <style href="css/common.css"></style>
    <!-- 나눔스퀘어 폰트 -->
    <link href="https://fonts.googleapis.com/css?family=Sunflower:500" rel="stylesheet">
    <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
   
   <!-- Bootstrap (for modal) -->
   
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<style>
/** common **/
.numspan{
   display: inline-block;
   line-height:1px;
   margin-left : 5px;
   color : black;
   font-weight: bold;
   font-size: 13px;
}

body,ul ,li, h1,h2,h3{
    margin: 0;
    padding: 0;
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
    font-family: 'Sunflower' !important;
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
    a:hover {color: #de5f47;; text-decoration: none;}
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
   font-family: 'Sunflower' !important;
   display: inline-block;
   background: #5c3018;
   border: 1px solid #404144;
   padding: 6px 17px 7px 17px;
   transition: 0.5s;
}

.btn_list:hover {
   background-color: #5c3018;
}

.btn_txt02 {
   color: white;
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
    border-bottom: #c7bebe 1px solid;
    z-index: 1050;
}

#header ul{
    display: flex;
    font-family: 'NanumSquareBold';
}

#header ul li{
	font-family: 'Sunflower' !important;
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
   font-family: 'Sunflower' !important;
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
   font-family: 'Sunflower' !important;
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
    font-family: 'Sunflower' !important;
    
}
.notice {
   background-color: #F2F2F2;
}

.notice td>a:first-child{

    font-weight: bold;
}

/***** pagingSec  *****/
#pagingSec ul{
    display: flex;
}

#pagingSec{
    display: flex;
    justify-content: center;
    margin-top: 30px;
    line-height: 2.5;
}

#btnSec .search-wrap{
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
	font-family: 'Sunflower' !important;
    font-size: 14px;
    font-weight: 600;
}

#btnSec .search-wrap .select select{
    border: 2px solid #5c3018;
    border-radius: 10px;
    height: 36px;
    width: 90px;
    box-sizing: border-box;
    padding-left: 10px;
}

.search-wrap select option{
    font-weight: normal;
    display: block;
    white-space: nowrap;
    min-height: 1.2em;
    padding: 0px 2px 1px;
}

#pagingSec .search-wrap #search{
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
.search-wrap button{
    width: 30px;
    height: 25px;
    right: 5%;
    top: 10%;
    text-indent: -9999px;
    overflow: hidden;
    background: url( ../images/search2.png) no-repeat ;
    position: absolute;
    background-size: 38px 25px;
 
}

#pagingSec ul li{
    width: 42px;
    height: 42px;
    text-align: center;
    line-height: 42px;
    margin-right: 10px;
    border: 1px solid #c4c4c4;
    border-radius: 10%;
}

#pagingSec .active{
    color:white;
    background-color: #de5f47;
}
   .board_pagetab { text-align: center; display: inline-flex; position:relative;}
   .board_pagetab a { text-decoration: none; font: 12px verdana; color: #000; padding: 0 3px 0 3px; }
    /* .board_pagetab ul a:hover  { background-color:black; } */
   .on a { font-weight: bold; }

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
.modal-dialog {
    position: fixed;
    margin: auto;
    width: 320px;
    height: 100%;
    right: 0px;
}

.modal-content {
	font-family: 'Sunflower' !important;
    border: 1px solid black;
    height: 100%;
}
#noticelogo {
   width: 25%;
}

.modal-body {
   font-family: 'Sunflower' !important;
   padding-top: 0px;
   height: 100%;
}

.modal-body span {
	font-family: 'Sunflower' !important;
	float: right;
}

.notice img {
   object-fit: cover;
   width: 15px;
}

.board-table img {
   object-fit: cover;
   width: 15px;
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
                <a href="../../main" class="logoclick"><img src="../images/logo.png" alt="logo"></a>
            </h1>
            <h3><%=welcome %><a href="../../bye" id="logout" style="color : gray"><br/><%=log %></a></h3>
            <ul>
                <li><b><a href="../../mypage" class="logoclick">마이페이지</a></b></li>
                <li><b><a href="../../adgroups" class="logoclick">소모임장페이지</a></b></li>
                <li><b><a href="../../admin" class="logoclick">관리자페이지</b></li></a>
               <li><b><a href="../../favorite" class="logoclick">즐겨찾기</b></li></a>
                <li id="bell" style="margin-left: 20px;">
                   <button type="button" id="modalBtn" class="btn" data-bs-toggle="modal" data-bs-target="#exampleModal">
                  <img src="../images/bell.png">
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
          <span id="noticelogo"><img src="../images/logo.png"></span>
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
             <button class="active"><a href="../../main/board?tseq=<%=tseq %>" style="color : #de5f47">게시판</a></button>
             <button class="allbtn"><a href="../../main/search?tseq=<%=tseq %>">식당 검색</a></button>
             <button class="allbtn"><a href="../../main/members?tseq=<%=tseq %>">소모임 회원 목록</a></button>
             <button class="allbtn" id="bsbtn"><a href="../../main/quitgroup?tseq=<%=tseq %>">소모임 탈퇴</a></button>
        </div>
      </section>
    </nav>  
    

    <!-- 전체 요소를 감싸는 div -->
    <div id="wrap">
        <!-- 게시판 이름이 있는 섹션입니다 -->
        <section id="titSec">
            <strong></strong>
        </section>
          
        <section id ="btnSec" >
            <strong>소모임 : <b><%=tname %></b></strong>

            <div class="search-wrap"> 
            <form action="../../main/board?tseq=<%=tseq %>" method="post" name="sfrm"> 
                <div class="select">

               <select class="form-select" aria-label="Default select example" name="which">
                  <option value="subject">제목</option>
                  <option value="content">내용</option>
                  <option value="writer">글쓴이</option>
                   </select> 


               </div><!-- select-->
               <div class="input">          
                  <input type="text" title="검색어 입력" name="search" value="">
                  <button type="submit">검색</button>
               </div><!-- input -->
           </form>
            </div><!-- search-wrap -->
           
        </section>
    
        <!-- 테이블 목록이 있는 섹션입니다 -->
        <section id="tblSec">

            <div id="tblWrap">
                <table class="board-table">
            
                    <thead>
                        <tr>
                            <th scope="col" class="th-num" style="width:10%;">분류</th>
                            <th scope="col" class="th-date" style="width:13%;">글쓴이</th>
                            <th scope="col" class="th-title">제목</th>
                            <th scope="col" class="th-date">등록일</th>
                            <th scope="col" class="th-date">조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                        
                        <%=noticeSb %>
                        <%=sb %>
                        <!-- 
                            <td><a href="#">공지</td>
                            <td><a href="#">[중요]게시판 이용시 준수사항</a></td>
                            <td><a href="#">관리자</a></td>
                            <td><a href="#">2022-08-01</a></td>
                            <td><a href="#">13</a></td>
                        </tr>

                       <tr>
                            <td><a href="#">일반</a></td>
                            <td><a href="#">여기 가보신분 있어요?</a>&nbsp;<img src="./images/Img_show.png"></td>
                            <td><a href="#">이다함</a></td>
                            <td><a href="#">2022-07-31</a></td>
                            <td><a href="#">30</a></td>
                        </tr>         

                        <tr>
                            <td><a href="#">일반</a></td>
                            <td><a href="#">여기 맛집강추</a></td>
                            <td><a href="#">김영주</a></td>
                            <td><a href="#">2022-07-31</a></td>
                            <td><a href="#">30</a></td>
                        </tr>   
  
                        <tr>
                            <td><a href="#">일반</a></td>
                            <td><a href="#">회식장소 괜찮나요?</a></td>
                            <td><a href="#">정진석</a></td>
                            <td><a href="#">2022-07-31</a></td>
                            <td><a href="#">30</a></td>
                        </tr>   

                        <tr>
                            <td><a href="#">일반</a></td>
                            <td><a href="#">점심메뉴 추천좀요</a></td>
                            <td><a href="#">정규진</a></td>
                            <td><a href="#">2022-07-31</a></td>
                            <td><a href="#">30</a></td>
                        </tr>    -->
                    </tbody>
                </table>
            </div>

        </section><!--tblSec-->

        
        <section id="pagingSec">
        
        
            <div class="paginate_regular">
                <div class="board_pagetab" style="margin-left: 300px; ">
                
                <%         
               if( startBlock == 1 ) {
                  out.println( "<span class='on'>&lt;&lt;</span>" );
               } else {
                  out.println( "<span class='off'><a href='../../main/board?tseq="+tseq+"&cpage=" + ( startBlock - blockPerPage ) + "'>&lt;&lt;</a></span>" );
               }
               
               out.println( "&nbsp;&nbsp;&nbsp;" );
            
               if( cpage == 1 ) {
                  out.println( "<span class='on'>&lt;</span>" );
               } else {
                  out.println( "<span class='off'><a href='../../main/board?tseq="+tseq+"&cpage=" + ( cpage - 1 )+ "'>&lt;&nbsp;</a></span>" );
               }
               
               out.println( "&nbsp;&nbsp;&nbsp;" );
               
               out.println( "<ul>");
               
               for( int i=startBlock ; i<=endBlock ; i++ ) {
                  if( cpage == i ) {
                     out.println( "<li class='active'> " + i + " </li>" );
                  } else {
                     out.println( "<li class='off'><a href='../../main/board?tseq="+tseq+"&cpage=" + i + "'>" + i + "</a></li>" );
                  }
               }
            	
               
               out.println( "</ul>");
               out.println( "&nbsp;" );
               
               if( cpage == totalPage ) {
                  out.println( "<span class='on'>&gt;</span>" );
               } else {
                  out.println( "<span class='off'><a href='../../main/board?tseq="+tseq+"&cpage=" + ( cpage + 1 )+ "'>&gt;</a></span>" );
               }
               
               out.println( "&nbsp;&nbsp;&nbsp;" );
               
               if( endBlock == totalPage ) {
                  out.println( "<span class='on'>&gt;&gt;</span>" );
               } else {
                  out.println( "<span class='off'><a href='../../main/board?tseq="+tseq+"&cpage=" + ( startBlock + blockPerPage ) + "'>&gt;&gt;</a></span>" );
               }
%>
                
<!--                     <span class="off"><a href="#">&lt;&lt;</a>&nbsp;&nbsp;</span>
                    <span class="off"><a href="#">&lt;</a>&nbsp;&nbsp;</span>
                <ul>
                    <li class="active"><a href="#">1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                    <li><a href="#">5</a></li>
                </ul>
                    <span class="off">&nbsp;&nbsp;<a href="#">&gt;</a></span>
                    <span class="off">&nbsp;&nbsp;<a href="#">&gt;&gt;</a></span> -->
                     <div style= "margin-left: 350px;">
                        <input type="button" value="글 쓰기" class="btn_list btn_txt02"  
                        style="cursor: pointer; position: absolute; right: -235px;"
                  onclick="location.href='../../main/board/write?tseq=<%=tseq %>&cpage=<%=cpage %>'" /> 
                        </div>
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