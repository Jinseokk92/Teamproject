<%@page import="com.example.model1.BoardTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.example.model1.BoardDAO"%>
<%@page import="com.example.model1.BoardListTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
		BoardListTO listTO = new BoardListTO();
	
		
		BoardDAO dao = new BoardDAO();
		listTO = (BoardListTO)request.getAttribute("listTO");
		int cpage = listTO.getCpage();
		int recordPerPage = listTO.getRecordPerPage();
		
		int totalRecord = listTO.getTotalRecord();
		int totalPage = listTO.getTotalPage();
		
		int blockPerPage = listTO.getBlockPerPage();
		int startBlock = listTO.getStartBlock();
		int endBlock = listTO.getEndBlock();
		
		ArrayList<BoardTO> boardLists = listTO.getBoardLists();
		
		StringBuilder sb = new StringBuilder();
		
		String bseq = "";
		String subject = "";
		String content = "";
		String writer = "";
		String wdate = "";
		String hit = "";
		
		for( int i = 0 ; i < boardLists.size(); i++ ) {
			BoardTO to = boardLists.get(i);
			bseq = to.getBseq();
			subject = to.getSubject();
			content = to.getContent();
			writer = to.getWriter();
			wdate = to.getWdate();
			hit = to.getHit();
			
			sb.append("<tr>");
			sb.append("		<td><a href='#'>일반</a></td>");
			sb.append("		<td><a href='#'>"+ subject+"</a></td>");
			sb.append("		<td><a href='#'>"+ writer+"</a></td>");
			sb.append("		<td><a href='#'>"+ wdate+"</a></td>");
			sb.append("		<td><a href='#'>"+ hit+"</a></td>");
			sb.append("</tr>");
		}
		
/* 		 <tr>
         <td><a href="#">일반</a></td>
         <td><a href="#">여기 가보신분 있어요?</a></td>
         <td><a href="#">이다함</a></td>
         <td><a href="#">2022-07-31</a></td>
         <td><a href="#">30</a></td>
     </tr>    */
    
    
    %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>소모임게시판</title>
    <style href="css/common.css"></style>
    <!-- 나눔스퀘어 폰트 -->
    <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">


<style>
/** common **/


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

a:link {  text-decoration: none }
    a:visited {color: black; text-decoration: none;}
    a:hover {color: #5c3018; text-decoration: none;}
    a:active {color: #de5f47; text-decoration: none;}


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
    padding-left: 10%;
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
#tblSec table{
    width: 100%;
    border-collapse: collapse;
    
}

#tblSec table td{
   height: 45px;
   border-bottom : 1px solid #c7bebe;
}

#tblWrap{
    padding-top: 30px;
}

.notice td>a:first-child{
    color: red;
}

/***** pagingSec  *****/
#pagingSec ul{
    display: flex;
}


#pagingSec{
    display: flex;
    justify-content: center;
    margin-top: 30px;
    line-height: 2.5;
}

#btnSec .search-wrap{
    right: 0;
    font-size: 0; 
    margin-bottom : 8px;
}

.select{
    display: inline-block;
    vertical-align: top;
    position: relative;
}

#btnSec .search-wrap .select select{
    border: 2px solid #5c3018;
    border-radius: 10px;
    height: 36px;
    width: 90px;
    box-sizing: border-box;
    padding-left: 10px;
    z-index: 1;
    position: relative;
    background: transparent;
}

.search-wrap select option{
    font-weight: normal;
    display: block;
    white-space: nowrap;
    min-height: 1.2em;
    padding: 0px 2px 1px;
}



#pagingSec .search-wrap #search{
    height: 37.6px;
    margin-right: 4px;
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

#pagingSec ul li{
    width: 42px;
    height: 42px;
    text-align: center;
    line-height: 42px;
    margin-right: 10px;
    border: 1px solid #c4c4c4;
    border-radius: 10%;
}


