package Model;

public class CommunityDTO {
	//게시글작성
	private int article_seq; //글 순번
	private String article_title; //글 제목
	private String article_content; //글 내용
	private String article_file; //글 첨부파일이름
	private String article_date; //글 작성일자
	private String m_id; // 작성자
	private String article_category; //카테고리
	
	//댓글
	private int cmt_seq; //댓글 순번
	private String cmt_content; //댓글 내용
	private String cmt_date; //댓글 작성일자
	private int cmt_like; //좋아요 수
	

	//게시글작성 생성자
	public CommunityDTO(int article_seq,String article_title, String article_content, String article_file,
			String article_date, String m_id, String article_category) {
		this.article_seq = article_seq;
		this.article_title = article_title;
		this.article_content = article_content;
		this.article_file = article_file;
		this.article_date = article_date;
		this.m_id = m_id;
		this.article_category = article_category;
	}
	
	//댓글 생성자
	public CommunityDTO(int cmt_seq, int article_seq, String cmt_content, String cmt_date, String m_id, int cmt_like) {
		this.article_seq = article_seq;
		this.m_id = m_id;
		this.cmt_seq = cmt_seq;
		this.cmt_content = cmt_content;
		this.cmt_date = cmt_date;
		this.cmt_like = cmt_like;
	}
	
	
	// 왜 있는 건지 모르겠지만 일단 추가(현지)
	public CommunityDTO(int article_seq, String article_title, String article_date, String m_id, String article_category) {
		this.article_seq = article_seq;
		this.article_title = article_title;
		this.article_date = article_date;
		this.m_id = m_id;
		this.article_category = article_category;
	}
	
	
	
	public CommunityDTO() {
		super();
	}

	public void setArticle_category(String article_category) {
		this.article_category = article_category;
	}
	

	public int getArticle_seq() {
		return article_seq;
	}


	public void setArticle_seq(int article_seq) {
		this.article_seq = article_seq;
	}

	public String getArticle_title() {
		return article_title;
	}

	public void setArticle_title(String article_title) {
		this.article_title = article_title;
	}

	public String getArticle_content() {
		return article_content;
	}

	public void setArticle_content(String article_content) {
		this.article_content = article_content;
	}

	public String getArticle_file() {
		return article_file;
	}

	public void setArticle_file(String article_file) {
		this.article_file = article_file;
	}

	public String getArticle_date() {
		return article_date;
	}

	public void setArticle_date(String article_date) {
		this.article_date = article_date;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public String getArticle_category() {
		return article_category;
	}


	public int getCmt_seq() {
		return cmt_seq;
	}

	public void setCmt_seq(int cmt_seq) {
		this.cmt_seq = cmt_seq;
	}

	public String getCmt_content() {
		return cmt_content;
	}

	public void setCmt_content(String cmt_content) {
		this.cmt_content = cmt_content;
	}

	public String getCmt_date() {
		return cmt_date;
	}

	public void setCmt_date(String cmt_date) {
		this.cmt_date = cmt_date;
	}

	public int getCmt_like() {
		return cmt_like;
	}

	public void setCmt_like(int cmt_like) {
		this.cmt_like = cmt_like;
	}
	
}
