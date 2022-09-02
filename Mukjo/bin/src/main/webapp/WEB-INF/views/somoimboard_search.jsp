<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <!-- 부트스트랩 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<style>
/** common **/

a:link {  text-decoration: none}
    a:visited {color: black; text-decoration: none;}
    a:hover {color: #5c3018; text-decoration: none;}
    a:active {color: #de5f47; text-decoration: none;}


body,ul ,li, h1,h2,h3{
    margin: 0;
    padding: 0;
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
  
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
  
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
    z-index: 1;
}

#header ul{
    display: flex;
    font-family: 'NanumSquareBold';
}

#header ul li{
    margin-left: 73px;
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
    width: 5%;
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


#btnSec .search-wrap{
    right: 0;
    font-size: 0; 
    margin-bottom : 8px;
    margin-left : 150px;
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
    background: url( ./images/search2.png) no-repeat ;
    position: absolute;
    background-size: 38px 25px;
 
}

#locationSec{
    width: 100%;
    background-color: #f7f7fd;
    overflow: hidden;
    padding-left: 10%;
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
    margin-right :16%;
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
    flex: 1;
    flex-direction: column;
    border-top: 1px solid;
    border-color: #ecf0f2;
    border-color: rgba(var(--place-color-border2), 1);
    height: 1000px;
    position: relative;
    
}

.scrollwrap{
    width: 600px;
    overflow: scroll;
    overflow-y: auto;
    flex: 1;
    overflow: hidden;
    overflow-y: auto;
   
}

.scrollbar{
    height:100%;
    scrollbar-width: auto;
   
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
    width:53%;
}
.maps{
    position: absolute;
    display: flex;
    justify-content: end;
    width:100%;
}










/***** footer  *****/
footer{
    width: 100%;
    height: 163px;
    background-color: #d7d7d7;
    margin-top: 5%;
}

</style>

</head>
<body>
    <nav id="header">
        <div id="headerWap">
            <h1 id="logoSec">
                <a href="#"><img src="images/logo.png" alt="logo"></a>
            </h1>
            <h3 id="logout"><a href="#" style="color : gray">Logout</a></h3>
            
            <ul>
                <li><b><a href="#">마이페이지</a></b></li>
                <li><b><a href="#">소모임장페이지</a></b></li>
                <li><b><a href="#">관리자페이지</b></li></a>
                <li><b><a href="#">즐겨찾기</b></li></a>
                <li id="bell"><a href="#"><b><img src="images/bell.png"></a></b>1</li>
            </ul>
        </div> <!--headerWap-->
   
   
      <!--locationSec -->
      <section id="locationSec">
        <div id = "locationwrap">
             <button class="active"><a href="#" >게시판</a></button>
             <button class="allbtn"><a href="#" style="color : #de5f47">식당검색</a></button>
             <button class="allbtn"><a href="#">소모임 회원 목록</a></button>
             <button class="allbtn"><a href="#">소모임 탈퇴</a></button>
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
          
            <div class="search-wrap">  
             
            <div class="input">
                <input type="text" title="검색어 입력">
                <button type="button">검색</button>
            </div><!-- input -->
         </div><!-- search-wrap -->
           
        </section>
    
        <!-- 테이블 목록이 있는 섹션입니다 -->
        <section id="tblSec">
           
            <div id="tblWrap">
                <div class="maps">
                    <img src="images/mapsearch2.png">
                </div>
             
                <div class="scrollwrap">
                 <div class="scrollbar">
                    <ul>
                        <li>

                            <div class="lists1">
                            <a href="#"><img class="list1" style="background-image: url('https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fsearchad-phinf.pstatic.net%2FMjAyMjA0MThfMTYx%2FMDAxNjUwMjc2MTI4OTEz.Iwfc3HzhfZYcIfdtiWx7f4L1x9lOoGg1EUKGy2ZCxAwg.2S0g3cV4uNkldREs__6NEt5ChSUE2EOOV4EwCxJRtv8g.PNG%2F2355050-adba00da-0fad-4f6d-8d3d-9ade8109773c.png');">
                                <span class="write1">경양가츠 강남점</span>
                                <span class="write2">줄서서 먹는 돈까스맛집</span>
                                <span class="write3"><i class="fa fa-star" style="font-size:20px;color:red"></i>    4.8점</span>
                            </div>
                            </a>

                            <div class="lists1">
                                <a href="#"><img class="list1" style="background-image: url('https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220427_237%2F165102764126107Ghf_JPEG%2F1.jpg');">
                                    <span class="write1">을지다락 강남</span>
                                    <span class="write2">깔끔한 분위기의 파스타</span>
                                    <span class="write3"><i class="fa fa-star" style="font-size:20px;color:red"></i>    4.9점</span>
                                </div>
                                </a>

                                <div class="lists1">
                                    <a href="#"><img class="list1" style="background-image: url('https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20161112_233%2F147894152004419V1R_PNG%2F177062583539881_0.png');">
                                        <span class="write1">장인닭갈비 강남점</span>
                                        <span class="write2">순수 모짜렐라 치즈를 사용한 닭갈비</span>
                                        <span class="write3"><i class="fa fa-star" style="font-size:20px;color:red"></i>    4.5점</span>
                                    </div>
                                    </a>

                        </li>

                    </ul>

                   
                    
                </div><!--scrollbar-->
              
            </div><!-- scrollwrap -->

           

           
            </div><!-- tblWrap -->
               
        </section><!--tblSec-->

    
    </div>

    <!-- footer 
    <footer>

    </footer>
    -->

</body>
</html>