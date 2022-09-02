<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>오류 페이지</title>
<link href="https://fonts.googleapis.com/css?family=Cabin:400,700" rel="stylesheet">
</head>
<style>
* {
  -webkit-box-sizing: border-box;
          box-sizing: border-box;
}

body {
  padding: 0;
  margin: 0;
}

#notfound {
  position: relative;
  height: 100vh;
}

#notfound .notfound {
  position: absolute;
  left: 50%;
  top: 50%;
  -webkit-transform: translate(-50%, -50%);
      -ms-transform: translate(-50%, -50%);
          transform: translate(-50%, -50%);
}

.notfound {
  max-width: 1280px;
  width: 100%;
  height: 100%;
  text-align: center;
  line-height: 1.4;
  margin-left: 120px;
}

.notfound .notfound-404 {
  position: relative;
  width: 180px;
  height: 180px;
  margin: 120px auto 50px;
  
}

.notfound .notfound-404>div:first-child {
  position: absolute;
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
  background: #ffa200;
  -webkit-transform: rotate(45deg);
      -ms-transform: rotate(45deg);
          transform: rotate(45deg);
  border: 5px dashed #000;
  border-radius: 5px;
}

.notfound .notfound-404 h1 {
  font-family: 'Cabin', sans-serif;
  color: #000;
  font-weight: 700;
  margin: 0;
  font-size: 70px;
  position: absolute;
  top: 50%;
  -webkit-transform: translate(-50%, -50%);
      -ms-transform: translate(-50%, -50%);
          transform: translate(-50%, -50%);
  left: 50%;
  text-align: center;
  height: 40px;
  line-height: 40px;
}

.notfound h2 {
  font-family: 'Cabin', sans-serif;
  font-size: 33px;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 7px;
}

.notfound p {
  font-family: 'Cabin', sans-serif;
  font-size: 16px;
  color: #000;
  font-weight: 400;
}

.notfound a {
  font-family: 'Cabin', sans-serif;
  display: inline-block;
  padding: 10px 25px;
  background-color: #8f8f8f;
  border: none;
  border-radius: 40px;
  color: #fff;
  font-size: 14px;
  font-weight: 700;
  text-transform: uppercase;
  text-decoration: none;
  -webkit-transition: 0.2s all;
  transition: 0.2s all;
}

.notfound a:hover {
  background-color: #f1b654;
}


</style>
<body>
	<div di="notfound">
		<div class="notfound">
			<div class="notfound-404">
				<div>
					
				</div>
				<h1>Error!</h1>
			</div>
			<h2>Not Available!</h2>
			<p> ${status} </p>
			<p> The page you are looking for might have been removed had its name changed 
				or is temporarily unavailable.
			</p>
			<a href="main">메인페이지로 돌아가기</a>
		</div>
	</div>
</body>
</html>