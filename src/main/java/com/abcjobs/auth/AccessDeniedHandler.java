package com.abcjobs.auth;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.access.AccessDeniedHandlerImpl;
import org.springframework.stereotype.Service;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collection;

@Service
public class AccessDeniedHandler extends AccessDeniedHandlerImpl {
    // Define array of URLs that should not trigger a redirect
    private static final String[] ANONYMOUS_URIS = { "/", "/showLogin", "/showRegister", "/showForgotPassword" };

    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException e) throws IOException, ServletException {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && !(auth instanceof AnonymousAuthenticationToken)) {
            // User is logged in and not anonymous
            String contextRoot = request.getContextPath();
            String homePage = "/";

            Collection<? extends GrantedAuthority> authorities = auth.getAuthorities();
            for (GrantedAuthority authority : authorities) {
                // Check user's role and set appropriate home page
                if (authority.getAuthority().equals("ROLE_ADMINISTRATOR")) {
                    homePage = "/admin/";
                    break;
                } else if (authority.getAuthority().equals("ROLE_SOFTWARE_PROGRAMMER")) {
                    homePage = "/home";
                    break;
                }
            }

            String requestUri = request.getRequestURI();
            for (String uri : ANONYMOUS_URIS) {
                if (requestUri.equals(contextRoot + uri)) {
                    // Redirect to appropriate home page only if user is trying to access anonymous page
                    response.sendRedirect(contextRoot + homePage);
                    return;
                }
            }
        }

        // Show the custom access denied page for all other cases
        super.setErrorPage("/accessDenied");
        super.handle(request, response, e);
    }
}