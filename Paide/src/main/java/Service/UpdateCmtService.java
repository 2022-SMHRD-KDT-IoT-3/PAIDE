package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Inter.Command;
import Model.CommunityDAO;

public class UpdateCmtService implements Command {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("[UpdateCmtService]");
		response.setCharacterEncoding("UTF-8");
		
		int cmt_seq = Integer.parseInt(request.getParameter("cmt_seq"));
		String cmt_content = request.getParameter("cmt_content");
		
		CommunityDAO dao = new CommunityDAO();
		
		int cnt = dao.updateCmt(cmt_seq, cmt_content);
		
		return null;
	}

}
