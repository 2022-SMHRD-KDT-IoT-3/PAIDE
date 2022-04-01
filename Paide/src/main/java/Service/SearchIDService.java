package Service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import Inter.Command;
import Model.MemberDAO;

public class SearchIDService implements Command{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("[SearchIDService]");
		
		request.setCharacterEncoding("UTF-8");
		
		String nextpage = null;
		String m_name = request.getParameter("m_name");
		String m_phone = request.getParameter("m_phone");
		
		ArrayList<String> sendid = new MemberDAO().SearchID(m_name, m_phone);
		System.out.println(sendid.get(0));
		System.out.println(sendid.get(1));
		
		
		Gson gson = new Gson();
				
		if(sendid.size() != 0) {
		String mailid = gson.toJson(sendid);
		
			PrintWriter out = response.getWriter();
			out.print(mailid);
			out.close();
			
		}else {
			System.out.println("¾øÀ½");
		}
		
		
		return nextpage;
	}
	
	

}
