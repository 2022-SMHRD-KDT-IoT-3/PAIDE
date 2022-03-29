package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Inter.Command;
import Model.MemberDAO;
import Model.MemberDTO;

public class UpdateLevel implements Command{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("[UpdateLevel]");
		
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO)session.getAttribute("info");
		int level = Integer.parseInt(request.getParameter("level"));
		
		int cnt = new MemberDAO().M_Level(level, dto.getM_id());
		
		
		return null;
	}

}
