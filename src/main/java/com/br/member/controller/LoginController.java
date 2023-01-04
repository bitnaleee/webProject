package com.br.member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.br.member.model.service.MemberService;
import com.br.member.model.vo.Member;

/**
 * Servlet implementation class LoginController
 */
@WebServlet("/login.me")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1) 요청시 전달값(한글있으면 깨짐 > 인코딩처리) 뽑기 & 데이터가공처리(파싱..) => 변수 또는 객체에 기록하기
		String userId = request.getParameter("userId");
		String userPwd = request.getParameter("userPwd");
		
		// 2) 요청처리 (db에 sql문 실행)
		//    > Service > Dao > sql문 실행
		Member loginUser = new MemberService().loginMember(userId, userPwd);
		//System.out.println(loginUser);
		
		// 3) 처리된 결과를 가지고 사용자가 보게 될 응답뷰(jsp) 지정 후 포워딩 또는 url재요청
		/*
		 * 응답페이지에 전달할 값이 있을 경우 어딘가에 담아야됨! (담을 수 있는 영역 == JSP내장객체)
		 * 
		 * 1) application : 여기에 담긴 데이터는 "웹 애플리케이션 전역"에서 다 꺼내서 슬 수 있음
		 * 2) session : 여기에 담긴 데이터는 내가 직접 지우기전까지, 세션이 만료(서버가 멈추거나, 브라우저 종료)되기 전까지
		 *			    "어떤 jsp든, 어떤 servlet"이든 꺼내 쓸 수 있음
		 * 3) request : 여기에 담긴 데이터는 현재 이 request객체를 "포워딩한 응답jsp에서만" 꺼내 쓸 수 있음 (일회성)
		 * 4) page : 해당 jsp에서 담고 그 jsp에서만 꺼내 쓸 수 있음
		 * 
		 * 공통적으로 데이터를 담고자한다면 .setAttribute("키", 밸류);
		 *          데이터를 꺼내고자한다면 .getAttribute("키") : Object타입으로 밸류
		 *          데이터를 지우고자한다면 .removeAttribute("키")
		 */
		
		if(loginUser == null) {
			// 조회결과없음 == 로그인실패 ==> 에러페이지(views/common/errorPage.jsp)응답
			request.setAttribute("errorMsg", "로그인에 실패했습니다!");
			
			RequestDispatcher view = request.getRequestDispatcher("views/common/errorPage.jsp");
			view.forward(request, response);
			
		} else {
			// 조회결과있음 == 로그인성공 ==> 메인페이지(index.jsp) 응답
			
			// Servlet에서 session에 접근하고자 한다면 세션객체 얻어와야됨
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", loginUser); // 로그인한 회원객체 session에 담기 (여기저기서 계속 필요하기 때문)
			
			// 1. 포워딩 방식 
			//    해당 선택된 jsp가 보여질 뿐 url은 절대 변경되지 않음 (즉, 현재 요청했을 때의 url이 여전히 남아있음)
			//RequestDispatcher view = request.getRequestDispatcher("index.jsp");
			//view.forward(request, response);
			
			// 2. url재요청 방식 (redirect)
			//    기존에 저 페이지를 응답하는 url이 존재할 경우 사용가능
			//    localhost:8887/web
			response.sendRedirect(request.getContextPath());
			
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
