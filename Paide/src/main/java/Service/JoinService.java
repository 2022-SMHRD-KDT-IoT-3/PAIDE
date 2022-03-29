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
		
		String m_id = request.getParameter("m_id");
		String m_pw = request.getParameter("m_pw");
		String m_name = request.getParameter("m_name");
		String m_phone = request.getParameter("m_phone");
		String m_email = request.getParameter("m_email");
		
		
		MemberDTO dto = new MemberDTO();
		int cnt = new MemberDAO().Join(dto);
		
		if(cnt>0) {
			System.out.println("회원가입 성공");
			nextpage = "";
		}else {
			System.out.println("회원가입 실패");
			nextpage = "";
		}
		
		return nextpage;
	}
	
}
