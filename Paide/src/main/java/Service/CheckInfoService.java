package Service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Inter.Command;
import Model.MemberDAO;

public class CheckInfoService implements Command{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
			request.setCharacterEncoding("UTF-8");
			
			String m_phone = request.getParameter("m_phone");
			String m_email = request.getParameter("m_email");
			
			boolean resPhone = new MemberDAO().checkPhone(m_phone);
			boolean resEmail = new MemberDAO().checkPhone(m_email);
			
			PrintWriter out = response.getWriter();
			if(resPhone == false && resEmail == false) {
				out.print("possible");
				out.close();
			}else if(resPhone == true) {
				out.print("phone");
				out.close();
			}else if(resEmail == true) {
				out.print("email");
				out.close();
			}else {
				out.print("not");
				out.close();
			}
			
		return null;
	}

}
