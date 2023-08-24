package com.abcjobs.config;

import com.abcjobs.auth.AccessDeniedHandler;
import com.abcjobs.auth.UserDetailsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Bean
    public UserDetailsService userDetailsService() {
        return new UserDetailsServiceImpl();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Autowired
    AuthenticationSuccessHandler authSuccessHandler;

    @Autowired
    private AccessDeniedHandler accessDeniedHandler;

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        System.out.println("At Authentication configure");
        auth.userDetailsService(userDetailsService()).passwordEncoder(passwordEncoder());
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        System.out.println("At Security configure");
        http.sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
                .maximumSessions(1)
                .expiredUrl("/showLogin?expired=true");

        http.authorizeRequests()
		        .antMatchers("/css/**").permitAll()
		        .antMatchers("/images/**").permitAll()
		        .antMatchers("/js/**").permitAll()
		        .antMatchers(HttpMethod.GET, "/favicon.*").permitAll()
                .antMatchers("/", "/showLogin", "/showRegister", "/registerSuccess", "/showForgotPassword").anonymous()
                .antMatchers(HttpMethod.POST, "/register").anonymous()
                .antMatchers("/admin/**").hasRole("ADMINISTRATOR")
                .anyRequest().access("isAuthenticated() and hasRole('SOFTWARE_PROGRAMMER')")
            .and()
                .formLogin().loginPage("/showLogin").loginProcessingUrl("/login").usernameParameter("email").defaultSuccessUrl("/home")
                .successHandler(authSuccessHandler)
                .and().httpBasic()
            .and()
                .logout().logoutUrl("/logout").logoutSuccessUrl("/showLogin?logout").permitAll()
            .and()
                .exceptionHandling().accessDeniedPage("/accessDenied").accessDeniedHandler(accessDeniedHandler);
    }
}
