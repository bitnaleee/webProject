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

    #enroll-form table {margin:auto;}
    #enroll-form input {margin:5px;}

</style>
</head>
<body>
	
	 <%@ include file="../common/menubar.jsp" %>

    <div class="outer">
        <br>
        <h2 align="center">회원가입</h2>

        <form action="<%=contextPath %>/insert.me" method="post" id="enroll-form">

            <table>
                <tr>
                    <td>* 아이디</td>
                    <td><input type="text" name="userId" required></td>
                    <td><button type="button">중복확인</button></td>
                </tr>
                <tr>
                    <td>* 비밀번호</td>
                    <td><input type="password" name="userPwd" maxlength="15" required></td>
                    <td></td>
                </tr>
                <tr>
                    <td>* 비밀번호확인</td>
                    <td><input type="password" maxlength="15" required></td>
                    <td></td>
                </tr>
                <tr>
                    <td>* 이름</td>
                    <td><input type="text" name="userName" maxlength="5" required></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;핸드폰 번호</td>
                    <td><input type="text" name="phone" placeholder="-포함해서 입력"></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;Email</td>
                    <td><input type="email" name="email"></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;주소</td>
                    <td><input type="text" name="address"></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;관심분야</td>
                    <td colspan="2">
                        <input type="checkbox" name="interest" value="sports" id="sports">
                        <label for="sports">운동</label>

                        <input type="checkbox" name="interest" value="climbing" id="climbing">
                        <label for="climbing">등산</label>

                        <input type="checkbox" name="interest" value="fishing" id="fishing">
                        <label for="fishing">낚시</label>
                        <br>
                        <input type="checkbox" name="interest" value="cooking" id="cooking">
                        <label for="cooking">요리</label>

                        <input type="checkbox" name="interest" value="game" id="game">
                        <label for="game">게임</label>

                        <input type="checkbox" name="interest" value="movie" id="movie">
                        <label for="movie">영화</label>
                    </td>
                </tr>
            </table>

            <br><br>

            <div align="center">
                <button type="submit">회원가입</button>
                <button type="reset">초기화</button>
            </div>
            <br><br>

        </form>

    </div>

</body>
</html>