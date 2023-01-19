package com.br.member.model.service;

import java.sql.Connection;

import static com.br.common.JDBCTemplate.*;
import com.br.member.model.dao.MemberDao;
import com.br.member.model.vo.Member;

public class MemberService {
	
	public Member loginMember(String userId, String userPwd) {
		
		Connection conn = getConnection();
		Member m = new MemberDao().loginMember(conn, userId, userPwd);
		close(conn);
		
		return m;
		
	}
	
	
	/**
	 * Alt + Shift + J
	 * 회원가입요청 서비스
	 * @author 빛나
	 * @param m insert할 데이터들이 담겨있는 Member객체
	 * @return insert 후에 처리된 행 수 
	 */
	public int insertMember(Member m) {
		Connection conn = getConnection();
		int result = new MemberDao().insertMember(conn, m);
		
		if(result>0) { // 성공
			commit(conn);
		} else { // 실패
			rollback(conn);
		}
		
		close(conn);
		
		return result;
		
	}
	
	public Member updateMember(Member m ) {
		Connection conn = getConnection();
		
		new MemberDao().updateMember(conn, m);
		
		int result = new MemberDao().updateMember(conn, m);
		
		Member updateMem = null;
		if(result > 0) {
			commit(conn);
			// 갱신된 회원 객체 다시 조회해오기 => 세션에 담긴 회원객체를 갱신시켜야되기 때문
			updateMem = new MemberDao().selectMember(conn, m.getUserId());
		} else {
			rollback(conn);
		}
		
		close(conn);
		
		return updateMem;
		
	}
	
	public Member updatePwdMember(String userId, String userPwd, String updatePwd) {
		
		Connection conn = getConnection();
		int result = new MemberDao().updatePwdMember(conn, userId, userPwd, updatePwd);
		
		Member updateMem = null;
		if(result > 0) {
			commit(conn);
			updateMem = new MemberDao().selectMember(conn, userId);
		} else {
			rollback(conn);
		}
		
		close(conn);
		
		return updateMem;
		
	}
	
	public int deleteMember(String userId, String userPwd) {
		
		Connection conn = getConnection();
		int result = new MemberDao().deleteMember(conn, userId, userPwd);
		
		if(result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	
	}
	
	public int idCheck(String checkId) {
		Connection conn = getConnection();
		int count = new MemberDao().idCheck(conn, checkId);
		close(conn);
		return count;
	}
	
	
	
	
	
}
