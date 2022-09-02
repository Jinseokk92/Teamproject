<%@page import="ch.qos.logback.core.recovery.ResilientSyslogOutputStream"%>
<%@page import="com.example.model1.NoticeTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.example.model1.FoodTO"%>
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
   String search = request.getParameter("search");
   if (search==null) {
      search="강남역";
   }
   String tname = (String)request.getAttribute("tname");
   
   ArrayList<FoodTO> lists = (ArrayList<FoodTO>)request.getAttribute("lists");
   
   StringBuilder sbHtml = new StringBuilder();
   StringBuilder mHtml = new StringBuilder();
   
   mHtml.append( "var loc = [" );
   
   for(FoodTO to : lists) {
      String id = to.getId();
      String name = to.getName();
      String category = to.getCategory();
      String longitude = to.getLongitude();
      String latitude = to.getLatitude();
      String thumurl = to.getThumurl();
      String avgStar = to.getAvgStar();
      if (avgStar == null) {
         avgStar = "  점수없음";
      }
      
      
      sbHtml.append( "<div class='lists1'>" );
       sbHtml.append( "<a href='../../main/search/info?tseq=" + tseq +"&search="+search+"&id=" + id + "&latitude=" + latitude + "&longitude=" + longitude + "'><img class='list1' style=\"background-image: url('" + thumurl + "');\">");
       sbHtml.append( "<span class='write1'>"+name+"</span>" );
       sbHtml.append( "<span class='write2'>"+category+"</span>" );
       sbHtml.append( "<span class='write3'><i class='fa fa-star' style='font-size:20px;color:red'></i> "+avgStar+"</span>" );
       sbHtml.append( "</a>" );
       sbHtml.append( "</div>" );
       
       mHtml.append( "{ Name: \""+name+"\", " );
       mHtml.append( "Lat: \""+latitude+"\", " );
       mHtml.append( "Lng: \""+longitude+"\" }," );
   }
   mHtml.deleteCharAt(mHtml.length() - 1);
   mHtml.append( "]" );
   
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
<title>식당검색</title>
<style href="css/common.css"></style>
<!-- 나눔스퀘어 폰트 -->
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Sunflower:500" rel="stylesheet">
<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- 지도 -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=f8b62z9xjz&amp;submodules=geocoder"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- Bootstrap (for modal) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<style>
/** common **/

a:link {  color : black; text-decoration: none}
    a:visited {color: black; text-decoration: none;}
    a:hover {color: #5c3018; text-decoration: none;}
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
     display: flex;
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


#btnSec .search-wrap{
    right: 0;
    font-size: 0; 
    margin-bottom : 8px;
    margin-left : 30px;
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
    background: url( ../../images/search2.png) no-repeat ;
    position: absolute;
    background-size: 38px 25px;
 
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



#tblWrap{
    display: flex;
    overflow: hidden;
    border-top: 1px solid;
    border-color: #ecf0f2;
    border-color: rgba(var(--place-color-border2), 1);
    
}



.scrollbar{
    height:450px;
    overflow: hidden;
    overflow-y: auto;
   
   
}


.scrollbar li{
    display: list-item;
    text-align: -webkit-match-parent;
    position: relative;
    margin-top: 20px;
    margin-left : 30px;
    
}

.scrollbar li a{
    overflow: hidden;
    flex: 1;
}

.list1{
    width: 150px; height: 150px;
    background-repeat: no-repeat; background-position: 50% 50%; background-size: cover;
    margin-right: 35px;
}
.lists1{
    position: relative;
    margin-top: 30px;
}

.scrollbar .write1{
    position: absolute;
    font-size: 1.3rem;
    font-weight: 700;
    letter-spacing: -1px;
    color : #0068c3;
    bottom: 105px;
}

.scrollbar .write1::before{
    width: 200px;
    position: absolute;
    right: -2px;
    bottom: 0;
    left: -2px;
    height: 11px;
    top: 47px;
    border-radius: 6px;
    background: rgba(43,152,235,.1);
    content: "";
}

.write2{
    color:#0068c3;
    margin-top : 55px;
    position: absolute;
    
}
.write3{
    position: absolute;
    top: 120px;
    color: #de5f47;
}

