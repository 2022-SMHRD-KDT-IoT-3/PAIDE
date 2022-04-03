package Service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import Inter.Command;
import Model.FarmDAO;
import Model.FarmDTO;

public class EditFarmService implements Command{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("[EditFarmService]");
		
		String nextpage = null;
		String f_name = request.getParameter("f_name");
		System.out.println(f_name);
		FarmDTO farm = new FarmDAO().SelectF(f_name);
		ArrayList<FarmDTO> fdto = new ArrayList<>();
		fdto.add(farm);
		System.out.println(fdto.get(0).getF_crops());
		
		response.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();
		if(fdto.size() != 0) {
			PrintWriter out = response.getWriter();
			String ffarm = gson.toJson(fdto);
			out.print(ffarm);
			out.close();
		}
		
		
		
		return nextpage;
	}

}
