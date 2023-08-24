package com.abcjobs.controller;

import com.abcjobs.model.UserProfile;
import com.abcjobs.service.UserProfileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    UserProfileService userProfileService;

    /**
     * Show the administrator home page
     *
     * @return ModelAndView that represents the administrator home page view
     */
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView showAdminHomePage() {
        return new ModelAndView("admin");
    }

    /**
     * Show the administrator page containing the list of user data
     *
     * @return ModelAndView that represents the administrator page view of user data
     */
    @RequestMapping(value = "/users", method = RequestMethod.GET)
    public ModelAndView showAdminUsersPage() {
        ModelAndView mav = new ModelAndView("adminUsers");
        List<UserProfile> userProfileList = userProfileService.findAllUsers();
        mav.addObject("userProfileList", userProfileList);
        return mav;
    }
}
