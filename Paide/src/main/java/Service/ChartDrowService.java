package Service;

import java.util.ArrayList;

import Model.FarmDAO;
import Model.FarmDTO;
import Model.GraphDTO;

public class ChartDrowService {
	
	FarmDTO dto = new FarmDTO();
	FarmDAO dao = new FarmDAO();
	GraphDTO gdto = new GraphDTO();
	
	// 1일 그래프 그리기
	public String timedrow(int seq, String date) {
		ArrayList<FarmDTO> timelist = new ArrayList<>();
		String result ="";
		timelist = dao.envGraph(date, seq);
		
		if(timelist.size() == 0) {
			result = "0";
		}else {

		System.out.println(timelist.get(0).getEnv_date());
		result = "'" + timelist.get(0).getEnv_date() + "'";

		for (int i = 1; i < timelist.size(); i++) {
			result += ", '" + timelist.get(i).getEnv_date() + "'";
		}
		}
		return result;
	}
	
	public String tempdrow(int seq, String date) {
		ArrayList<FarmDTO> templist = new ArrayList<>();
		String result ="";
		templist = dao.envGraph(date, seq);
		
		if(templist.size() == 0) {
			result = "0";
		}else {

		System.out.println(templist.get(0).getTemperature());
		result = "" + templist.get(0).getTemperature();

		for (int i = 1; i < templist.size(); i++) {
			result += ", " + templist.get(i).getTemperature();
		}
		}
		return result;
	}
	
	public String humidrow(int seq, String date) {
		ArrayList<FarmDTO> humilist = new ArrayList<>();
		String result ="";
		humilist = dao.envGraph(date, seq);
		
		if(humilist.size() == 0) {
			result = "0";
		}else {

		System.out.println(humilist.get(0).getHumidity());
		result = "" + humilist.get(0).getHumidity();

		for (int i = 1; i < humilist.size(); i++) {
			result += ", " + humilist.get(i).getHumidity();
		}
		}
		return result;
	}
	
	public String outtempdrow(int seq, String date) {
		ArrayList<FarmDTO> outtemplist = new ArrayList<>();
		String result ="";
		outtemplist = dao.envGraph(date, seq);
		
		if(outtemplist.size() == 0) {
			result = "0";
		}else {

		System.out.println(outtemplist.get(0).getTemperature_outer());
		result = "" + outtemplist.get(0).getTemperature_outer();

		for (int i = 1; i < outtemplist.size(); i++) {
			result += ", " + outtemplist.get(i).getTemperature_outer();
		}
		}
		return result;
	}
	
	public String outhumidrow(int seq, String date) {
		ArrayList<FarmDTO> outhumilist = new ArrayList<>();
		String result ="";
		outhumilist = dao.envGraph(date, seq);
		
		if(outhumilist.size() == 0) {
			result = "0";
		}else {

		System.out.println(outhumilist.get(0).getHumidity_outer());
		result = "" + outhumilist.get(0).getHumidity_outer();

		for (int i = 1; i < outhumilist.size(); i++) {
			result += ", " + outhumilist.get(i).getHumidity_outer();
		}
		}
		return result;
	}
	
	public String soildrow(int seq, String date) {
		ArrayList<FarmDTO> soillist = new ArrayList<>();
		String result ="";
		soillist = dao.envGraph(date, seq);
		
		if(soillist.size() == 0) {
			result = "0";
		}else {

		System.out.println(soillist.get(0).getHumidity_soil());
		result = "" + soillist.get(0).getHumidity_soil();

		for (int i = 1; i < soillist.size(); i++) {
			result += ", " + soillist.get(i).getHumidity_soil();
		}
		}
		return result;
	}
	
	public String depodrow(int seq, String date) {
		ArrayList<FarmDTO> depolist = new ArrayList<>();
		String result ="";
		depolist = dao.envGraph(date, seq);
		
		if(depolist.size() == 0) {
			result = "0";
		}else {

		System.out.println(depolist.get(0).getDew_point());
		result = "" + depolist.get(0).getDew_point();

		for (int i = 1; i < depolist.size(); i++) {
			result += ", " + depolist.get(i).getDew_point();
		}
		}
		return result;
	}
	
	public String windowdrow(int seq, String date) {
		ArrayList<FarmDTO> windowlist = new ArrayList<>();
		String result ="";
		windowlist = dao.envGraph(date, seq);
		
		if(windowlist.size() == 0) {
			result = "0";
		}else {

		System.out.println(windowlist.get(0).getWindow_opened());
		result = "" + windowlist.get(0).getWindow_opened();

		for (int i = 1; i < windowlist.size(); i++) {
			result += ", " + windowlist.get(i).getWindow_opened();
		}
		}
		return result;
	}
	
	public String co2drow(int seq, String date) {
		ArrayList<FarmDTO> co2list = new ArrayList<>();
		String result ="";
		co2list = dao.envGraph(date, seq);
		
		if(co2list.size() == 0) {
			result = "0";
		}else {

		System.out.println(co2list.get(0).getCo2());
		result = "" + co2list.get(0).getCo2();

		for (int i = 1; i < co2list.size(); i++) {
			result += ", " + co2list.get(i).getCo2();
		}
		}
		return result;
	}
	
	public String isoldrow(int seq, String date) {
		ArrayList<FarmDTO> isollist = new ArrayList<>();
		String result ="";
		isollist = dao.envGraph(date, seq);
		
		if(isollist.size() == 0) {
			result = "0";
		}else {

		System.out.println(isollist.get(0).getInsolation());
		result = "" + isollist.get(0).getInsolation();

		for (int i = 1; i < isollist.size(); i++) {
			result += ", " + isollist.get(i).getInsolation();
		}
		}
		return result;
	}
	

}
