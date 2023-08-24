package com.abcjobs.controller;

import com.abcjobs.model.Education;
import com.abcjobs.model.Location;
import com.abcjobs.model.UserProfile;
import com.abcjobs.service.*;
import com.abcjobs.util.ValidationUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.List;
import java.util.Optional;

/**
 * The Controller class handles HTTP requests related to user profiles.
 * It provides the methods for showing the forgot password page, profile
 * page, update profile details included the education details.
 * <p>
 * This controller depends on the services provided by the
 * {@link UserAccountService}, {@link UserProfileService} for the update
 * profile process.
 * <p>
 * Uses the {@link LocationService} to retrieve the list of countries
 * and cities for populating the options of location selection in the
 * update profile basic details form.
 * <p>
 * {@link EducationService} for managing and retrieve all the education
 * records of the current user.
 *
 * @author Ch'ng Sin Yi
 * @see UserAccountService
 * @see UserProfileService
 * @see LocationService
 * @see EducationService
 */
@Controller
public class UserController {
    @Autowired
    UserProfileService userProfileService;

    @Autowired
    UserAccountService userAccountService;

    @Autowired
    LocationService locationService;

    @Autowired
    EducationService educationService;

    /**
     * Show the forgot password page
     *
     * @return ModelAndView object that contain the view name of forgot password page
     */
    @RequestMapping("/showForgotPassword")
    public ModelAndView showForgotPasswordPage() {
        return new ModelAndView("forgotPassword");
    }

    /**
     * Display the user profile page
     *
     * @return ModelAndView object that represents the user's profile page
     */
    @RequestMapping(value = "/viewProfile", method = RequestMethod.GET)
    public ModelAndView viewProfile() {
        ModelAndView mav = new ModelAndView("profile");
        Optional<UserProfile> currentProfile = userProfileService.findByCurrentUserAccount();
        if (currentProfile.isPresent()) {
            UserProfile userProfile = currentProfile.get();

            // Get the list of location for the selection dropdown
            List<Location> locationList = locationService.getAllLocation();

            // Retrieve all the education records of the current user
            List<Education> educationList = educationService.getEducationsByProfileIdSorted(userProfile.getProfileId());

            mav.addObject("locationList", locationList);
            mav.addObject("userProfile", userProfile);
            mav.addObject("educationList", educationList);
            mav.addObject("education", new Education());
        } else {
            mav.addObject("errMsg", "User profile not found");
        }

        return mav;
    }

    /**
     * Update the user's basic profile details
     *
     * @param userProfile the UserProfile to be updated
     * @param result      the BindingResult object
     * @param redirectAttributes   the RedirectAttributes object
     * @return the User Profile Page and message
     */
    @RequestMapping(value = "/updateProfile", method = RequestMethod.POST)
    public String updateProfile(@Valid @ModelAttribute("userProfile") UserProfile userProfile, BindingResult result, RedirectAttributes redirectAttributes) {
        // Get the UserProfile object based on the id
        Optional<UserProfile> currentProfile = userProfileService.findByCurrentUserAccount();

        if (currentProfile.isPresent()) {
            UserProfile profile = currentProfile.get();
            userProfile.setUserAccount(profile.getUserAccount());
            userProfile.setProfileId(profile.getProfileId());

            ValidationUtil validationUtil = new ValidationUtil();
            if (validationUtil.checkValidation(result, redirectAttributes)) return "redirect:/viewProfile";

            // Get the location by the location id
            Optional<Location> selectedLocation = locationService.getLocationById(userProfile.getLocation().getLocationId());
            if (selectedLocation.isPresent()) {
                Location location = selectedLocation.get();
                userProfile.setLocation(location);
            }

            // Pass the form input to Service to update current user profile details
            userProfileService.update(userProfile);

            // Add a success flash attribute
            redirectAttributes.addFlashAttribute("successMsg", "Profile updated successfully");

            // Redirect to the Profile page
            return "redirect:/viewProfile";
        }
        // Add a error flash attribute
        redirectAttributes.addFlashAttribute("errMsg", "Error occurred");

        // Redirect to the Profile page
        return "redirect:/viewProfile";
    }

