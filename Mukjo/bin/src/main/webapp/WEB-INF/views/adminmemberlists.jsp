<%@page import="com.example.model1.PageMemberTO"%>
<%@page import="com.example.model1.MemberTO"%>
<%@ page import="java.util.ArrayList" %>
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
    		if (!loginedMemberSeq.equals("1")) {
       	   		out.println ( "<script>");
       	   		out.println( "alert('관리자만 관리자페이지에 들어갈 수 있습니다.');" );
       			out.println ( "window.location.href = 'http://localhost:8080/main.do'");
       			out.println ( "</script>");
       	   	}
    	} else {
    		out.println ( "<script>");
			out.println ( "window.location.href = 'http://localhost:8080/login.do'");
			out.println ( "</script>");
    	}
    	
    	PageMemberTO pageMemberTO=(PageMemberTO)request.getAttribute("pageMemberTO");

    	int cpage=pageMemberTO.getCpage();
    	int recordPerPage = pageMemberTO.getRecordPerPage();
    	int totalRecord = pageMemberTO.getTotalRecord();
    	int totalPage = pageMemberTO.getTotalPage();
    	int blockPerPage = pageMemberTO.getBlockPerPage();
    	int startBlock = pageMemberTO.getStartBlock();
    	int endBlock = pageMemberTO.getEndBlock();
    	ArrayList<MemberTO> memberLists = pageMemberTO.getMemberLists();
    
    	StringBuilder sbHtml=new StringBuilder();
		int num=1;

    	for (int j=0; j<memberLists.size(); j=j+20) {
    		num=(pageMemberTO.getCpage()-1)*20+1;
    		for (int i=j; i<j+20; i++) {
				
    			if (i>=memberLists.size()) {

    			} else {
    				String seq=memberLists.get(i).getSeq();
    				String name=memberLists.get(i).getName();
    				String email=memberLists.get(i).getEmail();
    				String birth=memberLists.get(i).getBirth();
    				
    				sbHtml.append("<tr>");
    				sbHtml.append("<td>"+num+"</td>");
    				sbHtml.append("<td>"+name+"</td>");
    				sbHtml.append("<td>"+email+"</td>");
    				sbHtml.append("<td>"+birth+"</td>");
    				sbHtml.append("<td><a href='#'><button type='sumbit'>추방</button></a></td>");
    				sbHtml.append("</tr>");
    				num+=1;
    			}
    		}
    	}
    %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Main</title>
   
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

a:link {  text-decoration: none}
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

#headerWap h3 {
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
  font-size: 25px;
  display: inline-block;
  padding-left: 50px;
}

#btnSec .search-wrap{
    margin-left : 50%;
   
}

#locationSec{
    width: 100%;
    background-color: #f7f7fd;
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

#pagingSec .search-wrap #search{
    height: 37.6px;
    margin-right: 4px;
}


