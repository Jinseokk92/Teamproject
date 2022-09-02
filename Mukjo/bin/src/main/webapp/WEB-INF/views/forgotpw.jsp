<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<style>
HTML CSSResult Skip Results Iframe
EDIT ON
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: "Noto Sans KR", sans-serif;
}

a {
  text-decoration: none;
  color: black;
}

li {
  list-style: none;
}

.img_logo {
}

.wrap {
  width: 100%;
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: white;
}

.login {
  width: 450px;
  height: 600px;
  background: white;
  border-radius: 20px;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
}

.form_1 {
    height: 400px;
    margin-bottom: auto;
}

h2 {
  color: #5c3018;
  font-size: 2em;
  text-align: center;
}

h4 {}

.user_mail {
  margin-top: 20px;
  width: 80%;
}

.user_mail h4 {
    margin-bottom: 10px;
}

.user_mail input {
  width: 310px;
  height: 40px;
  border-radius: 10px;
  margin-top: 10px;
  padding: 0px 20px;
  border: 1px solid lightgray;
  outline: none;
}

.user_name {
  margin-top: 20px;
  width: 80%;
}

.user_name h4 {
    margin-bottom: 10px;
}

.user_name input {
  width: 310px;
  height: 40px;
  border-radius: 10px;
  margin-top: 10px;
  padding: 0px 20px;
  border: 1px solid lightgray;
  outline: none;
}

.submit {
  margin-top: 50px;
  width: 350px;
  text-align: center;
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
  width: 350px;
  height: 50px;
  border: 0;
  outline: none;
  border-radius: 10px;
  background-color: #f1b654;
  color: #5c3018;
  font-size: 1.2em;
  font-weight: 600;
  letter-spacing: 2px;
  box-shadow: 3px 3px 3px black;
  transition-duration: 0.5s;
}
</style>
<script type="text/javascript">
    window.onload = function() {
       document.querySelector('#fpbtn').onclick = function() {
          if( document.fpfrm.usermail.value.trim() == "" ) {
             alert( '아이디를 입력해주세요.' );
             return false;
          }
          
          if( document.fpfrm.username.value.trim() == "" ) {
             alert( '비밀번호를 입력해주세요.' );
             return false;            
          }
          document.fpfrm.submit();
       };
    };
 </script>
 <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
 <script src="https://kit.fontawesome.com/53a8c415f1.js" crossorigin="anonymous"></script>
<body>
    <div class="wrap">
        <div class="login">
            <form action="forgotpw_ok.do" method="post" name="fpfrm" class="form_1">
                <h2>Forgot Password?</h2>
                <hr />
                <div class="user_mail">
                    <h4>이메일</h4>
                    <input type="text" class="form-control" name="usermail" id="" placeholder="E-mail">
                </div>
                <div class="user_name">
                    <h4>이름</h4>
                    <input type="text" class="form-control" name="username" id="" placeholder="Name">
                </div>

                <div class="submit">
                    <input type="button" id="fpbtn" value="비밀번호 찾기">
                </div>

            </form>
        </div>
    </div>
</body>
</html>