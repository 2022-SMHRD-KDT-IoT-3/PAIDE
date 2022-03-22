package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MemberDAO {
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	MemberDTO dto = null;
	int cnt = 0;
	
	//DB ���� �޼ҵ�
		public void dbconn() {
			try {
				Class.forName("oracle.jdbc.driver.OracleDriver");

				String url = "jdbc:oracle:thin:@project-db-stu.ddns.net:1524:xe";
				String dbid = "campus_b_0310_3";
				String dbpw = "smhrd3";

				conn = DriverManager.getConnection(url, dbid, dbpw);
				if(conn != null) {
					System.out.println("DB���� ����");
				}else {
					System.out.println("DB���� ����");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	//DB close �޼ҵ�
		public void dbclose() {
				try {
					if(rs != null) rs.close();
					if(psmt != null) psmt.close();
					if(conn != null) conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}		

	// ȸ����� ��ü���� �޼ҵ�
	public ArrayList<MemberDTO> MemberList() {
		ArrayList<MemberDTO> list = new ArrayList<>();
		dbconn();
		try {
			String sql = "select * from t_member";
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) {
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
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return list;
	}
		
	//ȸ������ �޼ҵ�
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

	//�α��� �޼ҵ�
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
	
	// ���̵�ã�� �޼ҵ�
	public String SearchID(String name, String phone, String email) {
		String m_id = null;
		dbconn();
		try {
			String sql = "select * from t_member where m_name =? and m_phone =? and m_email=?";
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, name);
			psmt.setString(2, phone);
			psmt.setString(3, email);
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				m_id = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return m_id;
	}
	
	// ��й�ȣã�� �޼ҵ�
	public String SearchPW(String id, String email) {
		String m_pw = null;
		dbconn();
		try {
			String sql = "select * from t_member where m_id =? and m_email=?";
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, id);
			psmt.setString(2, email);
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				m_pw = rs.getString(2);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return m_pw;
	}
	
	//'����� ���ƿ� ����(5��)' ������Ʈ �޼ҵ� (Likes_score)
	public int Likes_S(String id) {
		dbconn();
		try {
			String sql = "update t_member set m_score = m_score+5 where m_id = ?";
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, id);
			cnt = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return cnt;
	}
	
	//'��� ����(1��)' ������Ʈ �޼ҵ� (Comment_score)
	public int Comment_S(String id) {
		dbconn();
		try {
			String sql = "update t_member set m_score = m_score+1 where m_id = ?";
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, id);
			cnt = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return cnt;
	}
	
	//'������ ���ƿ� ����(10��)' ������Ʈ �޼ҵ� (Farm_score)
	public int Farm_S(String id) {
		dbconn();
		try {
			String sql = "update t_member set m_score = m_score+10 where m_id = ?";
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, id);
			cnt = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return cnt;
	}
	
	// ȸ���� ���� ���� �޼ҵ� -> level�� jsp select������ �ֱ�
	public int M_Level(int level, MemberDTO dto) {
		dbconn();
		try {
			String sql = "update t_member set m_level = ? where m_id=?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, level);
			psmt.setString(2, dto.getM_id());
			
			cnt = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return cnt;
	}

	//'����� ���ƿ� �������(-5��)' ������Ʈ �޼ҵ� (Likes_score)
		public int Likes_MS(String id) {
			dbconn();
			try {
				String sql = "update t_member set m_score = m_score-5 where m_id = ?";
				psmt = conn.prepareStatement(sql);
				
				psmt.setString(1, id);
				cnt = psmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				dbclose();
			}
			return cnt;
		}
	
	//'������ ���ƿ� �������(-10��)' ������Ʈ �޼ҵ� (Farm_score)
		public int Farm_MS(String id) {
			dbconn();
			try {
				String sql = "update t_member set m_score = m_score-10 where m_id = ?";
				psmt = conn.prepareStatement(sql);
				
				psmt.setString(1, id);
				cnt = psmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				dbclose();
			}
			return cnt;
		}

	//ȸ������ ���� ������Ʈ �޼ҵ� 
	public int UpdateMember(MemberDTO dto) {
		dbconn();
		try {
			String sql = "update t_member set m_name=?, m_phone=?, m_pw=?, m_email=? where m_id=?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getM_name());
			psmt.setString(2, dto.getM_phone());
			psmt.setString(3, dto.getM_pw());
			psmt.setString(4, dto.getM_email());
			psmt.setString(5, dto.getM_id());
			
			cnt = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return cnt;
	}
}
