package Model;

public class ChartDTO {
	//��Ʈ����
	private int chart_seq; //��Ʈ ����
	private String chart_title; //��Ʈ ����
	private String chart_content; //��Ʈ ����
	private String chart_date; //��Ʈ ��������
	
	//��Ʈ���
	private int ccmt_seq; //��Ʈ��� ����
	private String ccmt_content; //��Ʈ��� ����
	private String ccmt_date; //��Ʈ��� �ۼ�����
	private String m_id; //��Ʈ��� �ۼ���
	private int likes; //���ƿ� ��
	
	//��Ʈ������
	public ChartDTO(int chart_seq, String chart_title, String chart_content, String chart_date) {
		super();
		this.chart_seq = chart_seq;
		this.chart_title = chart_title;
		this.chart_content = chart_content;
		this.chart_date = chart_date;
	}

	//��Ʈ��� ������
	public ChartDTO(int chart_seq, int ccmt_seq, String ccmt_content, String ccmt_date, String m_id, int likes) {
		super();
		this.chart_seq = chart_seq;
		this.ccmt_seq = ccmt_seq;
		this.ccmt_content = ccmt_content;
		this.ccmt_date = ccmt_date;
		this.m_id = m_id;
		this.likes = likes;
	}

	public int getChart_seq() {
		return chart_seq;
	}

	public void setChart_seq(int chart_seq) {
		this.chart_seq = chart_seq;
	}

	public String getChart_title() {
		return chart_title;
	}

	public void setChart_title(String chart_title) {
		this.chart_title = chart_title;
	}

	public String getChart_content() {
		return chart_content;
	}

	public void setChart_content(String chart_content) {
		this.chart_content = chart_content;
	}

	public String getChart_date() {
		return chart_date;
	}

	public void setChart_date(String chart_date) {
		this.chart_date = chart_date;
	}

	public int getCcmt_seq() {
		return ccmt_seq;
	}

	public void setCcmt_seq(int ccmt_seq) {
		this.ccmt_seq = ccmt_seq;
	}

	public String getCcmt_content() {
		return ccmt_content;
	}

	public void setCcmt_content(String ccmt_content) {
		this.ccmt_content = ccmt_content;
	}

	public String getCcmt_date() {
		return ccmt_date;
	}

	public void setCcmt_date(String ccmt_date) {
		this.ccmt_date = ccmt_date;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public int getLikes() {
		return likes;
	}

	public void setLikes(int likes) {
		this.likes = likes;
	}
	
	
	
	
	
	
	
	

	
}
