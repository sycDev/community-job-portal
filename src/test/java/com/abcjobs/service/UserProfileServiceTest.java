package com.abcjobs.service;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.abcjobs.config.JpaConfig;
import com.abcjobs.config.WebMvcConfig;
import com.abcjobs.dto.RegistrationDto;
import com.abcjobs.model.UserProfile;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={WebMvcConfig.class, JpaConfig.class})
@WebAppConfiguration
public class UserProfileServiceTest {
	@Autowired
	UserProfileService service;

	@Test
	public void testRegister() {
		RegistrationDto registrationDto = new RegistrationDto();
		registrationDto.setEmail("abc@test.com");
		registrationDto.setPassword("abc123test");
		registrationDto.setFirstName("abc");
		registrationDto.setLastName("test");
		registrationDto.setRole("SOFTWARE_PROGRAMMER");
		registrationDto.setLocationId((long) 1805);

		try {
			UserProfile regUser = service.register(registrationDto);
			assertEquals(registrationDto.getFirstName(), regUser.getFirstName());
			
			assertEquals(registrationDto.getEmail(), regUser.getUserAccount().getEmail());
		} catch (Exception e) {
			fail("Caught an exception: " + e.getMessage());
		}
	}

}