    /**
     * Adds a new education record for the user
     *
     * @param education the Education object to be added
     * @param result    the BindingResult object
     * @param redirectAttributes   the RedirectAttributes object
     * @return the User Profile Page and message
     */
    @RequestMapping(value = "/addEducation", method = RequestMethod.POST)
    public String addEducation(@Valid @ModelAttribute("education") Education education, BindingResult result, RedirectAttributes redirectAttributes) {
        // Get the UserProfile object based on the id
        Optional<UserProfile> currentProfile = userProfileService.findByCurrentUserAccount();

        if (currentProfile.isPresent()) {
            UserProfile userProfile = currentProfile.get();
            education.setUserProfile(userProfile);

            ValidationUtil validationUtil = new ValidationUtil();
            if (validationUtil.checkValidation(result, redirectAttributes)) return "redirect:/viewProfile";

            // Pass the form input to Service to create new record
            educationService.create(education, userProfile.getProfileId());

            // Add a success flash attribute
            redirectAttributes.addFlashAttribute("successMsg", "Education added successfully");

            // Redirect to the Profile page
            return "redirect:/viewProfile";
        }
        // Add a error flash attribute
        redirectAttributes.addFlashAttribute("errMsg", "Error occurred");

        // Redirect to the Profile page
        return "redirect:/viewProfile";
    }

    /**
     * Update the user's basic profile details
     *
     * @param education the UserProfile to be updated
     * @param result      the BindingResult object
     * @param redirectAttributes   the RedirectAttributes object
     * @return the User Profile Page and message
     */
    @RequestMapping(value = "/updateEducation", method = RequestMethod.POST)
    public String updateEducation(@Valid @ModelAttribute("education") Education education, BindingResult result, RedirectAttributes redirectAttributes) {
        // Get the UserProfile object based on the id
        Optional<UserProfile> currentProfile = userProfileService.findByCurrentUserAccount();

        if (currentProfile.isPresent()) {
            UserProfile profile = currentProfile.get();
            education.setUserProfile(profile);

            ValidationUtil validationUtil = new ValidationUtil();
            if (validationUtil.checkValidation(result, redirectAttributes)) return "redirect:/viewProfile";

            // Pass the form input to Service to update existing education record
            educationService.update(education);

            // Add a success flash attribute
            redirectAttributes.addFlashAttribute("successMsg", "Education updated successfully");

            // Redirect to the Profile page
            return "redirect:/viewProfile";
        }
        // Add a error flash attribute
        redirectAttributes.addFlashAttribute("errMsg", "Error occurred");

        // Redirect to the Profile page
        return "redirect:/viewProfile";
    }

    /**
     * Delete one education record
     *
     * @param eduId              the education id to be deleted
     * @param redirectAttributes the RedirectAttributes object
     * @return the User Profile Page and message
     */
    @RequestMapping(value = "/deleteEducation", method = RequestMethod.DELETE)
    public String deleteEducation(@RequestParam("eduId") Long eduId, RedirectAttributes redirectAttributes) {
        // Get the UserProfile object based on the id
        Optional<UserProfile> currentProfile = userProfileService.findByCurrentUserAccount();
        if (currentProfile.isPresent()) {
            // Pass the selected education object to Service to delete the record
            educationService.deleteById(eduId);

            // Add a success flash attribute
            redirectAttributes.addFlashAttribute("successMsg", "Education deleted successfully");

            // Redirect to the Profile page
            return "redirect:/viewProfile";
        }
        // Add a error flash attribute
        redirectAttributes.addFlashAttribute("errMsg", "Error occurred");

        // Redirect to the Profile page
        return "redirect:/viewProfile";
    }

    /**
     * Show search results page with the list of users found based on the keyword input by user
     *
     * @param keyword the searching keyword
     * @return the model and view of Search Results Page and total number of users found
     */
    @RequestMapping("/search")
    public ModelAndView showSearchResults(@RequestParam("q") String keyword) {
        ModelAndView mav = new ModelAndView();
        // Retrieve all the user profile that matched the keyword searched
        List<UserProfile> userResultList = userProfileService.searchUserProfile(keyword);
        mav.setViewName("search");
        mav.addObject("totalUserFound", userResultList.size());
        mav.addObject("userResultList", userResultList);
        return mav;
    }

    /**
     * Show the correspond Public Profile page
     *
     * @param profileId the correspond user profile id
     * @return ModelAndView object that contain the view name of Public Profile page
     */
    @RequestMapping("/profile/{profileId}")
    public ModelAndView showPublicProfilePage(@PathVariable("profileId") Long profileId) {
        ModelAndView mav = new ModelAndView();
        Optional<UserProfile> selectedUser = userProfileService.findByProfileId(profileId);
        if (selectedUser.isPresent()) {
            UserProfile userProfile = selectedUser.get();
            // Retrieve all the education records of the current user
            List<Education> educationList = educationService.getEducationsByProfileIdSorted(userProfile.getProfileId());

            mav.addObject("userProfile", userProfile);
            mav.addObject("educationList", educationList);
            mav.setViewName("publicProfile");
        }
        return mav;
    }
}
