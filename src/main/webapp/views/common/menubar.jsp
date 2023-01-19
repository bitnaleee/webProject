<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.br.member.model.vo.Member" %>
<%
	
	String contextPath = request.getContextPath(); // "/web"

	Member loginUser = (Member)session.getAttribute("loginUser"); // (sessoin jsp내장객체라서 바로 쓸 수 있고 Servlet에서는 )
	// 로그인 시도 전 menubar.jsp 로딩시 : null
	// 로그인 성공 후 menubar.jsp 로딩시 : 로그인한 회원의 정보가 담겨있는 Member객체
	
	String alertMsg = (String)session.getAttribute("alertMsg");
	// 서비스 요청 전 menubar.jsp 로딩시 : null
	// 서비스 성공 후 menubar.jsp 로딩시 : alert로 띄어줄 메세지 문구
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .login-area>* {float:right}
    .login-area a {
        text-decoration:none;
        color:black;
        font-size:12px;
    }
    .nav-area {background:black;}
    .menu {
        display:table-cell;
        width:150px;
        height:50px;
    }
    .menu a { /*테두리는 설정했다가 삭제*/
        text-decoration:none;
        color:white;
        font-size:20px;
        font-weight:bold;
        display:block;
        width:100%;
        height:100%;
        line-height:50px;
    }
    .menu a:hover {background:darkgrey;}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	
	<% if(alertMsg != null) { %>
		<script>
			alert("<%=alertMsg%>"); 
			<!--한글이면 '' 해줘야함, session은 내가 멈추기 전까지 계속 돔-->
		</script>
		<% session.removeAttribute("alertMsg"); %>
	<% } %>


    <h1 align="center">Welcome Boram World</h1>

    <div class="login-area">
    	<% if(loginUser == null) { %>
        <!-- case1. 로그인 전 -->
        <!-- /web이라 작성하면 안됨 바뀔 수 있어서 request.getContextPath()로 호출 -->
        <form action="<%= contextPath %>/login.me" method="post">
            <table>
                <tr>
                    <th>아이디</th>
                    <td><input type="text" name="userId" required></td>
                </tr>
            
                <tr>
                    <th>비밀번호</th>
                    <td><input type="password" name="userPwd" required></td> 
                </tr>
                <tr>
                    <th colspan="2">
                        <button type="submit">로그인</button>
                        <button type="button" onclick="enrollPage();">회원가입</button>
                        <!-- 기본타입이 submit이기 때문에 type="button" -->
                    </th>
                </tr>
            </table>
            <script>
            	function enrollPage() {
            		//location.href = "<%=contextPath %>/views/member/memberEnrollForm.jsp";
            		// url에 웹 애플리케이션의 디렉토리 구조가 노출되면 보안에 취약
            		
            		location.href = "<%=contextPath%>/enrollForm.me";
            		// 단순한 페이지 요청에 있어서도 Servlet을 만들어서 처리하자
            		// 포워딩방식을 통해서 해당 페이지가 보여지게끔 (이때 url에는 서블릿 매핑값만 남아있음)
            	
            	}
            </script>
        </form>
		<% } else { %>
        <!-- case2. 로그인 후 -->
        <div>
            <b><%= loginUser.getUserName() %>님</b>의 방문을 환영합니다 <br><br>
            <div align="center">
                <a href="<%=contextPath %>/myPage.me">마이페이지</a>
                <a href="<%=contextPath %>/logout.me">로그아웃</a>
            </div>
        </div>
		<% } %>
    </div>

        <br clear="both">
        <br>

        <div class="nav-area" align="center">
            <div class="menu"><a href="<%=contextPath%>">HOME</a></div>
            <div class="menu"><a href="<%=contextPath%>/list.no">공지사항</a></div>
            <div class="menu"><a href="<%=contextPath%>/list.bo?cpage=1">일반게시판</a></div>
            <div class="menu"><a href="<%=contextPath%>/list.th">사진게시판</a></div>
        </div>

</body>
</html>