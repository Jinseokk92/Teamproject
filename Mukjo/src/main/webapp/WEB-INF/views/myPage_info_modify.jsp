<%@page import="com.example.model1.NoticeTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.example.model1.MemberTO"%>
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
    
       MemberTO to = (MemberTO)request.getAttribute("to");
       String seq=to.getSeq();
       String email=to.getEmail();
       String birth=to.getBirth();
       String phone=to.getPhone();
       String password=to.getPassword();
       
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
<title>내 정보 수정</title>

<style href="css/common.css"></style>
<!-- 나눔스퀘어 폰트 -->
<link
   href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css"
   rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Sunflower:500" rel="stylesheet">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
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
   width: 100%;
   margin-top : 5px;
   padding-top: 10px;
   padding-bottom: 10px;
   display: flex;
   /* border: 1px dotted black; */
   justify-content: center;
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
   background: url( ../../images/search2.png) no-repeat;
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
/* .board_pagetab ul a:hover  { background-color:black; } */
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

.user_id {
   margin-top: 20px;
   width: 1000px;
   justify-content:center;
   display: flex;
}

.user_id h4 {
   margin-top: 15px;
}

.user_id input {
   width: 400px;
   border-radius: 0px;
   margin-left: 80px;
   padding: 0px 20px;
   border: 1px solid lightgray;
   outline: none;
}

.birth {
   margin-top: 20px;
   width: 1000px;
   justify-content:center;
   display: flex;
}

.birth h4 {
	margin-top: 25px;
}

.birth input {
   width: 400px;
   height: 40px;
   border-radius: 0px;
   margin-top: 10px;
   margin-left: 40px;
   padding: 0px 20px;
   border: 1px solid lightgray;
   outline: none;
}

.phone {
   margin-top: 20px;
   width: 1000px;
   justify-content:center;
   display: flex;
}

.phone h4 {
	margin-top: 25px;
}

.phone input {
   width: 400px;
   height: 40px;
   border-radius: 0px;
   margin-top: 10px;
   margin-left: 20px;
   padding: 0px 20px;
   border: 1px solid lightgray;
   outline: none;
}

.pwd1 {
   margin-top: 20px;
   width: 1000px;
   justify-content:center;
   display: flex;
}

.pwd1 h4 {
   margin-top: 25px;
}

.pwd1 input {
   width: 400px;
   height: 40px;
   border-radius: 0px;
   margin-top: 10px;
   margin-left: 40px;
   padding: 0px 20px;
   padding-left: 20px;
   border: 1px solid lightgray;
   outline: none;
}

.pwd2 {
   margin-top: 20px;
   width: 1000px;
   justify-content:center;
   display: flex;
}

.pwd2 h4 {
   margin-top: 20px;
}

.pwd2 input {
   width: 400px;
   height: 40px;
   border-radius: 0px;
   margin-top: 10px;
   margin-left: 15px;
   padding: 0px 20px;
   padding-left: 20px;
   border: 1px solid lightgray;
   outline: none;
}

.submit {
   margin-top: 30px;
   margin-left: 120px;
   width: 800px;
   text-align: center;
   justify-cotent: center;
}

.submit input:active {
   font-size: 15px;
   font-weight: 500;
   box-shadow: none;
}

.submit input:hover {
   cursor: pointer;
}

.submit input {
   width: 100px;
   height: 35px;
   border: 0;
   outline: none;
   background-color: #f1b654;
   color: #5c3018;
   font-size: 1em;
   font-weight: 600;
   text-align: center;
   letter-spacing: 2px;
   box-shadow: 1px 2px 2px black;
   transition-duration: 0.5s;
}



.validation-form h4 {
   font-weight: bold;
   font-size: 0.9em;
}

.validation-form h2 {
   text-align: center;
   font-weight: bold;
   color: #5c3018;
}

.chkbox1 {
   padding-top: 20px;
   padding-bottom: 0px;
   
}

.chkbox1 input {
   cursor: pointer;
}

.error_next_box {
   width: 500px;
   position: absolute;
   margin-top: 60px;
   margin-left: 220px;
   font-size: 5px;
   text-align: left;
   color: red;
   display: none;
}

