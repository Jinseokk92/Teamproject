<%@page import="com.example.model1.NoticeTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.example.model1.TeamBossPageTO"%>
<%@page import="com.example.model1.TeamTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 디자인만 만들어놓음 -->
<%
       String log = "LOGIN";
    
       HttpSession sess = request.getSession();
       
       String loginedMemberSeq = (String)sess.getAttribute("loginedMemberSeq");
       String welcome = "";
    
       if(loginedMemberSeq != null) {
      		welcome = (String)sess.getAttribute("loginedMemberName")+"님 환영합니다.";
      		log = "LOGOUT";
      		if (loginedMemberSeq.equals("1")) {
      	   		out.println ( "<script>");
      	   		out.println( "alert('관리자는 소모임장 페이지에 들어갈 수 없습니다.');" );
      			out.println ( "history.back();");
      			out.println ( "</script>");
      	   	}
      	} else {
      		out.println ( "<script>");
   		out.println ( "window.location.href = 'http://localhost/welcome'");
   		out.println ( "</script>");
      	}
       
       TeamBossPageTO teamBossPageTO = (TeamBossPageTO)request.getAttribute("teamBossPageTO");

       int cpage = teamBossPageTO.getCpage();
       int recordPerPage = teamBossPageTO.getRecordPerPage();
       int totalRecord = teamBossPageTO.getTotalRecord();
       int totalPage = teamBossPageTO.getTotalPage();
       int blockPerPage = teamBossPageTO.getBlockPerPage();
       int startBlock = teamBossPageTO.getStartBlock();
       int endBlock = teamBossPageTO.getEndBlock();
       
       ArrayList<TeamTO> teamLists = teamBossPageTO.getTeamLists();

       int num = 1;
       
       StringBuilder sbHtml = new StringBuilder();

       for (int j = 0 ; j < teamLists.size() ; j = j+20) {
          num = (teamBossPageTO.getCpage() - 1) * 20+1;
          for (int i = j ; i < j+20 ; i++) {
             
             if (i < teamLists.size()) {
                String seq = teamLists.get(i).getSeq();
                String tseq = teamLists.get(i).getTseq();
                String tname = teamLists.get(i).getTname();
                String name = teamLists.get(i).getName();
                int memcount = teamLists.get(i).getMemcount();

                sbHtml.append( "<tr>" );
                sbHtml.append( "<td>" + num + "</td>" );
                sbHtml.append( "<td><a href='./adgroups/members?tseq=" + tseq + "' />" + tname + "</td>" );
                sbHtml.append( "<td>" + name + "</td>" );
                sbHtml.append( "<td>" + memcount + "명</td>" );
                sbHtml.append( "</tr>" );
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
    <title>소모임 목록</title>
   
    <!-- 나눔스퀘어 폰트 -->
    <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
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

a:link {  text-decoration: none}
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
  font-family: 'NanumSquareExtraBold';
  font-size: 25px;
  display: inline-block;
  padding-left: 50px;
}

#btnSec .search-wrap{
    margin-left : 50%;
   
}

#locationSec{
    width: 100%;
    background-color: #f7f7fd;
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
    font-family: 'Sunflower' !important;
}

.allbtn{
    color : #333;
    position : relative;
}
/*
.allbtn:before{
    position: absolute;
    left: 0;
    top : 0;
    margin : auto 0;
    width: 1px;
    height: 18px;
    background-color: #000;
    content: "";
    margin-top: 8%;
}
*/

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

#pagingSec .search-wrap #search{
    height: 37.6px;
    margin-right: 4px;
}


.search-wrap input{
    height: 32px;
    width: 80%;
    color: #000;
    font-size: 16px;
    box-sizing: border-box;
    margin-left:5px;
}

