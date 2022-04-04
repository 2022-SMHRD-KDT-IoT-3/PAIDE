package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Inter.Command;
import Model.CommunityDAO;
import Model.MemberDTO;

public class LikeUpdateService implements Command {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		MemberDTO info = (MemberDTO)session.getAttribute("info");
	    session.getAttribute("info");
	    String m_id = info.getM_id();
		
		// int article_seq = Integer.parseInt(request.getParameter("article_seq"));
		int cmt_seq = Integer.parseInt(request.getParameter("cmt_seq"));
		
		
		// System.out.println(article_seq);
		System.out.println(cmt_seq);
		System.out.println(m_id);
		
		CommunityDAO dao = new CommunityDAO();
		dao.Plikes(cmt_seq);
		dao.addLikeInfo(cmt_seq, m_id);
		
		
		int like = dao.select_like(cmt_seq);
		System.out.println("LikeUpdateServiceÀÇ like °³¼ö : " + like);
		response.setContentType("application/x-json; charset=utf-8");
		response.getWriter().print(like);
		
		
		return null;
		//return "ViewBoard.jsp?article_seq=" + article_seq;
	}

}