.validation-form {
   width: 1000px;
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
</style>
<script type="text/javascript">
    window.onload = function() {
       function checkModify() {
         let result = confirm("이대로 수정하시겠습니까?");
            if(result == true) {
               document.mpfrm.submit();
            }
         }
       
       document.querySelector('#mpBtn1').onclick = function() {

          var checkBirthNum = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
          if(document.mpfrm.birth.value.trim() == "") {
             alert('생일을 입력하셔야 합니다.');
             return false;
          } else if(!checkBirthNum.test(document.mpfrm.birth.value.trim())) {
             alert('생일형식에 맞게 입력하셔야 합니다.');
             return false;
          }
          
          let isPhoneNum = /([01]{2})([01679]{1})([0-9]{4})([0-9]{4})/;
          if( document.mpfrm.phone.value.trim() == "" ) {
             alert( '핸드폰 번호를 입력해주세요.' );
             return false;            
          } else if(!isPhoneNum.test(document.mpfrm.phone.value.trim())) {
              alert('핸드폰 형식이 맞지 않습니다.');
              return false;
           }    
          let pwPattern = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&]).*$/;
          if(document.mpfrm.pwd1.value.trim() == "") {
             alert('비밀번호를 입력하셔야 합니다.');
             return false;            
          } else if(!pwPattern.test(document.mpfrm.pwd1.value.trim())) {
             alert('비밀번호 형식이 맞지 않습니다.');
             return false;
          }
          if(document.getElementById('pwd1').value != document.getElementById('pwd2').value){
             alert('비밀번호를 일치하게 입력했는지 확인해주세요.');
             return false;
          }
          checkModify();
       };  
    };
 </script>
</head>
<body>
   <nav id="header">
      <div class="headermake" style="width:100%; background-color: #fff;">
        <div id="headerWap">
            <h1 id="logoSec">
                <a href="../../main" class="logoclick"><img src="../../images/logo.png" alt="logo"></a>
            </h1>
            <h3><%=welcome %><a href="../bye" id="logout" style="color : gray"><br/><%=log %></a></h3>
            <ul>
                <li><b><a href="../mypage" style="color : #de5f47;" class="logoclick">마이페이지</a></b></li>
                <li><b><a href="../adgroups" class="logoclick">소모임장페이지</a></b></li>
                <li><b><a href="../admin" class="logoclick">관리자페이지</b></li></a>
                <li><b><a href="../favorite" class="logoclick">즐겨찾기</b></li></a>
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
         <div id="locationwrap">
            <button class="allbtn">
               <a href="../mypage">내가 쓴 글 보기</a>
            </button>
            <button class="active">
               <a href="/mypage/change" style="color: #de5f47;">내 정보 수정</a>
            </button>
         </div>
      </section>
   </nav>

   <!-- 전체 요소를 감싸는 div -->
   <div id="wrap">
      <form action="./change/success" method="post" name="mpfrm" class="validation-form">
            <h2>내 정보 수정</h2>
            <hr />
            <div class="user_id">
               <h4>계정</h4>
               <input type="text" name="email" id="email" value="<%=email %>" readonly />
            </div>

            <div class="birth">
               <h4>생년월일</h4>
               &nbsp;&nbsp; <input type="text" name="birth" id="birth" placeholder="<%=birth %>" value="<%=birth %>" maxlength="10"/>
               <span class="error_next_box"></span>
            </div>

            <div class="phone">
               <h4>핸드폰 번호</h4>
               &nbsp;&nbsp;
                <input type="text" name="phone" id="phone"  placeholder="<%=phone %>" value="<%=phone %>" maxlength="11"/>
               <span class="error_next_box"></span>
            </div>

            <div class="pwd1">
               <h4>비밀번호</h4>
               &nbsp;&nbsp; <input type="password" name="pwd1" id="pwd1" maxlength="20"/>
               <span class="error_next_box" style="vertical-align:middle;"></span>
            </div>

            <div class="pwd2">
               <h4>비밀번호 확인</h4>
               <input type="password" name="pwd2" id="pwd2" maxlength="20"/>
               <span class="error_next_box"></span>
            </div>
            
            <div class="submit">
                    <input type="button" id="mpBtn1" value="수정" >
                    &nbsp;&nbsp;
                    <input type="button" id="mpBtn2" value="회원 탈퇴" onclick="location.href='../../mypage/change/quit?seq=<%=seq %>'">
            </div>
      </form>
   </div>

   <!-- footer 
    <footer>

    </footer>
    -->
<script src="../../js/myPage_modify.js"></script>
</body>

</html>