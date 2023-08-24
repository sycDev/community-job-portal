package com.abcjobs.controller;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;

/**
 * The Controller that handlers user login.
 * It provides the methods for showing the login page.
 * 
 * @author Ch'ng Sin Yi
 */
@Controller
public class LoginController {
	/**
	 * Shows the login page
	 *
	 * @return the name of the appropriate view page
	 */
	@RequestMapping("/showLogin")
	public String showLoginPage() {
		return "login";
	}
}
