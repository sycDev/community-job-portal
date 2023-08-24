package com.abcjobs.controller;

import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.validation.Valid;

import com.abcjobs.util.ValidationUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.abcjobs.dto.RegistrationDto;
import com.abcjobs.exception.DuplicateEmailException;
import com.abcjobs.model.Location;
import com.abcjobs.service.LocationService;
import com.abcjobs.service.UserProfileService;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * The Controller that handlers user registration.
 * It provides the methods for showing the register page and
 * registering new user with validation and duplicate email
 * registration checking.
 * 
 * This controller depends on the services provided by the 
 * {@link UserProfileService} for user registration and validation.
 * Uses the {@link LocationService} to retrieve the list of countries
 * and cities for populating the options of location selection in the
 * registration form.
 * 
 * @author Ch'ng Sin Yi
 * @see UserProfileService
 * @see LocationService
 */
@Controller
public class RegisterController {
	@Autowired
	LocationService locationService;

	@Autowired
	UserProfileService userProfileService;

	@Autowired
	PasswordEncoder passwordEncoder;

	/**
	 * Show register page with registration form
	 *
	 * @return ModelAndView object containing the registration form view and 
	 * 		a list of available countries and cities
	 */
	@RequestMapping("/showRegister")
	public ModelAndView showRegisterPage() {
		List<Location> locationList = locationService.getAllLocation();
		ModelAndView mav = new ModelAndView("register");
		mav.addObject("registrationDto", new RegistrationDto());
		mav.addObject("locationList", locationList);
		return mav;
	}

	/**
	 * Register new user
	 *
	 * @param registrationDto the RegistrationDto
	 * @param result the BindingResult object
	 * @param redirectAttributes the RedirectAttributes object
	 * @return Thank You page
	 * @throws DuplicateEmailException the duplicate email exception
	 * @throws AddressException the address exception
	 * @throws MessagingException the messaging exception
	 */
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerUser(@Valid @ModelAttribute("registrationDto") RegistrationDto registrationDto,
							   BindingResult result, RedirectAttributes redirectAttributes) throws DuplicateEmailException, AddressException, MessagingException {

		ValidationUtil validationUtil = new ValidationUtil();
		if (validationUtil.checkValidation(result, redirectAttributes)) {
			return "redirect:/showRegister";
		}
		String encodedPwd = passwordEncoder.encode(registrationDto.getPassword());
		registrationDto.setPassword(encodedPwd);
		userProfileService.register(registrationDto);

		return "redirect:/registerSuccess";
	}

	@RequestMapping("/registerSuccess")
	private String showRegisterSuccessPage() {
		return "registerSuccess";
	}

	/**
	 * Handle duplicate email exception for new user registration
	 *
	 * @param ex the Exception object
	 * @return ModelAndView with the register page view and error message
	 */
	@ExceptionHandler(DuplicateEmailException.class)
	public ModelAndView handleDuplicateEmailException(Exception ex) {
		ModelAndView mav = showRegisterPage();

		mav.addObject("errMsg", ex.getMessage());

		return mav;
	}

	/**
	 * Handle exception
	 *
	 * @param ex the Exception object
	 * @return ModelAndView with the error page view and error message
	 */
	@ExceptionHandler(Exception.class)
	public ModelAndView handleException(Exception ex) {
		ModelAndView mav = new ModelAndView("error");
		mav.addObject("errMsg", ex.getMessage());
		return mav;
	}
}
