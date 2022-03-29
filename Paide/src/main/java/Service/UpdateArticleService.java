package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Inter.Command;
import Model.CommunityDAO;

public class UpdateArticleService implements Command {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		
		
		int article_seq = Integer.parseInt(request.getParameter("article_seq"));
		String article_title = request.getParameter("article_title");
		String article_content = request.getParameter("article_content");
		
		CommunityDAO dao = new CommunityDAO();
		
		int cnt = dao.updateArticle(article_seq, article_title, article_content);
		
		System.out.println(cnt);
		
		return "ViewBoard.jsp?article_seq=" + article_seq;
	}

}
