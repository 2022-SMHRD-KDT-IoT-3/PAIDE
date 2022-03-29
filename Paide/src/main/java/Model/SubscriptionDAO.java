package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class SubscriptionDAO {
	
	// 전역변수 선언
	PreparedStatement psmt = null;
	Connection conn = null;
	ResultSet rs = null;
	int cnt = 0;
	SubscriptionDTO slist = null;

	// DB연결 메소드
	public void dbconn() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");

			String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
			// thin이라는 버전
			String dbid = "hr";
			String dbpw = "hr";

			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// DB close 메소드
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

	// 구독 추가 메소드 (DB에 저장)
	public int subscribe(SubscriptionDTO slist) {

		// 1. DB연결(ojdbc6.jar 넣어주기
		// 1-1. Class찾기 : DB와 이클립스를 연결해주는 Class
		try {
			// DB연결 메소드
			dbconn();
			// 2. DB실행
			// SQL문 작성
			String sql = "insert into t_subscription values(subscription_seq.nextval,?,?,sysdate)";

			// sql문 db에 전달
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, slist.getSubscription_id());
			psmt.setInt(2, slist.getFarm_id());

			// sql문 실행
			cnt = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return cnt;

	}

	// 구독취소 메소드
	public int cancel(String subscription_id, int farm_id) {
		dbconn();

		try {

			String sql = "delete from t_subscription where subscription_id = ? and farm_id = ?";

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, subscription_id);
			psmt.setInt(2, farm_id);

			cnt = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}

		return cnt;
	}

	// 구독 목록 전체 보기
	public ArrayList<MemberDTO> sub_list(String subscription_id) {
		ArrayList<MemberDTO> list = new ArrayList<>();
		dbconn();

		try {
			String sql = "select s.subscription_id, s.subscriptioned_id, m.m_id"
					+ "from t_subscription s, t_member m, t_farm f"
					+ "where s.subscriptioned_id = f.f_seq"
					+ "and f.f_owner_id = m.m_id"
					+ "and s.subscription_id = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, subscription_id);

			rs = psmt.executeQuery();
			while (rs.next()) {

				String m_id = rs.getString(3);
				
				MemberDTO dto = new MemberDTO(m_id);
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return list;
	}
	
	// 구독한 농장 찾아가기 메소드
	public MemberDTO reachFarm(String name) {
		MemberDTO dto = null;
		dbconn();
		try {
			String sql = "select * from t_memeber where m_name = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, name);
			
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
				String m_profile = rs.getString(10);
				
				dto = new MemberDTO(m_id, m_pw, m_name, m_phone, m_score, m_level, m_email, m_joindate, m_type, m_profile);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return dto;
	}

}
