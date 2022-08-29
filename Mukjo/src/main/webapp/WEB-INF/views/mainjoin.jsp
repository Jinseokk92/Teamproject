<%@page import="com.example.model1.NoticeTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.example.model1.PageTeamMemberTO"%>
<%@page import="com.example.model1.MemberTO"%>
<%@page import="java.util.ArrayList"%>
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
    
       PageTeamMemberTO pageTeamMemberTO = (PageTeamMemberTO)request.getAttribute("pageTeamMemberTO");

       int cpage = pageTeamMemberTO.getCpage();
       int recordPerPage = pageTeamMemberTO.getRecordPerPage();
       int totalRecord = pageTeamMemberTO.getTotalRecord();
       int totalPage = pageTeamMemberTO.getTotalPage();
       int blockPerPage = pageTeamMemberTO.getBlockPerPage();
       int startBlock = pageTeamMemberTO.getStartBlock();
       int endBlock = pageTeamMemberTO.getEndBlock();
       
       ArrayList<MemberTO> memberLists = pageTeamMemberTO.getTeamMemberLists();

       int num = 1;
       String tname = "";
       String tseq = request.getParameter("tseq");
       
       StringBuilder sbHtml = new StringBuilder();

       for (int j = 1 ; j < memberLists.size() ; j = j+20) {
          num = (pageTeamMemberTO.getCpage() - 1) * 20+1;
          for (int i = j ; i < j+20 ; i++) {
             
             if (i < memberLists.size()) {
                String seq = memberLists.get(i).getSeq();
                String name = memberLists.get(i).getName();
                String email = memberLists.get(i).getEmail();
                String birth = memberLists.get(i).getBirth();
                String accept = memberLists.get(i).getAccept();
                tname = memberLists.get(i).getTname();
                // 소모임 장 가입 승인 필요 
                if(accept.equals("1")) {
                   sbHtml.append( "<tr>" );
                    sbHtml.append( "<td>" + num + "</td>" );
                    sbHtml.append( "<td>" + name + "</td>" );
                    sbHtml.append( "<td>" + email + "</td>" );
                    sbHtml.append( "<td>" + birth + "</td>" );
                    sbHtml.append( "</tr>" );
                    num+=1;
                }
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
    <title>소모임 가입신청</title>
    <style href="css/common.css"></style>
    <!-- 나눔스퀘어 폰트 -->
    <link href="https://fonts.googleapis.com/css?family=Sunflower:500" rel="stylesheet">
    <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
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

#locationwrap button{
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

a:link {  color : black; text-decoration: none}
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

#headerWap h3 {
   font-size: 15px;
   justify-content: left;
   position: absolute;
   margin-left: 120px;
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
    font-family: 'NanumSquareBold';
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

a{
    text-decoration: none;
}

*{
    box-sizing: border-box;
}

.btn-close{
    position: absolute;
    top : 15px;
    right: 15px;
}

.btn-guide{
    background-color: #de5f47;
    color: #fff;
    border-radius: 5px;
    font-size: 14px;
    padding : 7px;
}

.btn-guide a{
    color : #fff
}


.swal2-styled .swal2-cancel{
    display : none;
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
    background: url( ../../../images/search2.png) no-repeat ;
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

</style>

</head>
<body>
    <nav id="header">
        <div class="headermake" style="width:100%; background-color: #fff;">
        <div id="headerWap">
            <h1 id="logoSec">
                <a href="../../../main"><img src="../../../images/logo.png" alt="logo"></a>
            </h1>
            <h3 > <%=welcome %> <a href="../../../bye" id="logout" style="color : gray"> <br/><%=log %>   </a></h3>
            
            <ul>
                <li><b><a href="../../../mypage">마이페이지</a></b></li>
                <li><b><a href="../../../adgroups">소모임장페이지</a></b></li>
                <li><b><a href="../../../admin">관리자페이지</b></li></a>
            <li><b><a href="../../../favorite">즐겨찾기</b></li></a>
            
                <li id="bell" style="margin-left: 20px;">
                   <button type="button" id="modalBtn" class="btn" data-bs-toggle="modal" data-bs-target="#exampleModal">
                  <img src="../../../images/bell.png">
               </button><%=noticeCount %>
            </li>

            </ul>
        </div> <!--headerWap-->
    </div>
   
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
          <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal"><a href="../../../notice/read"><b>읽음</b></button>
          <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal"><a href=""><b>닫기</b></button>
        </div>
      </div>
    </div>
  </div>
      
   
   
      <!--locationSec -->
      <section id="locationSec">
        <div id = "locationwrap">
             <button class="allbtn"><a href="../../../main">가입한 소모임</a></button>
             <button class="active"><a href="../../../main/groups" style="color : #de5f47">전체 소모임</a></button>
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

         
            <button id="joinsomoim">가입 신청</button>
        </section>
        <!-- 소모임 가입하기 -->
      <script type="text/javascript">
      
      $("#joinsomoim").click(function () {
         Swal.fire({
            title: '소모임 가입 신청',
            html: '소모임 이름: ' + '<%=tname %>' + '<br />가입을 신청하시겠습니까?',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '가입',
            cancelButtonText: '취소',
            reverseButtons: false, // 버튼 순서 거꾸로    
         }).then((result) => {
            if (result.isConfirmed) {
               var tseq = <%=tseq %>;
               var seq = <%=loginedMemberSeq %>;
               
               $.ajax({
                  type: 'get',
                    url: '../../../main/groups/members/join',
                    data: { 'tseq': tseq, 'seq': seq },
                    success: function(flag) {
                       console.log($.trim(flag));
                       if($.trim(flag) == 2) {
                          Swal.fire({
                             title: '가입 신청 완료',
                             html: '가입 신청이 완료되었습니다.<br />소모임장의 승인을 기다려주세요.',
                             icon: 'success',
                          })
                       } else if($.trim(flag) == 1) {
                          Swal.fire({
                             title: '가입 신청 실패',
                             html: '가입을 신청하신 소모임입니다.<br />소모임장의 승인을 기다려주세요.',
                             icon: 'error',
                          })
                       }
                    },
                    error: function(data) {}
               })
            }
         }) 
      });
      </script>

        <!-- 테이블 목록이 있는 섹션입니다 -->
        <section id="tblSec">

            <div id="tblWrap">
                <table class="board-table">
            
                    <thead>
                        <tr>
                            <th scope="col" class="th-num"><a>번호</a></th>
                            <th scope="col" class="th-title"><a>이름</a></th>
                            <th scope="col" class="th-date"><a>이메일</a></th>
                            <th scope="col" class="th-date"><a>생일</a></th>
                        </tr>
                    </thead>
                    <tbody>
                    <%=sbHtml.toString() %>
                    <!-- 
                        <tr>
                            <td><a href="#">1</td>
                            <td><a href="#">김영주</a></td>
                            <td><a href="#">youngju@naver.com</a></td>
                            <td><a href="#">980524</a></td>
                        </tr>

                        <tr>
                            <td><a href="#">2</a></td>
                            <td><a href="#">이다함</a></td>
                            <td><a href="#">daham@naver.com</a></td>
                            <td><a href="#">960825</a></td>
                        </tr>         

                        <tr>
                            <td><a href="#">3</a></td>
                            <td><a href="#">정진석</a></td>
                            <td><a href="#">jinsuk@google.com</a></td>
                            <td><a href="#">920129</a></td>
                        </tr>   
                        <tr>
                            <td><a href="#">4</a></td>
                            <td><a href="#">정규진</a></td>
                            <td><a href="#">kkk817@naver.com</a></td>
                            <td><a href="#">920817</a></td>
                        </tr>   
                        <tr>
                            <td><a href="#">5</a></td>
                            <td><a href="#">김영규</a></td>
                            <td><a href="#">dudrb7795@gmail.com</a></td>
                            <td><a href="#">930207</a></td>
                        </tr>  -->  
                    </tbody>
                </table>
            </div>

        </section><!--tblSec-->

        
        <section id="pagingSec">


            <div class="paginate_regular">
                <div class="board_pagetab">
               <!-- <span class="off"><a href="#">&lt;&lt;</a>&nbsp;&nbsp;</span>
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
<%   
   if (startBlock==1) { //<<
      out.println("<span><a>&lt;&lt;</a>&nbsp;&nbsp;</span>");
   } else {
      out.println("<span><a href='../../../main/groups/members?cpage="+(startBlock-blockPerPage)+"'>&lt;&lt;</a>&nbsp;&nbsp;</span>");
   }

   if (cpage==1) { //<
      out.println("<span><a>&lt;</a>&nbsp;&nbsp;</span>");
   } else {
      out.println("<span><a href='../../../main/groups/members?cpage="+(cpage-1)+"'>&lt;</a>&nbsp;&nbsp;</span>");
   }
   
   out.println("<ul>");
   for (int i=startBlock;i<=endBlock;i++) {
      if (cpage==i) {
         out.println("<li class='active'><a>"+i+"</a></li>");
      } else {
         out.println("<li><a href='../../../main/groups/members?cpage="+i+"'>"+i+"</a></span>");
      }
   }
   
   out.println("</ul>");
   
   if (cpage==totalPage) { //>
      out.println("<span><a>&gt;</a></span>");
   } else {
      out.println("<span><a href='../../../main/groups/members?cpage="+(cpage+1)+"'>&gt;</a></span>");
   }
   
   if (endBlock==totalPage) { //>>
      out.println("<span>&nbsp;&nbsp;<a>&gt;&gt;</a></span>");
   } else {
      out.println("<span>&nbsp;&nbsp;<a href='../../../main/groups/members?cpage="+(startBlock+blockPerPage)+"'>&gt;&gt;</a></span>");
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