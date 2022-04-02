package Service;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Inter.Command;
import Model.FarmDAO;
import Model.FarmDTO;

public class SearchFarmlistService implements Command{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("[SearchFarmlistService]");
		
		String[] crop = request.getParameterValues("f_crops");
		String[] region = request.getParameterValues("f_region");
		String[] fac = request.getParameterValues("f_facility");
		

		
		String crops = ","+crop[0];
		for(int i = 1 ; i<crop.length; i++) {
			crops += "," + crop[i];
		}
		crops += ",";
		String regions = ","+region[0];
		for(int i = 1 ; i<region.length; i++) {
			regions += "," + region[i];
		}
		regions +=",";
		String facs = ","+fac[0];
		for(int i = 1 ; i<fac.length; i++) {
			facs += "," + fac[i];
		}
		facs += ",";
		System.out.println(crops);
		System.out.println(regions);
		System.out.println(facs);
		
		//ArrayList<FarmDTO> farmlist = new FarmDAO().SearchFarm(crops, regions, facs);
		response.setContentType("text/html; charset=UTF-8");
		String nextpage="farmSelect_Choice.jsp?crops="+URLEncoder.encode(crops, StandardCharsets.UTF_8)+"&regions="+URLEncoder.encode(regions, StandardCharsets.UTF_8)+"&facs="+URLEncoder.encode(facs, StandardCharsets.UTF_8);
		return nextpage;
	}

}
