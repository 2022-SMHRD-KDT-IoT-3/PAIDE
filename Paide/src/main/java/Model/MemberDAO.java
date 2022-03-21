package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberDAO {
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	MemberDTO dto = null;
	int cnt = 0;
	
	//DB 연결 메소드
		public void dbconn() {
			try {
				Class.forName("oracle.jdbc.driver.OracleDriver");

				String url = "jdbc:oracle:thin:@localhost:1521:xe";
				String dbid = "hr";
				String dbpw = "hr";

				conn = DriverManager.getConnection(url, dbid, dbpw);
				if(conn != null) {
					System.out.println("DB연결 성공");
				}else {
					System.out.println("DB연결 실패");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	//DB close 메소드
		public void dbclose() {
				try {
					if(rs != null) rs.close();
					if(psmt != null) psmt.close();
					if(conn != null) conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}		

	//회원가입 메소드
	public int Join(MemberDTO dto) {
		dbconn();
		try {
			String sql = "insert into t_member values(?, ?, ?, ?, 0, 1, ?, sysdate, 'U')";
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, dto.getM_id());
			psmt.setString(2, dto.getM_pw());
			psmt.setString(3, dto.getM_name());
			psmt.setString(4, dto.getM_phone());
			psmt.setString(5, dto.getM_email());
			
			cnt = psmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return cnt;
	}

	//로그인 메소드
	public MemberDTO Login(String id, String pw) {
		dbconn();
		try {
			String sql = "select * from t_member where id=? and pw=?";
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, id);
			psmt.setString(2, pw);
			rs = psmt.executeQuery();
			if(rs.next()) {
				String m_id = rs.getString(1);
				String m_pw = rs.getString(2);
				String m_name = rs.getString(3);
				String m_phone = rs.getString(4);
				int m_score = rs.getInt(5);
				String m_level = rs.getString(6);
				String m_email = rs.getString(7);
				String m_joindate = rs.getString(8);
				String m_type = rs.getString(9);
		
				dto = new MemberDTO(m_id, m_pw, m_name, m_phone, m_score, m_level, m_email, m_joindate, m_type);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return dto;
	}

	//'댓글의 좋아요 점수(5점)' 업데이트 메소드 (Likes_score)
	public int Likes_S(MemberDTO dto) {
		dbconn();
		try {
			String sql = "update t_member set m_score = m_score+5 where m_id = ?";
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, dto.getM_id());
			cnt = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return cnt;
	}
	
	//'댓글 점수(1점)' 업데이트 메소드 (Comment_score)
	public int Comment_S(MemberDTO dto) {
		dbconn();
		try {
			String sql = "update t_member set m_score = m_score+1 where m_id = ?";
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, dto.getM_id());
			cnt = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return cnt;
	}
	
	//'농장의 좋아요 점수(10점)' 업데이트 메소드 (Farm_score)
	public int Farm_S(MemberDTO dto) {
		dbconn();
		try {
			String sql = "update t_member set m_score = m_score+10 where m_id = ?";
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, dto.getM_id());
			cnt = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return cnt;
	}
	
}
