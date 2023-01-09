<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        height:500px;
        margin:auto;
        margin-top:50px;
    }

</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>

    <div class="outer" align="center">
        <br>
        <h2>공지사항 상세보기</h2>
        <br>

        <table id="detail-area" border="1">
            <tr>
                <th width="70">제목</th>
                <td colspan="3" width="430">여기는 공지사항 제목자리</td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>작성자의 아이디</td>
                <th>작성일</th>
                <td>xxxx-xx-xx</td>
            </tr>
            <tr>
                <th>내용</th>
                <td colspan="3">
                    <p style="height:150px">여기는 공지사항의 내용자리</p>
                </td>
            </tr>
        </table>
        <br><br>

        <div>
            <a href="" class="btn btn-secondary btn-sm">목록가기</a>
            
            <!-- 현재 로그인한 사용자가 해당 글을 쓴 본인일 경우  -->
            <a href="" class="btn btn-warning btn-sm">수정하기</a>
            <a href="" class="btn btn-danger btn-sm">삭제하기</a>
        </div>

    </div>
</body>
</html>