#pagingSec .active{
    color:white;
    background-color: #de5f47;
}

    .board_pagetab { text-align: center; display: inline-flex; position:relative;}
	.board_pagetab a { text-decoration: none; font: 12px verdana; color: #000; padding: 0 3px 0 3px; }
    /* .board_pagetab ul a:hover  { background-color:black; } */
	.on a { font-weight: bold; }





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
                <a href="main.do"><img src="images/logo.png" alt="logo"></a>
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
             <button class="active"><a href="#" style="color : #de5f47">게시판</a></button>
             <button class="allbtn"><a href="#">식당검색</a></button>
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
            <strong>소모임 : <b>코딩모임</b></strong>

            <div class="search-wrap">  
                <div class="select">
                <select>
                    <option value="title">제목</option>
                    <option value="content">내용</option>
                    <option value="writer">글쓴이</option>
                </select>    
            </div><!-- select-->
            <div class="input">
                <input type="text" title="검색어 입력">
                <button type="button">검색</button>
            </div><!-- input -->
         </div><!-- search-wrap -->
           
        </section>
    
        <!-- 테이블 목록이 있는 섹션입니다 -->
        <section id="tblSec">

            <div id="tblWrap">
                <table class="board-table">
            
                    <thead>
                        <tr>
                            <th scope="col" class="th-num">분류</th>
                            <th scope="col" class="th-title">제목</th>
                            <th scope="col" class="th-date">글쓴이</th>
                            <th scope="col" class="th-date">등록일</th>
                            <th scope="col" class="th-date">조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="notice">
                            <td><a href="#">공지</td>
                            <td><a href="#">[중요]게시판 이용시 준수사항</a></td>
                            <td><a href="#">관리자</a></td>
                            <td><a href="#">2022-08-01</a></td>
                            <td><a href="#">13</a></td>
                        </tr>
                        
                        <%=sb %>

<!--                         <tr>
                            <td><a href="#">일반</a></td>
                            <td><a href="#">여기 가보신분 있어요?</a></td>
                            <td><a href="#">이다함</a></td>
                            <td><a href="#">2022-07-31</a></td>
                            <td><a href="#">30</a></td>
                        </tr>         

                        <tr>
                            <td><a href="#">일반</a></td>
                            <td><a href="#">여기 맛집강추</a></td>
                            <td><a href="#">김영주</a></td>
                            <td><a href="#">2022-07-31</a></td>
                            <td><a href="#">30</a></td>
                        </tr>   

                        <tr>
                            <td><a href="#">일반</a></td>
                            <td><a href="#">회식장소 괜찮나요?</a></td>
                            <td><a href="#">정진석</a></td>
                            <td><a href="#">2022-07-31</a></td>
                            <td><a href="#">30</a></td>
                        </tr>   

                        <tr>
                            <td><a href="#">일반</a></td>
                            <td><a href="#">점심메뉴 추천좀요</a></td>
                            <td><a href="#">정규진</a></td>
                            <td><a href="#">2022-07-31</a></td>
                            <td><a href="#">30</a></td>
                        </tr>    -->
                    </tbody>
                </table>
            </div>

        </section><!--tblSec-->

        
        <section id="pagingSec">


            <div class="paginate_regular">
                <div class="board_pagetab">
                
                    <span class="off"><a href="#">&lt;&lt;</a>&nbsp;&nbsp;</span>
                    <span class="off"><a href="#">&lt;</a>&nbsp;&nbsp;</span>
                <ul>
                    <li class="active"><a href="#">1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                    <li><a href="#">5</a></li>
                </ul>
                    <span class="off">&nbsp;&nbsp;<a href="#">&gt;</a></span>
                    <span class="off">&nbsp;&nbsp;<a href="#">&gt;&gt;</a></span>
                    
                </div><!-- board_pagetab -->
                
            
            </div><!-- paginate_regular -->
            
            
            
        </section>
    
    </div>

    <!-- footer 
    <footer>

    </footer>
    -->

</body>
</html>