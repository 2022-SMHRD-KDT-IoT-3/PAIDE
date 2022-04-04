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

	// DB ���� �޼ҵ�
	public void dbconn() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");

			String url = "jdbc:oracle:thin:@project-db-stu.ddns.net:1524:xe";
			String dbid = "campus_b_0310_3";
			String dbpw = "smhrd3";

			conn = DriverManager.getConnection(url, dbid, dbpw);
			if (conn != null) {
				System.out.println("DB���� ����");
			} else {
				System.out.println("DB���� ����");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// DB close �޼ҵ�
	public void dbclose() {
		try {
			if (rs != null)
				rs.close();
			if (psmt != null)
				psmt.close();
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// �Խñ� �ۼ� �޼ҵ� -> ī�װ��� ������Ʈ������ �Ѱ��ֱ�??
	public int Insert_C(CommunityDTO dto) {
		dbconn();
		try {
			String sql = "insert into t_community values(t_community_seq.nextval, ?, ?, ?, sysdate, ?, ?, 1)";
			psmt = conn.prepareStatement(sql);

			psmt.setString(1, dto.getArticle_title());
			psmt.setString(2, dto.getArticle_content());
			psmt.setString(3, dto.getArticle_file());
			psmt.setString(4, dto.getM_id());
			psmt.setString(5, dto.getArticle_category());

			cnt = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return cnt;
	}

	// �Խñ� ��ȸ �޼ҵ� (select_community)
	public ArrayList<CommunityDTO> Select_C(String category) {
		ArrayList<CommunityDTO> c_list = new ArrayList<>();
		dbconn();
		try {
			String sql = "select * from t_community where article_category = ? order by article_date desc";
			psmt = conn.prepareStatement(sql);

			rs = psmt.executeQuery();
			while (rs.next()) {
				int article_seq = rs.getInt(1);
				String article_title = rs.getString(2);
				String article_content = rs.getString(3);
				String article_file = rs.getString(4);
				String article_date = rs.getString(5);
				String m_id = rs.getString(6);
				String article_category = rs.getString(7);

				codto = new CommunityDTO(article_seq, article_title, article_content, article_file, article_date, m_id,
						article_category);
				c_list.add(codto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return c_list;
	}

	// getNext �޼ҵ�(��ü)
	public int getNext() {
		PreparedStatement psmt2;
		ResultSet rs2;
		try {
			String sql = "select count(*) from t_community where available = 1";
			psmt2 = conn.prepareStatement(sql);

			rs2 = psmt2.executeQuery();

			while (rs2.next()) {
				return rs2.getInt(1) + 1;
			}
			return 1; // ù��° �Խù��� ���

		} catch (Exception e) {
			e.printStackTrace();
		}

		return -1; // �����ͺ��̽� ����
	}
	
	// ī�װ��� �Խñ� ��
	public int getNext2(String category) {
		PreparedStatement psmt2;
		ResultSet rs2;
		dbconn();
		try {
			String sql = "select count(*) from t_community where available = 1 and article_category = ?";
			psmt2 = conn.prepareStatement(sql);
			psmt2.setString(1, category);
			
			rs2 = psmt2.executeQuery();

			while (rs2.next()) {
				return rs2.getInt(1) + 1;
			}
			return 1; // ù��° �Խù��� ���

		} catch (Exception e) {
			e.printStackTrace();
		}

		return -1; // �����ͺ��̽� ����
	}

	// �Խñ� ���� �޼ҵ� (�Խñ� ����)
	public CommunityDTO getArticle(int num) {
		dbconn();
		try {
			String sql = "select * from t_community where article_seq = ?";

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, num);
			rs = psmt.executeQuery();

			if (rs.next()) {
				int article_seq = rs.getInt(1);
				String article_title = rs.getString(2);
				String article_content = rs.getString(3);
				String article_file = rs.getString(4);
				String article_date = rs.getString(5);
				String m_id = rs.getString(6);
				String article_category = rs.getString(7);
				codto = new CommunityDTO(article_seq, article_title, article_content, article_file, article_date, m_id,
						article_category);

				return codto;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return null;
	}

	// �Խù� ��� ���� �޼ҵ�(��ü)
	public ArrayList<CommunityDTO> getList(int pageNumber) {
		dbconn();
		ArrayList<CommunityDTO> list = new ArrayList<CommunityDTO>();
		try {
			String sql = "select * from t_community where article_seq < ? and available = 1 and rownum < 11  order by article_seq desc";
			psmt = conn.prepareStatement(sql);
			// and rownum< 11
			// select * from t_board where article_seq < 10 order by article_seq desc
			int check1 = getNext();
			int check2 = pageNumber;
			int test = check1 - (check2 - 1) * 10;
			System.out.println("check1 : " + check1 + ", check2 : " + check2);

			psmt.setInt(1, test);

			rs = psmt.executeQuery();

			while (rs.next()) {
				int article_seq = rs.getInt(1);
				String article_title = rs.getString(2);
				String article_content = rs.getString("article_content");
				String article_file = rs.getString("article_file");
				String article_date = rs.getString("article_date");
				String m_id = rs.getString("m_id");
				String article_category = rs.getString("article_category");

				codto = new CommunityDTO(article_seq, article_title, article_content, article_file, article_date, m_id,
						article_category);
				list.add(codto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return list;
	}

	// �Խñ� ��� ���� �޼ҵ�(ī�װ���)
	public ArrayList<CommunityDTO> getList(int pageNumber, String category) {
		dbconn();
		ArrayList<CommunityDTO> list = new ArrayList<CommunityDTO>();
		try {
			String sql = "SELECT SA2.* FROM( SELECT ROWNUM R1, SA1.* FROM(SELECT * FROM t_community where article_category = ? ORDER BY article_date)SA1)SA2 WHERE R1 > ? AND R1 < ?";
			psmt = conn.prepareStatement(sql);
			// int check1 = getNext();
			// int check2 = pageNumber;
			// int test = check1 - (check2 - 1) * 10;
			// System.out.println("check1 : " + check1 + ", check2 : " + check2);

			psmt.setString(1, category);
			psmt.setInt(2, (pageNumber - 1) * 10);
			psmt.setInt(3, (pageNumber - 1) * 10 + 11);

			rs = psmt.executeQuery();

			while (rs.next()) {
				int article_seq = rs.getInt(2);
				System.out.println("test " + article_seq);
				String article_title = rs.getString(3);
				System.out.println("test2 " + article_title);

				String article_content = rs.getString("article_content");
				String article_file = rs.getString("article_file");
				String article_date = rs.getString("article_date");
				String m_id = rs.getString("m_id");
				String article_category = rs.getString("article_category");

				codto = new CommunityDTO(article_seq, article_title, article_content, article_file, article_date, m_id,
						article_category);
				list.add(codto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return list;
	}

	// ������ �Խñ� ���� ��ȣ ã�� �޼ҵ� (ī�װ���)s
	public boolean nextPage(int pageNumber, String category) {
		dbconn();
		try {
			String sql = "select * from t_community where article_category = ? and rownum < ?";

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, getNext() - (pageNumber - 1) * 10);

			rs = psmt.executeQuery();

			if (rs.next()) {
				return true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// �Խñ� ���� �޼ҵ�
	public int Delete_C(int article_seq) {
		dbconn();
		try {
			String sql = "update t_community set available = 0 where article_seq = ?";
			psmt = conn.prepareStatement(sql);

			psmt.setInt(1, article_seq);

			cnt = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return cnt;
	}

	// �Խñ� ���� �޼ҵ�(����, ����)
	public int updateArticle(int article_seq, String article_title, String article_content) {
		dbconn();
		try {

			String sql = "update t_community set article_title = ?, article_content =? where article_seq = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, article_title);
			psmt.setString(2, article_content);
			psmt.setInt(3, article_seq);

			cnt = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return cnt;
	}

	// ������ ��� ���� �޼ҵ�(�Խ��� ���)
	public int Insert_Cmt(CommunityDTO dto) {
		dbconn();
		try {
			String sql = "insert into t_comment values(t_comment_seq.nextval, ?, ?, sysdate, ?, 0, 1)";
			psmt = conn.prepareStatement(sql);

			psmt.setInt(1, dto.getArticle_seq());
			System.out.println("�۹�ȣ : " + dto.getArticle_seq());
			psmt.setString(2, dto.getCmt_content());
			System.out.println("��۳��� : " + dto.getCmt_content());
			psmt.setString(3, dto.getM_id());
			System.out.println("����ۼ��� : " + dto.getM_id());

			cnt = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return cnt;
	}

	// ������ ��� ���� �޼ҵ�(������)
	public int Insert_Fcmt(CommunityDTO dto) {
		dbconn();
		try {
			String sql = "insert into t_comment_farm values(t_comment_farm_seq.nextval, ?, ?, sysdate, ?, 0, 1)";
			psmt = conn.prepareStatement(sql);

			psmt.setInt(1, dto.getArticle_seq());
			System.out.println("�۹�ȣ : " + dto.getArticle_seq());
			psmt.setString(2, dto.getCmt_content());
			System.out.println("��۳��� : " + dto.getCmt_content());
			psmt.setString(3, dto.getM_id());
			System.out.println("����ۼ��� : " + dto.getM_id());

			cnt = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return cnt;
	}

	// ��� ���� �޼ҵ�(�Խ��� ���)
	public int updateCmt(int cmt_seq, String cmt_content) {
		dbconn();
		try {

			String sql = "update t_comment set cmt_content = ? where cmt_seq = ?";
			psmt = conn.prepareStatement(sql);

			psmt.setString(1, cmt_content);
			psmt.setInt(2, cmt_seq);

			cnt = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return cnt;
	}

	// ��� ���� �޼ҵ�(���� ���)
	public int updateFcmt(int fcmt_seq, String fcmt_content) {
		dbconn();
		try {

			String sql = "update t_comment_farm set fcmt_content = ? where fcmt_seq = ?";
			psmt = conn.prepareStatement(sql);

			psmt.setString(1, fcmt_content);
			psmt.setInt(2, fcmt_seq);

			cnt = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return cnt;
	}

	// ��� ���� �޼ҵ�(�Խ��� ���)
	public int Delete_Cmt(int cmt_seq) {
		dbconn();
		try {
			String sql = "update t_comment set cmtavailable = 0 where cmt_seq = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, cmt_seq);

			cnt = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return cnt;
	}

	// ��� ���� �޼ҵ�(���� ���)
	public int Delete_Fcmt(int fcmt_seq) {
		dbconn();
		try {
			String sql = "update t_comment_farm set fcmtavailable = 0 where fcmt_seq = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, fcmt_seq);

			cnt = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return cnt;
	}

	// ��� ���ƿ� ������Ʈ �޼ҵ�(�Խ��� ���)
	public int Plikes(int cmt_seq) {
		dbconn();
		try {
			String sql = "update t_comment set cmt_like = cmt_like + 1 where cmt_seq = ?";
			psmt = conn.prepareStatement(sql);

			// psmt.setInt(1, article_seq);
			psmt.setInt(1, cmt_seq);

			cnt = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return cnt;
	}

	// ��� ���ƿ� ������Ʈ �޼ҵ�(���� ���)
	public int Pflikes(int fcmt_seq) {
		dbconn();
		try {
			String sql = "update t_comment_farm set fcmt_like = fcmt_like + 1 where fcmt_seq = ?";
			psmt = conn.prepareStatement(sql);

			psmt.setInt(1, fcmt_seq);

			cnt = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return cnt;
	}

	// ���ƿ� ���� ã�� �޼ҵ�(�Խ��� ���)
	public int select_like(int cmt_seq) {
		dbconn();
		int like = 0;
		try {
			String sql = "select cmt_like from t_comment where cmt_seq = ?";
			psmt = conn.prepareStatement(sql);

			// psmt.setInt(1, article_seq);
			psmt.setInt(1, cmt_seq);

			rs = psmt.executeQuery();

			if (rs.next()) {
				like = rs.getInt("cmt_like");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}

		return like;
	}

	// ���ƿ� ���� ã�� �޼ҵ�(���� ���)
	public int select_flike(int fcmt_seq) {
		dbconn();
		int like = 0;
		try {
			String sql = "select fcmt_like from t_comment_farm where fcmt_seq = ?";
			psmt = conn.prepareStatement(sql);

			psmt.setInt(1, fcmt_seq);

			rs = psmt.executeQuery();

			if (rs.next()) {
				like = rs.getInt("fcmt_like");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}

		return like;
	}

	// ���ƿ� ��� �޼ҵ�(�Խ��� ���)
	public int Mlikes(int cmt_seq) {
		dbconn();
		try {
			String sql = "update t_comment set cmt_like = cmt_like - 1 where cmt_seq = ?";
			psmt = conn.prepareStatement(sql);

			psmt.setInt(1, cmt_seq);
			cnt = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return cnt;
	}

	// ���ƿ� ��� �޼ҵ�(���� ���)
	public int Mflikes(int cmt_seq) {
		dbconn();
		try {
			String sql = "update t_comment_farm set fcmt_like = fcmt_like-1 where fcmt_seq = ?";
			psmt = conn.prepareStatement(sql);

			psmt.setString(1, dto.getM_id());
			cnt = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return cnt;
	}

	// ���ƿ� ���� ������Ʈ(�߰�)
	public void addLikeInfo(int cmt_seq, String m_id) {
		dbconn();
		try {

			String sql2 = "insert into infolike values(?,?)";
			PreparedStatement psmt2 = conn.prepareStatement(sql2);

			psmt2.setInt(1, cmt_seq);
			psmt2.setString(2, m_id);

			int cnt = psmt2.executeUpdate();
			System.out.println(cnt);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
	}

	// ���ƿ� ���� ������Ʈ(����)
	public void deleteLikeInfo(int cmt_seq, String m_id) {
		dbconn();
		try {

			String sql = "delete from infolike where cmt_seq = ? and m_id = ?";
			psmt = conn.prepareStatement(sql);

			psmt.setInt(1, cmt_seq);
			psmt.setString(2, m_id);

			psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// ���ƿ� ���� ������� Ȯ��
	public int isLike(int cmt_seq, String m_id) {
		dbconn();
		try {
			String sql = "select * from infolike where cmt_seq = ? and m_id = ?";
			psmt = conn.prepareStatement(sql);

			psmt.setInt(1, cmt_seq);
			psmt.setString(2, m_id);

			rs = psmt.executeQuery();

			if (rs.next()) {

				return 1;
			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			dbclose();
		}
		return 0;

	}

	// �Խñ� ��� ��ü ��ȸ(�Խ��� ���)
	public ArrayList<CommunityDTO> getCmtList(int article_seq) {
		ArrayList<CommunityDTO> list = new ArrayList<CommunityDTO>();
		dbconn();
		try {
			String sql = "select * from t_comment where article_seq = ? and CMTAVAILABLE = 1";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, article_seq);

			rs = psmt.executeQuery();

			while (rs.next()) {
				int cmt_seq = rs.getInt(1);
				article_seq = rs.getInt(2);
				String cmt_content = rs.getString(3);
				String m_id = rs.getString(4);
				String cmt_date = rs.getString(5);
				int like = rs.getInt(6);

				codto = new CommunityDTO(cmt_seq, article_seq, cmt_content, m_id, cmt_date, like);
				list.add(codto);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return list;
	}

	// �Խñ� ��� ��ü ��ȸ(���� ���)
	public ArrayList<CommunityDTO> getFcmtList(int t_farm_seq) {
		ArrayList<CommunityDTO> list = new ArrayList<CommunityDTO>();
		dbconn();
		try {
			String sql = "select * from t_comment_farm where t_farm_seq = ? and FCMTAVAILABLE = 1";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, t_farm_seq);

			rs = psmt.executeQuery();

			while (rs.next()) {
				int cmt_seq = rs.getInt(1);
				t_farm_seq = rs.getInt(2);
				String cmt_content = rs.getString(3);
				String m_id = rs.getString(4);
				String cmt_date = rs.getString(5);
				int like = rs.getInt(6);

				codto = new CommunityDTO(cmt_seq, t_farm_seq, cmt_content, m_id, cmt_date, like);
				list.add(codto);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return list;
	}

	// Ư�� ��۹�ȣ�� ��� ���� ã��(�Խ��� ���)
	public String cmt_content(int cmt_seq) {
		dbconn();
		String cmt = "";
		try {

			String sql = "select cmt_content from t_commnet where cmt_seq = ?";
			psmt = conn.prepareStatement(sql);

			psmt.setInt(1, cmt_seq);

			if (rs.next()) {
				cmt = rs.getString(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return cmt;
	}

	// Ư�� ��۹�ȣ�� ��� ���� ã��(���� ���)
	public String fcmt_content(int fcmt_seq) {
		dbconn();
		String cmt = "";
		try {

			String sql = "select fcmt_content from t_commnet_farm where fcmt_seq = ?";
			psmt = conn.prepareStatement(sql);

			psmt.setInt(1, fcmt_seq);

			if (rs.next()) {
				cmt = rs.getString(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return cmt;
	}
	
	// �Խñ� �˻� �޼ҵ�
	public ArrayList<CommunityDTO> getSearch(String searchField, String searchText, int pageNumber){
		ArrayList<CommunityDTO> list = new ArrayList<CommunityDTO>();
		dbconn();

		try {
			
			String sql = "SELECT SA2.* FROM( SELECT ROWNUM R1, SA1.* FROM(SELECT * FROM t_community WHERE "
					+ searchField.trim();

			if(searchText != null && !searchText.equals("")) {
				sql += " LIKE '%"
					+ searchField.trim()
					+ "ORDER BY article_date)SA1)SA2 WHERE R1 > ? AND R1 < ?";	
					};
					
			psmt = conn.prepareStatement(sql);
	
			psmt.setInt(1, (pageNumber - 1) * 10);
			psmt.setInt(2, (pageNumber - 1) * 10 + 11);
			
			psmt = conn.prepareStatement(sql);

			rs = psmt.executeQuery();

			int article_seq = rs.getInt(1);
			String article_title = rs.getString(2);
			String article_content = rs.getString("article_content");
			String article_file = rs.getString("article_file");
			String article_date = rs.getString("article_date");
			String m_id = rs.getString("m_id");
			String article_category = rs.getString("article_category");
			codto = new CommunityDTO(article_seq, article_title, article_content, article_file, article_date, m_id,
					article_category);
			list.add(codto);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return list;
			
	}
	
	// ��� �˸� �޼ҵ�(����)
	public ArrayList<CommunityDTO> newcomment(String id, int cmtcnt) {
		System.out.println("��۾˸�����");
			ArrayList<CommunityDTO> cmtlist = new ArrayList<CommunityDTO>();
		dbconn();
		try {
			String sql = "select y.article_title, t.cmt_date, y.article_seq, t.m_id "
					+ "from t_community y, t_comment t "
					+ "where y.m_id = ? "
					+ "and rownum <= ? "
					+ "and y.article_seq = t.article_seq "
					+ "order by t.cmt_date desc";
				
				psmt = conn.prepareStatement(sql);
				
				System.out.println("id : " + id);
				System.out.println( "cnt : " + cmtcnt);
				psmt.setString(1, id);
				psmt.setInt(2, cmtcnt);
				
				rs = psmt.executeQuery();

				while(rs.next()) {
					String article_title = rs.getString(1);
					String m_id = rs.getString(4);
					
					System.out.println("title : " + article_title);
					System.out.println("m_id : " + m_id); 
					
					codto = new CommunityDTO(article_title, m_id);
					
					cmtlist.add(codto);
				}
				
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return cmtlist;
	}
	
	// ���� ��� �˸� �޼ҵ�(����)
	public ArrayList<CommunityDTO> newfcomment(String id, int fcmtcnt){
		System.out.println("�����۾˸�����");
		ArrayList<CommunityDTO> fcmtlist = new ArrayList<CommunityDTO>();
		dbconn();
		try {
			String sql = "select c.fcmt_content, c.m_id, f.f_seq, f.f_owner_id "
					+ "from t_comment_farm c, t_farm f "
					+ "where c.t_farm_seq = f.f_seq "
					+ "and f.f_owner_id = ? "
					+ "and rownum <= ? "
					+ "order by c.fcmt_date desc";
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setInt(2, fcmtcnt);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				String fcmt_content = rs.getString(1);
				String m_id = rs.getString(2);
				
				codto = new CommunityDTO(fcmt_content, m_id);
				
				fcmtlist.add(codto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return fcmtlist;
		
	}
}
