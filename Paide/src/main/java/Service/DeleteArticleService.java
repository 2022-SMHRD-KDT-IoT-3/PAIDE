package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Inter.Command;
import Model.CommunityDAO;

public class DeleteArticleService implements Command {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setCharacterEncoding("UTF-8");
		
		int article_seq = Integer.parseInt(request.getParameter("article_seq"));
		
		CommunityDAO dao = new CommunityDAO();
		
		int cnt = dao.Delete_C(article_seq);
		
		if(cnt > 0) {
			System.out.println("삭제가 완료되었습니다.");
		}
		
		return "BoardMain.jsp";
	}

}
