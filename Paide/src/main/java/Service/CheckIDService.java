package Service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Inter.Command;
import Model.MemberDAO;

public class CheckIDService implements Command{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("[CheckIDService]");
		
		String id = request.getParameter("id");
		System.out.println(id);
		boolean result = new MemberDAO().CheckID(id);
		
		PrintWriter out = response.getWriter();
		out.print(result);
		out.close();
		String nextpage = null;
		
		return nextpage;
	}

	
	
}
