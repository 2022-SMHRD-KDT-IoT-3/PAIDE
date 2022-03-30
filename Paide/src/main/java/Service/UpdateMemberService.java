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
		
		String savePath = request.getServletContext().getRealPath("./profile");
		
		int maxsize = 2*1024*1024;
		
		String encoding = "UTF-8";
		
		DefaultFileRenamePolicy filePolicy = new DefaultFileRenamePolicy();
		
		MultipartRequest multi = new MultipartRequest(request, savePath, maxsize, encoding, filePolicy);
		
		
		String nextpage = "";
		String m_id = request.getParameter("");
		String m_name = request.getParameter("");
		String m_phone = request.getParameter("");
		String m_pw = request.getParameter("");
		String m_email = request.getParameter("");
		String m_profile = multi.getFilesystemName("profile");
		
		
		MemberDTO dto = new MemberDTO(m_id, m_pw, m_name, m_phone,m_email, m_profile);
		
		int cnt = new MemberDAO().UpdateMember(dto);
		if(cnt>0) {
			HttpSession session = request.getSession();
			session.setAttribute("info", dto);
			System.out.println("회원정보수정 성공");
			nextpage = "";
		}else {
			System.out.println("회원정보수정 실패");
			nextpage = "";
		}
		return nextpage;
	}

	
}
