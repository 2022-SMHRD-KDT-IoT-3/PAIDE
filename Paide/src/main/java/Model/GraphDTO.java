package Model;

public class GraphDTO {
	
	private double avg_temperature_outer;
	private double avg_humidity_outer;
	private double avg_temperature;
	private double avg_humidity;
	private double avg_insolation;
	private String avg_env_date;
	private double avg_co2;
	private double avg_humidity_soil;
	
	private int env_HL;
	private String time;
	
	public GraphDTO() {
		
	}
	
	//평균그래프 생성자
	public GraphDTO(double avg_temperature_outer, double avg_humidity_outer, double avg_temperature, double avg_humidity,
			double avg_insolation, String avg_env_date) {
		super();
		this.avg_temperature_outer = avg_temperature_outer;
		this.avg_humidity_outer = avg_humidity_outer;
		this.avg_temperature = avg_temperature;
		this.avg_humidity = avg_humidity;
		this.avg_insolation = avg_insolation;
		this.avg_env_date = avg_env_date;
	}
	
	// 두번째 그래프 생성자
	public GraphDTO(double avg_temperature_outer, double avg_humidity_outer, double avg_temperature, double avg_humidity,
			double avg_insolation, double avg_co2, double avg_humidity_soil) {
		super();
		this.avg_temperature_outer = avg_temperature_outer;
		this.avg_humidity_outer = avg_humidity_outer;
		this.avg_temperature = avg_temperature;
		this.avg_humidity = avg_humidity;
		this.avg_insolation = avg_insolation;
		this.avg_co2 = avg_co2;
		this.avg_humidity_soil = avg_humidity_soil;
	}
	
	//최고최저
	public GraphDTO(int env_HL, String time) {
		this.env_HL = env_HL;
		this.time = time;
	}
	


	public int getEnv_HL() {
		return env_HL;
	}

	public void setEnv_HL(int env_HL) {
		this.env_HL = env_HL;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public double getAvg_co2() {
		return avg_co2;
	}


	public void setAvg_co2(int avg_co2) {
		this.avg_co2 = avg_co2;
	}

	public double getAvg_humidity_soil() {
		return avg_humidity_soil;
	}

	public void setAvg_humidity_soil(int avg_humidity_soil) {
		this.avg_humidity_soil = avg_humidity_soil;
	}

	public double getAvg_temperature_outer() {
		return avg_temperature_outer;
	}



	public void setAvg_temperature_outer(int avg_temperature_outer) {
		this.avg_temperature_outer = avg_temperature_outer;
	}


	public double getAvg_humidity_outer() {
		return avg_humidity_outer;
	}


	public void setAvg_humidity_outer(int avg_humidity_outer) {
		this.avg_humidity_outer = avg_humidity_outer;
	}


	public double getAvg_temperature() {
		return avg_temperature;
	}


	public void setAvg_temperature(int avg_temperature) {
		this.avg_temperature = avg_temperature;
	}


	public double getAvg_humidity() {
		return avg_humidity;
	}


	public void setAvg_humidity(int avg_humidity) {
		this.avg_humidity = avg_humidity;
	}


	public double getAvg_insolation() {
		return avg_insolation;
	}


	public void setAvg_insolation(int avg_insolation) {
		this.avg_insolation = avg_insolation;
	}


	public String getAvg_env_date() {
		return avg_env_date;
	}


	public void setAvg_env_date(String avg_env_date) {
		this.avg_env_date = avg_env_date;
	}
	
	
	
	
}

	