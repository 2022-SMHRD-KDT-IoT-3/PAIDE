package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Inter.Command;
import Model.CommunityDAO;
import Model.CommunityDTO;

public class WrtieFCmtService implements Command {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		
		// encoding : ¹æ½Ä
		String encoding = "UTF-8";
		
		int t_farm_seq = Integer.parseInt(request.getParameter("t_farm_seq"));
		System.out.println(t_farm_seq);
		String m_id = request.getParameter("fcmtWriter");
		System.out.println("idTest "+m_id);
		String fcmt_content = request.getParameter("fcmtContent");
		System.out.println("conTest "+fcmt_content);
		// int like = Integer.parseInt(request.getParameter("c_like"));
		// int page = Integer.parseInt(request.getParameter("page"));
		
		CommunityDAO dao = new CommunityDAO();
		
		CommunityDTO dto = new CommunityDTO(0, t_farm_seq, fcmt_content,"", m_id, 0);
		
		
		int result = dao.Insert_Cmt(dto);
		System.out.println(result);
		

		return null;
		
		// https://lkg3796.tistory.com/37
		// https://all-record.tistory.com/143
	}

}
