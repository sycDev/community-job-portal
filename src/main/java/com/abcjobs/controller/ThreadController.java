package com.abcjobs.controller;

import com.abcjobs.model.ThreadPost;
import com.abcjobs.model.UserProfile;
import com.abcjobs.service.ThreadPostService;
import com.abcjobs.service.UserProfileService;
import com.abcjobs.util.ValidationUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.Optional;

@Controller
public class ThreadController {
    @Autowired
    ThreadPostService threadPostService;

    @Autowired
    UserProfileService userProfileService;

    /**
     * Adds a new thread post record
     *
     * @param threadPost the ThreadPost object to be added
     * @param result    the BindingResult object
     * @param redirectAttributes   the RedirectAttributes object
     * @return the User Home Page and message
     */
    @RequestMapping(value = "/createThread", method = RequestMethod.POST)
    public String addThreadPost(@Valid @ModelAttribute("threadPost") ThreadPost threadPost, BindingResult result, RedirectAttributes redirectAttributes) {
        // Get the UserProfile object based on the id
        Optional<UserProfile> currentProfile = userProfileService.findByCurrentUserAccount();

        if (currentProfile.isPresent()) {
            UserProfile userProfile = currentProfile.get();
            threadPost.setUserProfile(userProfile);

            ValidationUtil validationUtil = new ValidationUtil();
            if (validationUtil.checkValidation(result, redirectAttributes)) return "redirect:/home";

            // Pass the form input to Service to create new record
            threadPostService.create(threadPost, userProfile.getProfileId());

            // Add a success flash attribute
            redirectAttributes.addFlashAttribute("successMsg", "Thread posted successfully");

            // Redirect to the User Home page
            return "redirect:/home";
        }
        // Add a error flash attribute
        redirectAttributes.addFlashAttribute("errMsg", "Error occurred");

        // Redirect to the User Home page
        return "redirect:/home";
    }
}
