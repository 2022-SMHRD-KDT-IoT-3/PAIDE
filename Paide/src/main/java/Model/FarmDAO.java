 package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import Service.envCheckService;

public class FarmDAO {

   // 전역변수 선언
   PreparedStatement psmt = null;
   Connection conn = null;
   ResultSet rs = null;
   FarmDTO fdto = null;
   GraphDTO gdto = null;
   int cnt = 0;
   SensorVO vo = new SensorVO();

   // DB연결 메소드
   public void dbconn() {
      try {
         Class.forName("oracle.jdbc.driver.OracleDriver");

         String url = "jdbc:oracle:thin:@project-db-stu.ddns.net:1524:xe";
         // thin이라는 버전
         String dbid = "campus_b_0310_3";
         String dbpw = "smhrd3";

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

   // 농장등록 메소드 (DB에 저장)
   public int register(FarmDTO dto) {

		// 1. DB연결(ojdbc6.jar 넣어주기
		// 1-1. Class찾기 : DB와 이클립스를 연결해주는 Class
		try {
			// DB연결 메소드
			dbconn();
			// 2. DB실행
			// SQL문 작성
			String sql = "insert into t_farm values(t_farm_seq.nextval,?,?,?,?,sysdate,?)";

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
   public boolean checkfname(String f_name) {
      boolean result = false;
      dbconn();
      try {
         String sql = "select f_name from t_farm where f_name = ?";
         psmt = conn.prepareStatement(sql);

         psmt.setString(1, f_name);
         rs = psmt.executeQuery();
         if (rs.next()) {
            result = true;
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         dbclose();
      }
      return result;
   }

   // 농장정보수정 메소드
   public int update(FarmDTO dto, String f_name) {
		dbconn();
		try {
			
		String sql = "update t_farm set f_region = ?, f_crops = ?, f_facility = ?, f_name = ? where f_name = ?";	
		
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1, dto.getF_region());
		psmt.setString(2, dto.getF_crops());
		psmt.setString(3, dto.getF_facility());
		psmt.setString(4, dto.getF_name());
		psmt.setString(5, f_name);
		
		cnt = psmt.executeUpdate();
		
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}return cnt;
		
	}

// 농장삭제 메소드
	public int delete(String f_name) {
		dbconn();
		
		try {
			
			String sql = "update t_farm set f_owner_id = 'delete', f_name=delete_seq.nextval where f_name = ?";
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, f_name);
			
			cnt = psmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		
		return cnt;
	}

   // 농장목록 검색 메소드
   public ArrayList<FarmDTO> SearchFarm(String crops, String regions, String facs) {
      ArrayList<FarmDTO> farmlist = new ArrayList<>();
      dbconn();
      try {
         String sql = "select * from t_farm where INSTR(?, ',' || f_crops || ',')>0 and INSTR(?, ',' || f_region || ',')>0 and INSTR(?, ',' || f_facility || ',')>0 order by f_crops";
         psmt = conn.prepareStatement(sql);
         psmt.setString(1, crops);
         psmt.setString(2, regions);
         psmt.setString(3, facs);

         rs = psmt.executeQuery();
         while (rs.next()) {
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
      } finally {
         dbclose();
      }
      return farmlist;
   }

   // 검색한 농장 (메인)상세보기 메소드
   public FarmDTO selectFarm(int seq) {
	   dbconn();
		try {
			String sql = "select * "
					+ " from t_farm t, t_env e "
					+ " where t.f_seq = e.f_seq "
					+ " and e.env_date = "
					+ " (select max(env_date) from t_env where f_seq = ?)";
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				int f_seq = rs.getInt(1);
				String f_owner_id = rs.getString(2);
				String f_region = rs.getString(3);
				String f_crops = rs.getString(4);
				String f_facility = rs.getString(5);
				String f_name = rs.getString(7);
				int env_seq = rs.getInt(8);
				double temperature = rs.getDouble(10);
				double temperature_outer = rs.getDouble(11);
				double humidity = rs.getDouble(12);
				double hmidity_outer = rs.getDouble(13);
				double humidity_soil = rs.getDouble(14);
				double insolation = rs.getDouble(15);
				double window_opened = rs.getDouble(16);
				double co2 = rs.getDouble(17);
				double dew_point = rs.getDouble(18);
				String env_date = rs.getString(19);
				
				fdto = new FarmDTO(f_seq,f_owner_id,f_region,f_crops, f_facility,f_name, env_seq, temperature, temperature_outer,humidity,hmidity_outer,humidity_soil,insolation,window_opened,co2,dew_point,env_date);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return fdto;
   }

   // 내 농장 (메인)상세보기 메소드
   public FarmDTO myFarm(int seq) {
	   dbconn();
		try {
			String sql = "select *"
					+ " from t_farm t, t_env e "
					+ " where t.f_seq = e.f_seq "
					+ " and e.env_date = "
					+ " (select max(env_date) from t_env where f_seq = ?) ";
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				int f_seq = rs.getInt(1);
				String f_owner_id = rs.getString(2);
				String f_region = rs.getString(3);
				String f_crops = rs.getString(4);
				String f_facility = rs.getString(5);
				String f_name = rs.getString(7);
				int env_seq = rs.getInt(8);
				double temperature = rs.getDouble(10);
				double temperature_outer = rs.getDouble(11);
				double humidity = rs.getDouble(12);
				double hmidity_outer = rs.getDouble(13);
				double humidity_soil = rs.getDouble(14);
				double insolation = rs.getDouble(15);
				double window_opened = rs.getDouble(16);
				double co2 = rs.getDouble(17);
				double dew_point = rs.getDouble(18);
				String env_date = rs.getString(19);
				
				fdto = new FarmDTO(f_seq,f_owner_id,f_region,f_crops, f_facility,f_name, env_seq, temperature, temperature_outer,humidity,hmidity_outer,humidity_soil,insolation,window_opened,co2,dew_point,env_date);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return fdto;
   }

   // 꺾은선그래프
   public ArrayList<FarmDTO> envGraph(String date, int seq) {
	      ArrayList<FarmDTO> graph1 = new ArrayList<>();
	      dbconn();
	      try {
	         String sql = "select temperature_outer, humidity_outer, temperature, humidity, dew_point, co2, window_opened, humidity_soil, insolation, to_char(env_date, 'YYYYMMDD HH24:MI'), f_seq "
	               + " from t_env " 
	               + " where to_char(env_date, 'YYYY-MM-DD') = ? and f_seq = ? "
	               + " order by env_date ";
	         psmt = conn.prepareStatement(sql);

	         psmt.setString(1, date);
	         psmt.setInt(2, seq);

	         rs = psmt.executeQuery();
	         while (rs.next()) {
	            double temperature_outer = rs.getDouble(1);
	            double humidity_outer = rs.getDouble(2);
	            double temperature = rs.getDouble(3);
	            double humidity = rs.getDouble(4);
	            double dew_point = rs.getDouble(5);
	            double co2 = rs.getDouble(6);
	            double window_opened = rs.getDouble(7);
	            double humidity_soil = rs.getDouble(8);
	            double insolation = rs.getDouble(9);
	            String env_date = rs.getString(10);
	            int f_seq = rs.getInt(11);

	            fdto = new FarmDTO(temperature, temperature_outer, humidity, humidity_outer, humidity_soil, insolation,
	                  window_opened, co2, dew_point, env_date, f_seq);
	            graph1.add(fdto);
	         }

	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         dbclose();
	      }
	      return graph1;
	   }

   // 과거 일주일 온도,습도,일사량,토양습도,co2
   public GraphDTO avgGraph_7(int seq) {
	      dbconn();
	      try {
	         String sql = "SELECT round(avg(temperature_outer),2), round(avg(temperature),2), round(avg(humidity_outer),2), round(avg(humidity),2), round(avg(insolation),2),round(avg(co2),2),round(avg(humidity_soil),2) "
	               + " FROM T_ENV " 
	               + " WHERE f_seq = ? "
	               + " and ENV_DATE BETWEEN (SELECT SYSDATE-7 FROM DUAL) AND (SELECT SYSDATE-1 FROM DUAL) ";
	         psmt = conn.prepareStatement(sql);
	         psmt.setInt(1, seq);
	         rs = psmt.executeQuery();
	         if (rs.next()) {
	        	 double avg_temperature_outer = rs.getDouble(1);
	        	 double avg_temperature = rs.getDouble(2);
	        	 double avg_humidity_outer = rs.getDouble(3);
	        	 double avg_humidity = rs.getDouble(4);
	        	 double avg_insolation = rs.getDouble(5);
	        	 double avg_co2 = rs.getDouble(6);
	        	 double avg_humidity_soil = rs.getDouble(7);

	            gdto = new GraphDTO(avg_temperature_outer, avg_humidity_outer, avg_temperature, avg_humidity,
	                  avg_insolation, avg_co2, avg_humidity_soil);
	         }

	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         dbclose();
	      }
	      return gdto;
	   }

   // 어제 온도,습도,일사량,토양습도,co2
   public GraphDTO avgGraph_yesterday(int seq) {
	      dbconn();
	      try {
	         String sql = "SELECT round(avg(temperature_outer),2), round(avg(temperature),2), round(avg(humidity_outer),2), round(avg(humidity),2), round(avg(insolation),2),round(avg(co2),2),round(avg(humidity_soil),2) "
	               + " FROM T_ENV " 
	               + " WHERE f_seq = ? "
	               + " and to_char(env_date, 'YYYY-MM-DD') = (SELECT TO_CHAR(TRUNC(SYSDATE) - 1, 'YYYY-MM-DD') "
	               + "FROM DUAL)";
	         psmt = conn.prepareStatement(sql);
	         psmt.setInt(1, seq);
	         rs = psmt.executeQuery();
	         if (rs.next()) {
	        	 double avg_temperature_outer = rs.getDouble(1);
	        	 double avg_temperature = rs.getDouble(2);
	        	 double avg_humidity_outer = rs.getDouble(3);
	        	 double avg_humidity = rs.getDouble(4);
	        	 double avg_insolation = rs.getDouble(5);
	        	 double avg_co2 = rs.getDouble(6);
	        	 double avg_humidity_soil = rs.getDouble(7);

	            gdto = new GraphDTO(avg_temperature_outer, avg_humidity_outer, avg_temperature, avg_humidity,
	                  avg_insolation, avg_co2, avg_humidity_soil);
	         }

	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         dbclose();
	      }
	      return gdto;
	   }
   
   // 당일 온도,습도,일사량,토양습도,co2
   public GraphDTO avgGraph_today(int seq) {
	      dbconn();
	      try {
	         String sql = "SELECT round(avg(temperature_outer),2), round(avg(temperature),2), round(avg(humidity_outer),2), round(avg(humidity),2), round(avg(insolation),2),round(avg(co2),2),round(avg(humidity_soil),2) "
	               + " FROM T_ENV" + "WHERE f_seq = ? "
	               + " and to_char(env_date, 'YYYY-MM-DD') = to_char(sysdate, 'YYYY-MM-DD') ";
	         psmt = conn.prepareStatement(sql);
	         psmt.setInt(1, seq);
	         rs = psmt.executeQuery();
	         if (rs.next()) {
	        	 double avg_temperature_outer = rs.getDouble(1);
	        	 double avg_temperature = rs.getDouble(2);
	        	 double avg_humidity_outer = rs.getDouble(3);
	        	 double avg_humidity = rs.getDouble(4);
	        	 double avg_insolation = rs.getDouble(5);
	        	 double avg_co2 = rs.getDouble(6);
	        	 double avg_humidity_soil = rs.getDouble(7);

	            gdto = new GraphDTO(avg_temperature_outer, avg_humidity_outer, avg_temperature, avg_humidity,
	                  avg_insolation, avg_co2, avg_humidity_soil);
	         }

	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         dbclose();
	      }
	      return gdto;
	   }

   // 과거 30일 온도,습도,일사량,토양습도,co2
   public GraphDTO avgGraph_30(int seq) {
	      dbconn();
	      try {
	         String sql = "SELECT round(avg(temperature_outer),2), round(avg(temperature),2), round(avg(humidity_outer),2), round(avg(humidity),2), round(avg(insolation),2),round(avg(co2),2),round(avg(humidity_soil),2) "
	               + " FROM T_ENV" + "WHERE f_seq = ? "
	               + " and ENV_DATE BETWEEN (SELECT SYSDATE-30 FROM DUAL) AND (SELECT SYSDATE-1 FROM DUAL) ";
	         psmt = conn.prepareStatement(sql);
	         psmt.setInt(1, seq);
	         rs = psmt.executeQuery();
	         if (rs.next()) {
	        	 double avg_temperature_outer = rs.getDouble(1);
	        	 double avg_temperature = rs.getDouble(2);
	        	 double avg_humidity_outer = rs.getDouble(3);
	        	 double avg_humidity = rs.getDouble(4);
	        	 double avg_insolation = rs.getDouble(5);
	        	 double avg_co2 = rs.getDouble(6);
	        	 double avg_humidity_soil = rs.getDouble(7);

	            gdto = new GraphDTO(avg_temperature_outer, avg_humidity_outer, avg_temperature, avg_humidity,
	                  avg_insolation, avg_co2, avg_humidity_soil);
	         }

	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         dbclose();
	      }
	      return gdto;
	   }

   // 최고최저 온도
   public ArrayList<GraphDTO> temp_HL(int seq, String date) {
	      ArrayList<GraphDTO> env_HL = new ArrayList<GraphDTO>();
	      dbconn();
	      try {
	         String sql = "SELECT TEMPERATURE, TO_CHAR(ENV_DATE, 'HH24:MI') "
	         		+ " FROM T_ENV "
	         		+ " WHERE TEMPERATURE =(SELECT MAX(TEMPERATURE) "
	         		+ " FROM T_ENV "
	         		+ " WHERE f_seq = ? "
	         		+ " AND TO_CHAR(ENV_DATE, 'YYYY-MM-DD') = ? ) "
	         		+ " and ROWNUM <= 1 UNION ALL "
	         		+ " SELECT TEMPERATURE, TO_CHAR(ENV_DATE, 'HH24:MI') "
	         		+ " FROM T_ENV "
	         		+ " WHERE TEMPERATURE =(SELECT MIN(TEMPERATURE) "
	         		+ " FROM T_ENV "
	         		+ " WHERE f_seq = ? "
	         		+ " AND TO_CHAR(ENV_DATE, 'YYYY-MM-DD') = ? ) "
	         		+ " and ROWNUM <= 1 ";

	         psmt = conn.prepareStatement(sql);
	         psmt.setInt(1, seq);
	         psmt.setString(2, date);
	         psmt.setInt(3, seq);
	         psmt.setString(4, date);
	         rs = psmt.executeQuery();
	         while (rs.next()) {
	            int temp_HL = rs.getInt(1);
	            String time = rs.getString(2);

	            gdto = new GraphDTO(temp_HL, time);
	            env_HL.add(gdto);
	         }

	      } catch (SQLException e) {
	         e.printStackTrace();
	      } finally {
	         dbclose();
	      }
	      return env_HL;
	   }

   // 최고최저 습도
   public ArrayList<GraphDTO> humi_HL(int seq,String date) {
	      ArrayList<GraphDTO> env_HL = new ArrayList<GraphDTO>();
	      dbconn();
	      try {
	         String sql = "SELECT HUMIDITY, TO_CHAR(ENV_DATE, 'HH24:MI') "
		         		+ " FROM T_ENV "
		         		+ " WHERE HUMIDITY =(SELECT MAX(HUMIDITY) "
		         		+ " FROM T_ENV "
		         		+ " WHERE f_seq = ? "
		         		+ " AND TO_CHAR(ENV_DATE, 'YYYY-MM-DD') = ? ) "
		         		+ " and ROWNUM <= 1 UNION ALL "
		         		+ " SELECT HUMIDITY, TO_CHAR(ENV_DATE, 'HH24:MI') "
		         		+ " FROM T_ENV "
		         		+ " WHERE HUMIDITY =(SELECT MIN(HUMIDITY) "
		         		+ " FROM T_ENV "
		         		+ " WHERE f_seq = ? "
		         		+ " AND TO_CHAR(ENV_DATE, 'YYYY-MM-DD') = ? ) "
		         		+ " and ROWNUM <= 1 ";

	         psmt = conn.prepareStatement(sql);
	         psmt.setInt(1, seq);
	         psmt.setString(2, date);
	         psmt.setInt(3, seq);
	         psmt.setString(4, date);
	         rs = psmt.executeQuery();
	         while (rs.next()) {
	            int temp_HL = rs.getInt(1);
	            String time = rs.getString(2);

	            gdto = new GraphDTO(temp_HL, time);
	            env_HL.add(gdto);
	         }

	      } catch (SQLException e) {
	         e.printStackTrace();
	      } finally {
	         dbclose();
	      }
	      return env_HL;
	   }

   // 최고최저 일사량
   public ArrayList<GraphDTO> insol_HL(int seq, String date) {
	      ArrayList<GraphDTO> env_HL = new ArrayList<GraphDTO>();
	      dbconn();
	      try {
	         String sql = "SELECT INSOLATION, TO_CHAR(ENV_DATE, 'HH24:MI') "
		         		+ " FROM T_ENV "
		         		+ " WHERE INSOLATION =(SELECT MAX(INSOLATION) "
		         		+ " FROM T_ENV "
		         		+ " WHERE f_seq = ? "
		         		+ " AND TO_CHAR(ENV_DATE, 'YYYY-MM-DD') = ? ) "
		         		+ " and ROWNUM <= 1 UNION ALL "
		         		+ " SELECT INSOLATION, TO_CHAR(ENV_DATE, 'HH24:MI') "
		         		+ " FROM T_ENV "
		         		+ " WHERE INSOLATION =(SELECT MIN(INSOLATION) "
		         		+ " FROM T_ENV "
		         		+ " WHERE f_seq = ? "
		         		+ " AND TO_CHAR(ENV_DATE, 'YYYY-MM-DD') = ? ) "
		         		+ " and ROWNUM <= 1 ";

	         psmt = conn.prepareStatement(sql);
	         psmt.setInt(1, seq);
	         psmt.setString(2, date);
	         psmt.setInt(3, seq);
	         psmt.setString(4, date);
	         rs = psmt.executeQuery();
	         while (rs.next()) {
	            int temp_HL = rs.getInt(1);
	            String time = rs.getString(2);

	            gdto = new GraphDTO(temp_HL, time);
	            env_HL.add(gdto);
	         }

	      } catch (SQLException e) {
	         e.printStackTrace();
	      } finally {
	         dbclose();
	      }
	      return env_HL;
	   }

   // 최고최저 토양습도
   public ArrayList<GraphDTO> soil_HL(int seq, String date) {
	      ArrayList<GraphDTO> env_HL = new ArrayList<GraphDTO>();
	      dbconn();
	      try {
	         String sql = "SELECT HUMIDITY_SOIL, TO_CHAR(ENV_DATE, 'HH24:MI') "
		         		+ " FROM T_ENV "
		         		+ " WHERE HUMIDITY_SOIL =(SELECT MAX(HUMIDITY_SOIL) "
		         		+ " FROM T_ENV "
		         		+ " WHERE f_seq = ? "
		         		+ " AND TO_CHAR(ENV_DATE, 'YYYY-MM-DD') = ? ) "
		         		+ " and ROWNUM <= 1 UNION ALL "
		         		+ " SELECT HUMIDITY_SOIL, TO_CHAR(ENV_DATE, 'HH24:MI') "
		         		+ " FROM T_ENV "
		         		+ " WHERE HUMIDITY_SOIL =(SELECT MIN(HUMIDITY_SOIL) "
		         		+ " FROM T_ENV "
		         		+ " WHERE f_seq = ? "
		         		+ " AND TO_CHAR(ENV_DATE, 'YYYY-MM-DD') = ? ) "
		         		+ " and ROWNUM <= 1 ";

	         psmt = conn.prepareStatement(sql);
	         psmt.setInt(1, seq);
	         psmt.setString(2, date);
	         psmt.setInt(3, seq);
	         psmt.setString(4, date);
	         rs = psmt.executeQuery();
	         while (rs.next()) {
	            int temp_HL = rs.getInt(1);
	            String time = rs.getString(2);

	            gdto = new GraphDTO(temp_HL, time);
	            env_HL.add(gdto);
	         }

	      } catch (SQLException e) {
	         e.printStackTrace();
	      } finally {
	         dbclose();
	      }
	      return env_HL;
	   }

   // 농장 환경 데이터 DB 저장 메소드
   public int eData(FarmDTO fdto) {
      dbconn();

      try {
         String sql = "INSERT INTO t_env VALUES(t_env_seq.nextval,?,?,?,?,?,?,?,?,?,?,sysdate,?)";

         psmt = conn.prepareStatement(sql);

         System.out.println("Fseq : " + fdto.getF_seq());
         System.out.println("Temp : " + fdto.getTemperature());
         System.out.println("Otemp : " + fdto.getTemperature_outer());
         System.out.println("Humi : " + fdto.getHumidity());
         System.out.println("Ohumi : " + fdto.getHumidity_outer());
         System.out.println("Soil : " + fdto.getHumidity_soil());
         System.out.println("Sol : " + fdto.getInsolation());
         System.out.println("Window : " + fdto.getWindow_opened());
         System.out.println("Co2 : " + fdto.getCo2());
         System.out.println("Depo : " + fdto.getDew_point());
         System.out.println("Mid : " + fdto.getM_id());

         psmt.setInt(1, fdto.getF_seq());
         psmt.setDouble(2, fdto.getTemperature());
         psmt.setDouble(3, fdto.getTemperature_outer());
         psmt.setDouble(4, fdto.getHumidity());
         psmt.setDouble(5, fdto.getHumidity_outer());
         psmt.setDouble(6, fdto.getHumidity_soil());
         psmt.setDouble(7, fdto.getInsolation());
         psmt.setDouble(8, fdto.getWindow_opened());
         psmt.setDouble(9, fdto.getCo2());
         psmt.setDouble(10, fdto.getDew_point());
         psmt.setString(11, fdto.getM_id());

         cnt = psmt.executeUpdate();

         System.out.println(cnt);

      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         dbclose();
      }
      return cnt;

   }

   // 농장 환경 데이터 보내기 메소드
   public SensorVO newData() {
      envCheckService ecs = new envCheckService();
      Std_envDTO dto2 = new Std_envDTO();
      Std_envDAO dao2 = new Std_envDAO();

      dbconn();
      try {
         String sql = "SELECT * FROM V_T_ENV";

         psmt = conn.prepareStatement(sql);

         rs = psmt.executeQuery();

         while (rs.next()) {

            double temp = rs.getDouble(1);
            double otemp = rs.getDouble(2);
            double humi = rs.getDouble(3);
            double ohumi = rs.getDouble(4);
            double soil = rs.getDouble(5);
            double sol = rs.getDouble(6);
            double open = rs.getDouble(7);
            double co2 = rs.getDouble(8);
            double depo = rs.getDouble(9);

            // if(temp < 기준temp){
            // led = "1"

            System.out.println(temp);
            System.out.println(humi);
            System.out.println(co2);
            System.out.println(sol);

            String temp1 = Double.toString(temp);
            String otemp1 = Double.toString(otemp);
            String humi1 = Double.toString(humi);
            String ohumi1 = Double.toString(ohumi);
            String co21 = Double.toString(co2);
            String sol1 = Double.toString(sol);
            String depo1 = Double.toString(depo);
            String soil1 = Double.toString(soil);
            String open1 = Double.toString(open);
            String led1 = dao2.LED();

            vo.setTEMP(temp1);
            vo.setOTEMP(otemp1);
            vo.setHUMI(humi1);
            vo.setOHUMI(ohumi1);
            vo.setCO2(co21);
            vo.setSOL(sol1);
            vo.setDEPO(depo1);
            vo.setSOIL(soil1);
            vo.setOPEN(open1);
            vo.setLED(led1);

         }

         System.out.println(cnt);

      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         dbclose();
      }
      return vo;

   }
 //농장수정 정보불러오기 메소드
 	public FarmDTO SelectF(String f_name) {
 		dbconn();
 		try {
 			String sql = "select * from t_farm where f_name = ?";
 			psmt = conn.prepareStatement(sql);
 			psmt.setString(1, f_name);
 			rs = psmt.executeQuery();
 			if(rs.next()) {
 				String f_owner= rs.getString(2);
 				String f_region= rs.getString(3);
 				String f_crops= rs.getString(4);
 				String f_facility= rs.getString(5);
 				String f_myname = rs.getString(7);
 				
 				
 				fdto = new FarmDTO(f_owner, f_region, f_crops, f_facility, f_myname);
 			}
 		} catch (Exception e) {
 			e.printStackTrace();
 		}finally {
 			dbclose();
 		}
 		return fdto;
 	}
 	
 	//내 농장 리스트 불러오기 메소드
 	public ArrayList<FarmDTO> myfarm(String m_id){
 		ArrayList<FarmDTO> list = new ArrayList<>();
 		dbconn();
 		try {
			String sql = "select f_seq, f_name from t_farm where f_owner_id = ? order by f_seq";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, m_id);
			rs = psmt.executeQuery();
			while(rs.next()) {
				int f_seq = rs.getInt(1);
				String f_names = rs.getString(2);
				
				fdto = new FarmDTO(f_seq, f_names);
				list.add(fdto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
 		return list;
 	}
 	
 // 농장 seq 찾기 메소드
  	public int searchSeq(String f_name) {
  		int f_seq = 0;
  		dbconn();
  		try {
 			String sql = "select f_seq from t_farm where f_name = ?";
 			psmt = conn.prepareStatement(sql);
 			psmt.setString(1, f_name);
 			rs = psmt.executeQuery();
 			if(rs.next()) {
 				f_seq = rs.getInt(1);
 			}
 		} catch (Exception e) {
 			e.printStackTrace();
 		}finally {
 			dbclose();
 		}
  		return f_seq;
  	}
  	
  	
  	// 농장환경 초기 데이터 메소드
  	public int firstEnv(int f_seq, String m_id) {
  		dbconn();
  		try {
 			String sql = "insert into t_env values(t_env_seq.nextval,?,0,0,0,0,0,0,0,0,0,sysdate,?)";
 			psmt = conn.prepareStatement(sql);
 			psmt.setInt(1, f_seq);
 			psmt.setString(2, m_id);
 			cnt = psmt.executeUpdate();
 			
 		} catch (Exception e) {
 			e.printStackTrace();
 		}finally {
 			dbclose();
 		}
  		return cnt;
  	}
  	
  	//농장삭제시 환경들도 삭제하는 메소드
  	public int deleteEnv(int f_seq) {
  		dbconn();
  		try {
  			String sql = "update t_env set m_id = 'delete' where f_seq = ?";
  			psmt = conn.prepareStatement(sql);
  			psmt.setInt(1, f_seq);
  			cnt = psmt.executeUpdate();
  		} catch (Exception e) {
 			e.printStackTrace();
 		}finally {
 			dbclose();
 		}
  		return cnt;
  	}
  	
 // 날짜시간 메소드
    public String myFarmDate(int seq) {
    	String env_date = null;
 	   dbconn();
 		try {
 			String sql = "select TO_CHAR(ENV_DATE, 'YYYY-MM-DD HH24:MI:SS') "
 					+ " from t_farm t, t_env e "
 					+ " where t.f_seq = e.f_seq "
 					+ " and e.env_date = "
 					+ " (select MAX(env_date) from t_env where f_seq = ?)";
 			
 			psmt = conn.prepareStatement(sql);
 			psmt.setInt(1, seq);
 			
 			rs = psmt.executeQuery();
 			if(rs.next()) {
 				env_date = rs.getString(1);
 				
 			}
 			
 		} catch (Exception e) {
 			e.printStackTrace();
 		}finally {
 			dbclose();
 		}
 		return env_date;
    }

}