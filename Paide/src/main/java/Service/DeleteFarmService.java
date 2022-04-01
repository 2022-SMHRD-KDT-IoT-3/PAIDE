package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Inter.Command;
import Model.FarmDAO;
import Model.FarmDTO;

public class DeleteFarmService implements Command{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("[DeleteFarmService]");
		
		request.setCharacterEncoding("UTF-8");
		
		String nextpage = null;
		String f_name = request.getParameter("");
		int cnt = new FarmDAO().delete(f_name);
		
		if(cnt>0) {
			System.out.println("농장삭제 성공");
			nextpage = "main.jsp";
		}else {
			System.out.println("농장삭제 실패");
			nextpage = "updateMember.jsp";
		}
		
		return nextpage;
	}

}
