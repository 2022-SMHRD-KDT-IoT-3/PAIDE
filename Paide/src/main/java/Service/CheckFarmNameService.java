package Service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Inter.Command;
import Model.FarmDAO;

public class CheckFarmNameService implements Command{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("[CheckFarmNameService]");
		String nextpage = null;
		
		
		String f_name = request.getParameter("f_name");
		boolean result = new FarmDAO().checkfname(f_name);
		
		PrintWriter out = response.getWriter();
		out.print(result);
		out.close();
		
		
		
		return nextpage;
	}

}
