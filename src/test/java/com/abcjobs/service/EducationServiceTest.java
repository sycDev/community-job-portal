package com.abcjobs.service;

import com.abcjobs.config.JpaConfig;
import com.abcjobs.config.WebMvcConfig;
import com.abcjobs.model.Education;
import com.abcjobs.model.UserProfile;
import com.abcjobs.repository.EducationRepository;
import com.abcjobs.repository.UserProfileRepository;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.text.SimpleDateFormat;
import java.util.*;

import static org.junit.Assert.*;
import static org.mockito.Mockito.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={WebMvcConfig.class, JpaConfig.class})
@WebAppConfiguration
public class EducationServiceTest {
    @Mock
    EducationRepository repository;

    @Mock
    UserProfileRepository userProfileRepository;

    @InjectMocks
    EducationService educationService;

    Long profileId = 1L;

    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);

        // Create a mock UserProfile object with the specified ID
        UserProfile userProfile = new UserProfile();
        userProfile.setProfileId(profileId);

        // Configure the mock user profile repository to return the mock UserProfile object
        when(userProfileRepository.findById(profileId)).thenReturn(Optional.of(userProfile));
    }

    @Test
    public void testGetEducationsByProfileId() throws Exception {
        // Create some mock Education objects
        Education education1 = new Education();
        education1.setSchoolName("School 1");
        Education education2 = new Education();
        education2.setSchoolName("School 2");

        // Save them in a List
        List<Education> educationList = new ArrayList<>();
        educationList.add(education1);
        educationList.add(education2);

        // Configure the mock repository to return the mock Education List
        when(repository.findByProfileIdSortedByEndDateDesc(anyLong())).thenReturn(educationList);

        // Call the service method to retrieve the Education list
        List<Education> results = educationService.getEducationsByProfileIdSorted(1L);

        // Assert that the result contains the expected Education object
        assertEquals(educationList, results);
    }

    @Test
    public void testGetEducationById() throws Exception {
        // Create a mock Education object with the specified ID
        Long id = 1L;
        Education education = new Education();
        education.setEducationId(id);

        // Configure the mock repository to return the mock Education object
        when(repository.findById(id)).thenReturn(Optional.of(education));

        // Call the service method to retrieve the Education object
        Optional<Education> result = educationService.getEducationById(id);

        // Assert that the result contains the expected Education object
        assertTrue(result.isPresent());
        assertEquals(id, result.get().getEducationId());
    }

    @Test
    public void testCreate() throws Exception {
        // Create a mock Education object and profile ID
        Education education = new Education();

        // Call the service method to create the Education object
        when(repository.save(education)).thenReturn(education);
        Education result = educationService.create(education, profileId);

        // Verify that the user profile was retrieved from the repository
        verify(userProfileRepository).findById(profileId);

        // Verify that the Education object was saved to the repository
        verify(repository).save(education);

        // Assert that the result matches the input Education object
        assertSame(education, result);
    }

    @Test
    public void testDelete() throws Exception {
        String schoolName = "Test School";
        String startDateStr = "2023-01-01";
        Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse(startDateStr);
        // Create a new education
        Education education = new Education();
        education.setSchoolName(schoolName);
        education.setStartDate(startDate);

        // Call the service method to create the Education object
        when(repository.save(education)).thenReturn(education);
        Education result = educationService.create(education, profileId);

        // Delete the education by its ID
        educationService.deleteById(result.getEducationId());

        // Verify that the education was deleted by trying to retrieve it from the database
        Optional<Education> deletedEducation = repository.findById(result.getEducationId());
        assertFalse(deletedEducation.isPresent());
    }
}
