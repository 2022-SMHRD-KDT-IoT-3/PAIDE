package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class FarmDAO {

	// 전역변수 선언
	PreparedStatement psmt = null;
	Connection conn = null;
	ResultSet rs = null;
	int cnt = 0;
	
	// DB연결 메소드
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
	
	// DB close 메소드
	public void dbclose() {
		try {
			if (rs != null) rs.close();
			if (psmt != null) psmt.close();
			if (conn != null) conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 농장등록 메소드 (DB에 저장)
	public int register(FarmDTO dto) {

		// 1. DB연결(ojdbc6.jar 넣어주기
		// 1-1. Class찾기 : DB와 이클립스를 연결해주는 Class
		try {
			// DB연결 메소드
			dbconn();
			// 2. DB실행
			// SQL문 작성
			String sql = "insert into t_farm values(f_seq.nextval,?,?,?,?,sysdate)";

			// sql문 db에 전달
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getF_owner_id());
			psmt.setString(2, dto.getF_region());
			psmt.setString(3, dto.getF_crops());
			psmt.setString(4, dto.getF_facility());

			// sql문 실행
			cnt = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return cnt;

	}

	// 농장정보수정 메소드
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
	
	// 농장삭제 메소드
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
