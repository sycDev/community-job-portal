package com.abcjobs.controller;

//import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
//import org.springframework.mail.javamail.JavaMailSender;

public class EmailController {
	//@Autowired private JavaMailSender mailSender;
	
	public void sendEmail () {
		SimpleMailMessage vEmail = new SimpleMailMessage();
		vEmail.setFrom("Sender email");
		vEmail.setTo("receiver eamil"); // normally setTo(email);
		vEmail.setSubject("Verification Code For Resetting Your Password");
		vEmail.setText("Your password has been reset" );
		//mailSender.send(vEmail);
		
	}
}
