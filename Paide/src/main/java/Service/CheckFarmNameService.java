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
		
		request.setCharacterEncoding("UTF-8");
		
		String owner_id = request.getParameter("");
		boolean result = new FarmDAO().checkfname(owner_id);
		
		PrintWriter out = response.getWriter();
		out.print(result);
		out.close();
		
		return null;
	}

}
