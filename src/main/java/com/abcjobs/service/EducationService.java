package com.abcjobs.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.abcjobs.model.Education;
import com.abcjobs.model.UserProfile;
import com.abcjobs.repository.EducationRepository;
import com.abcjobs.repository.UserProfileRepository;

/**
 * The Service class for managing education information of user profiles.
 * 
 * @author Ch'ng Sin Yi
 */
@Service
@Transactional
public class EducationService {
	@Autowired
	EducationRepository repository;

	@Autowired
	UserProfileRepository userProfileRepository;

	/**
	 * Returns a list of educations of a user profile sorted by end date in descending order.
	 * 
	 * @param profileId the profile id
	 * @return the list of educations of the user profile sorted by end date in descending order
	 */
	public List<Education> getEducationsByProfileIdSorted(Long profileId) {
		return repository.findByProfileIdSortedByEndDateDesc(profileId);
	}

	/**
	 * Retrieves an education by id
	 *
	 * @param id the education id to retrieve
	 * @return an Optional containing the education with the specified ID, or an empty Optional if no education was found
	 */
	public Optional<Education> getEducationById(Long id) {
		return repository.findById(id);
	}

	/**
	 * Creates a new education for a user profile
	 *
	 * @param education the education to create
	 * @param profileId the profile id to associate the education with
	 * @return the created education
	 */
	public Education create(Education education, Long profileId) {
		Optional<UserProfile> userProfile = userProfileRepository.findById(profileId);

		if (userProfile.isPresent()) {
			education.setUserProfile(userProfile.get());
			return repository.save(education);
		}

		throw new IllegalArgumentException("User profile not found");
	}

	/**
	 * Updates the given education with the new information.
	 *
	 * @param updatedEducation the updated education object
	 */
	public void update(Education updatedEducation) {
		Optional<Education> currentEducation = repository.findById(updatedEducation.getUserProfile().getProfileId());

		if (currentEducation.isPresent()) {
			Education education = currentEducation.get();
			education.setSchoolName(updatedEducation.getSchoolName());
			education.setCourseName(updatedEducation.getCourseName());
			education.setGrade(updatedEducation.getGrade());
			education.setStartDate(updatedEducation.getStartDate());
			education.setEndDate(updatedEducation.getEndDate());
			education.setDescription(updatedEducation.getDescription());
			repository.save(education);
		}
	}

	public void deleteById(Long eduId) {
		repository.deleteEducationByEducationId(eduId);
	}
}
