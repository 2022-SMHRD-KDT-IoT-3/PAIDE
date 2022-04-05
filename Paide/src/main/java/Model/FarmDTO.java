package Model;

public class FarmDTO {
	private int f_seq;
	private String f_owner_id;
	private String f_region;
	private String f_crops;
	private String f_facility;
	private String f_date;
	private String f_name;
	
	// 농장등록 생성자 > t_farm
	public FarmDTO(String f_owner_id, String f_region, String f_crops, String f_facility, String f_name) {
		super();
		this.f_owner_id = f_owner_id;
		this.f_region = f_region;
		this.f_crops = f_crops;
		this.f_facility = f_facility;
		this.f_name = f_name;
	}
	
	
	public FarmDTO(int f_seq, String f_owner_id, String f_region, String f_crops, String f_facility, String f_date,
			String f_name) {
		super();
		this.f_seq = f_seq;
		this.f_owner_id = f_owner_id;
		this.f_region = f_region;
		this.f_crops = f_crops;
		this.f_facility = f_facility;
		this.f_date = f_date;
		this.f_name = f_name;
	}


	private int env_seq;
	private double temperature;
	private double temperature_outer;
	private double humidity;
	private double humidity_outer;
	private double humidity_soil;
	private double insolation;
	private double window_opened;
	private double co2;
	private double dew_point;
	private String env_date;
	private String m_id;
	
	// 농장환경 생성자 > t_env
	public FarmDTO(int f_seq, int env_seq, double temperature, double temperature_outer, double humidity,
			double humidity_outer, double humidity_soil, double insolation, double window_opened, double co2, double dew_point,
			String env_date, String m_id) {
		this.f_seq = f_seq;
		this.env_seq = env_seq;
		this.temperature = temperature;
		this.temperature_outer = temperature_outer;
		this.humidity = humidity;
		this.humidity_outer = humidity_outer;
		this.humidity_soil = humidity_soil;
		this.insolation = insolation;
		this.window_opened = window_opened;
		this.co2 = co2;
		this.dew_point = dew_point;
		this.env_date = env_date;
		this.m_id = m_id;
	}
	
	// 농장환경 생성자 (수집기 -> DB)
	public FarmDTO(int f_seq, double temperature, double temperature_outer, double humidity, double humidity_outer,
			double humidity_soil, double insolation, double window_opened, double co2, double dew_point,
			 String m_id) {
		super();

		this.f_seq = f_seq;
		this.temperature = temperature;
		this.temperature_outer = temperature_outer;
		this.humidity = humidity;
		this.humidity_outer = humidity_outer;
		this.humidity_soil = humidity_soil;
		this.insolation = insolation;
		this.window_opened = window_opened;
		this.co2 = co2;
		this.dew_point = dew_point;
		this.m_id = m_id;
	}
	
	
	//농장검색 생성자
	public FarmDTO(int f_seq, String f_owner_id, String f_region, String f_crops, String f_facility, String f_name) {
		super();
		this.f_seq = f_seq;
		this.f_owner_id = f_owner_id;
		this.f_name = f_name;
		this.f_region = f_region;
		this.f_crops = f_crops;
		this.f_facility = f_facility;
	}
	
	// 농장 상세보기 생성자
	public FarmDTO(int f_seq, String f_owner_id, String f_region, String f_crops, String f_facility, String f_name,
			int env_seq, double temperature, double temperature_outer, double humidity, double humidity_outer,
			double humidity_soil, double insolation, double window_opened, double co2, double dew_point, String env_date) {
		super();
		this.f_seq = f_seq;
		this.f_owner_id = f_owner_id;
		this.f_name = f_name;
		this.f_region = f_region;
		this.f_crops = f_crops;
		this.f_facility = f_facility;
		this.f_name = f_name;
		this.env_seq = env_seq;
		this.temperature = temperature;
		this.temperature_outer = temperature_outer;
		this.humidity = humidity;
		this.humidity_outer = humidity_outer;
		this.humidity_soil = humidity_soil;
		this.insolation = insolation;
		this.window_opened = window_opened;
		this.co2 = co2;
		this.dew_point = dew_point;
		this.env_date = env_date;
	}
	
	//꺾은선 그래프 생성자
	public FarmDTO(double temperature, double temperature_outer, double humidity, double humidity_outer,
			double humidity_soil, double insolation, double window_opened, double co2, double dew_point,
			String env_date, int f_seq) {
		super();
		this.temperature = temperature;
		this.temperature_outer = temperature_outer;
		this.humidity = humidity;
		this.humidity_outer = humidity_outer;
		this.humidity_soil = humidity_soil;
		this.insolation = insolation;
		this.window_opened = window_opened;
		this.co2 = co2;
		this.dew_point = dew_point;
		this.env_date = env_date;
		this.f_seq = f_seq;
	}
	



	public String getF_name() {
		return f_name;
	}


	public void setF_name(String f_name) {
		this.f_name = f_name;
	}


	public int getF_seq() {
		return f_seq;
	}


	public double getDew_point() {
		return dew_point;
	}


	public void setDew_point(double dew_point) {
		this.dew_point = dew_point;
	}


	public String getM_id() {
		return m_id;
	}


	public void setM_id(String m_id) {
		this.m_id = m_id;
	}


	public void setF_seq(int f_seq) {
		this.f_seq = f_seq;
	}
	public String getF_owner_id() {
		return f_owner_id;
	}
	public void setF_owner_id(String f_owner_id) {
		this.f_owner_id = f_owner_id;
	}
	public String getF_region() {
		return f_region;
	}
	public void setF_region(String f_region) {
		this.f_region = f_region;
	}
	public String getF_crops() {
		return f_crops;
	}
	public void setF_crops(String f_crops) {
		this.f_crops = f_crops;
	}
	public String getF_facility() {
		return f_facility;
	}
	public void setF_facility(String f_facility) {
		this.f_facility = f_facility;
	}
	public String getF_date() {
		return f_date;
	}
	public void setF_date(String f_date) {
		this.f_date = f_date;
	}
	public int getEnv_seq() {
		return env_seq;
	}
	public void setEnv_seq(int env_seq) {
		this.env_seq = env_seq;
	}
	public double getTemperature() {
		return temperature;
	}
	public void setTemperature(double temperature) {
		this.temperature = temperature;
	}
	public double getTemperature_outer() {
		return temperature_outer;
	}
	public void setTemperature_outer(double temperature_outer) {
		this.temperature_outer = temperature_outer;
	}
	public double getHumidity() {
		return humidity;
	}
	public void setHumidity(double humidity) {
		this.humidity = humidity;
	}
	public double getHumidity_outer() {
		return humidity_outer;
	}
	public void setHumidity_outer(double humidity_outer) {
		this.humidity_outer = humidity_outer;
	}
	public double getHumidity_soil() {
		return humidity_soil;
	}
	public void setHumidity_soil(double humidity_soil) {
		this.humidity_soil = humidity_soil;
	}
	public double getInsolation() {
		return insolation;
	}
	public void setInsolation(double insolation) {
		this.insolation = insolation;
	}
	public double getWindow_opened() {
		return window_opened;
	}
	public void setWindow_opened(double window_opened) {
		this.window_opened = window_opened;
	}
	public double getCo2() {
		return co2;
	}
	public void setCo2(double co2) {
		this.co2 = co2;
	}
	public String getEnv_date() {
		return env_date;
	}
	public void setEnv_date(String env_date) {
		this.env_date = env_date;
	}
	
	
}
