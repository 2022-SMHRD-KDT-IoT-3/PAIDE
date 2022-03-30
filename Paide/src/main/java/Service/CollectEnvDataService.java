package Service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.FarmDAO;
import Model.FarmDTO;

@WebServlet("/CollectEnvDataService")
public class CollectEnvDataService extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF8");
		PrintWriter out = response.getWriter();

		
		int cnt = 0;
		double Window = 0.0;
		double Soil = 0.0;
		double Temp = 0.0;
		double Otemp = 0.0;
		double Humi = 0.0;
		double Ohumi = 0.0;
		double Depo = 0.0;
		double Co2 = 0.0;
		double Sol = 0.0;
		int Fseq = 0;
		String Mid = "";

		Window = Double.parseDouble(request.getParameter("Window"));
		Soil = Double.parseDouble(request.getParameter("GG"));
		Temp = Double.parseDouble(request.getParameter("Temp"));
		Otemp = Double.parseDouble(request.getParameter("Otemp"));
		Humi = Double.parseDouble(request.getParameter("Humi"));
		Ohumi = Double.parseDouble(request.getParameter("Ohumi"));
		Depo = Double.parseDouble(request.getParameter("Depo"));
		Co2 = Double.parseDouble(request.getParameter("Co2"));
		Sol = Double.parseDouble(request.getParameter("Sol"));
		Fseq = Integer.parseInt(request.getParameter("Fseq"));
		Mid = request.getParameter("Mid");
		
		

		FarmDTO dto = new FarmDTO(Fseq, Temp, Otemp, Humi, Ohumi, Soil, Sol, Window, Co2, Depo, Mid);
		
		FarmDAO dao = new FarmDAO();
		
		
		
		cnt = dao.eData(dto);
		
		
		if(cnt > 0) {
			System.out.println("DB등록 성공");
		}else {
			System.out.println("DB등록 실패");
		}

		System.out.println("창문열림 : " + Window + "%");
		System.out.println("토양습도 : " + Soil + "%");
		System.out.println("온도 : " + Temp + "도");
		System.out.println("습도 : " + Humi + "%");
		System.out.println("이슬점 : " + Depo + "도");
		System.out.println("Co2 : " + Co2 + "ppm");
		System.out.println("Sol : " + Sol + "W/m2");
	
	}

}
