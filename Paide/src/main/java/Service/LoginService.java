package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Inter.Command;
import Model.MemberDAO;
import Model.MemberDTO;

public class LoginService implements Command{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("[LoginService]");
		
		request.setCharacterEncoding("UTF-8");
		
		
		String login_id = request.getParameter("");
		String login_pw = request.getParameter("");
		
		MemberDTO dto = new MemberDAO().Login(login_id, login_pw);
		
		if(dto != null) {
			System.out.println("로그인 성공");
			HttpSession session = request.getSession();
			session.setAttribute("info", dto);
		}else {
			System.out.println("로그인 실패");
		}
		String nextpage="goMain";
		
		return nextpage;
	}

}
