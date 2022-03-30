package Model;

public class SensorVO {

	private String TEMP;
	private String OTEMP;
	private String HUMI;
	private String OHUMI;
	private String CO2;
	private String SOL;
	private String DEPO;
	private String SOIL;
	private String OPEN;
	private String LED;

	public SensorVO(String tEMP, String oTEMP, String hUMI, String oHUMI, String cO2, String sOL, String dEPO,
			String sOIL, String oPEN, String lED) {
		super();
		TEMP = tEMP;
		OTEMP = oTEMP;
		HUMI = hUMI;
		OHUMI = oHUMI;
		CO2 = cO2;
		SOL = sOL;
		DEPO = dEPO;
		SOIL = sOIL;
		OPEN = oPEN;
		LED = lED;
	}

	public SensorVO() {

	}

	public String getLED() {
		return LED;
	}

	public void setLED(String lED) {
		LED = lED;
	}

	public String getTEMP() {
		return TEMP;
	}

	public void setTEMP(String tEMP) {
		TEMP = tEMP;
	}

	public String getOTEMP() {
		return OTEMP;
	}

	public void setOTEMP(String oTEMP) {
		OTEMP = oTEMP;
	}

	public String getHUMI() {
		return HUMI;
	}

	public void setHUMI(String hUMI) {
		HUMI = hUMI;
	}

	public String getOHUMI() {
		return OHUMI;
	}

	public void setOHUMI(String oHUMI) {
		OHUMI = oHUMI;
	}

	public String getCO2() {
		return CO2;
	}

	public void setCO2(String cO2) {
		CO2 = cO2;
	}

	public String getSOL() {
		return SOL;
	}

	public void setSOL(String sOL) {
		SOL = sOL;
	}

	public String getDEPO() {
		return DEPO;
	}

	public void setDEPO(String dEPO) {
		DEPO = dEPO;
	}

	public String getSOIL() {
		return SOIL;
	}

	public void setSOIL(String sOIL) {
		SOIL = sOIL;
	}

	public String getOPEN() {
		return OPEN;
	}

	public void setOPEN(String oPEN) {
		OPEN = oPEN;
	}

}
