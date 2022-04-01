package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MemberDAO {
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
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

	// 회원목록 전체보기 메소드
	public ArrayList<MemberDTO> MemberList() {
		ArrayList<MemberDTO> list = new ArrayList<>();
		dbconn();
		try {
			String sql = "select * from t_member";
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) {
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
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return list;
	}
		
	//회원가입 메소드
	public int Join(MemberDTO dto) {
		dbconn();
		try {
			String sql = "insert into t_member values(?, ?, ?, ?, 0, 1, ?, sysdate, 'U', 'basic.jpg')";
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, dto.getM_id());
			psmt.setString(2, dto.getM_pw());
			psmt.setString(3, dto.getM_name());
			psmt.setString(4, dto.getM_phone());
			psmt.setString(5, dto.getM_email());
			
			cnt = psmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return cnt;
	}

	//로그인 메소드
	public MemberDTO Login(String id, String pw) {
		dbconn();
		try {
			String sql = "select * from t_member where m_id=? and m_pw=?";
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, id);
			psmt.setString(2, pw);
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
	
	// 아이디찾기 본인확인 메소드
	public ArrayList<String> SearchID(String name, String phone) {
		ArrayList<String> sendid = new ArrayList<>();
		dbconn();
		try {
			String sql = "select * from t_member where m_name =? and m_phone =?";
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, name);
			psmt.setString(2, phone);
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				String m_id = rs.getString(1);
				String m_email = rs.getString(7);

				sendid.add(m_id);
				sendid.add(m_email);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		
		return sendid;
	}
	//회원가입시 입력했던 이메일 찾기 메소드
	public String sendMailID(String id) {
		String email = null;
		dbconn();
		try {
			String sql = "select m_email from t_member where m_id = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			if(rs.next()) {
				email = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return email;
	}
	
	// 비밀번호찾기 메소드
	public ArrayList<String> SearchPW(String id) {
		ArrayList<String> sendpw = new ArrayList<>();
		dbconn();
		try {
			String sql = "select * from t_member where m_id =?";
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, id);
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				String m_pw = rs.getString(2);
				String m_email=rs.getString(7);
				String m_id = rs.getString(1);
				
				sendpw.add(m_pw);
				sendpw.add(m_email);
				sendpw.add(m_id);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return sendpw;
	}
	
	//'댓글의 좋아요 점수(5점)' 업데이트 메소드 (Likes_score)
	public int Likes_S(String id) {
		dbconn();
		try {
			String sql = "update t_member set m_score = m_score+5 where m_id = ?";
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, id);
			cnt = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return cnt;
	}
	
	//'댓글 점수(1점)' 업데이트 메소드 (Comment_score)
	public int Comment_S(String id) {
		dbconn();
		try {
			String sql = "update t_member set m_score = m_score+1 where m_id = ?";
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, id);
			cnt = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return cnt;
	}
	
	//'농장의 좋아요 점수(10점)' 업데이트 메소드 (Farm_score)
	public int Farm_S(String id) {
		dbconn();
		try {
			String sql = "update t_member set m_score = m_score+10 where m_id = ?";
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, id);
			cnt = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return cnt;
	}
	
	// 회원의 레벨 변경 메소드 -> level을 jsp select값으로 주기
	public int M_Level(int level, String id) {
		dbconn();
		try {
			String sql = "update t_member set m_level = ? where m_id=?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, level);
			psmt.setString(2, id);
			
			cnt = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return cnt;
	}

	//'댓글의 좋아요 취소점수(-5점)' 업데이트 메소드 (Likes_score)
		public int Likes_MS(String id) {
			dbconn();
			try {
				String sql = "update t_member set m_score = m_score-5 where m_id = ?";
				psmt = conn.prepareStatement(sql);
				
				psmt.setString(1, id);
				cnt = psmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				dbclose();
			}
			return cnt;
		}
	
	//'농장의 좋아요 취소점수(-10점)' 업데이트 메소드 (Farm_score)
		public int Farm_MS(String id) {
			dbconn();
			try {
				String sql = "update t_member set m_score = m_score-10 where m_id = ?";
				psmt = conn.prepareStatement(sql);
				
				psmt.setString(1, id);
				cnt = psmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				dbclose();
			}
			return cnt;
		}

	//회원정보 수정 업데이트 메소드 
	public int UpdateMember(MemberDTO dto) {
		dbconn();
		try {
			String sql = "update t_member set m_name=?, m_phone=?, m_pw=?, m_email=?, m_profile=? where m_id=?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getM_name());
			psmt.setString(2, dto.getM_phone());
			psmt.setString(3, dto.getM_pw());
			psmt.setString(4, dto.getM_email());
			psmt.setString(5, dto.getM_profile());
			psmt.setString(6, dto.getM_id());
			
			cnt = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return cnt;
	}
	
	//아이디찾기 메일보내기 메소드
	public static boolean SendMailID(ArrayList<String> sendid) {
		Properties prop = System.getProperties();
		
		prop.put("mail.smtp.host", "smtp.gmail.com");
		prop.put("mail.smtp.port", 465);
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.ssl.enable", "true");
		prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		
		Authenticator auth = new SendMailToCustomers();
		Session session = Session.getDefaultInstance(prop, auth);
		
		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress("paide0411@gmail.com", "PAIDE"));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(sendid.get(1)));
		
			message.setSubject("요청하신 PAIDE 회원정보입니다.", "UTF-8");
			
			message.setText("아이디 : " + sendid.get(0), "UTF-8");
			
			Transport.send(message);
			System.out.println("Success Message Send");
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			System.out.println("check check");
		}
		return true;
	}
	
	//비번찾기 메일보내기 메소드
		public static boolean SendMailPW(ArrayList<String> sendpw) {
			Properties prop = System.getProperties();
			
			prop.put("mail.smtp.host", "smtp.gmail.com");
			prop.put("mail.smtp.port", 465);
			prop.put("mail.smtp.auth", "true");
			prop.put("mail.smtp.ssl.enable", "true");
			prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
			
			Authenticator auth = new SendMailToCustomers();
			Session session = Session.getDefaultInstance(prop, auth);
			
			try {
				MimeMessage message = new MimeMessage(session);
				message.setFrom(new InternetAddress("paide0411@gmail.com", "PAIDE"));
				message.setRecipient(Message.RecipientType.TO, new InternetAddress(sendpw.get(1)));
			
				message.setSubject("요청하신 PAIDE 회원정보입니다.", "UTF-8");
				
				message.setText("비밀번호 : " + sendpw.get(0), "UTF-8");
				
				Transport.send(message);
				System.out.println("Success Message Send");
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				System.out.println("check check");
			}
			return true;
		}
		
	//아이디 중복확인 메소드
	public boolean CheckID(String id) {
		boolean result = false;
		dbconn();
		try {
			String sql = "select * from t_member where m_id = ?";
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			if(rs.next()) {
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return result;
		
		
	}
	
	// 전화번호 중복확인 메소드 
	public boolean checkPhone(String phone) {
		boolean checkphone = false;
		dbconn();
		try {
			String sql = "select * from t_member where m_phone = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, phone);
			rs = psmt.executeQuery();
			if(rs.next()) {
				checkphone = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return checkphone;
	}
	
	// 이메일 중복확인 메소드
	public boolean checkEmail(String email) {
		boolean checkEmail = false;
		dbconn();
		try {
			String sql = "select * from t_member where m_email = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, email);
			rs = psmt.executeQuery();
			if(rs.next()) {
				checkEmail = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose();
		}
		return checkEmail;
	}
	
	// 게시글의 주인에게 게시글에 달린 댓글 수 업데이트
		public void commentUp(int article_seq) {

			dbconn();
			try {
				String sql = "update t_member set m_comment = m_comment + 1 where m_id = (select m_id from t_community where article_seq = ?)";
				
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, article_seq);
				
				psmt.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		}
		
}
