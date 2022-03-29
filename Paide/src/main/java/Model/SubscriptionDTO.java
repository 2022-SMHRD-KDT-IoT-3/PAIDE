package Model;

public class SubscriptionDTO {

	private int subscription_seq;
	private String subscription_id;
	private int subscriptioned_id;
	private String subscription_date;
	
	public SubscriptionDTO(int subscription_seq, String subscription_id, int subscriptioned_id, String subscription_date) {
		super();
		this.subscription_seq = subscription_seq;
		this.subscription_id = subscription_id;
		this.subscriptioned_id = subscriptioned_id;
		this.subscription_date = subscription_date;
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
