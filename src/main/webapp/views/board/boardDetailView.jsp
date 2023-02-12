<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.br.board.model.vo.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
        margin:auto;
        margin-top:50px;
    }

    .list-area {
        border:1px solid white;
        text-align:center;
    }

</style>
</head>
<body>

	<jsp:include page="../common/menubar.jsp"/>

    <div class="outer" align="center">
        <br>
        <h2>일반게시판 상세보기</h2>
        <br>

        <table border="1" id="detail-area">
            <tr>
                <th width="70">카테고리</th>
                <td width="70">${ b.category }</td>
                <th width="70">제목</th>
                <td width="350">${ b.categoryTitle }</td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>${ b.boardWriter }</td>
                <th>작성일</th>
                <td>${ b.createDate }</td>
            </tr>
            <tr>
                <th>내용</th>
                <td colspan="3" height="200">
                    ${ b.boardContent }
                </td>
            </tr>
            <tr>
                <th>첨부파일</th>
                <td colspan="3">
                	<c:choose>
                		<c:when test="${ empty at }">
                			<!-- case1. 첨부파일 없을 경우 -->
	                        첨부파일이 없습니다.
	                    </c:when>
						<c:otherwise>
	                    	<!-- case2. 첨부파일 있을 경우 -->
	                    	<a download="${ at.originName }" href="${ at.filePath + at.changeName }">${ at.originName }</a>
						</c:otherwise>
					</c:choose>
                </td>
                <th></th>
                <td></td>
            </tr>
        </table>
        <br>

        <div>
        
            <a href="list.bo?cpage=1" class="btn btn-secondary btn-sm">목록가기</a>
			
			<c:if test="${ empty loginUser and loginUser.userId eq b.boardWriter }">
            <a href="updateForm.bo?no=${ b.boardNo }" class="btn btn-warning btn-sm">수정하기</a>
            <a href="" class="btn btn-danger btn-sm">삭제하기</a>
			</c:if>
			
        </div>

        <br>

        <div id="reply-area">
            <table border="1">
                <thead>
                    <tr>
                        <th>댓글작성</th>
						<% if(loginUser != null) { %>
	                        <!-- 로그인이 되어있을경우 -->
	                        <td><textarea name="" id="" cols="50" rows="3" style="resize:none"></textarea></td>
	                        <td><button onclick="insertReply();">댓글등록</button></td>
						<% } else { %>	
	                        <!-- 로그인이 되어있지않을 경우 -->
	                        <td><textarea name="" id="" cols="50" rows="3" style="resize:none" readonly>로그인 후 이용가능한 서비스입니다.</textarea></td>
	                        <td><button disabled>댓글등록</button></td>
 						<% } %>
                    </tr>
                </thead>
                <tbody>
     				<!-- 댓글들어갈자리 -->
                </tbody>
            </table>
        </div>
        <br><br>
        
        <script>
        	$(function() {
        		selectReplyList();
        		
        		// 1초마다 주기적으로 댓글 리스트 조회해오는 요청
        		// => 다른 사람이 댓글 쓴 걸 실시간으로 볼 때
        		setInterval(selectReplyList, 1000);
        		
        	})
        	
        	// ajax로 댓글 작성용
        	function insertReply() {
        		$.ajax({
        			url:"<%=contextPath%>/rinsert.bo",
        			data:{
        				content:$("#reply-area textarea").val(),
        				no:<%=b.getBoardNo()%>
        				
        			},
        			type:"post",
        			success:function(result) {
        				if(result > 0) { // 댓글등록 성공
        					$("#reply-area textarea").val("");
        					selectReplyList();
        				} else {
        					alert("댓글등록실패");
        				}
        				
        			}, error:function() {
        				console.log("댓글 작성용 ajax 통신 실패");
        			}
        			
        		})
        	}
        	
        	
        
        	// ajax로 해당 게시글에 달린 댓글 목록 조회용
        	function selectReplyList() {
        		$.ajax ({
        			url:"<%=contextPath%>/rlist.bo",
        			data:{no:<%=b.getBoardNo()%>}, // 문자열이면 ''감싸줘야함
        			success:function(list){
        				
        				//console.log(list);
        				
        				let value = "";
        				if(list.length == 0) { // 댓글이 없을 경우
        					value += "<tr>"
        						  + 	"<td colspan='3'>조회된 댓글이 없습니다.</td>"
        						  + "</tr>";
        				} else { // 댓글이 있을 경우
        					for(let i=0; i<list.length; i++) {
        						value += "<tr>"
        							  +		"<td>" + list[i].replyWriter + "</td>"
        							  +		"<td>" + list[i].replyContent + "</td>"
        							  +		"<td>" + list[i].createDate + "</td>"
        							  +  "</tr>";
        					}
        					
        				}
        				
        				$("#reply-area tbody").html(value);
        				
        			}, error:function() {
        				console.log("댓글목록 조회용 ajax 통신실패");
        			}
        		})
        	}
        
        
        </script>
        
    </div>
	

</body>
</html>