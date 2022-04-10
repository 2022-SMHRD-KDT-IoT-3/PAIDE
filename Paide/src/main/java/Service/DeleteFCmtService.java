package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Inter.Command;
import Model.CommunityDAO;

public class DeleteFCmtService implements Command {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println("[DeleteCmtService]");
		response.setCharacterEncoding("UTF-8");
		
		int fcmt_seq = Integer.parseInt(request.getParameter("fcmt_seq"));
		
		CommunityDAO dao = new CommunityDAO();
		
		int cnt = dao.Delete_Fcmt(fcmt_seq);
		
		if(cnt > 0) {
			System.out.println("삭제가 완료되었습니다.");
		}
		
		return null;
	}

}
