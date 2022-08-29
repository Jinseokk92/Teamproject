<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Mukjo 회원가입 페이지</title>

<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
   integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<!-- SweetAlert창 바꾸기-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<%
   out.println("<script type='text/javascript'>");
   out.println( "alert('회원이 아닙니다. 회원가입창으로 이동합니다.');" );
   out.println( "</script>" ); 

   String email = (String)request.getAttribute("email");
%>
<script type="text/javascript">
   window.onload = function() {
      function checkSignUp() {
         let result = confirm("가입 하시겠습니까?");
            if(result == true) {
               document.sfrm.submit();
            }
         }
      
      document.getElementById('sbtn').onclick = function() {
            if(document.sfrm.agree.checked == false) {
               alert('개인정보 수집 및 이용에 동의하셔야 합니다.');
               return false;
            }
            if(document.sfrm.agree2.checked == false) {
                  alert('이메일 수신에 동의하셔야 합니다.');
                  return false;
               }
            let namePattern = /[a-zA-Z가-힣]/;
            if(document.sfrm.name.value.trim() == "") {
               alert('이름을 입력하셔야 합니다.');
               return false;            
            } else if(!namePattern.test(document.sfrm.name.value.trim())) {
               alert('한글이나 영문 대소문자를 사용하세요. (특수기호, 공백 사용 불가)');
               return false;
            }
            
            let emailPattern = /[a-z0-9]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/;
            if(document.sfrm.email.value.trim() == "") {
               alert('이메일 입력하셔야 합니다.');
               return false;
            } else if(!emailPattern.test(document.sfrm.email.value.trim())) {
               alert('이메일 형식이 맞지 않습니다.');
               return false;
            }
            
            let pwPattern = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&]).*$/;
            if(document.sfrm.password.value.trim() == "") {
               alert('8~16자 영문, 숫자, 특수문자(!@#$%^&)를 사용하세요.');
               return false;            
            } else if(!pwPattern.test(document.sfrm.password.value.trim())) {
               alert('비밀번호 형식이 맞지 않습니다.\n8~16자 영문, 숫자, 특수문자(!@#$%^&)를 사용하세요.');
               return false;
            }
            if(document.getElementById('pwd1').value != document.getElementById('pwd2').value){
               alert('비밀번호를 일치하게 입력했는지 확인해주세요.');
               return false;
            }
            
            let isPhoneNum = /([01]{2})([01679]{1})([0-9]{4})([0-9]{4})/;
            if(document.sfrm.phone.value.trim() == "") {
               alert('핸드폰 번호를 입력하셔야 합니다.');
               return false;            
            } else if(!isPhoneNum.test(document.sfrm.phone.value.trim())) {
               alert('핸드폰 형식이 맞지 않습니다.');
               return false;
            }

            let checkBirthNum = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
            if(document.sfrm.birth.value.trim() == "") {
               alert('생일을 입력하셔야 합니다.');
               return false;
            } else if(!checkBirthNum.test(document.sfrm.birth.value.trim())) {
               alert('생일형식에 맞게 입력하셔야 합니다.');
               return false;
            }
            checkSignUp();
         };
      };
