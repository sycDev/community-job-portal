package com.abcjobs.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

/**
 * This Configuration class contains the Spring MVC configuration for the web application.
 * It provides a view resolver for mapping view names to JSP files, and 
 * configures resource handlers for serving static content such as images, 
 * CSS, and JavaScript files.
 *
 * <p>This configuration class implements {@code WebMvcConfigurer}</p>
 */
@Configuration
@EnableWebMvc
@ComponentScan("com.abcjobs")
public class WebMvcConfig implements WebMvcConfigurer {

	/**
	 * Configures the view resolver bean for the Spring MVC web application.
	 * 
	 * @return The configured InternalResourceViewResolver object.
	 */
	@Bean(name = "viewResolver")
	public InternalResourceViewResolver getViewResolver() {
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setPrefix("/WEB-INF/views/");
		viewResolver.setSuffix(".jsp");
		return viewResolver;
	}

	/**
	 * Configures the resource handlers for static resources such as images, CSS, and JS files.
	 * 
	 * @param registry The ResourceHandlerRegistry object used for configuring the resource handlers.
	 */
	@Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
    	if (!registry.hasMappingForPattern("/static/**")) {
        	System.out.println("|||||||||||||||||||||| Resources Handlers |||||||||||||||||||||");
        	registry.addResourceHandler("/images/**",
                    					"/css/**",
                    					"/js/**"
                    					)
                    .addResourceLocations("classpath:/static/images/", 
                    					"classpath:/static/css/",
                            			"classpath:/static/js/"
                    					);
        }
    }
}
