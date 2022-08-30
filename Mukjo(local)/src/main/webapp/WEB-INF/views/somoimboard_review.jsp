<%@page import="com.example.model1.ReviewTO"%>
<%@page import="com.example.model1.NoticeTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.example.model1.BoardTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.example.model1.BoardDAO"%>
<%@page import="com.example.model1.BoardListTO"%>
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
    
   String onoff=(String)request.getAttribute("onoff");
   String avg=(String)request.getAttribute("avg");
   
   String tseq=request.getParameter("tseq");
   String search=request.getParameter("search");
   String rname = (String)request.getAttribute("rname");
   String id=request.getParameter("id");
   String latitude=request.getParameter("latitude");
   String longitude=request.getParameter("longitude");
   
   ArrayList<ReviewTO> lists = (ArrayList)request.getAttribute("lists");
   
   StringBuilder sb = new StringBuilder();
   for (ReviewTO rto : lists) {
      sb.append("<tr>");
      sb.append("<td class='nick'><span><i class='fa fa-star' style='font-size:20px;color:#de5f47; margin-right:15px;'></i>");
      sb.append(rto.getStar()+"점</td>");
      sb.append("<td>"+rto.getWriter()+"</td>");
      sb.append("<td class='comment'>"+ rto.getRcontent()+"</td>");
      if(loginedMemberSeq.equals(rto.getSeq())||loginedMemberSeq.equals("1")) {
         sb.append("<td class='data'><a href='../../../main/search/review/del?tseq="+tseq+"&search="+search+"&id="+id+"&latitude="+latitude+"&longitude="+longitude+"&rseq="+rto.getRseq()+"' style> &nbsp X </a></td> ");
      } else {
         sb.append("<td class='data'></td> ");
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
   
   StringBuilder sbhh=new StringBuilder();
   if (avg==null) {
       sbhh.append("<td colspan='4' class='homesub' style='height:61px; border-top: 2px solid black; border: 2px solid black;'><a href='#' style='font-weight:bold; margin-left: 40px;'>"+rname+"</a>");
   } else {
       sbhh.append("<td colspan='4' class='homesub' style='height:61px; border-top: 2px solid black; border: 2px solid black;'><a href='#' style='font-weight:bold; margin-left: 40px;'>"+rname+"&nbsp;(&nbsp;<i class='fa fa-star' style='font-size:20px;color:#f1b654;'></i>&nbsp;<span>"+avg+"점</span>&nbsp;)</a>");
   }
    %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>세부내용 리뷰</title>
    <style href="css/common.css"></style>
    <!-- 나눔스퀘어 폰트 -->
    <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Sunflower:500" rel="stylesheet">
    <!-- 부트스트랩 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
    <!-- 제이쿼리 -->
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.1/jquery.raty.min.js" integrity="sha512-Isj3SyFm+B8u/cErwzYj2iEgBorGyWqdFVb934Y+jajNg9kiYQQc9pbmiIgq/bDcar9ijmw4W+bd72UK/tzcsA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
   
   <!-- Bootstrap (for modal) -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
   
<!-- 지도 -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=f8b62z9xjz&amp;submodules=geocoder"></script>


<style>
/** common **/
a:link {  color: black; text-decoration: none}
    a:visited {color: black; text-decoration: none;}
    a:hover {color: #f1b654; text-decoration: none;}
    a:active {color: #de5f47; text-decoration: none;}
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
img{
    width: 100%;
    padding-bottom: 5px;
}
table{
    text-align: center;
    table-layout: fixed;
    border-spacing: 0px;
    border-collapse: separate;
}
:root {
  --button-color: #ffffff;
  --button-bg-color: #5c3018;
  --button-hover-bg-color: none;
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
#headerWap h3{
   
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
 
  display: inline-block;
}
/* 버튼 섹션*/
#btnSec {
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
#itemBox{
    height: 325px;
    overflow-y: auto;
}
#tabBox th{
    width : 23%;
}
.mainmenu{
    border: 1px solid #fff;
    border-radius: 4px;
    margin-right: 20px;
    font-size: 12px;
    padding: 0 5px 0 5px;
    background: #de5f47;
    color: #ffffff;
}
.tblmain table th{
    background-color: #f7f7fd;
}
.cmttable tr{
   border-bottom: 2px solid #c4b2b2;
   border-top: 2px solid #aa9d9d;
   border-right: none;
   border-left: none;
}
.cmttable td{
   vertical-align: top;
   border-right: none;
   border-left: none;
    padding: 10px 0;
}
.nick{
    padding-left: 10px;
   width: 80px;
    color:blue;
}
.tablewrap table td:nth-last-child(2) { /*뒤에서 (n)번째에 해당색을 집어넣으려고 할 때 */
    width:440px;
}
.tablewrap table td:nth-last-child(3){
    color : #de5f47;
    width: 80px;
}
.tablewrap table tr{
    border-bottom: 2px solid #c4b2b2;
   border-top: 2px solid #aa9d9d;
   border-right: none;
   border-left: none;
}
.btn_list2 {
   display: inline-block;
   background: #f3f3f3;
   border: 1px solid;
    border-color: #ccc #c6c6c6 #c3c3c3 #ccc;
   padding: 6px 17px 7px 17px;
}
.btn_txt03 {
   color: #000;
   font-weight: 600;
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
 td { word-break: break-all;
}
/***** footer  *****/
footer{
    width: 100%;
    height: 163px;
    background-color: #d7d7d7;
    margin-top: 5%;
}

.tblmain table th {
   border: 1px solid black;
   border-bottom: none;
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
.iw_inner {
   margin: 5px;
   padding: 1px 5px;
   border-radius: 30px;
   background-color: rgba(4, 117, 244, 0.9);
}
.checkbox {
   float: right;
   
}
#star {
   width: 40px;
   margin-top: 10px;
   
}
input[type="checkbox"]+label {
    display: flex;
    width: 28px;
    height: 28px;
    background: url('../../../images/heart1.png') no-repeat 0 0px / contain;
}
input[type='checkbox']:checked+label {
    background: url('../../../images/heart2.png') no-repeat 0 1px / contain;
}
input[type="checkbox"] {
    display: none;
}

/* button */
.logoclick:active {
  top: 3px;
  border-color: rgba(0,0,0,0.34) rgba(0,0,0,0.21) rgba(0,0,0,0.21);
  box-shadow: 0 1px 0 rgba(255,255,255,0.89),0 1px rgba(0,0,0,0.05) inset;
  position: relative;
}

#btnarrow {
   position: absolute;
    float: left;
    top: 10px;
    left: 0;
}

#btnarrow i{
    font-size: 20px;
}

#btnarrow title{
    font-size: 20px;
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
                <a href="/../../../main" class="logoclick"><img src="../../../images/logo.png" alt="logo"></a>
            </h1>
            <h3><%=welcome %><a href="/../../../bye" id="logout" style="color : gray"><br/><%=log %></a></h3>
            <ul>
                <li><b><a href="/../../../mypage" class="logoclick">마이페이지</a></b></li>
                <li><b><a href="/../../../adgroups" class="logoclick">소모임장페이지</a></b></li>
                <li><b><a href="/../../../admin" class="logoclick">관리자페이지</b></li></a>
               <li><b><a href="/../../../favorite" class="logoclick">즐겨찾기</b></li></a>
                <li id="bell" style="margin-left: 20px;">
                   <button type="button" id="modalBtn" class="btn" data-bs-toggle="modal" data-bs-target="#exampleModal">
                  <img src="../../../images/bell.png">
               </button><%=noticeCount %>
            </li>
            </ul>
          </div>
        </div> <!--headerWap-->
   
   
       <!--locationSec -->
      <section id="locationSec">
        <div id = "locationwrap">
             <button class="active"><a href="../../../main/board?tseq=<%=tseq %>">게시판</a></button>
             <button class="allbtn"><a href="../../../main/search?tseq=<%=tseq %>" style="color : #de5f47">식당 검색</a></button>
             <button class="allbtn"><a href="../../../main/members?tseq=<%=tseq %>">소모임 회원 목록</a></button>
             <button class="allbtn" id="bsbtn"><a href="../../../main/quitgroup?tseq=<%=tseq %>">소모임 탈퇴</a></button>
        </div>
      </section>
    </nav>  
    
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
          <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal"><a href="../../../notice/read"><b>읽음</b></a></button>
          <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal"><a href=""><b>닫기</b></a></button>
        </div>
      </div>
    </div>
  </div>

    <!-- 전체 요소를 감싸는 div -->
    <div id="wrap">


        <!-- 게시판 이름이 있는 섹션입니다 -->
        <section id="titSec">
            <strong></strong>
        </section>

               <div class="tblmain" style= "display: flex; justify-content: space-around;">
                    <div style="width: 50%;">
                         <table border="1" style="width: 100%; height: 20%; border-collapse: separate; border-bottom: 2px solid black" >  
                             <thead>
                               <tr style="position:relative; height:61px; border-collapse: separate;">
                        <%=sbhh %>      
                        <button id="btnarrow" type="button" class="btn btn-outline-none" data-bs-toggle="tooltip" data-bs-placement="top" title="검색결과 다시보기">
                             <a href="../../main/search?tseq=<%=tseq %>&search=<%=search%>"><i class="bi bi-arrow-90deg-left"></i></a>
                        </button>                               
                                      <div class="checkbox">
                                         <input type="checkbox" id="favCheck" <%=onoff %>>
                               <label for="favCheck" style="margin-right: 10px;"></label>
                             </div>
                        
                        
                                  <tr id="tabBox" style="height:61px; border: 1.5px solid black">
                                    <th scope="col" class="th-title"><a href="../../../main/search/info?tseq=<%=tseq%>&search=<%=search %>&id=<%=id %>&latitude=<%=latitude %>&longitude=<%=longitude %>" >홈</a></th>
                                    <th scope="col" class="th-date"><a href="../../../main/search/review?tseq=<%=tseq%>&search=<%=search %>&id=<%=id %>&latitude=<%=latitude %>&longitude=<%=longitude %>" style="color : #de5f47">리뷰</a></th>
                                    <th scope="col" class="th-num"><a href="../../../main/search/menu?tseq=<%=tseq%>&search=<%=search %>&id=<%=id %>&latitude=<%=latitude %>&longitude=<%=longitude %>" >메뉴</a></th>
                                    <th scope="col" class="th-date"><a href="../../../main/search/pic?tseq=<%=tseq%>&search=<%=search %>&id=<%=id %>&latitude=<%=latitude %>&longitude=<%=longitude %>" >사진</a></th>
                                </tr> 
                            </thead>

                            
                         </table>


                         <div id="itemBox">
                         
                           <div class="cmteditor" style="padding: 12px 16px 20px;background: #fcfcfc;border: 1px solid #ddd;
            border-bottom-color: #ccc; border-radius: 8px; box-shadow: 0 1px 3px -1px rgb(0 0 0 / 10%);">
         
            <form action="../../../main/search/review/write" name ="rfrm" style="display: block; position: relative; clear: both;">           
               <label for="editorlabel" style="cursor: pointer; position: relative; margin-bottom: 10px;"> 
               
               <strong style="padding-left:5px;font-size:16px;line-height:1.5;">리뷰 쓰기
                        <div id="star" style="width : 130px; display:flex;" >
                        </div>
                       </strong>
               </label>
            <input type="hidden" id="starRating" name="star" value="3" />
            <input type="hidden" name="tseq" value="<%=tseq %>" />         
            <input type="hidden" name="search" value="<%=search %>" />         
            <input type="hidden" name="id" value="<%=id %>" />
            <input type="hidden" name="latitude" value="<%=latitude %>" />         
            <input type="hidden" name="longitude" value="<%=longitude %>" />
            
            <div class="textcmt" style="display: flex; margin-top: 10px;">
               <textarea name="content" style="background: rgb(255, 255, 255); overflow: hidden; min-height: 4em; resize: none;
               height: 49px;width: 85%; margin-left: 3px;"></textarea>

            <input type="button" id="rwbtn" value="등록" class="btn_list2 btn_txt03"
            style="cursor: pointer; margin-left:40px ;"  />
            </div>

            </form>

            </div> <!-- cmteditor -->

                            <div class="cmttable" style="clear: both; margin-bottom: 8px; overflow: hidden; _height: 1%;
                                                    background: #fff; margin-top:20px; display: table; border-collapse: separate;">
            <div class="tablewrap" style="display : table-cell;">
            <table width="100%" cellpadding="0" cellspacing="0" style="table-layout : fixed; text-align: start;  border-collapse: collapse;">
               <tbody>
                <%=sb %>

               </tbody>

            </table>
            </div>
         </div><!-- cmttable -->

          
                         
                        </div><!-- itembox -->
                    </div><!-- width50%용 div -->


                    <div class="maps" style="width:50%;">
            <div id="map" style="width:100%;height:450px;"></div>
         </div>
      </div><!-- tblWrap -->
   </div>
<!-- footer 
<footer>
</footer>
 -->
</body>
<script type="text/javascript">
$(function() {
   $('#favCheck').on('click', function(){
      if (document.querySelector('#favCheck').checked == true) {
         location.href='../../../favorite/add?id=<%=id %>';
      } else {
         location.href='../../../favorite/del?id=<%=id %>';
      }
   });
});
window.onload = function() {
      document.getElementById( 'rwbtn' ).onclick = function() {
         if( document.rfrm.content.value.trim() == "" ) {
            alert( '내용을 입력하셔야 합니다.' );
            return false;
         }
         
         document.rfrm.submit();
      };
      
   };
   
$(function() {
   initMap();
})
function initMap() {
   var map = new naver.maps.Map('map', {
       center: new naver.maps.LatLng(<%=latitude %>, <%=longitude %>),
       zoom: 17
   });
   
   var marker = new naver.maps.Marker({
         position: new naver.maps.LatLng(<%=latitude %>, <%=longitude %>),
         map: map
   });
   
   var infoWindow = new naver.maps.InfoWindow({
       content: '<div class=\"iw_inner\"><div class=\"div_font\"style=\"font-size:13px;font-weight:600;text-align:center;padding:10px;color:#ffffff;\"><b><%= rname%></b></div></div>',
          borderWidth: 0,
          disableAnchor: true,
          backgroundColor: 'transparent'
    });
   
   infoWindow.open(map, marker);
}
$(function() {
    $('div#star').raty({
        score: 3
        ,path : "/../../../images/"
        ,width : 130
        ,click: function(score, evt) {
            $("#starRating").val(score);
            $("#displayStarRating").html(score);
        }
    });
});
</script>
</html>