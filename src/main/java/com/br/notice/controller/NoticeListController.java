package com.br.notice.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.br.notice.model.service.NoticeService;
import com.br.notice.model.vo.Notice;

/**
 * Servlet implementation class NoticeListController
 */
@WebServlet("/list.no")
public class NoticeListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// [1) 요청시 전달값 뽑기]
		
		// 2) 요청 처리 (db에 sql문 실행)
		//    응답페이지상에 필요한 데이터를 조회 (select)
		ArrayList<Notice> list = new NoticeService().selectNoticeList();
		
		// 3) 응답뷰 => views/notice/noticeListView.jsp
		//    포워딩시 응답뷰에 필요한 데이터는 request의 attribute에 담기
		request.setAttribute("list", list);
		request.getRequestDispatcher("views/notice/noticeListView.jsp").forward(request, response);
		
		
		
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
