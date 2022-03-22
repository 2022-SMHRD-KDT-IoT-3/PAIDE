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
	
	//DB 연결 메소드
	public void dbconn() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");

			String url = "jdbc:oracle:thin:@project-db-stu.ddns.net:1524:xe";
			String dbid = "campus_b_0310_3";
			String dbpw = "smhrd3";

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

	//게시글 작성 메소드 -> 카테고리값 쿼리스트링으로 넘겨주기??
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
	
	//게시글 조회 메소드 (select_community)
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

	//게시글 가져오기 메소드 (view_community) -> 댓글등록 or 게시글 나갈때까지 세션(원글순번) 부여하기
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

	//게시글 삭제 메소드
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
	
	//생성한 댓글 저장 메소드 (insert_comment)
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

	//댓글 삭제 메소드 
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

	// 댓글 좋아요 '누르면' 메소드 (plus likes) -> 세션 m_id로 값주기
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
	
	// 좋아요 취소 메소드(minus likes)
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
