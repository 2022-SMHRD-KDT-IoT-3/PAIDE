package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class FarmDAO {

	// 전역변수 선언
	PreparedStatement psmt = null;
	Connection conn = null;
	ResultSet rs = null;
	FarmDTO fdto = null;
	GraphDTO gdto = null;
	int cnt = 0;
	
	// DB연결 메소드
	public void dbconn() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");

			String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
			// thin이라는 버전
			String dbid = "hr";
			String dbpw = "hr";

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
			String sql = "insert into t_farm values(f_seq.nextval,?,?,?,?,sysdate,?)";

			// sql문 db에 전달
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getF_owner_id());
			psmt.setString(2, dto.getF_region());
			psmt.setString(3, dto.getF_crops());
			psmt.setString(4, dto.getF_facility());
			psmt.setString(5, dto.getF_name());

			// sql문 실행
			cnt = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose();
		}
		return cnt;

	}
	
	// 농장이름 중복확인 메소드
	public boolean checkfname(String f_owner_id) {
		boolean result = false;
		dbconn();
		try {
			String sql = "select f_name from t_farm where f_owner_id = ?";
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, f_owner_id);
			rs = psmt.executeQuery();
			if(rs.next()) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return result;
	}

	// 농장정보수정 메소드
	public int update(FarmDTO dto) {
		dbconn();
		try {
			
		String sql = "update t_farm set f_region = ?, f_crops = ?, f_facility = ?, f_name = ? where f_owner_id = ?";	
		
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1, dto.getF_region());
		psmt.setString(2, dto.getF_crops());
		psmt.setString(3, dto.getF_facility());
		psmt.setString(4, dto.getF_name());
		psmt.setString(5, dto.getF_owner_id());
		
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
	
	//농장목록 검색 메소드
	public ArrayList<FarmDTO> SearchFarm(String crops, String regions, String facs) {
		ArrayList<FarmDTO> farmlist = new ArrayList<>();
		dbconn();
		try {
			String sql = "select * from t_farm where INSTR(?, ',' || f_crops || ',')>0 and INSTR(?, ',' || f_region || ',')>0 and INSTR(?, ',' || f_facility || ',')>0 order by f_crops";
			psmt= conn.prepareStatement(sql);
			psmt.setString(1, crops);
			psmt.setString(2, regions);
			psmt.setString(3, facs);
			
			rs = psmt.executeQuery();
			while(rs.next()) {
				int f_seq = rs.getInt(1);
				String f_owner_id = rs.getString(2);
				String f_region = rs.getString(3);
				String f_crops = rs.getString(4);
				String f_facility = rs.getString(5);
				String f_name = rs.getString(7);
				
				fdto = new FarmDTO(f_seq, f_owner_id, f_region, f_crops, f_facility, f_name);
				farmlist.add(fdto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return farmlist;
	}
	
	// 검색한 농장 (메인)상세보기 메소드
	public FarmDTO selectFarm(int seq) {
		dbconn();
		try {
			String sql = "select *"
					+ "from t_farm t, t_env e"
					+ "where t.f_seq = e.f_seq"
					+ "and e.env_date ="
					+ "(select max(env_date) from t_env where f_seq = ?)";
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				int f_seq = rs.getInt(1);
				String f_owner_id = rs.getString(2);
				String f_region = rs.getString(3);
				String f_crops = rs.getString(4);
				String f_facility = rs.getString(5);
				int env_seq = rs.getInt(7);
				double temperature = rs.getDouble(9);
				double temperature_outer = rs.getDouble(10);
				double humidity = rs.getDouble(11);
				double hmidity_outer = rs.getDouble(12);
				double humidity_soil = rs.getDouble(13);
				double insolation = rs.getDouble(14);
				double window_opened = rs.getDouble(15);
				double co2 = rs.getDouble(16);
				double dew_point = rs.getDouble(17);
				String env_date = rs.getString(18);
				String f_name = rs.getString(19);
				
				fdto = new FarmDTO(f_seq,f_owner_id,f_region,f_crops, f_facility, env_seq, temperature, temperature_outer,humidity,hmidity_outer,humidity_soil,insolation,window_opened,co2,dew_point,env_date,f_name);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return fdto;
	}
	
	// 내 농장 (메인)상세보기 메소드
	public FarmDTO myFarm(String m_id) {
		dbconn();
		try {
			String sql = "select *"
					+ "from t_farm t, t_env e"
					+ "where t.f_seq = e.f_seq"
					+ "and e.env_date ="
					+ "(select max(env_date) from t_env where m_id = ?)";
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, m_id);
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				int f_seq = rs.getInt(1);
				String f_owner_id = rs.getString(2);
				String f_region = rs.getString(3);
				String f_crops = rs.getString(4);
				String f_facility = rs.getString(5);
				int env_seq = rs.getInt(7);
				double temperature = rs.getDouble(9);
				double temperature_outer = rs.getDouble(10);
				double humidity = rs.getDouble(11);
				double hmidity_outer = rs.getDouble(12);
				double humidity_soil = rs.getDouble(13);
				double insolation = rs.getDouble(14);
				double window_opened = rs.getDouble(15);
				double co2 = rs.getDouble(16);
				double dew_point = rs.getDouble(17);
				String env_date = rs.getString(18);
				String f_name = rs.getString(19);
				
				fdto = new FarmDTO(f_seq,f_owner_id,f_region,f_crops, f_facility, env_seq, temperature, temperature_outer,humidity,hmidity_outer,humidity_soil,insolation,window_opened,co2,dew_point,env_date,f_name);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return fdto;
	}

	// 꺾은선그래프
	public ArrayList<FarmDTO> envGraph(String date, String owner_id) {
		ArrayList<FarmDTO> graph1 = new ArrayList<>();
		dbconn();
		try {
			String sql = "select temperature_outer, humidity_outer, temperature, humidity, dew_point, co2, window_opened, humidity_soil, insolation, to_char(env_date, 'YYYYMMDD HH24:MI'), m_id"
					+ "from t_env"
					+ "where to_char(env_date, 'YYYY-MM-DD') = ? and m_id = ?";
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, date);
			psmt.setString(2, owner_id);
			
			rs = psmt.executeQuery();
			while(rs.next()) {
				int temperature_outer = rs.getInt(1);
				int humidity_outer = rs.getInt(2);
				int temperature = rs.getInt(3);
				int humidity = rs.getInt(4);
				int dew_point = rs.getInt(5);
				int co2 = rs.getInt(6);
				int window_opened = rs.getInt(7);
				int humidity_soil = rs.getInt(8);
				int insolation = rs.getInt(9);
				String env_date = rs.getString(10);
				String m_id = rs.getString(11);
				
				fdto = new FarmDTO(temperature, temperature_outer, humidity, humidity_outer, humidity_soil, insolation, window_opened, co2, dew_point, env_date, owner_id);
				graph1.add(fdto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return graph1;
	}
	
	// 과거 일주일 온도,습도,일사량,토양습도,co2
	public GraphDTO avgGraph_7(String owner_id) {
		dbconn();
		try {
			String sql = "SELECT round(avg(temperature_outer),2), round(avg(temperature),2), round(avg(humidity_outer),2), round(avg(humidity),2), round(avg(insolation),2),round(avg(co2),2),round(avg(humidity_soil),2)"
					+ "FROM T_ENV"
					+ "WHERE m_id = ?"
					+ "and ENV_DATE BETWEEN (SELECT SYSDATE-7 FROM DUAL) AND (SELECT SYSDATE-1 FROM DUAL)";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, owner_id);
			rs = psmt.executeQuery();
			if(rs.next()) {
				int avg_temperature_outer = rs.getInt(1);
				int avg_temperature = rs.getInt(2);
				int avg_humidity_outer = rs.getInt(3);
				int avg_humidity = rs.getInt(4);
				int avg_insolation = rs.getInt(5);
				int avg_co2 = rs.getInt(6);
				int avg_humidity_soil = rs.getInt(7);
				
				gdto = new GraphDTO(avg_temperature_outer, avg_humidity_outer, avg_temperature, avg_humidity, avg_insolation, avg_co2, avg_humidity_soil);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return gdto;
	}
	
	//당일 온도,습도,일사량,토양습도,co2
	public GraphDTO avgGraph_today(String owner_id) {
		dbconn();
		try {
			String sql = "SELECT round(avg(temperature_outer),2), round(avg(temperature),2), round(avg(humidity_outer),2), round(avg(humidity),2), round(avg(insolation),2),round(avg(co2),2),round(avg(humidity_soil),2)"
					+ "FROM T_ENV"
					+ "WHERE m_id = ?"
					+ "and to_char(env_date, 'YYYY-MM-DD') = to_char(sysdate, 'YYYY-MM-DD')";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, owner_id);
			rs = psmt.executeQuery();
			if(rs.next()) {
				int avg_temperature_outer = rs.getInt(1);
				int avg_temperature = rs.getInt(2);
				int avg_humidity_outer = rs.getInt(3);
				int avg_humidity = rs.getInt(4);
				int avg_insolation = rs.getInt(5);
				int avg_co2 = rs.getInt(6);
				int avg_humidity_soil = rs.getInt(7);
				
				gdto = new GraphDTO(avg_temperature_outer, avg_humidity_outer, avg_temperature, avg_humidity, avg_insolation, avg_co2, avg_humidity_soil);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return gdto;
	}
	
	
	// 과거 30일 온도,습도,일사량,토양습도,co2
	public GraphDTO avgGraph_30(String owner_id) {
		dbconn();
		try {
			String sql = "SELECT round(avg(temperature_outer),2), round(avg(temperature),2), round(avg(humidity_outer),2), round(avg(humidity),2), round(avg(insolation),2),round(avg(co2),2),round(avg(humidity_soil),2)"
					+ "FROM T_ENV"
					+ "WHERE m_id = ?"
					+ "and ENV_DATE BETWEEN (SELECT SYSDATE-30 FROM DUAL) AND (SELECT SYSDATE-1 FROM DUAL)";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, owner_id);
			rs = psmt.executeQuery();
			if(rs.next()) {
				int avg_temperature_outer = rs.getInt(1);
				int avg_temperature = rs.getInt(2);
				int avg_humidity_outer = rs.getInt(3);
				int avg_humidity = rs.getInt(4);
				int avg_insolation = rs.getInt(5);
				int avg_co2 = rs.getInt(6);
				int avg_humidity_soil = rs.getInt(7);
				
				gdto = new GraphDTO(avg_temperature_outer, avg_humidity_outer, avg_temperature, avg_humidity, avg_insolation, avg_co2, avg_humidity_soil);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return gdto;
	}
	
	// 최고최저 온도
	public ArrayList<GraphDTO> temp_HL(String owner_id) {
		ArrayList<GraphDTO> env_HL = new ArrayList<GraphDTO>(); 
		dbconn();
		try {
		String sql = "SELECT TEMPERATURE, TO_CHAR (ENV_DATE, 'HH24:MI')"
				+ "FROM T_ENV"
				+ "WHERE TEMPERATURE =(SELECT MAX(TEMPERATURE)"
				+ "FROM T_ENV"
				+ "WHERE M_ID = ?"
				+ "AND TO_CHAR(ENV_DATE, 'YYYY-MM-DD') = TO_CHAR(SYSDATE, 'YYYY-MM-DD')) UNION ALL"
				+ "SELECT TEMPERATURE, TO_CHAR (ENV_DATE, 'HH24:MI')"
				+ "FROM T_ENV"
				+ "WHERE TEMPERATURE =(SELECT MIN(TEMPERATURE)"
				+ "FROM T_ENV"
				+ "WHERE M_ID = ?"
				+ "AND TO_CHAR(ENV_DATE, 'YYYY-MM-DD') = TO_CHAR(SYSDATE, 'YYYY-MM-DD'));";
		
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, owner_id);
			psmt.setString(2, owner_id);
			rs = psmt.executeQuery();
			while(rs.next()) {
				int temp_HL = rs.getInt(1);
				String time = rs.getString(2);
				
				gdto = new GraphDTO(temp_HL, time);
				env_HL.add(gdto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return env_HL;
	}
	
	// 최고최저 습도
	public ArrayList<GraphDTO> humi_HL(String owner_id) {
		ArrayList<GraphDTO> env_HL = new ArrayList<GraphDTO>(); 
		dbconn();
		try {
		String sql = "SELECT HUMIDITY, TO_CHAR (ENV_DATE, 'HH24:MI')"
				+ "FROM T_ENV"
				+ "WHERE HUMIDITY =(SELECT MAX(HUMIDITY)"
				+ "FROM T_ENV"
				+ "WHERE M_ID = ?"
				+ "AND TO_CHAR(ENV_DATE, 'YYYY-MM-DD') = TO_CHAR(SYSDATE, 'YYYY-MM-DD')) UNION ALL"
				+ "SELECT HUMIDITY, TO_CHAR (ENV_DATE, 'HH24:MI')"
				+ "FROM T_ENV"
				+ "WHERE HUMIDITY =(SELECT MIN(HUMIDITY)"
				+ "FROM T_ENV"
				+ "WHERE M_ID = ?"
				+ "AND TO_CHAR(ENV_DATE, 'YYYY-MM-DD') = TO_CHAR(SYSDATE, 'YYYY-MM-DD'));";
		
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, owner_id);
			psmt.setString(2, owner_id);
			rs = psmt.executeQuery();
			while(rs.next()) {
				int temp_HL = rs.getInt(1);
				String time = rs.getString(2);
				
				gdto = new GraphDTO(temp_HL, time);
				env_HL.add(gdto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return env_HL;
	}
	
	// 최고최저 일사량
	public ArrayList<GraphDTO> insol_HL(String owner_id) {
		ArrayList<GraphDTO> env_HL = new ArrayList<GraphDTO>(); 
		dbconn();
		try {
		String sql = "SELECT INSOLATION, TO_CHAR (ENV_DATE, 'HH24:MI')"
				+ "FROM T_ENV"
				+ "WHERE INSOLATION =(SELECT MAX(INSOLATION)"
				+ "FROM T_ENV"
				+ "WHERE M_ID = ?"
				+ "AND TO_CHAR(ENV_DATE, 'YYYY-MM-DD') = TO_CHAR(SYSDATE, 'YYYY-MM-DD')) UNION ALL"
				+ "SELECT INSOLATION, TO_CHAR (ENV_DATE, 'HH24:MI')"
				+ "FROM T_ENV"
				+ "WHERE INSOLATION =(SELECT MIN(INSOLATION)"
				+ "FROM T_ENV"
				+ "WHERE M_ID = ?"
				+ "AND TO_CHAR(ENV_DATE, 'YYYY-MM-DD') = TO_CHAR(SYSDATE, 'YYYY-MM-DD'));";
		
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, owner_id);
			psmt.setString(2, owner_id);
			rs = psmt.executeQuery();
			while(rs.next()) {
				int temp_HL = rs.getInt(1);
				String time = rs.getString(2);
				
				gdto = new GraphDTO(temp_HL, time);
				env_HL.add(gdto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return env_HL;
	}
	
	// 최고최저 토양습도
	public ArrayList<GraphDTO> soil_HL(String owner_id) {
		ArrayList<GraphDTO> env_HL = new ArrayList<GraphDTO>(); 
		dbconn();
		try {
		String sql = "SELECT HUMIDITY_SOIL, TO_CHAR (ENV_DATE, 'HH24:MI')"
				+ "FROM T_ENV"
				+ "WHERE HUMIDITY_SOIL =(SELECT MAX(HUMIDITY_SOIL)"
				+ "FROM T_ENV"
				+ "WHERE M_ID = ?"
				+ "AND TO_CHAR(ENV_DATE, 'YYYY-MM-DD') = TO_CHAR(SYSDATE, 'YYYY-MM-DD')) UNION ALL"
				+ "SELECT HUMIDITY_SOIL, TO_CHAR (ENV_DATE, 'HH24:MI')"
				+ "FROM T_ENV"
				+ "WHERE HUMIDITY_SOIL =(SELECT MIN(HUMIDITY_SOIL)"
				+ "FROM T_ENV"
				+ "WHERE M_ID = ?"
				+ "AND TO_CHAR(ENV_DATE, 'YYYY-MM-DD') = TO_CHAR(SYSDATE, 'YYYY-MM-DD'));";
		
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, owner_id);
			psmt.setString(2, owner_id);
			rs = psmt.executeQuery();
			while(rs.next()) {
				int temp_HL = rs.getInt(1);
				String time = rs.getString(2);
				
				gdto = new GraphDTO(temp_HL, time);
				env_HL.add(gdto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return env_HL;
	}
	
	
	
	
}
