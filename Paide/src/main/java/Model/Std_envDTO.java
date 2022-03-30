package Model;

public class Std_envDTO {
	
	private String crop ;
	private int hour;
	private double temp;
	private double humi;


	public Std_envDTO(String crop, int hour, double temp, double humi) {
		super();
		this.crop = crop;
		this.hour = hour;
		this.temp = temp;
		this.humi = humi;
	}
	
	public Std_envDTO(String crop, int hour, double humi) {
		super();
		this.crop = crop;
		this.hour = hour;
		this.humi = humi;
	}
	
	
	public Std_envDTO() {
		
	}
	
	public String getCrop() {
		return crop;
	}

	public void setCrop(String crop) {
		this.crop = crop;
	}

	public int getHour() {
		return hour;
	}

	public void setHour(int hour) {
		this.hour = hour;
	}

	public double getTemp() {
		return temp;
	}

	public void setTemp(double temp) {
		this.temp = temp;
	}

	public double getHumi() {
		return humi;
	}

	public void setHumi(double humi) {
		this.humi = humi;
	}

}
