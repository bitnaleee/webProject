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
        height:800px;
        margin:auto;
        margin-top:50px;
    }

    #enroll-form table {
        border:1px solid white;
    }

    #enroll-form input, #enroll-form textarea {
        width:100%;
        box-sizing: border-box;
    }


</style>
</head>
<body>

	<%@ include file="../common/menubar.jsp" %>

    <div class="outer" align="center">
        <br>
        <h2>사진게시판 작성하기</h2>
        <br>

        <form action="<%= contextPath%>/insert.th" id="enroll-form" method="post" enctype="multipart/form-data">
            <table>
                <tr>
                    <th width="100">제목</th>
                    <td colspan="3"><input type="text" name="title" required></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td colspan="3">
                        <textarea name="content" rows="5" style="resize:none" required></textarea>
                    </td>
                </tr>
                <tr>
                    <th>대표이미지</th>
                    <td colspan="3" align="center">
                        <img id="titleImg" width="250" height="170" onclick="clickFile(1);">
                    </td>
                </tr>
                <tr>
                    <th>상세이미지</th>
                    <td><img id="contentImg1" width="150" height="120" onclick="clickFile(2);"></td>
                    <td><img id="contentImg2" width="150" height="120" onclick="clickFile(3);"></td>
                    <td><img id="contentImg3" width="150" height="120" onclick="clickFile(4);"></td>
                </tr>
            </table>

            <div id="file-area" style="display:none">
                <input type="file" name="file1" onchange="loadImg(this, 1);" required>
                <input type="file" name="file2" onchange="loadImg(this, 2);">
                <input type="file" name="file3" onchange="loadImg(this, 3);">
                <input type="file" name="file4" onchange="loadImg(this, 4);">
            </div>

            <script>

                function clickFile(num) {
                    $("input[name=file" + num + "]").click();
                }


                function loadImg(inputFile, num) {
                    // imputFile : 현재 변화가 생긴 input type="file" 요소객체
                    // num : 몇번째 inpute 요소에 변화가 생겼는지 구분하기 위한 숫자 => 해당img영역을 찾는 용도
                    
                    // 선택된 파일이 있다면 inputFile.files[0]에 선택된 파일이 담겨있음
                    //                     => inputFile.files.length  또한 1이 될꺼임
                    if(inputFile.files.length == 1) { 
                        // 파일이 선택된 경우 => 파일읽어들여서 미리보기

                        // 파일을 읽어들일 FileReader 객체 생성
                        const reader = new FileReader();
                        // 파일을 읽어들이는 메소드 실행
                        reader.readAsDataURL(inputFile.files[0]);
                        // 이 코드가 실행되는 순간 내부적으로 이 파일만의 고유한 url 부여

                        // 파일 읽어들이기가 완료됐을 때 실행할 함수를 정의해두기
                        reader.onload = function(e) {
                            // e.target.result = > 읽어들인 파일의 고유한 url
                            switch(num) {
                                case 1: $("#titleImg").attr("src", e.target.result); break;
                                case 2: $("#contentImg1").attr("src", e.target.result); break;
                                case 3: $("#contentImg2").attr("src", e.target.result); break;
                                case 4: $("#contentImg3").attr("src", e.target.result); break;
                            }  
                        }


                    } else { 
                        // 선택된 파일이 취소된 경우 => 미리보기 됐던게 사라지게 
                        switch(num) {
                                case 1: $("#titleImg").attr("src", null); break;
                                case 2: $("#contentImg1").attr("src", null); break;
                                case 3: $("#contentImg2").attr("src", null); break;
                                case 4: $("#contentImg3").attr("src", null); break;
                            }  
                    }

                }


            </script>


            <br>

            <button type="submit">등록하기</button>


        </form>

    </div>

</body>
</html>