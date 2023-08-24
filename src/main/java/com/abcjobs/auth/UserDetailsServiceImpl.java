package com.abcjobs.auth;

import com.abcjobs.model.UserAccount;
import com.abcjobs.service.UserAccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class UserDetailsServiceImpl implements UserDetailsService {
    @Autowired
    private UserAccountService userAccountService;

    public UserDetailsServiceImpl() {}

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        UserAccount userAccount = userAccountService.findByEmail(email);
        if (userAccount == null) {
            throw new UsernameNotFoundException("Login user " + email + " is not valid. Please re-enter.");
        }
        User.UserBuilder userBuilder = User.builder();

        String role = userAccount.getRole();

        return userBuilder.username(userAccount.getEmail())
                .password(userAccount.getPassword())
                .roles(role)
                .build();
    }
}