.search-wrap input{
    height: 32px;
    width: 80%;
    color: #000;
    font-size: 16px;
    box-sizing: border-box;
    margin-left:5px;
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
             <h3><%=welcome %><a href="logoutok.do" id="logout" style="color : gray"> <br/><%=log %></a></h3>
            
            <ul>
                <li><b><a href="#">마이페이지</a></b></li>
                <li><b><a href="#">소모임장페이지</a></b></li>
                <li><b><a href="admin.do" style="color: #de5f47">관리자페이지</b></li></a>
                <li><b><a href="favorite.do">즐겨찾기</b></li></a>
                <li id="bell"><a href="#"><b><img src="images/bell.png"></a></b>1</li>

            </ul>
        </div> <!--headerWap-->
   
   
      <!--locationSec -->
      <section id="locationSec">
        <div id = "locationwrap">
             <button class="allbtn"><a href="admin.do">리뷰&게시물 수</a></button>
             <button class="active"><a href="adminmemberlists.do" style="color: #de5f47">전체 회원 목록</a></button>
             <button class="active"><a href="adminteam.do">소모임 목록</a></button>
             <button class="active"><a href="adminnotice.do">공지사항</a></button>
        </div>
      </section>
    </nav>  

    <!-- 전체 요소를 감싸는 div -->
    <div id="wrap">
    	<div id="write"></div>
   		<section id="tblSec">

            <div id="tblWrap">
                <table class="board-table">
            
                    <thead>
                        <tr>
                            <th scope="col" class="th-num">번호</th>
                            <th scope="col" class="th-name">이름</th>
                            <th scope="col" class="th-id">계정</th>
                            <th scope="col" class="th-birthdate">생년월일</th>
                            <th scope="col" class="th-function">기능</th>
                        </tr>
                    </thead>
                    <tbody>
                      <!--  
                        <tr>
                            <td><a href="#">1</td>
                            <td><a href="#">김영주</a></td>
                            <td><a href="#">young@naver.com</a></td>
                            <td><a href="#">201017</a></td>
                            <td><a href="#"><button type="sumbit">추방</button></a></td>
                        </tr>
                     -->
	<%=sbHtml.toString() %>
						<!--  
                        <tr>
                            <td><a href="#">2</td>
                            <td><a href="#">이다함</a></td>
                            <td><a href="#">dahami@gmail.com</a></td>
                            <td><a href="#">980920</a></td>
                            <td><a href="#"><button type="sumbit">추방</button></a></td>
                        </tr>         

                        <tr>
                            <td><a href="#">3</td>
                            <td><a href="#">정규진</a></td>
                            <td><a href="#">kujin@naver.com</a></td>
                            <td><a href="#">960117</a></td>
                            <td><a href="#"><button type="sumbit">추방</button></a></td>
                        </tr>   
                        <tr>
                            <td><a href="#">4</td>
                            <td><a href="#">김영규</a></td>
                            <td><a href="#">young@naver.com</a></td>
                            <td><a href="#">201017</a></td>
                            <td><a href="#"><button type="sumbit">추방</button></a></td>
                        </tr>   
                        <tr>
                            <td><a href="#">5</td>
                            <td><a href="#">정진석</a></td>
                            <td><a href="#">jinseokk92@naver.com</a></td>
                            <td><a href="#">961029</a></td>
                            <td><a href="#"><button type="sumbit">추방</button></a></td>
                        </tr>
                        -->
                    </tbody>
                </table>
            </div>

        </section>
		<!--tblSec-->
		

        <!-- 페이징 처리 -->
        <section id="pagingSec">
            <div class="paginate_regular">
                <div class="board_pagetab">
                <!--  
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
                 -->
<%	
	if (startBlock==1) { //<<
		out.println("<span><a>&lt;&lt;</a>&nbsp;&nbsp;</span>");
	} else {
		out.println("<span><a href='adminmemberlists.do?cpage="+(startBlock-blockPerPage)+"'>&lt;&lt;</a>&nbsp;&nbsp;</span>");
	}

	if (cpage==1) { //<
		out.println("<span><a>&lt;</a>&nbsp;&nbsp;</span>");
	} else {
		out.println("<span><a href='adminmemberlists.do?cpage="+(cpage-1)+"'>&lt;</a>&nbsp;&nbsp;</span>");
	}
	
	out.println("<ul>");
	for (int i=startBlock;i<=endBlock;i++) {
		if (cpage==i) {
			out.println("<li class='active'><a>"+i+"</a></li>");
		} else {
			out.println("<li><a href='adminmemberlists.do?cpage="+i+"'>"+i+"</a></span>");
		}
	}
	
	out.println("</ul>");
	
	if (cpage==totalPage) { //>
		out.println("<span>&nbsp;&nbsp;<a>&gt;</a></span>");
	} else {
		out.println("<span>&nbsp;&nbsp;<a href='adminmemberlists.do?cpage="+(cpage+1)+"'>&gt;</a></span>");
	}
	
	if (endBlock==totalPage) { //>>
		out.println("<span>&nbsp;&nbsp;<a>&gt;&gt;</a></span>");
	} else {
		out.println("<span>&nbsp;&nbsp;<a href='adminmemberlists.do?cpage="+(startBlock+blockPerPage)+"'>&gt;&gt;</a></span>");
	}
%>    
                 
                 
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
