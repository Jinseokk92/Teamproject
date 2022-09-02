<%@page import="com.example.model1.NoticeTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.example.model1.MenuTO"%>
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
    
       String onoff=(String)request.getAttribute("onoff");
       String avg=(String)request.getAttribute("avg");
       
       String tseq = request.getParameter("tseq");
       String search=request.getParameter("search");

       String id=request.getParameter("id");
       String latitude=request.getParameter("latitude");
       String longitude=request.getParameter("longitude");
       ArrayList<MenuTO> resMenu = (ArrayList<MenuTO>)request.getAttribute("resMenu");
       String rname = (String)request.getAttribute("rname");

       String rmenuimage="";
      String rmenuname="";
      String rmenuprice="";
      
       StringBuilder sb = new StringBuilder();

      for( int i = 0 ; i < resMenu.size(); i++ ) {
            MenuTO to = resMenu.get(i);

            rmenuimage = to.getRmenuimage();
            rmenuname = to.getRmenuname();
            rmenuprice = to.getRmenuprice();          
            
            if(i%2 == 0) {
                sb.append("<div class='fl'>");
                sb.append("<li>");
                sb.append("<div class='divimg 'style='background-image: url("+rmenuimage+")';>");
                sb.append("<div class='st1'><span class='spanmenu'>"+rmenuname+"</span>");
                sb.append("<div class='price'><p>"+rmenuprice+"</p></div>");
                sb.append("</div>");
                sb.append("</div>");
                sb.append("</li>");
                } else { //오른쪽 꺼
                   
                    sb.append("<li>");
                    sb.append("<div class='divimg 'style='background-image: url("+rmenuimage+")';>");
                    sb.append("<div class='st1'><span class='spanmenu'>"+rmenuname+"</span>");
                    sb.append("<div class='price'><p>"+rmenuprice+"</p></div>");
                    sb.append("</div>");
                    sb.append("</div>");
                    sb.append("</li>");
                   sb.append("</div>");
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
    <title>세부내용 MENU</title>
    <style href="css/common.css"></style>
    <!-- 나눔스퀘어 폰트 -->
    
    <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Sunflower:500" rel="stylesheet">
    <!-- 부트스트랩 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
   <!-- Bootstrap (for modal) -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
   
<!-- 지도 -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=f8b62z9xjz&amp;submodules=geocoder"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<style>
/** common **/

a:link {  color: black; text-decoration: none}
    a:visited {color: black; text-decoration: none;}
    a:hover {color: #f1b654;; text-decoration: none;}
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
    border-spacing: 0px;
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

#itemBox ul{
    overflow: hidden;
}



#itemBox ul li {
    border-bottom: 1px solid #d7d7d7;
    width:50%;
    padding : 10px;
}

.menu1{
    display: flex;
    align-items: center;
    position: relative;
    padding: 22px 18px 22px 18px
}

.divimg{
    background-repeat: no-repeat;
    background-position: 50% 50%;
    background-size: cover;
    width: 150px;
    height: 160px;
}

.spanmenu{
    font-weight: bold;
    font-size: 15px;
    word-break:keep-all;
   width: 100px;
   display:inline-block;
   word-break: break-all;
   letter-spacing : 3px;
}

.price{
    margin-top: 5px;
    font-weight: 700;
    color: #ff5757;
    font-size: 13px;
    line-height: 1.7rem;
    width: 60px;
}

.price p {
    display: inline-block;
}

.st1{
    margin-left: 170px;
    padding-top: 35px;
}

.fl{
    display: flex;
    border-bottom : 1px solid gray;
}
.fl ul{
    overflow: hidden;
}

#tabBox th{
    width : 23%;
}

.tblmain table th{
    background-color: #f7f7fd;
}



/***** footer  *****/
footer{
    width: 100%;
    height: 163px;
    background-color: #d7d7d7;
    margin-top: 5%;
}

.tblmain table td {
   border: 1px solid black;
}

.tblmain table th {
   border-bottom: none;
}

.tblmain table tr {
   border: 1px solid black;
}

