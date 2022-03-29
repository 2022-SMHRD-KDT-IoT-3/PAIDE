package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Inter.Command;
import Model.MemberDAO;
import Model.MemberDTO;

public class UpdateMemberService implements Command{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("[UpdateMemberService]");
		
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO)session.getAttribute("info");
		
		String nextpage = "";
		String m_name = request.getParameter("");
		String m_phone = request.getParameter("");
		String m_pw = request.getParameter("");
		String m_email = request.getParameter("");
		String m_profile = request.getParameter("");
		
		int cnt = new MemberDAO().UpdateMember(dto.getM_id(), m_name, m_phone, m_pw, m_email, m_profile);
		if(cnt>0) {
			System.out.println("회원정보수정 성공");
			nextpage = "";
		}else {
			System.out.println("회원정보수정 실패");
			nextpage = "";
		}
		return nextpage;
	}

	
}
