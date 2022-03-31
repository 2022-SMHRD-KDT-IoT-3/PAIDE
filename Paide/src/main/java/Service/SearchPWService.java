package Service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import Inter.Command;
import Model.MemberDAO;

public class SearchPWService implements Command{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("[SearchPWService]");
		String nextpage = null;
		request.setCharacterEncoding("UTF-8");
		
		String m_id = request.getParameter("m_id");
		
		ArrayList<String> sendpw = new MemberDAO().SearchPW(m_id);
		
		Gson gson = new Gson();
		
		if(sendpw.size() != 0) {
		String mailpw = gson.toJson(sendpw);
		
			PrintWriter out = response.getWriter();
			out.print(mailpw);
			out.close();
			
		}else {
			System.out.println("¾øÀ½");
		}
		
		
		return nextpage;
	}

}
