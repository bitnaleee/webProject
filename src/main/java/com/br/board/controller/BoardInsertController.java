package com.br.board.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.br.board.model.service.BoardService;
import com.br.board.model.vo.Attachment;
import com.br.board.model.vo.Board;
import com.br.common.MyFileRenamePolicy;
import com.br.member.model.vo.Member;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class BoardInsertController
 */
@WebServlet("/insert.bo")
public class BoardInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		// multipart/form-data로 전송하는 경우 request로부터 바로 값 뽑기 불가
		//String boardTitle = request.getParameter("title");
		
		// enctype이 multipart/form-data로 잘 전송되었을 경우 전반적인 내용들 수
		if(ServletFileUpload.isMultipartContent(request)) {
			
			// 파일 업로드를 위한 라이브러리 : cos.jar (com.orilly.servlet의 약자)
			//							 http://www.servlets.com
			
			// 1. 전달되는 파일을 처리할 작업내용 (파일의 용량 제한, 전달된 파일을 저장시킬 폴더 경로)
			// 1_1. 파일의 용량 제한 (int maxSize => byte단위) => 10Mbyte로 제한
			/*
			 * byte => kbyte => mbyte => gbyte => tbyte...
			 * 
			 * 1kbyte == 1024byte
			 * 1mbyte == 1024kbyte == 1024*1024byte
			 * 10mbyte == 10*1024*1024byte
			 */
			int maxSize = 10*1024*1024;
			
			// 1_2. 전달된 파일을 저장시킬 폴더의 물리적인 경로 알아내기 (String savePath)
			String savePath = request.getSession().getServletContext().getRealPath("/resources/board_upfiles/");
			//System.out.println(savePath);
			
			/*
			 * 2. 전달된 파일의 파일명 수정 및 서버에 업로드 (폴더에 저장)작업
			 * 	  >> HttpServletRequest request => MultiRequest multiRequest 변환
			 * 
			 * 	  단, 업로드시 파일명은 수정해주는게 일반적임! 파일명을 수정시켜주는 객체 제시해야됨
			 * 	  => 같은 파일명이 존재할 경우 덮어씌워질 수 있음
			 * 	  => 파일명에 한글/특수문자/띄어쓰기가 포함되어있을 경우 서버에 따라 문제 발생
			 *    
			 *    기본적으로 파일명이 안겹치도록 수정작업해주는 객체 있음
			 *    => DefaultFileRenamePolicy 객체 (cos.jar에서 제공하는 객체)
			 *    => 내부적으로 해당 클래스에 rename()메소드가 실행되면서 파일명 수정된 후 업로드
			 *       rename(원본파일) {
			 *       	기존에 동일한 파일명 존재할 경우
			 *          파일명 뒤에 카운팅된 숫자를 붙여줌
			 *          ex) aaa.jpg, aaa1.jpg, aaa2.jpg
			 *          return 수정파일;
			 *       }
			 * 	  나만의 방식으로 파일명 수정하고자 한다면 나만의 FileRenamePolicy 클래스 (rename메소드 정의) 만들면 됨
			 * 	  com.br.common.MyFileRenamePolicy
			 * 
			 */
			MultipartRequest multiRequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
			
			// 3. DB에 기록할 데이터를 뽑아서 vo에 주섬주섬담기
			//    > 카테고리번호, 제목, 내용, 로그인한회원번호 => Board 테이블 insert
			//    > "넘어온첨부파일있다면" 원본명, 실제파일명, 저장경로 = Attachment insert
			
			String category = multiRequest.getParameter("category");
			String boardTitle = multiRequest.getParameter("title");
			String boardContent = multiRequest.getParameter("content");
			
			HttpSession session = request.getSession();
			int userNo = ((Member)session.getAttribute("loginUser")).getUserNo();
			
			Board b = new Board();
			b.setCategory(category);
			b.setBoardTitle(boardTitle);
			b.setBoardContent(boardContent);
			b.setBoardWriter(String.valueOf(userNo));
			
			Attachment at = null; // 첨에는 null로 초기화, 넘어온 첨부파일있다면 생성
			
			// multiRequest.getOriginalFileName("키") : 넘어온 첨부파일이 있을 경우 파일명은 문자열 리턴 | 없었을 경우 null
			if(multiRequest.getOriginalFileName("upfile") != null) { // 첨부파일이 있을 경우 
				at = new Attachment();
				at.setOriginName(multiRequest.getOriginalFileName("upfile"));
				at.setChangeName(multiRequest.getFilesystemName("upfile"));
				at.setFilePath("resources/board_upfiles/");
			
			}
			
			// 4. 서비스 요청 (요청처리)
			int result = new BoardService().insertBoard(b, at);
			
			// 5. 응답뷰 지정
			if(result > 0) {
				// 성공 => 목록페이지
				session.setAttribute("alertMsg", "일반게시글 작성 성공");
				response.sendRedirect(request.getContextPath() + "/list.bo?cpage=1");
				
			} else {
				// 실패 => 에러페이지
				// 첨부파일이 있었다면 업로드된 파일을 찾아서 삭제
				if(at != null) {
					new File(savePath + at.getChangeName()).delete();
				}
				
				request.setAttribute("errorMsg", "일반게시글 작성 실패");
				request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
				
			}
			
			
		}
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
