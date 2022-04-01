package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Inter.Command;
import Model.MemberDAO;
import Model.MemberDTO;

public class JoinService implements Command{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("[JoinService]");
		
		request.setCharacterEncoding("UTF-8");
		
		String nextpage = null;
		
		String m_id = request.getParameter("id");
		String m_pw = request.getParameter("pw1");
		String m_name = request.getParameter("name");
		String m_phone = request.getParameter("tel");
		String m_email = request.getParameter("email");
		
		
		MemberDTO dto = new MemberDTO(m_id, m_pw, m_name, m_phone, m_email);
		int cnt = new MemberDAO().Join(dto);
		
		if(cnt>0) {
			System.out.println("회원가입 성공");
			nextpage = "goMain";
		}else {
			System.out.println("회원가입 실패");
			nextpage = "goMain";
			
		}
		
		return nextpage;
	}
	
}
