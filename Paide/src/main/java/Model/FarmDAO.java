package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class FarmDAO {

	// �������� ����
	PreparedStatement psmt = null;
	Connection conn = null;
	ResultSet rs = null;
	int cnt = 0;
	
	// DB���� �޼ҵ�
	public void dbconn() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");

			String url = "jdbc:oracle:thin:@project-db-stu.ddns.net:1524:xe";
			String dbid = "campus_b_0310_3";
			String dbpw = "smhrd3";

			conn = DriverManager.getConnection(url, dbid, dbpw);
		}catch (Exception e){
			e.printStackTrace();
		}
	}
	
	// DB close �޼ҵ�
	public void dbclose() {
		try {
			if (rs != null) rs.close();
			if (psmt != null) psmt.close();
			if (conn != null) conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// ������ �޼ҵ� (DB�� ����)
	public int register(FarmDTO dto) {

		// 1. DB����(ojdbc6.jar �־��ֱ�
		// 1-1. Classã�� : DB�� ��Ŭ������ �������ִ� Class
		try {
			// DB���� �޼ҵ�
			dbconn();
			// 2. DB����
			// SQL�� �ۼ�
			String sql = "insert into t_farm values(f_seq.nextval,?,?,?,?,sysdate)";

			// sql�� db�� ����
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getF_owner_id());
			psmt.setString(2, dto.getF_region());
			psmt.setString(3, dto.getF_crops());
			psmt.setString(4, dto.getF_facility());

			// sql�� ����
			cnt = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return cnt;

	}

	// ������������ �޼ҵ�
	public int update(FarmDTO dto) {
		dbconn();
		try {
			
		String sql = "update t_farm set f_region = ?, f_crops = ?, f_facility = ? where f_owner_id = ?";	
		
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1, dto.getF_region());
		psmt.setString(2, dto.getF_crops());
		psmt.setString(3, dto.getF_facility());
		psmt.setString(4, dto.getF_owner_id());
		
		cnt = psmt.executeUpdate();
		
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}return cnt;
		
	}
	
	// ������� �޼ҵ�
	public int delete(int f_seq) {
		dbconn();
		
		try {
			
			String sql = "delete from t_farm where f_seq = ?";
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, f_seq);
			
			cnt = psmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		
		return cnt;
	}


	
}
