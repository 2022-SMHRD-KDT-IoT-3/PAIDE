package Service;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Inter.Command;
import Model.MemberDAO;
import Model.MemberDTO;

public class SeenotificationService implements Command {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("지난좋아요 지우기");

		MemberDAO dao = new MemberDAO();
		MemberDTO dto = new MemberDTO();

		HttpSession session = request.getSession();
		MemberDTO info = (MemberDTO) session.getAttribute("info");
		String id = info.getM_id();
		System.out.println(id);
		dao.commentcheck(id);
		dao.fcommentcheck(id);

		String nextpage = "goMain";
		return nextpage;

	}

}
