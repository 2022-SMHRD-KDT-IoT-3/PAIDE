package Model;

public class MemberDTO {
	private String m_id; //ȸ�� ���̵�
	private String m_pw; //ȸ�� ���
	private String m_name; //ȸ�� �̸�
	private String m_phone; // ��ȭ��ȣ
	private int m_score; //����
	private String m_level; //����
	private String m_email; //�̸���
	private String m_joindate; //��������
	private String m_type; //����(�������, �Ϲݻ��������)
	
	//������
	public MemberDTO(String m_id, String m_pw, String m_name, String m_phone, int m_score, String m_level,
			String m_email, String m_joindate, String m_type) {
		this.m_id = m_id;
		this.m_pw = m_pw;
		this.m_name = m_name;
		this.m_phone = m_phone;
		this.m_score = m_score;
		this.m_level = m_level;
		this.m_email = m_email;
		this.m_joindate = m_joindate;
		this.m_type = m_type;
	}
	
	
	//ȸ������ ������
	public MemberDTO(String m_id, String m_pw, String m_name, String m_phone, String m_email, String m_joindate) {
		this.m_id = m_id;
		this.m_pw = m_pw;
		this.m_name = m_name;
		this.m_phone = m_phone;
		this.m_email = m_email;
		this.m_joindate = m_joindate;
	}
	
	

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public String getM_pw() {
		return m_pw;
	}

	public void setM_pw(String m_pw) {
		this.m_pw = m_pw;
	}

	public String getM_name() {
		return m_name;
	}

	public void setM_name(String m_name) {
		this.m_name = m_name;
	}

	public String getM_phone() {
		return m_phone;
	}

	public void setM_phone(String m_phone) {
		this.m_phone = m_phone;
	}

	public int getM_score() {
		return m_score;
	}

	public void setM_score(int m_score) {
		this.m_score = m_score;
	}

	public String getM_level() {
		return m_level;
	}

	public void setM_level(String m_level) {
		this.m_level = m_level;
	}

	public String getM_email() {
		return m_email;
	}

	public void setM_email(String m_email) {
		this.m_email = m_email;
	}

	public String getM_joindate() {
		return m_joindate;
	}

	public void setM_joindate(String m_joindate) {
		this.m_joindate = m_joindate;
	}

	public String getM_type() {
		return m_type;
	}

	public void setM_type(String m_type) {
		this.m_type = m_type;
	}
	
	
	
	
}
