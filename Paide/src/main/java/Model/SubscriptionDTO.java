package Model;

public class SubscriptionDTO {

	private int subscription_seq;
	private String subscription_id;
	private int subscriptioned_id;
	private String subscription_date;
	
	private String f_name;
	private String subscript_id;
	
	public SubscriptionDTO(int subscription_seq, String subscription_id, int subscriptioned_id, String subscription_date) {
		super();
		this.subscription_seq = subscription_seq;
		this.subscription_id = subscription_id;
		this.subscriptioned_id = subscriptioned_id;
		this.subscription_date = subscription_date;
	}
	
	//이웃추가/삭제 메소드
		public SubscriptionDTO(String subscription_id, int subscriptioned_id) {
			this.subscription_id = subscription_id;
			this.subscriptioned_id = subscriptioned_id;
		}
		
		//이웃목록 불러오기 메소드
		public SubscriptionDTO(String subscription_id, int subscriptioned_id, String f_name, String subscript_id) {
			super();
			this.subscription_id = subscription_id;
			this.subscriptioned_id = subscriptioned_id;
			this.f_name = f_name;
			this.subscript_id = subscript_id;
		}
	
	
	
	
	public int getSubscriptioned_id() {
		return subscriptioned_id;
	}




	public void setSubscriptioned_id(int subscriptioned_id) {
		this.subscriptioned_id = subscriptioned_id;
	}




	public String getF_name() {
		return f_name;
	}




	public void setF_name(String f_name) {
		this.f_name = f_name;
	}




	public String getSubscript_id() {
		return subscript_id;
	}




	public void setSubscript_id(String subscript_id) {
		this.subscript_id = subscript_id;
	}




	public int getSubscription_seq() {
		return subscription_seq;
	}
	public void setSubscription_seq(int subscription_seq) {
		this.subscription_seq = subscription_seq;
	}
	public String getSubscription_id() {
		return subscription_id;
	}
	public void setSubscription_id(String subscription_id) {
		this.subscription_id = subscription_id;
	}
	public int getFarm_id() {
		return subscriptioned_id;
	}
	public void setFarm_id(int farm_id) {
		this.subscriptioned_id = farm_id;
	}
	public String getSubscription_date() {
		return subscription_date;
	}
	public void setSubscription_date(String subscription_date) {
		this.subscription_date = subscription_date;
	}

}
