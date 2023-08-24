package com.abcjobs.util;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * This Util class provides utility methods for sending emails and managing email functionality.
 */
public class EmailUtil {
	/**
	 * Sends an email to the specified recipient with the given subject and text.
	 *
	 * @param recipient the email address of the recipient
	 * @param subject the subject of the email
	 * @param text the text content of the email
	 * @throws AddressException if the email address is invalid
	 * @throws MessagingException if there is an error sending the email
	 */
	public void send(String recipient, String subject, String text) throws AddressException, MessagingException {
		final String username = "sinyi.20028@gmail.com";
		final String password = "bprdjrnzyuekjeas";

		Properties prop = new Properties();
		prop.put("mail.smtp.host", "smtp.gmail.com");
		prop.put("mail.smtp.port", "587");
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.starttls.enable", "true"); // TLS
		prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");

		Session session = Session.getInstance(prop, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress(username));
		message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
		message.setSubject(subject);
		message.setText(text);

		Transport.send(message);
	}

	/**
	 * Sends a confirmation email to the registrant's email address.
	 *
	 * @param registrantEmail the email address of the registrant
	 * @param registrant the name of the registrant
	 * @throws AddressException if the email address is invalid
	 * @throws MessagingException if there is an error sending the email
	 */
	public void sendConfirmationEmail(String registrantEmail, String registrant)
			throws AddressException, MessagingException {

		String subject = "Welcome to ABC Jobs Community!";
		String loginLink = "http://localhost:8080/community-portal/showLogin";
		String text = "<html><body><p style=\"line-height: 30px;\"><strong>Dear " + registrant
				+ ", </strong><br>We would like to inform you that your ABC Jobs Community Portal account has been successfully registered."
				+ "<br>Click the button below to login with your email address and password to start your journey in our community now!</p>"
				+ "<a style=\"letter-spacing: 2px; background-color: #FB8500; border: 0; border-radius: 3px; color: #fff !important; "
				+ "cursor: pointer; display: inline-block; padding: 12px; text-decoration: none;\" href=\"" + loginLink
				+ "\">LOGIN</a><br><br><p>Thank you and have a great day!</p><br>"
				+ "<p>Your friends from, </p><p style=\"color: #FB8500;\"><strong>ABC Jobs Team</strong></a></body></html>";

		send(registrantEmail, subject, text);
	}

	/**
	 * Sends an email to the registrant's email address to recover their password.
	 *
	 * @param registrantEmail the email address of the registrant
	 * @param registrant the name of the registrant
	 * @throws AddressException if the email address is invalid
	 * @throws MessagingException if there is an error sending the email
	 */
	public void recoverPassword(String registrantEmail, String registrant) throws AddressException, MessagingException {
		String subject = "ABC Jobs Community Portal - Request for Resetting Password";
		String text = "You have been requested for the password change.";

		send(registrantEmail, subject, text);
	}
}
