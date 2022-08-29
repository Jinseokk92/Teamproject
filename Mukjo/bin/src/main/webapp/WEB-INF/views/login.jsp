<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    
   		HttpSession sess = request.getSession();
    	String loginedMemberSeq = (String)sess.getAttribute("loginedMemberSeq");
    
    	if(loginedMemberSeq != null) {
		out.println ( "<script>");
		out.println ( "window.location.href = 'http://localhost:8080/main.do'");
		out.println ( "</script>");
    	}
    
    %>
<!doctype html>
<html lang="ko">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap" rel="stylesheet">
<link rel="stylesheet" href="./fonts/icomoon/style.css">
<link rel="stylesheet" href="./css/owl.carousel.min.css">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="./css/bootstrap.min.css">

<!-- Style -->
<link rel="stylesheet" href="./css/style.css">

<script src="./js/jquery-3.3.1.min.js"></script>
<script src="./js/popper.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script src="./js/main.js"></script>
<script type="text/javascript">
	window.onload = function() {
		document.getElementById( 'lbtn' ).onclick = function() {
			if( document.lfrm.username.value.trim() == "" ) {
				alert( '아이디를 입력해주세요.' );
				return false;
			}
			
			if( document.lfrm.password.value.trim() == "" ) {
				alert( '비밀번호를 입력해주세요.' );
				return false;				
			}
			document.lfrm.submit();
		};
	};
</script>
<style>
	img {
		width: 100px;
	}
</style>
<title>Login #6</title>
</head>
<body>
<div class="d-lg-flex half justify-content-center">
	<div class="contents order-2 order-md-1">
		<div class="container">
			<div class="row align-items-center justify-content-center">
				<div class="col-md-7">
					<div class="mb-4">
						<h3><img src="images/logo.png" /></h3>
						<p class="mb-4">Login with e-mail</p>
					</div>
					<!-- 로그인 폼 시작 -->
					<form action="loginok.do" method="post" name="lfrm"> <!-- form id -->
					<div class="form-group first">
						<label for="username"></label>
						<input type="text" class="form-control" name="username" placeholder="E-mail">
					</div>
					<div class="form-group last mb-3">
						<label for="password"></label>
						<input type="password" class="form-control" name="password" placeholder="Password">                
					</div>
					<!-- username, password 불러오기 -->
					<div class="d-flex mb-5 align-items-center">
						<span class="ml-auto"><a href="forgotpw.do" class="forgot-pass">Forgot Password</a></span> 
					</div>
					<!-- jsp로 넘겨줄 name 설정 -->
					<input type="button" id="lbtn" value="Log In" class="btn btn-block btn-primary"/>
					<!-- id추가 -->
					<input type="button" name="" value="Sign Up" class="btn btn-block btn-primary" onclick="location.href='signup.do'"/>
					<span class="d-block text-center my-4 text-muted">&mdash; or &mdash;</span>
					<div class="social-login">
						<!-- 네이버 버튼 (twitter->naver) 바꿀 시 로딩실패 : svg와 관련돼있는듯  -->
						<!-- 
						<a href="#" class="naver btn d-flex justify-content-center align-items-center">
							<span><img src="./images/naver.icon.png" style="width: 90%; height: 40px;">
							</span>Login with  Naver
						</a>
						-->
						<!-- 구글 버튼  -->
						<a href="./sociallogin/googlelogin.do" class="google btn d-flex justify-content-center align-items-center">
							<span class="icon-google mr-3">
							</span>Login with  Google
						</a>
					</div> 
				</form> 
				<!-- 로그인 폼 끝  -->
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>