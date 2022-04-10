package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Inter.Command;
import Model.CommunityDAO;

public class UpdateFcmtService implements Command {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("[UpdateCmtService]");
		response.setCharacterEncoding("UTF-8");
		
		int fcmt_seq = Integer.parseInt(request.getParameter("f_seq"));
		String fcmt_content = request.getParameter("fcmt_content");
		
		CommunityDAO dao = new CommunityDAO();
		
		int cnt = dao.updateFcmt(fcmt_seq, fcmt_content);
		
		return null;
	}

}
