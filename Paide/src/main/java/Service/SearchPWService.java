package Service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Inter.Command;
import Model.MemberDAO;

public class SearchPWService implements Command{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("[SearchPWService]");
		
		request.setCharacterEncoding("UTF-8");
		
		String nextpage = "";
		String m_id = request.getParameter("");
		
		ArrayList<String> sendpw = new MemberDAO().SearchPW(m_id);
		if (sendpw != null) {
			PrintWriter out = response.getWriter();
			out.print(sendpw);
			out.close();
			nextpage="";
		}
		
		
		return null;
	}

}
