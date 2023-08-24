package com.abcjobs.config;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.filter.HiddenHttpMethodFilter;
import org.springframework.web.servlet.DispatcherServlet;

import javax.servlet.*;
import java.util.EnumSet;
import java.util.TimeZone;

/**
 * Initializes the Spring web application context for the application.
 * This class is automatically detected by the Servlet container at startup time.
 * It registers the Spring MVC DispatcherServlet and maps it to the root URL pattern ('/').
 * <p>
 * This class is an alternative to using web.xml configuration file for Servlet 3.0+ container.
 *
 * <p>This configuration class implements {@code WebApplicationInitializer}</p>
 */
public class WebAppInitializer implements WebApplicationInitializer {

    /**
     * Configures the Spring web application context for the application.
     *
     * @param servletContext the ServletContext object
     * @throws ServletException if an error occurs while configuring the web application
     */
    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {
        AnnotationConfigWebApplicationContext appContext = new AnnotationConfigWebApplicationContext();
        TimeZone.setDefault(TimeZone.getTimeZone("Etc/UTC"));

        // Create the HiddenHttpMethodFilter
        FilterRegistration.Dynamic hiddenHttpMethodFilter = servletContext.addFilter("hiddenHttpMethodFilter", HiddenHttpMethodFilter.class);
        // Set the filter parameters
        hiddenHttpMethodFilter.setInitParameter("methodParam", "_method");
        hiddenHttpMethodFilter.addMappingForUrlPatterns(EnumSet.allOf(DispatcherType.class), true, "/*");

        appContext.register(WebMvcConfig.class);
        ServletRegistration.Dynamic dispatcher = servletContext.addServlet("SpringDispatcher",
                new DispatcherServlet(appContext));
        dispatcher.setLoadOnStartup(1);
        dispatcher.addMapping("/");
    }
}
