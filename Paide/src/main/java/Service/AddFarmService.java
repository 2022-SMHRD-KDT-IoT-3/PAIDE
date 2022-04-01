package Service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Inter.Command;
import Model.FarmDAO;
import Model.FarmDTO;

public class AddFarmService implements Command{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("[AddFarmService]");
		
		request.setCharacterEncoding("UTF-8");
		String nextpage = null;
		
		String f_owner_id = "m_id 01";//request.getParameter("f_owner_id");
		String f_name = request.getParameter("f_name");
		String f_region = request.getParameter("f_region");
		String f_crops = request.getParameter("f_crops");
		String f_facility = request.getParameter("f_facility");
		
		System.out.println(f_owner_id);
		System.out.println(f_name);
		System.out.println(f_region);
		System.out.println(f_crops);
		System.out.println(f_facility);
		FarmDTO fdto = new FarmDTO(f_owner_id, f_region, f_crops, f_facility, f_name);
		int cnt = new FarmDAO().register(fdto);
		
		PrintWriter out = response.getWriter();
		if(cnt>0) {
			System.out.println("농장등록 성공");
			nextpage = "index.jsp";
		}else {
			System.out.println("농장등록 실패");
			nextpage = "updateMember.jsp";
		}
		
		
		return nextpage;
	}

}
