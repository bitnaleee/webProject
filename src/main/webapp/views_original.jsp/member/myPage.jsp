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
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
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

        <form action="<%= contextPath %>/update.me" method="post" id="mypage-form">

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
                <button type="submit" class="btn btn-secondary btn-sm">정보변경</button>
                <button type="button" class="btn btn-warning btn-sm" data-toggle="modal" data-target="#updatePwdModal">비밀번호변경</button>
                <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#deleteModal">회원탈퇴</button>
            </div>
            <br><br>

        </form>

    </div>
    
    <!-- 비밀번호 변경용 모달 div -->
    <!-- The Modal -->
	<div class="modal" id="updatePwdModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">비밀번호 변경</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body" align="center">
	       	
	       	 <form action="<%= contextPath %>/updatePwd.me" method="post">
	       	 
	       	 	<input type="hidden" name="userId" value="<%=userId%>">
	      		
	      		<table>
	      			<tr>
	      				<td>현재 비밀번호</td>
	      				<td><input type="password" name="userPwd" required></td>
	      			</tr>
	      			<tr>
	      				<td>변경할 비밀번호</td>
	      				<td><input type="password" name="updatePwd" required></td>
	      			</tr>
	      			<tr>
	      				<td>변경할 비밀번호 확인</td>
	      				<td><input type="password" required></td>
	      			</tr>
	      		</table>
	      		<br>
	      		
	      		<button type="submit" class="btn btn-secondary btn-sm">비밀번호 변경</button>
	      		
	         </form>

	      </div>
	  
	    </div>  
	  </div>  
	</div>
    <!-- 회원탈퇴용 Modal -->
     <!-- The Modal -->
	<div class="modal" id="deleteModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">회원 탈퇴</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body" align="center">
	       	
	       	<b>탈퇴 후 복구가 불가능합니다. <br> 정말로 탈퇴하시겠습니까?</b> <br><br>
	       	
	       	<form action="<%=contextPath %>/delete.me" method="post">
	       	
	       		<input type="hidden" name="userId" value="<%=userId %>">
	       	
	       		비밀번호 : <input type="password" name="userPwd" required> <br><br>
	       		
	       		<button type="submit" class="btn btn-danger btn-sm">탈퇴하기</button>
	       		
	       	<!-- 
	       		요청시 실행할 sql문
	       		UPDATE MEMBER
	       		   SET STAUS = 'N'
	       		     , MODIFY_DATE = SYSDATE
	       		 WHERE USER_ID = 현재로그인한 회원아이디
	       		   AND USER_PWD = 사용자가 입력한 비밀번호
	       		   
	       		성공했을경우 => 메인페이지, alert("성공적으로 회원탈퇴되었습니다. 그동안 이용해주셔서 감사합니다.")
	       					 단, 로그아웃되어있어야됨 (Hint, 세션에 loginUser를 지우기)
	       		실패했을경우 => 마이페이지, alert(현재 비밀번호를 다시 확인해주세요.)
	       	 -->
	       	</form>
	       	
	       	
	      </div>
	  
	    </div>  
	  </div>  
	</div>
    
    
    
    
</body>
</html>