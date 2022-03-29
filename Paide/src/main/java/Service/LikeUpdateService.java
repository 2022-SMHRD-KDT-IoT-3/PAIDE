package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import Inter.Command;
import Model.CommunityDAO;

public class LikeUpdateService implements Command {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");

		int article_seq = Integer.parseInt(request.getParameter("article_seq"));
		int cmt_seq = Integer.parseInt(request.getParameter("cmt_seq"));
		
		System.out.println(article_seq);
		System.out.println(cmt_seq);
		
		CommunityDAO dao = new CommunityDAO();
		dao.Plikes(article_seq, cmt_seq);
		
		int like = dao.select_like(article_seq, cmt_seq);
		System.out.println("LikeUpdateServiceÀÇ like °³¼ö : " + like);
		
		JSONObject obj = new JSONObject();
		obj.put("like", like);
		
		response.setContentType("application/x-json; charset=utf-8");
		response.getWriter().print(obj);
		
		return null;
		//return "ViewBoard.jsp?article_seq=" + article_seq;
	}

}
