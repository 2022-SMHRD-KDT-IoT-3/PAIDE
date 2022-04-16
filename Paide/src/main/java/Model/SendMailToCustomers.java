package Model;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SendMailToCustomers extends Authenticator{
	
	PasswordAuthentication pa;
	
	public SendMailToCustomers() {
		String mail_id = "paide0411@gmail.com";
		String mail_pw = "";
		
		pa = new PasswordAuthentication(mail_id, mail_pw);
		
	}
	
	public PasswordAuthentication getPasswordAuthentication() {
		return pa;
	}
	
}