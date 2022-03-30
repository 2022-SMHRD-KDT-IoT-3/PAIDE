package Service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import Model.FarmDAO;
import Model.SensorVO;
import Model.Std_envDAO;
import Model.Std_envDTO;


@WebServlet("/SendEnvDataService")
public class SendEnvDataService extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		FarmDAO dao = new FarmDAO();
		SensorVO vo = dao.newData();
		Std_envDTO dto2 = new Std_envDTO();
		Std_envDAO dao2 = new Std_envDAO();
		
		
		Gson gson = new Gson();
		String result1 = gson.toJson(vo);
		out.print(result1);
		
		System.out.println(result1);
	}

}