.line{
   border-right: 1.5px solid black;
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
                <a href="../../../main" class="logoclick"><img src="../../../images/logo.png" alt="logo"></a>
            </h1>
            <h3><%=welcome %><a href="../../../bye" id="logout" style="color : gray"><br/><%=log %></a></h3>
            <ul>
                <li><b><a href="../../../mypage" class="logoclick">마이페이지</a></b></li>
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
          <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal"><a href="../../../notice/read"><b>읽음</b></button>
          <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal"><a href=""><b>닫기</b></button>
        </div>
      </div>
    </div>
  </div>
   
   
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

    <!-- 전체 요소를 감싸는 div -->
    <div id="wrap">


        <!-- 게시판 이름이 있는 섹션입니다 -->
        <section id="titSec">
            <strong></strong>
        </section>
          
    

               <div class="tblmain" style= "display: flex; justify-content: space-around;">
                    <div style="width: 50%;">
                         <table border="1" style="width: 100%;    height: 20%;">  
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
                               
                               
                                  <tr id="tabBox" style="height:61px; border: 1.5px solid black;">
                                    <th scope="col" class="th-title line" ><a href="../../../main/search/info?tseq=<%=tseq%>&search=<%=search %>&id=<%=id %>&latitude=<%=latitude %>&longitude=<%=longitude %>" >홈</a></th>
                                    <th scope="col" class="th-date line"><a href="../../../main/search/review?tseq=<%=tseq%>&search=<%=search %>&id=<%=id %>&latitude=<%=latitude %>&longitude=<%=longitude %>">리뷰</a></th>
                                    <th scope="col" class="th-num line"><a href="../../../main/search/menu?tseq=<%=tseq%>&search=<%=search %>&id=<%=id %>&latitude=<%=latitude %>&longitude=<%=longitude %>" style="color : #de5f47">메뉴</a></th>
                                    <th scope="col" class="th-date line"><a href="../../../main/search/pic?tseq=<%=tseq%>&search=<%=search %>&id=<%=id %>&latitude=<%=latitude %>&longitude=<%=longitude %>">사진</a></th>
                                 
                                </tr> 
                            </thead>

                            
                         </table>
                         <div id="itemBox">
                           
                              <ul>
                                <%=sb %>
                                <!--  
                                
                                <div class="fl">
                                <li>
                                    <a href="#" class="menu1">
                                        <div class="divimg "style="background-image: url('https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f320_320&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210312_211%2F1615525680667Gnbqz_JPEG%2FheDnef5YgFDQE28svVFiyKOi.jpeg.jpg');">

                                        </div> 
                                        <div class="st1"><span class="spanmenu">왕 돈까스</span>
                                        <div class="price"><p>10,000원</p></div>
                                    </div>
                                    </a>
                                </li>
                           

                                <li>
                                    <a href="#" class="menu1">
                                        <div class="divimg "style="background-image: url('https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f320_320&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210312_211%2F1615525680667Gnbqz_JPEG%2FheDnef5YgFDQE28svVFiyKOi.jpeg.jpg');">

                                        </div> 
                                        <div class="st1"><span class="spanmenu">행운 정식</span>
                                        <div class="price"><p>11,000원</p></div>
                                    </div>
                                    </a>
                                </li>
                            </div>

                            <div class="fl">
                                <li>
                                    <a href="#" class="menu1">
                                        <div class="divimg "style="background-image: url('https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f320_320&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210312_211%2F1615525680667Gnbqz_JPEG%2FheDnef5YgFDQE28svVFiyKOi.jpeg.jpg');">

                                        </div> 
                                        <div class="st1"><span class="spanmenu">행운 정식</span>
                                        <div class="price"><p>11,000원</p></div>
                                    </div>
                                    </a>
                                </li>

                                <li>
                                    <a href="#" class="menu1">
                                        <div class="divimg "style="background-image: url('https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f320_320&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220203_142%2F1643884642186SDQ4F_JPEG%2F52FC69D3-277B-4532-B566-DCACBB9FBBDA.jpeg');">

                                        </div> 
                                        <div class="st1"><span class="spanmenu">행운 정식</span>
                                        <div class="price"><p>11,000원</p></div>
                                    </div>
                                    </a>
                                </li>
                            </div>
           
                                   
                           -->
                                 </ul>
                                   
                        </div>
                    </div>


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
</script>
</html>