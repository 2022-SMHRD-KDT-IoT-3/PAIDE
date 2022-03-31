package Service;

import java.io.IOException;
import java.io.PrintWriter;

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
		String nextpage=null;
		
		String login_id = request.getParameter("signin-email");
		String login_pw = request.getParameter("signin-password");
		System.out.println(login_id);
		System.out.println(login_pw);
		MemberDTO dto = new MemberDAO().Login(login_id, login_pw);
		
		
		PrintWriter out = response.getWriter();
		if(dto != null) {
			System.out.println("로그인 성공");
			HttpSession session = request.getSession();
			session.setAttribute("info", dto);
			nextpage="goMain";
		}else {
			System.out.println("로그인 실패");
			nextpage="page-login.jsp";
		}
		
		
		return nextpage;
	}

}
