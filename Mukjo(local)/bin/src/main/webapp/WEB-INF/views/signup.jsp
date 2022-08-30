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
			if(document.sfrm.name.value.trim() == "") {
				alert('이름을 입력하셔야 합니다.');
				return false;            
			}
			if(document.sfrm.email.value.trim() == "") {
				alert('이메일 입력하셔야 합니다.');
				return false;            
			}
			//if(document.sfrm.mailDup.value != "mailchk") {
				//alert('메일 중복확인을 하셔야 합니다.');
				//return false;
			//}
			if(document.sfrm.password.value.trim() == "") {
				alert( '비밀번호를 입력하셔야 합니다.' );
				return false;            
			}
			if(document.sfrm.phone.value.trim() == "") {
				alert('핸드폰 번호를 입력하셔야 합니다.');
				return false;            
			}
			if(document.sfrm.birth.value.trim() == "") {
				alert('생일을 입력하셔야 합니다.');
				return false;
			}
			checkSignUp();
		};
	};

	function mailchk() {
		if(document.sfrm.email.value.trim() == "") {
			alert('이메일 입력하셔야 합니다.');
			return false;            
		}
		location.href='./checkmail.do?email=' + document.sfrm.email.value;
	}
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
			<form class="validation-form" action="./signup_ok.do" method="post" name="sfrm" novalidate>
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
						<input type="email" class="form-control" maxlength="25" id="email" name="email" placeholder="example@example.com" required>
						<span class="error_next_box"></span>
						<div class="mt-2 ">
							<button class="emailChk btn btn-primary" type="button" id="chkbtn" onclick="mailchk(this.form)" value="">중복확인</button>
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
						<!-- <div class="invalid-feedback">
						생년월일 입력해주세요
						</div> -->
					</div>
					<!--
					<div class="col-md-3 mb-3">
						<label for="bir-mm">&nbsp;</label>
						<select class="custom-select d-block w-100" id="bir-mm">
							<option>월</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select>
						<div class="invalid-feedback">
						월 입력.
						</div>
					</div>
					<div class="col-md-3 mb-3">
						<label for="bir-dd">&nbsp;</label>
						<input type="text" class="form-control" id="bir-dd" placeholder="일" required>
						<div class="invalid-feedback">
						일 수 입력.
						</div>
					</div>
					-->
				</div>
				
				<hr class="mb-4">
				<div class="custom-control custom-checkbox">
					<input type="checkbox" class="custom-control-input" id="agreement1" name="agree" required>
					<label class="custom-control-label" for="agreement1">개인정보 수집 및 이용에 동의합니다. (필수)</label>
				</div>

				<div class="custom-control custom-checkbox">
					<input type="checkbox" class="custom-control-input" id="agreement2">
					<label class="custom-control-label" for="agreement2">이메일 수신에 동의합니다. (선택)</label>
				</div>
				<div class="mb-4"></div>
				<input type="button" id="sbtn" value="가입 완료" class="btn btn-primary btn-lg btn-block" onclick="./signup_ok.do" />
			</form>
		</div>
	</div>

	<footer class="my-3 text-center text-small">
		<!-- <p class="mb-1">&copy; 2021 YD</p> -->
	</footer>
</div>

<script src="./js/login.js"></script>

</body>
</html>