/* width : 30, height : 45 */
.search-wrap button{
    width: 30px;
    height: 25px;
    right: 5%;
    top: 10%;
    text-indent: -9999px;
    overflow: hidden;
    background: url( ./images/search2.png) no-repeat ;
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
                <a href="main" class="logoclick"><img src="images/logo.png" alt="logo"></a>
            </h1>
            <h3><%=welcome %><a href="bye" id="logout" style="color : gray"><br/><%=log %></a></h3>
            <ul>
                <li><b><a href="mypage" class="logoclick">마이페이지</a></b></li>
                <li><b><a href="adgroups" style="color : #de5f47;" class="logoclick">소모임장페이지</a></b></li>
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
             <button class="active"><a href="adgroups" style="color: #de5f47">소모임 목록</a></button>
        </div>
      </section>
    </nav>  

    <!-- 전체 요소를 감싸는 div -->
    <div id="wrap">
               <section id="tblSec">

            <div id="tblWrap">
                <table class="board-table">
            
                    <thead>
                        <tr>
                            <th scope="col" class="th-num">번호</th>
                            <th scope="col" class="th-teamname">소모임 이름</th>
                            <th scope="col" class="th-teamleader">소모임장</th>
                            <th scope="col" class="th-membercount">멤버수</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%=sbHtml.toString() %>
                      <!--  
                        <tr>
                            <td><a href="#">1</a></td>
                            <td><a href="bossmember.do">맥크리</a></td>
                            <td><a href="#">이다함</a></td>
                            <td><a href="#">13명</td>
                        </tr>

                        <tr>
                            <td><a href="#">2</td>
                            <td><a href="bossmember.do">윈스턴</a></td>
                            <td><a href="#">정규진</a></td>
                            <td><a href="#">13명</td>
                        </tr>         

                        <tr>
                            <td><a href="#">3</td>
                            <td><a href="bossmember.do">아나</a></td>
                            <td><a href="#">김영규</a></td>
                            <td><a href="#">13명</td>
                        </tr>   
                        <tr>
                            <td><a href="#">4</td>
                            <td><a href="bossmember.do">에코</a></td>
                            <td><a href="#">정진석</a></td>
                            <td><a href="#">13명</td>
                        </tr>   
                        <tr>
                            <td><a href="#">5</td>
                            <td><a href="bossmember.do">젠야타</a></td>
                            <td><a href="#">김영주</a></td>
                            <td><a href="#">13명</td>
                        </tr>
                        -->
                    </tbody>
                </table>
            </div>

        </section>
      <!--tblSec-->

        <!-- 페이징 처리 -->
        <section id="pagingSec">
            <div class="paginate_regular">
                <div class="board_pagetab">
            <section id="pagingSec">
            <div class="paginate_regular">
                <div class="board_pagetab">
<%   
   if (startBlock==1) { //<<
      out.println("<span><a>&lt;&lt;</a>&nbsp;&nbsp;</span>");
   } else {
      out.println("<span><a href='/adgroups?cpage="+(startBlock-blockPerPage)+"'>&lt;&lt;</a>&nbsp;&nbsp;</span>");
   }

   if (cpage==1) { //<
      out.println("<span><a>&lt;</a>&nbsp;&nbsp;</span>");
   } else {
      out.println("<span><a href='/adgroups?cpage="+(cpage-1)+"'>&lt;</a>&nbsp;&nbsp;</span>");
   }
   
   out.println("<ul>");
   for (int i=startBlock;i<=endBlock;i++) {
      if (cpage==i) {
         out.println("<li class='active'><a>"+i+"</a></li>");
      } else {
         out.println("<li><a href='/adgroups?cpage="+i+"'>"+i+"</a></span>");
      }
   }
   
   out.println("</ul>");
   
   if (cpage==totalPage) { //>
      out.println("<span><a>&gt;</a></span>");
   } else {
      out.println("<span><a href='/adgroups?cpage="+(cpage+1)+"'>&gt;</a></span>");
   }
   
   if (endBlock==totalPage) { //>>
      out.println("<span>&nbsp;&nbsp;<a>&gt;&gt;</a></span>");
   } else {
      out.println("<span>&nbsp;&nbsp;<a href='/adgroups?cpage="+(startBlock+blockPerPage)+"'>&gt;&gt;</a></span>");
   }
%>            
                
                
                </div><!-- board_pagetab -->         
            </div><!-- paginate_regular -->
        </section>
    </div>

</body>
</html>