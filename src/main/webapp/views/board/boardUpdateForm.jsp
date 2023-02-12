<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        height:550px;
        margin:auto;
        margin-top:50px;
    }

    .list-area {
        border:1px solid white;
        text-align:center;
    }

    #update-form table {border:1px solid white;}
    #update-form input, #update-form textarea {
        width:100%;
        box-sizing:border-box;
    }

</style>
</head>
<body>
    
    <jsp:include page="../common/menubar.jsp"/>

    <div class="outer" align="center">
        <br>
        <h2>일반게시판 수정하기</h2>
        <br>

        <form id="update-form" action="update.bo" method="post" enctype="multipart/form-data">
			<input type = "hidden" name="no" value="${ b.boardNo }">
            <table>
                <tr>
                    <th width="70">카테고리</th>
                    <td width="500">
                        <select name="category">
                            <!-- db로부터 category테이블에 존재하는 값들 조회해와서 뿌려야함 -->
                            <c:forEach var="c" items="${ list }">
                            	<option value="${ c.categoryNo }">${ c.categoryName }</option>
                           	</c:forEach>
                        </select>
                        <script>
                        	// option 요소들의 innerText값이 현재 게시글의 카테고리명과 일치하는
                        	// option 요소를 찾아서 selected 속성 부여해주기
                        	$(function() {
                        		$("#update-form option").each(function() {
                        			if($(this).text() == "${ b.category }") {
                        				$(this).attr("selected", true);
                        			}
                        		})
                        	})
                        	
                        </script>
                    </td>
                </tr>
                <tr>
                    <th>제목</th>
                    <td><input type="text" name="title" required value="${ b.boardTitle }"></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea name="content" rows="10" style="resize:none" required>${ b.boardContent }</textarea></td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td>
                    	<c:if test="${ not empty at }">
	                        <!-- 기존의 첨부파일이 있었을 경우 -->
	                        ${ at.originName }
	                        <input type="hidden" name="originFileNo" value="${ at.fileNo }">
						</c:if>
                        <input type="file" name="upfile">
                    </td>
                </tr>
            </table>
            <br>

            <div>
                <button type="submit">수정하기</button>
                <button type="reset">취소하기</button>
            </div>


        </form>


    </div>
	

</body>
</html>