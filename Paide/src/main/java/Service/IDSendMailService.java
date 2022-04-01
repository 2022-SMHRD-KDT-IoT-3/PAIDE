package Service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Inter.Command;
import Model.MemberDAO;

public class IDSendMailService implements Command{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
				System.out.println("[IDSendMailService]");
						
				request.setCharacterEncoding("UTF-8");
				String nextpage = null;
				
				String m_id = request.getParameter("mailid");
				String m_email = request.getParameter("m_email");
				System.out.println(m_id);
				System.out.println(m_email);
				
				String email = new MemberDAO().sendMailID(m_id);
				System.out.println(email);
				
				PrintWriter out = response.getWriter();
				if(email.equals(m_email)) {
					ArrayList<String> info = new ArrayList<>();
					info.add(m_id);
					info.add(email);
					boolean res = new MemberDAO().SendMailID(info);
					if(res==true) {
						out.print("true");
						out.close();
					}
				}else {
					out.print("false");
					out.close();
				}
				
				return nextpage;
	}
	
}
