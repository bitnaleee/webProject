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
        margin:auto;
        margin-top:50px;
    }

    .list-area {
        border:1px solid white;
        text-align:center;
    }

    .list-area>tbody>tr:hover {
       background-color:gray;
       cursor:pointer;
    }

</style>
</head>
<body>

	<%@ include file="../common/menubar.jsp" %>

    <div class="outer" align="center">
        <br>
        <h2>일반게시판 상세보기</h2>
        <br>

        <table border="1" id="detail-area">
            <tr>
                <th width="70">카테고리</th>
                <td width="70">운동</td>
                <th width="70">제목</th>
                <td width="350">여기는 제목자리</td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>admin</td>
                <th>작성일</th>
                <td>2023/01/01</td>
            </tr>
            <tr>
                <th>내용</th>
                <td colspan="3" height="200">
                    여기는 내용자리
                </td>
            </tr>
            <tr>
                <th>첨부파일</th>
                <td colspan="3">

                    <!-- case1. 첨부파일 없을 경우 -->
                    첨부파일이 없습니다.

                    <!-- case2. 첨부파일 있을 경우 -->
                    <a href="첨부파일의저장경로, 첨부파일의실제저장된파일명">flower1.jpg</a>

                </td>
                <th></th>
                <td></td>
            </tr>
        </table>
        <br>

        <div>
            <a href="" class="btn btn-secondary btn-sm">목록가기</a>

            <a href="" class="btn btn-warning btn-sm">수정하기</a>
            <a href="" class="btn btn-danger btn-sm">삭제하기</a>

        </div>

        <br><br>
    </div>


</body>
</html>