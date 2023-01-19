<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>

	<h1>AJAX개요</h1>
    <p>
        AJAX란 Asynchronous Javascript And XML의 약자로 <br>
        비동기식 요청 기술에 해당됨 <br>
        서버로부터 데이터를 가져와 전체 페이지를 새로 고치지 않고 일부요소만 로드할 수 있게 하는 기법 <br><br>

        * 동기식 / 비동기식 <br>
        > 동기식 방식 요청 (a, form, submit, location.href, redirect을 이용해서 url요청) <br>
        <ul>
            <li>사용자의 요청 처리 후 그에 해당하는 응답페이지가 돌아와야만 그 이후의 작업 가능</li>
            <li>서버에 요청한 결과까지의 시간이 지연되면 무작정 계속 기다려야됨 (흰페이지로 보여질꺼임)</li>
            <li>응답페이지가 전체 로딩되면서 보여짐 (페이지 깜박거림 발생, 스크롤 최상단으로 올라감)</li>
        </ul>

        > 비동기식 방식 요청 (ajax)
        <ul>
            <li>현재 페이지를 그대로 유지하면서 중간중간마다 추가적으로 필요한 요청을 보낼 수 있음</li>
            <li>요청을 보냈다고해서 동기식 방식처럼 다른 페이지로 넘어가지 않음</li>
            <li>요청 보내놓고 그에 해당하는 응답(데이터)이 돌아돌 때까지 현재 페이지에서 다른 작업을 할 수 있음</li>
            <li>돌아오는 응답데이터로 현재 페이지 일부 영역에 출력시켜줄 수 있음</li>
            <li>페이지 전체가 리로딩 되는게 아니기 때문에 깜박거리지 않음</li>
        </ul>
        ex) 실시간 급상승 검색어 로딩, 검색어 자동완성, 아이디중복체크, 찜하기/해제하기, 댓글, 추천, 무한 스크롤
        <br><br>

        * 비동기식의 단점 <br>
        - 현재 페이지에 지속적으로 리소스가 쌓임 => 페이지가 느려질 수 있음 <br>
        - 에러 발생시 디버깅 어려움 <br>
        - 조회 요청 처리 후에 돌아온 응답데이터를 가지고 현재페이지 새로운 요소를 만들어서 뿌려줘야됨 <br>
          => 동적으로 요소를 만들어내는 스크립트 구문을 잘 써야됨
        <br><br>
        
        * AJAX 구현 방식 => JavaSript방식 / jQuery방식
    </p>

    <pre>
    * jQuery방식으로 AJAX통신

    $.ajax({
        속성명:속성값,
        속성명:속성값,
        속성명:속성값,
        ...
    });

    * 주요 속성
    - url : 요청할 url (필수속성)
    - type | method : 요청전송방식 (get/post)
    - data : 요청시전달할값
    - success : ajax통신 성공했을 경우 실행할 함수 정의
    - error : ajax통신 실패했을 경우 실행할 함수 정의
    - complete : ajax통신 성공했든 실패했든 간에 무조건 실행할 함수 정의

    * 부수적인 속성




    </pre> 

    <h2>기존에 했던 동기식 방식으로 요청시 값 전달해보기</h2>

    <h3>1) form submit으로 url 요청</h3>
    <form action="/web/test1.do">
        <input type="text" name="input">
        <button type="submit">전송</button>
    </form>

    <h3>2) location.href로 url 요청</h3>
    <input type="text" id="input">
    <button onclick="test();">전송</button>

    <script>
        function test() {
            location.href = "/web/test1.do?input=" + document.getElementById("input").value;
        }
    </script>

    <h1>AJAX 이용해서 비동기식 방식으로 요청시 값 전달해보기</h1>
    <h3>1. 버튼 클릭시 서버에 요청 및 응답</h3>

    입력 : 
    <input type="text" id="input1">
    <button onclick="test1();">전송</button>
    <br>

    응답 - 
    <span id="output1">현재응답없음</span>

    <script>
        function test1() {
            // 비동기식 방식으로 url요청 (요청했음에도 불구하고 현재페이지 유지)
            $.ajax({
                url:"/web/test1.do", 
                data:{input:$("#input1").val()},
                success:function(result) { // 매개변수에 요청처리 후에 돌아오는 응답데이터 담길꺼임
                	console.log("ajax통신성공");
                	$("#output1").text(result);
                },
                error:function() {
                	console.log("ajax통신실패");
                },
                complete:function() {
                	console.log("ajax통신 성공여부와 상관없이 무조건 출력");
                }
            });
        }
    </script>

    <h3>2. 버튼 클릭시 post방식으로 서버에 여러개의 데이터 전송 및 응답</h3>
    이름 : <input type="text" id="input2_1"> <br>
    나이 : <input type="number" id="input2_2"> <br>
    <button id="btn2">전송</button> <br>

	<!-- v1 -->
    <!-- 응답 - <label id="output2"></label>

    <script>
        $(function() {
            $("#btn2").click(function() {
                $.ajax({
                    url:"/web/test2.do",
                    data:{
                        name:$("#input2_1").val(),
                        age:$("#input2_2").val()
                    },
                    type:"post",
                    success:function(a) {
						$("#output2").html(a);
						$("#input2_1").val("");
						$("#input2_2").val("");
                    },
                    error:function() {
                        console.log("ajax 통신 실패");
                    }
                })
            })
        })

    </script> -->
    
    <!-- v2 -->
    응답
    <ul id="output2"></ul>

    <script>
        $(function() {
            $("#btn2").click(function() {
                $.ajax({
                    url:"/web/test2.do",
                    data:{
                        name:$("#input2_1").val(),
                        age:$("#input2_2").val()
                    },
                    type:"post",
                    success:function(a){
                    	// 방법1. JSONArray경우
                    	/*
                        console.log(a);
                        console.log(a[0]);
                        console.log(a[1]);
                        */
                        
                        // 방법2. JSONObject경우
                        console.log(a);
                        console.log(a.name);
                        console.log(a.age);
                        
                        const value = "<li>" + a.name + "</li>"
                        			+ "<li>" + a.age + "</li>"
                        
                        $("#output2").html(value);
                        
                        
                    },
                    error:function(){
                        console.log("ajax 통신 실패");
                    }
                })
            })
        })
    </script>
    
    <h3>3. 서버에 데이터 전송 후, 조회된 vo객체를 응답데이터로</h3>
    
    검색하고자 하는 회원아이디 : <input type="text" id="input3">
    <button onclick="test3();">검색</button>

    <div id="output3"></div>

    <script>
        function test3() {
            $.ajax({
                url:"/web/test3.do",
                data:{id:$("#input3").val()},
                success:function(result) {
                	
                	console.log(result); // {key:value, key:value}
                    
                	if(result == null) {
                		$("#output3").html("검색결과가 없습니다.");
                	} else {
                		const value = "회원번호 : " + result.userNo + "<br>"
                					+ "아이디 : " + result.userId + "<br>"
                					+ "이름 : " + result.userName + "<br>";
                		$("#output3").html(value);
                	}
                	
                }, error:function() {
                    console.log("ajax 통신 실패");
                }
            })
        }

    </script>

    <h3>4. 응답데이터로 조회된 여러 vo객체들이 담겨 있는 ArrayList로 받기</h3>

    <button onclick="test4();">공지사항 전체조회</button>
    <br><br>

    <script>
        function test4() {
            $.ajax({
                url:"/web/test4.do",
                success:function(result) {
                    console.log(result); // [{key:value,...}, {key:value,...}, {key:value,...}]
                    
                    let value = "";
                    for(let i=0; i<result.length; i++) {
                    	value += "<tr>"
                    			 + "<td>" + result[i].noticeNo + "</td>"
                    			 + "<td>" + result[i].noticeTitle + "</td>"
                    			 + "<td>" + result[i].noticeWriter + "</td>"
                    			 + "<td>" + result[i].count + "</td>"
                    		  + "</tr>";
                    }
                    
                    $("#output4 tbody").html(value);
                    
                }, error:function() {
                    console.log("ajax 통신 실패");
                }
            })
        }


    </script>

    <table id="output4" border="1">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>조회수</th>
            </tr>
        </thead>
        <tbody>


        </tbody>
    </table>
    
</body>
</html>