/*
   function mailchk() {
      if(document.sfrm.email.value.trim() == "") {
         alert('이메일 입력하셔야 합니다.');
         return false;            
      }
      location.href='./checkmail.do?email=' + document.sfrm.email.value;   
   }
*/
</script>
<style>
   body {
   min-height: 100vh;
   background: -webkit-gradient(linear, left bottom, right top, from(#92b5db), to(#1d466c));
   background: -webkit-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
   background: -moz-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
   background: -o-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
   background: linear-gradient(to top right, #92b5db 0%, #1d466c 100%);
   }

   h4 {
   text-align: center;
   font-family: 'Cafe24Oneprettynight';
   src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_twelve@1.1/Cafe24Oneprettynight.woff') format('woff');
   font-weight: bold;
   font-style: normal;
   }

   .input-form {
   max-width: 680px;
   margin-top: 80px;
   padding: 32px;
   background: #fff;
   -webkit-border-radius: 10px;
   -moz-border-radius: 10px;
   border-radius: 10px;
   -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.473);
   -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
   box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
   }

   .error_next_box {
   margin-top: 9px;
   font-size: 12px;
   color: red;
   display: none;
   }
</style>

</head>

<body>
   <div class="container">
      <div class="input-form-backgroud row">
         <div class="input-form col-md-12 mx-auto">
         <h4 class="mb-3">회원가입</h4>
         <form class="validation-form" action="http://localhost/signedup" method="post" name="sfrm" novalidate>
            <!--Name-->
            <div class="row">
               <div class="col-md-12 mb-3">
                  <label for="userName">이름</label>
                  <input type="text" class="form-control" maxlength="10" id="userName" name="name" placeholder="이름을 입력해주세요" value="" required>
                  <span class="error_next_box"></span>
                  <!-- <div class="invalid-feedback">
                  비밀번호를 입력해주세요.
                  </div> -->
               </div>
            </div>
            
            <!--email-->
            <div class="row">
               <div class="col-md-12 mb-3">
                  <label for="email">이메일</label>
                  <input type="email" class="form-control" maxlength="25" id="email" name="email" value="<%=email %>" readonly>
                  <div class="mt-2 ">
                     <!--  <button class="emailChk btn btn-primary" type="button" id="chkbtn" onclick="mailchk(this.form)" value="">중복확인</button> -->
                  </div>
                  <!-- <div class="invalid-feedback">
                  이메일을 입력해주세요.
                  </div> -->
               </div>
            </div>
            
            <!--password-->
            <div class="row">
               <div class="col-md-12 mb-3">
                  <label for="pwd1">비밀번호</label>
                  <input type="password" class="form-control" maxlength="15" id="pwd1" placeholder="비밀번호를 입력해주세요" value="" required>
                  <span class="error_next_box"></span>
                  <!-- <div class="invalid-feedback">
                  비밀번호를 입력해주세요.
                  </div> -->
               </div>
            </div>
            
            <!--password confirm-->
            <div class="row">
               <div class="col-md-12 mb-3">
                  <label for="pwd2">비밀번호 재입력</label>
                  <input type="password" class="form-control" maxlength="15" id="pwd2" name="password" placeholder="비밀번호를 재입력" value="" required>
                  <span class="error_next_box"></span>
                  <!-- <div class="invalid-feedback">
                  비밀번호를 재확인해주세요.
                  </div> -->
               </div>
            </div>

            <!--phone-->
            <div class="row">
               <div class="col-md-12 mb-3">
                  <label for="phone">핸드폰 번호</label>
                  <input type="text" class="form-control" maxlength="11" id="phone" name="phone" placeholder="'-' 없이 입력" required>
                  <span class="error_next_box"></span>
                  <!-- <div class="invalid-feedback">
                  핸드폰 번호를 입력해주세요.
                  </div> -->
               </div>
            </div>

            <!--birth-->
            <div>
               <div class="row">
                  <div class="col-md-3 mb-2">
                  <label for="birth">생년월일</label>
                  <input type="text" class="form-control" maxlength="10" id="birth" name="birth" placeholder="ex) 1998-01-29" required>
                  <span class="error_next_box"></span>
               </div>
               
            </div>
            
            <hr class="mb-4">
            <div class="custom-control custom-checkbox">
               <input type="checkbox" class="custom-control-input" id="agreement1" name="agree" required>
               <label class="custom-control-label" for="agreement1">개인정보 수집 및 이용에 동의합니다. (필수)</label>
            </div>

            <div class="custom-control custom-checkbox">
               <input type="checkbox" class="custom-control-input" id="agreement2" name="agree2" required>
               <label class="custom-control-label" for="agreement2">이메일 수신에 동의합니다. (필수)</label>
            </div>
            <div class="mb-4"></div>
            <input type="button" id="sbtn" value="가입 완료" class="btn btn-primary btn-lg btn-block" onclick="http://localhost/signedup" />
         </form>
      </div>
   </div>

   <footer class="my-3 text-center text-small">
      <!-- <p class="mb-1">&copy; 2021 YD</p> -->
   </footer>
</div>

<script src="/js/logingoogle.js"></script>

</body>
</html>