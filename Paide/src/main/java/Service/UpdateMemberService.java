package Service;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import Inter.Command;
import Model.MemberDAO;
import Model.MemberDTO;

public class UpdateMemberService implements Command{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("[UpdateMemberService]");
		
		request.setCharacterEncoding("UTF-8");
		
		
		String nextpage = null;
		String m_id = request.getParameter("m_id");
		String m_name = request.getParameter("m_name");
		String m_phone = request.getParameter("m_phone");
		String m_pw = request.getParameter("m_pw");
		String m_email = request.getParameter("m_email");
		
		
		MemberDTO dto = new MemberDTO(m_id, m_pw, m_name, m_phone,m_email);
		
		int cnt = new MemberDAO().UpdateMember(dto);
		if(cnt>0) {
			HttpSession session = request.getSession();
			session.setAttribute("info", dto);
			System.out.println("회원정보수정 성공");
			nextpage = "goMain";
		}else {
			System.out.println("회원정보수정 실패");
			nextpage = "updateMember.jsp";
		}
		return nextpage;
	}

	
}
