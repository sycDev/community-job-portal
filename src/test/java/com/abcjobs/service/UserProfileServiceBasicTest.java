package com.abcjobs.service;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.when;

import java.util.Optional;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.abcjobs.config.JpaConfig;
import com.abcjobs.config.WebMvcConfig;
import com.abcjobs.model.UserProfile;
import com.abcjobs.repository.UserProfileRepository;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={WebMvcConfig.class, JpaConfig.class})
@WebAppConfiguration
public class UserProfileServiceBasicTest {
	@Mock
	UserProfileRepository repository;
	
	@InjectMocks
	UserProfileService service;
	
	@Before
	public void setUp() {
		MockitoAnnotations.initMocks(this);
	}
	
	@Test
	public void testFindByProfileId() throws Exception {
		// Create a mock UserProfile object with the specified ID
		Long profileId = 1L;
        UserProfile userProfile = new UserProfile();
        userProfile.setProfileId(profileId);
        Optional<UserProfile> optionalUserProfile = Optional.of(userProfile);
        
        // Configure the mock user profile repository to return the mock UserProfile object
        when(repository.findById(profileId)).thenReturn(optionalUserProfile);
        
        // Call the service method to retrieve the user profile
        Optional<UserProfile> result = service.findByProfileId(profileId);
        
        // Assert that the result contains the expected Education object
        assertEquals(optionalUserProfile, result);
	}
}
