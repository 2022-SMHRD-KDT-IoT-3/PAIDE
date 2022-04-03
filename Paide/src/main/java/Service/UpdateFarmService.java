package Service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Inter.Command;
import Model.FarmDAO;
import Model.FarmDTO;

public class UpdateFarmService implements Command{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("[UpdateFarmService]");
		
		request.setCharacterEncoding("UTF-8");

		String nextpage = null;
		
		String fs_name = request.getParameter("fs_name");
		String f_owner_id = request.getParameter("f_owner_id");
		String f_name = request.getParameter("fu_name");
		String f_region = request.getParameter("fu_region");
		String f_crops = request.getParameter("fu_crops");
		String f_facility = request.getParameter("fu_facility");
		
		System.out.println(fs_name);
		System.out.println(f_owner_id);
		System.out.println(f_name);
		System.out.println(f_region);
		System.out.println(f_crops);
		System.out.println(f_facility);
		
		FarmDTO fdto = new FarmDTO(f_owner_id, f_region, f_crops, f_facility, f_name);
		int cnt = new FarmDAO().update(fdto, fs_name);
		
		PrintWriter out = response.getWriter();
		if(cnt>0) {
			System.out.println("농장수정 성공");
			out.print("success");
			out.close();
		}else {
			System.out.println("농장수정 실패");
			out.print("fail");
			out.close();
		}
		
		
		
		return nextpage;
	}

}
