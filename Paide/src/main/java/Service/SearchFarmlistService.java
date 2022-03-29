package Service;

import java.io.IOException;
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
		
		String[] crop = request.getParameterValues("crops");
		String[] region = request.getParameterValues("regions");
		String[] fac = request.getParameterValues("facs");
		
//		StringBuilder sb_c = new StringBuilder();
//		StringBuilder sb_r = new StringBuilder();
//		StringBuilder sb_f = new StringBuilder();
		
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
		
		ArrayList<FarmDTO> farmlist = new FarmDAO().SearchFarm(crops, regions, facs);
		
		return null;
	}

}
