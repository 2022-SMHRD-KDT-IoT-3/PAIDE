package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ChartDAO {
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	ChartDTO chdto = null;
	int cnt = 0;
	
	//DB ���� �޼ҵ�
	public void dbconn() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");

			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String dbid = "hr";
			String dbpw = "hr";

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

}
