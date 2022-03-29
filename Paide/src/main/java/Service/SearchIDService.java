package Service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Inter.Command;
import Model.MemberDAO;

public class SearchIDService implements Command{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("[SearchIDService]");
		
		request.setCharacterEncoding("UTF-8");
		
		String nextpage = "";
		String m_name = request.getParameter("");
		String m_phone = request.getParameter("");
		
		ArrayList<String> sendid = new MemberDAO().SearchID(m_name, m_phone);
		
		if (sendid != null) {
			PrintWriter out = response.getWriter();
			out.print(sendid);
			out.close();
			nextpage="TEST.jsp";
		}
		
		
		return nextpage;
	}
	
	

}
