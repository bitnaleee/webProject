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
                    <td><button type="button" onclick="idCheck();">중복확인</button></td>
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
                <button type="submit" disabled>회원가입</button>
                <button type="reset">초기화</button>
            </div>
            <br><br>
        </form>
    </div>
    
    <script>
    	function idCheck() {
    		// 중복확인 버튼 클릭시 사용자가 입력한 아이디값을 넘겨서
    		// 조회요청 (존재하는지 안하는지) => 응답데이터 돌려받기
    		// 1) 사용불가능(NNNNN) => alert로 메세지 출력, 다시 입력하도록 유도
    		// 2) 사용가능 (NNNNY) => 진짜 사용할껀지 의사를 물어볼꺼임 (confirm창)
    		//                    > 사용하겠다 => 더이상 아이디 수정 못하게끔, 회원가입버튼 활성화
    		//                    > 사용안하겠다
    		
    		// 아이디 입력하는 input요소 객체
    		const $idInput = $("#enroll-form input[name=userId]");
    		
    		$.ajax({
    			url:"<%=contextPath%>/idCheck.me",
    			data:{checkId:$idInput.val()},
    			success:function(result) {
    				if(result == "NNNNN") { // 사용불가능
    					alert("이미 존재하거나 탈퇴한 회원의 아이디입니다.");
    					$idInput.focus();
    				} else { // 사용가능
    					if(confirm("사용가능한 아이디입니다. 정말로 사용하시겠습니까?")) {
    						$idInput.attr("readonly", true);
    						$('#enroll-form :submit').removeAttr("disabled");
    					} else {
    						$idInput.focus();
    					}
    				}
    			},
    			error:function() {
    				console.log("아이디 중복체크용 ajax 통신실패");
    			}
    		});
    		
    	}
    </script>

</body>
</html>