.maps img{
    width:100%;
}

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
             <button class="allbtn"><a href="../../main/search?tseq=<%=tseq %>" style="color : #de5f47">식당 검색</a></button>
             <button class="allbtn"><a href="../../main/members?tseq=<%=tseq %>">소모임 회원 목록</a></button>
             <button class="allbtn bsbtn"><a href="../../main/quitgroup?tseq=<%=tseq %>" id="bstn">소모임 탈퇴</a></button>
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
            <b style="line-height: 2;
            font-size: 19px;">소모임 : <%=tname %></b>
          
            <div class="search-wrap">  
             
            <form class="input" action="/main/search" method="get" name="sfrm">
               <input type="hidden" name="tseq" value="<%=tseq %>" />
               <input type="text" title="검색어 입력" name="search" placeholder="<%=search %>" />
               <button type="submit">검색</button>
         </form><!-- input -->
         </div><!-- search-wrap -->
           
        </section>
    
        <!-- 테이블 목록이 있는 섹션입니다 -->
       
           
            <div id="tblWrap" style= "display: flex; justify-content: space-around;">
              
             
                <div class="scrollwrap" style="width: 50%;">
                 <div class="scrollbar" >
                    <ul>
                  <li>
                  <%=sbHtml.toString() %>
                  <!-- 
                     <div class="lists1">
                        <a href="./somoimboard_home.do"><img class="list1" style="background-image: url('https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fsearchad-phinf.pstatic.net%2FMjAyMjA0MThfMTYx%2FMDAxNjUwMjc2MTI4OTEz.Iwfc3HzhfZYcIfdtiWx7f4L1x9lOoGg1EUKGy2ZCxAwg.2S0g3cV4uNkldREs__6NEt5ChSUE2EOOV4EwCxJRtv8g.PNG%2F2355050-adba00da-0fad-4f6d-8d3d-9ade8109773c.png');">
                           <span class="write1">경양가츠 강남점</span>
                           <span class="write2">줄서서 먹는 돈까스맛집</span>
                           <span class="write3"><i class="fa fa-star" style="font-size:20px;color:red"></i>    4.8점</span>
                        </a>
                     </div>
                     <div class="lists1">
                        <a href="./somoimboard_home.do"><img class="list1" style="background-image: url('https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220427_237%2F165102764126107Ghf_JPEG%2F1.jpg');">
                           <span class="write1">을지다락 강남</span>
                           <span class="write2">깔끔한 분위기의 파스타</span>
                           <span class="write3"><i class="fa fa-star" style="font-size:20px;color:red"></i>    4.9점</span>
                        </a>
                     </div>
                     <div class="lists1">
                        <a href="./somoimboard_home.do"><img class="list1" style="background-image: url('https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20161112_233%2F147894152004419V1R_PNG%2F177062583539881_0.png');">
                           <span class="write1">장인닭갈비 강남점</span>
                           <span class="write2">순수 모짜렐라 치즈를 사용한 닭갈비</span>
                           <span class="write3"><i class="fa fa-star" style="font-size:20px;color:red"></i>    4.5점</span>
                        </a>
                     </div>
                      -->
                  </li>
               </ul>
            </div><!--scrollbar-->
         </div><!-- scrollwrap -->
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
   initMap();
})

function initMap() {
   let markers = [];
   let infoWindows = [];

   <%=mHtml.toString() %>
   
   // 지도가 뜰때 중심
   var map = new naver.maps.Map('map', {
       center: new naver.maps.LatLng(loc[0].Lat, loc[0].Lng),
       zoom: 16
   });
   
   // 마커들마다 위도 경도
   for(var i in loc) {
      var marker = new naver.maps.Marker({
          position: new naver.maps.LatLng(loc[i].Lat, loc[i].Lng),
          map: map
       });

      // 정보창
       var infoWindow = new naver.maps.InfoWindow({
          content: '<div class=\"iw_inner\"><div class=\"div_font\"style=\"font-size:13px;font-weight:600;text-align:center;padding:10px;color:#ffffff;\"><b>' + loc[i].Name + '</b></div></div>',
          borderWidth: 0,
          disableAnchor: true,
          backgroundColor: 'transparent'
       });
      
       markers.push(marker);
      infoWindows.push(infoWindow);
   }
    
   naver.maps.Event.addListener(map, 'idle', function() {
       updateMarkers(map, markers);
   });

   function updateMarkers(map, markers) {
       var mapBounds = map.getBounds();
       var marker, position;

       for (var i = 0 ; i < markers.length ; i++) {
           marker = markers[i]
           position = marker.getPosition();

           if (mapBounds.hasLatLng(position)) {
               showMarker(map, marker);
           } else {
               hideMarker(map, marker);
           }
       }
   }

   function showMarker(map, marker) {
       if (marker.setMap()) return;
       marker.setMap(map);
   }

   function hideMarker(map, marker) {
       if (!marker.setMap()) return;
       marker.setMap(null);
   }

   // 해당 마커의 인덱스를 seq라는 클로저 변수로 저장하는 이벤트 핸들러를 반환합니다.
   function getClickHandler(seq) {
       return function(e) {
           var marker = markers[seq],
               infoWindow = infoWindows[seq];

           if (infoWindow.getMap()) {
               infoWindow.close();
           } else {
               infoWindow.open(map, marker);
           }
       }
   }

   for (var i=0 ; i<markers.length ; i++) {
       naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));
   }
}
</script>
</html>