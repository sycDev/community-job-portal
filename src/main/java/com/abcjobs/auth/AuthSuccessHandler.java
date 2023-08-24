package com.abcjobs.auth;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collection;

@Component
public class AuthSuccessHandler implements AuthenticationSuccessHandler {
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException {
        String redirectUrl;
        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();

        for (GrantedAuthority grantedAuthority: authorities) {
            String role = grantedAuthority.getAuthority();

            if (role.equals("ROLE_SOFTWARE_PROGRAMMER")) {
                redirectUrl = "/home";
            } else if (role.equals("ROLE_ADMINISTRATOR")) {
                redirectUrl = "/admin/";
            } else {
                redirectUrl = "/accessDenied";
            }

            new DefaultRedirectStrategy().sendRedirect(request, response, redirectUrl);
        }
    }
}
