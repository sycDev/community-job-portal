package com.abcjobs.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Controller for rendering error pages with corresponding error messages
 * 
 * @author Ch'ng Sin Yi
 */
@Controller
public class AppErrorController {
    /**
     * Render error page with corresponding error message
     *
     * @param httpRequest the HttpServletRequest object
     * @return ModelAndView with the error page view and error message
     */
    @RequestMapping(value = "errors", method = RequestMethod.GET)
    public ModelAndView renderErrorPage(HttpServletRequest httpRequest) {

        ModelAndView errorPage = new ModelAndView("error");
        String errorMsg = "";
        int httpErrorCode = getErrorCode(httpRequest);

        switch (httpErrorCode) {
            case 400: {
                errorMsg = "Http Error Code: 400. Bad Request";
                break;
            }
            case 401: {
                errorMsg = "Http Error Code: 401. Unauthorized";
                break;
            }
            case 404: {
                errorMsg = "Http Error Code: 404. Resource not found";
                break;
            }
            case 500: {
                errorMsg = "Http Error Code: 500. Internal Server Error";
                break;
            }
        }
        errorPage.addObject("errorMsg", errorMsg);
        return errorPage;
    }

    /**
     * Gets the error code
     *
     * @param httpRequest the HttpServletRequest object
     * @return the error code
     */
    private int getErrorCode(HttpServletRequest httpRequest) {
        return (Integer) httpRequest
                .getAttribute("javax.servlet.error.status_code");
    }

    /**
     * Render the access denied page
     *
     * @return the access denied page
     */
    @RequestMapping("/accessDenied")
    public String showAccessDeniedPage() {
        return "accessDenied";
    }
}
