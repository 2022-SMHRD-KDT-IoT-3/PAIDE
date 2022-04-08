package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import Service.envCheckService;

public class Std_envDAO {
	 PreparedStatement psmt = null;
     Connection conn = null;
     ResultSet rs = null;
     int cnt = 0;
     Std_envDTO dto = new Std_envDTO();
	
	// DB연결 메소드
		public void dbconn() {
			try {
				Class.forName("oracle.jdbc.driver.OracleDriver");

				String url = "jdbc:oracle:thin:@project-db-stu.ddns.net:1524:xe";
				// thin이라는 버전
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
		
		// 아두이노 led 출력 메소드
		public String LED() {
	    	 envCheckService ecs = new envCheckService();
	    	 
	    	 String result = "";
	    	 dbconn();
	    	 
	    	 try {
	    		 String sql = "select * from v_env_check";
	    		 
	    		 psmt = conn.prepareStatement(sql);
	    		 
	    		 rs = psmt.executeQuery();
	    		 
	    		 if(rs.next()) {
	    			 double temp = rs.getDouble(2);
	    			 double humi = rs.getDouble(3);
	    			 int hour = rs.getInt(4);
	    			 String crop = rs.getString(5);
	    			 
	    			 result = ecs.envCheck(crop, hour, temp, humi);
	    			 
	    		 }
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				dbclose();
			}
	    	 return result;
	     }
		
		public String tempCheck(int f_seq) {
	    	 envCheckService ecs = new envCheckService();
	    	 String result = "";
	    	 dbconn();
	    	 
	    	 try {
	    		 String sql = "select * from v_env_check where f_seq = ? ";
	    		 
	    		 psmt = conn.prepareStatement(sql);
	    		 
	    		 psmt.setInt(1, f_seq);
	    		 
	    		 rs = psmt.executeQuery();
	    		 
	    		 if(rs.next()) {
	    			 double temp = rs.getDouble(2);
	    			 double humi = rs.getDouble(3);
	    			 int hour = rs.getInt(4);
	    			 String crop = rs.getString(5);
	    			 
	    			 result = ecs.tempCheck(crop, hour, temp);
	    			 
	    		 }
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				dbclose();
			}
	    	 return result;
	     }
		
		public String humiCheck(int f_seq) {
	    	 envCheckService ecs = new envCheckService();
	    	 String result = "";
	    	 dbconn();
	    	 
	    	 try {
	    		 String sql = "select * from v_env_check where f_seq = ? ";
	    		 
	    		 psmt = conn.prepareStatement(sql);
	    		 
	    		 psmt.setInt(1, f_seq);
	    		 
	    		 rs = psmt.executeQuery();
	    		 
	    		 if(rs.next()) {
	    			 double temp = rs.getDouble(2);
	    			 double humi = rs.getDouble(3);
	    			 int hour = rs.getInt(4);
	    			 String crop = rs.getString(5);
	    			 
	    			 result = ecs.humiCheck(crop, hour, humi);
	    			 
	    		 }
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				dbclose();
			}
	    	 return result;
	     }
		

}
