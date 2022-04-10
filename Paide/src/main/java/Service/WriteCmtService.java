package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Inter.Command;
import Model.CommunityDAO;
import Model.CommunityDTO;
import Model.MemberDAO;

public class WriteCmtService implements Command {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		
		String page = request.getHeader("referer");
		
		
		// encoding : ¹æ½Ä
		String encoding = "UTF-8";
		
		int article_seq = Integer.parseInt(request.getParameter("article_seq"));
		System.out.println(article_seq);
		String m_id = request.getParameter("cmtWriter");
		System.out.println("idTest "+m_id);
		String comment_content = request.getParameter("cmtContent");
		System.out.println("conTest "+comment_content);
		// int like = Integer.parseInt(request.getParameter("c_like"));
		// int page = Integer.parseInt(request.getParameter("page"));
		
		CommunityDAO dao = new CommunityDAO();
		
		CommunityDTO dto = new CommunityDTO(0, article_seq, comment_content,"", m_id, 0);
		
		
		int result = dao.Insert_Cmt(dto);
		System.out.println(result);
		
		MemberDAO dao2 = new MemberDAO();
		

		return "boardSelect.jsp?article_seq="+ article_seq;
		
		// https://lkg3796.tistory.com/37
		// https://all-record.tistory.com/143
	}

}
