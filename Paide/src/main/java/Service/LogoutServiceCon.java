package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Inter.Command;

public class LogoutServiceCon implements Command{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("[LogoutService]");
				
				//로그아웃 -> 로그인 한 정보삭제 == session 삭제
				HttpSession session = request.getSession();
				
				//1. 세션 삭제 -> 세션 종료
		//		session.invalidate(); //페이지에서 사용중인 세션 전부 삭제
				
				//2. 세션 삭제 -> 특정 세션 삭제
				session.removeAttribute("info"); //내가 지정한 세션 삭제
				
				System.out.println("로그아웃 성공");
				String nextpage = "goMain";
				
				
				
				return nextpage;
	}

}
