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

    #mypage-form table {margin:auto;}
    #mypage-form input {margin:5px;}

</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
	
	<%
		String userId = loginUser.getUserId();
		String userName = loginUser.getUserName();
		String phone = loginUser.getPhone() == null ? "" : loginUser.getPhone(); // null이 담겨 있을 수 있음
		String email = loginUser.getEmail() == null ? "" : loginUser.getEmail();
		String address = loginUser.getAddress() == null ? "" : loginUser.getAddress();
		String interest = loginUser.getInterest() == null ? "" : loginUser.getInterest();
	
	%>

    <div class="outer">
        <br>
        <h2 align="center">마이페이지</h2>

        <form action="" method="post" id="mypage-form">

            <table>
                <tr>
                    <td>* 아이디</td>
                    <td><input type="text" name="userId" value="<%=userId %>" readonly></td>
        
                </tr>
                <tr>
                    <td>* 이름</td>
                    <td><input type="text" name="userName" maxlength="5" value="<%=userName %>" required></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;핸드폰 번호</td>
                    <td><input type="text" name="phone" placeholder="-포함해서 입력" value="<%=phone %>"></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;Email</td>
                    <td><input type="email" name="email" value="<%=email%>"></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;주소</td>
                    <td><input type="text" name="address" value="<%=address%>"></td>
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
            
            <script>
            	$(function() {
            		const interest = "<%=interest%>";
            		// 현재 로그인한 회원의 관심 분야들
            		// "sports,climbing,game" | ""
            		
            		$("input[type=checkbox]").each(function() {
            			// $(this) : 순차적으로 접근하는 체크박스input요소
            			// $(this).val() : 순차적으로 접근하는 체크박스input요소의 value값 (sports,climbing, ...)
            			if(interest.search($(this).val()) != -1) {
            				$(this).attr("checked", true);
            			}
            		})	
            		
            	})
            	
            </script>

            <br><br>

            <div align="center">
                <button type="submit">정보변경</button>
                <button type="button">비밀번호변경</button>
                <button type="button">회원탈퇴</button>
            </div>
            <br><br>

        </form>

    </div>
</body>
</html>