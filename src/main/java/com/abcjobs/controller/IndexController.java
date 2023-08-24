package com.abcjobs.controller;

import com.abcjobs.model.ThreadPost;
import com.abcjobs.service.ThreadPostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * The Controller for handling requests related to the index and home page.
 * Provides the method for showing the index page, home page and logging out
 * of the current user session
 * 
 * @author Ch'ng Sin Yi
 */
@Controller
public class IndexController {
	@Autowired
	ThreadPostService threadPostService;

	/**
	 * Show index page which is the Home Landing Page
	 *
	 * @return the name of the appropriate view page
	 */
	@RequestMapping("/")
	public String showIndexPage() {
		return "index";
	}
	
	/**
	 * Show home page
	 *
	 * @return the name of the appropriate view page
	 */
	@RequestMapping("/home")
	public ModelAndView showHomePage() {
		ModelAndView mav = new ModelAndView("home");
		// Retrieve all the thread post records
		List<ThreadPost> threadPostList = threadPostService.getThreadPostsSorted();
		mav.addObject("threadPostList", threadPostList);
		return mav;
	}
}
