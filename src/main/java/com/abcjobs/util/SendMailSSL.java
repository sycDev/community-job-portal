package com.abcjobs.util;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class SendMailSSL {

	public static void main(String[] args) {
		final String username = "sinyi.20028@gmail.com";
		final String password = "dxqbzjrqnwcslnnm";

		Properties prop = new Properties();
		prop.put("mail.smtp.host", "smtp.gmail.com");
		prop.put("mail.smtp.port", "465");
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.socketFactory.port", "465");
		prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

		Session session = Session.getInstance(prop, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("sinyi.20028@gmail.com"));
			message.setRecipients(Message.RecipientType.TO,
					InternetAddress.parse("vowopo5800@orgria.com, dilozovo@mailgolem.com"));
			message.setSubject("Testing Gmail SSL");
			message.setText("Hello," + "\n\n It Works! Hooray!");
			
			Transport.send(message);
			System.out.println("Done");
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
}
