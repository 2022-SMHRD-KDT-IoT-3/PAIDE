package Service;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.mail.Session;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import Inter.Command;
import Model.MemberDAO;
import Model.MemberDTO;

public class UpdateProfileService implements Command{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("[UpdatePrifileService]");
		
		request.setCharacterEncoding("UTF-8");
		
		String savePath = request.getServletContext().getRealPath("./assets/img");
		
		int maxsize = 2*1024*1024;
		
		String encoding = "UTF-8";
		
		DefaultFileRenamePolicy filePolicy = new DefaultFileRenamePolicy();
		
		MultipartRequest multi = new MultipartRequest(request, savePath, maxsize, encoding, filePolicy);
		
		String nextpage = null;
		String m_profile = multi.getFilesystemName("profile");
		String m_id = multi.getParameter("infoid");
		System.out.println(m_profile);
		System.out.println(m_id);
		String m_pw = multi.getParameter("infopw");
		
		int cnt = new MemberDAO().profile(m_profile, m_id);
		if(cnt>0) {
			System.out.println("프로필 업로드 성공");
			MemberDTO dto = new MemberDAO().Login(m_id, m_pw);
			HttpSession session = request.getSession();
			session.setAttribute("info", dto);
			nextpage="goMain";
		}else {
			System.out.println("프로필 업로드 실패");
			nextpage="UpdateMember.jsp";
		}
		return nextpage;
	}

}
