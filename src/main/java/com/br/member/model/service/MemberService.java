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
	
	
	
}
