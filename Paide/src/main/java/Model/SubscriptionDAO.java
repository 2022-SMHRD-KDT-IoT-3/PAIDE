package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class SubscriptionDAO {
	
	// �������� ����
	PreparedStatement psmt = null;
	Connection conn = null;
	ResultSet rs = null;
	int cnt = 0;
	SubscriptionDTO slist = null;

	// DB���� �޼ҵ�
	public void dbconn() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");

			String url = "jdbc:oracle:thin:@project-db-stu.ddns.net:1524:xe";
			String dbid = "campus_b_0310_3";
			String dbpw = "smhrd3";

			conn = DriverManager.getConnection(url, dbid, dbpw);
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

	// ���� �߰� �޼ҵ� (DB�� ����)
	public int subscribe(SubscriptionDTO dto) {

		// 1. DB����(ojdbc6.jar �־��ֱ�
		// 1-1. Classã�� : DB�� ��Ŭ������ �������ִ� Class
		try {
			// DB���� �޼ҵ�
			dbconn();
			// 2. DB����
			// SQL�� �ۼ�
			String sql = "insert into t_subscription values(subscription_seq.nextval,?,?,sysdate)";

			// sql�� db�� ����
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getSubscription_id());
			psmt.setInt(2, dto.getFarm_id());

			// sql�� ����
			cnt = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return cnt;

	}

	// ������� �޼ҵ�
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

	// ���� ��� ��ü ����
	public ArrayList<SubscriptionDTO> sub_list(String subscription_id) {
		ArrayList<SubscriptionDTO> list = new ArrayList<>();
		dbconn();

		try {
			String sql = "select t_member.m_name from t_member where subscription = ? order by subscription_date";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, subscription_id);

			rs = psmt.executeQuery();
			while (rs.next()) {

				int farm_id = rs.getInt(3);

				slist = new SubscriptionDTO(farm_id);
				list.add(slist);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return list;
	}

}
