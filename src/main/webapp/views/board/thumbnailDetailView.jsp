<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, com.br.board.model.vo.*" %>
    
<%
	Board b = (Board)request.getAttribute("b");
	ArrayList<Attachment> list = (ArrayList<Attachment>)request.getAttribute("list");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .outer {
        background:black;
        color:white;
        width:1000px;
        height:800px;
        margin:auto;
        margin-top:50px;
    }

    .detail-area {
        text-align:center;
    }

</style>
</head>
<body>

	<%@ include file="../common/menubar.jsp" %>

    <div class="outer"  align="center">
    <br>
   	<h2>사진 게시판 상세보기</h2>
        <table class="detail-area" border="1">
            <tr>
                <td width="70">제목</td>
                <td colspan="3" with="600"><%= b.getBoardTitle() %></td>
            </tr>
            <tr>
                <td>작성자</td>
                <td><%= b.getBoardWriter() %></td>
                <td>작성일</td>
                <td><%= b.getCreateDate() %></td>
            </tr>
            <tr>
                <td>내용</td>
                <td colspan="3" height="50"><%= b.getBoardContent() %></td>
            </tr>
            <tr>
                <td>대표사진</td>
                <td colspan="3">
                    <img src="<%= contextPath %>/<%= list.get(0).getFilePath() + list.get(0).getChangeName() %>" width="500" height="300">
                </td>
            </tr>
            <tr>
                <td>상세사진</td>
                <td colspan="3">
                    <% for(int i=1; i<list.size(); i++) { %>
                    <img src="<%= contextPath %>/<%= list.get(i).getFilePath() + list.get(i).getChangeName()%>" width="200" height="150">
                   
					<% } %>
                </td>
            </tr>
        </table>
        
        <br><br>
        
        <a href="<%= contextPath%>/list.th">목록가기</a>
    </div>
    

</body>
</html>