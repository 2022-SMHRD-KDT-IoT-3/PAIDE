package Service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Inter.Command;
import Model.SubscriptionDAO;
import Model.SubscriptionDTO;

public class AddSubscriptionService implements Command{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("[AddSubscriptionService]");
		request.setCharacterEncoding("UTF-8");
		
		String subscription_id = request.getParameter("m_id");
		int subscriptioned_id = Integer.parseInt(request.getParameter("f_seq"));
		
		System.out.println(subscriptioned_id);
		SubscriptionDTO sdto = new SubscriptionDTO(subscription_id, subscriptioned_id);
		int cnt = new SubscriptionDAO().subscribe(sdto);
		
		PrintWriter out = response.getWriter();
		if(cnt>0) {
			System.out.println("이웃추가 성공");
			out.print("success");
			out.close();
		}else {
			System.out.println("이웃추가 실패");
			out.print("fail");
			out.close();
		}
		String nextpage = null;
		return nextpage;
	}

}
