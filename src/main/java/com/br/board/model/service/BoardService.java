package com.br.board.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.br.board.model.dao.BoardDao;
import com.br.board.model.vo.Attachment;
import com.br.board.model.vo.Board;
import com.br.board.model.vo.Category;
import com.br.common.model.vo.PageInfo;

import static com.br.common.JDBCTemplate.*;

public class BoardService {
	
	public int selectListCount() {
		Connection conn = getConnection();
		int listCount = new BoardDao().selectListCount(conn);
		close(conn);
		return listCount;
	}
	
	public ArrayList<Board> selectList(PageInfo pi) {
		Connection conn = getConnection();
		ArrayList<Board> list = new BoardDao().selectList(conn, pi);
		close(conn);
		return list;
		
	}
	
	public ArrayList<Category> selectCategoryList() {
		Connection conn = getConnection();
		ArrayList<Category> list = new BoardDao().selectCategoryList(conn);
		close(conn);
		return list;
	}
	
	public int insertBoard(Board b, Attachment at) {
		Connection conn = getConnection();
		
		int result1 = new BoardDao().insertBoard(conn, b);
		
		int result2 = 1;
		if(at != null) {
			result2 = new BoardDao().insertAttachment(conn, at);
		}
		
		if(result1 > 0 && result2 > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		
		close(conn);
		
		return result1 * result2;
		
	}
	
	public int increaseCount(int boardNo) {
		Connection conn = getConnection();
		int result = new BoardDao().increaseCount(conn, boardNo);
		if(result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		return result;
		
	}
	
	public Board selectBoard(int boardNo) {
		Connection conn = getConnection();
		Board b = new BoardDao().selectBoard(conn, boardNo);
		close(conn);
		return b;
	}
	
	public Attachment selectAttachment(int boardNo) {
		Connection conn = getConnection();
		Attachment at = new BoardDao().selectAttachment(conn, boardNo);
		close(conn);
		return at;
		
	}
	
	public int updateBoard(Board b, Attachment at) {
		
		Connection conn = getConnection();
		int result1 = new BoardDao().updateBoard(conn, b);
		
		int result2 = 1;
		if(at != null) { // 새로운 첨부파일이 있을 경우
			if(at.getFileNo() != 0) { // 기존의 첨부파일이 있었을 경우 => UPDATE ATTACHMENT
				result2 = new BoardDao().updateAttachment(conn, at);
			} else { // 기존의 첨부파일이 없었을 경우 => INSERT ATTACHMENT
				result2 = new BoardDao().insertNewAttachment(conn, at);
				// 기존의 insertAttachment랑 맞지 않음
			}
		}
		
		if(result1 > 0 && result2 > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return result1 * result2;
		
	}
	
	
	
	
	
	

}
