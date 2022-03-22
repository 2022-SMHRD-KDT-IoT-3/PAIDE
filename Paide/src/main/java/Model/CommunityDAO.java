package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CommunityDAO {
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	CommunityDTO codto = null;
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

	//�Խñ� �ۼ� �޼ҵ� -> ī�װ��� ������Ʈ������ �Ѱ��ֱ�??
	public int Insert_C(CommunityDTO dto) {
		dbconn();
		try {
			String sql = "insert into t_community values(t_community_seq.nextval, ?, ?, ?, sysdate, ?, ?)";
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, dto.getArticle_title());
			psmt.setString(2, dto.getArticle_content());
			psmt.setString(3, dto.getArticle_file());
			psmt.setString(4, dto.getM_id());
			psmt.setString(5, dto.getArticle_category());
			
			cnt = psmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return cnt;
	}
	
	//�Խñ� ��ȸ �޼ҵ� (select_community)
	public ArrayList<CommunityDTO> Select_C(String category) {
		ArrayList<CommunityDTO> c_list = new ArrayList<>();
		dbconn();
		try {
			String sql = "select * from t_community where article_category = ? order by article_date desc";
			psmt = conn.prepareStatement(sql);
			
			rs = psmt.executeQuery();
			while(rs.next()) {
				int article_seq = rs.getInt(1);
				String article_title = rs.getString(2);
				String article_content = rs.getString(3);
				String article_file = rs.getString(4);
				String article_date = rs.getString(5);
				String m_id = rs.getString(6);
				String article_category = rs.getString(7);
				
				codto = new CommunityDTO(article_seq, article_title, article_content, article_file, article_date, m_id, article_category);
				c_list.add(codto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return c_list;
	}

	//�Խñ� �������� �޼ҵ� (view_community) -> ��۵�� or �Խñ� ���������� ����(���ۼ���) �ο��ϱ�
	public CommunityDTO View_C(int num) {
		dbconn();
		try {
			String sql = "select * from t_community where article_seq=?";
			psmt = conn.prepareStatement(sql);
			
			psmt.setInt(1, num);
			rs = psmt.executeQuery();
			if(rs.next()) {
				int article_seq = rs.getInt(1);
				String article_title = rs.getString(2);
				String article_content = rs.getString(3);
				String article_file = rs.getString(4);
				String article_date = rs.getString(5);
				String m_id = rs.getString(6);
				String article_category = rs.getString(7);
				
				codto = new CommunityDTO(article_seq, article_title, article_content, article_file, article_date, m_id, article_category);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return codto;
	}

	//�Խñ� ���� �޼ҵ�
	public int Delete_C(int article_seq) {
		dbconn();
		try {
			String sql = "delete from t_community where article_seq = ?";
			psmt=conn.prepareStatement(sql);
			
			psmt.setInt(1, article_seq);
			
			cnt = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return cnt;
	}
	
	//������ ��� ���� �޼ҵ� (insert_comment)
	public int Insert_Cmt(CommunityDTO codto) {
		dbconn();
		try {
			String sql = "insert into t_comment values(t_comment_seq.nextval, ?, ?, sysdate, ?, 0)";
			psmt = conn.prepareStatement(sql);
			
			psmt.setInt(1, codto.getArticle_seq());
			psmt.setString(2, codto.getCmt_content());
			psmt.setString(3, codto.getM_id());
			
			cnt = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return cnt;
	}

	//��� ���� �޼ҵ� 
	public int Delete_Cmt(CommunityDTO codto) {
		dbconn();
		try {
			String sql = "delete from t_comment where m_id = ? and cmt_seq=?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, codto.getM_id());
			psmt.setInt(2, codto.getCmt_seq());
			
			cnt = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return cnt;
	}

	// ��� ���ƿ� '������' �޼ҵ� (plus likes) -> ���� m_id�� ���ֱ�
	public int Plikes(MemberDTO dto) {
		dbconn();
		try {
			String sql = "update t_comment set likes = likes+1 where m_id = ?";
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
	
	// ���ƿ� ��� �޼ҵ�(minus likes)
	public int Mlikes(MemberDTO dto) {
		dbconn();
		try {
			String sql = "update t_comment set likes = likes-1 where m_id = ?";
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
