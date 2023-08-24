package com.abcjobs.service;

import java.util.List;
import java.util.Optional;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.abcjobs.dto.RegistrationDto;
import com.abcjobs.exception.DuplicateEmailException;
import com.abcjobs.model.Location;
import com.abcjobs.model.UserAccount;
import com.abcjobs.model.UserProfile;
import com.abcjobs.repository.LocationRepository;
import com.abcjobs.repository.UserAccountRepository;
import com.abcjobs.repository.UserProfileRepository;
import com.abcjobs.util.EmailUtil;

/**
 * The Service class for managing user profiles.
 * Provides methods to register new user profiles, retrieve existing user profiles 
 * and update user profile information.
 * 
 * @author Ch'ng Sin Yi
 */
@Service
@Transactional
public class UserProfileService {
	@Autowired
	UserProfileRepository repository;

	@Autowired
	UserAccountRepository userAccountRepository;

	@Autowired
	LocationRepository locationRepository;

	/**
	 * Registers a new user profile with the given registration data.
	 * Throws a DuplicateEmailException if the provided email is already registered.
	 * Sends a confirmation email to the registered user upon successful registration.
	 *
	 * @param registrationDto the registration data for the new user profile
	 * @return the newly registered user profile
	 * @throws DuplicateEmailException if the provided email is already registered
	 * @throws AddressException if there is an error with the email address
	 * @throws MessagingException if there is an error sending the confirmation email
	 */
	public UserProfile register(RegistrationDto registrationDto)
			throws DuplicateEmailException, AddressException, MessagingException {
		UserProfile userProfile = new UserProfile();

		if (userAccountRepository.findByEmail(registrationDto.getEmail()) != null) {
			throw new DuplicateEmailException();
		} else {
			UserAccount userAccount = new UserAccount();
			userAccount.setEmail(registrationDto.getEmail());
			userAccount.setPassword(registrationDto.getPassword());
			userAccount.setRole(registrationDto.getRole());
			userAccountRepository.save(userAccount);

			Optional<Location> location = locationRepository.findById(registrationDto.getLocationId());

			// Optional - isEmpty (null) / isPresent ( not null)
			// .get()
			userProfile.setLocation(location.get());
			userProfile.setFirstName(registrationDto.getFirstName());
			userProfile.setLastName(registrationDto.getLastName());
			userProfile.setUserAccount(userAccount);
			userProfile = repository.saveAndFlush(userProfile);

			userAccount.setUserProfile(userProfile);
			userAccountRepository.saveAndFlush(userAccount);

			EmailUtil util = new EmailUtil();
			util.sendConfirmationEmail(userProfile.getUserAccount().getEmail(), userProfile.getFirstName());
		}

		return userProfile;
	}

	/**
	 * Finds the user profile with the given profile ID
	 *
	 * @param profileId the ID of the user profile to retrieve
	 * @return an Optional containing the user profile with the given ID, or an empty Optional if not found
	 */
	public Optional<UserProfile> findByProfileId(Long profileId) {
		return repository.findById(profileId);
	}

	/**
	 * Finds the user profile with the given user account ID
	 *
	 * @param userAccount the user account to retrieve
	 * @return an Optional containing the user profile with the given user account, or an empty Optional if not found
	 */
	public Optional<UserProfile> findByUserAccount(UserAccount userAccount) {
		return repository.findByUserAccount(userAccount);
	}

	/**
	 * Find the user profile of the current logged-in user
	 *
	 * @return the UserProfile of the logged-in user
	 */
	public Optional<UserProfile> findByCurrentUserAccount() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication != null && authentication.isAuthenticated()) {
			String email = authentication.getName();
			UserAccount currentUser = userAccountRepository.findByEmail(email);
			if (currentUser != null) {
				return repository.findByUserAccount(currentUser);
			}
		}
		return Optional.empty();
	}

	/**
	 * Find all the user profiles
	 *
	 * @return the list of all the UserProfile
	 */
	public List<UserProfile> findAllUsers() {
		return repository.findAll();
	}

	/**
	 * Updates the given user profile with the new information.
	 *
	 * @param updatedUserProfile the updated user profile object
	 */
	public void update(UserProfile updatedUserProfile) {
		Optional<UserProfile> currentUserProfile = repository.findById(updatedUserProfile.getProfileId());

		if (currentUserProfile.isPresent()) {
			UserProfile userProfile = currentUserProfile.get();
			userProfile.setFirstName(updatedUserProfile.getFirstName());
			userProfile.setLastName(updatedUserProfile.getLastName());
			userProfile.setPronouns(updatedUserProfile.getPronouns());
			userProfile.setLocation(updatedUserProfile.getLocation());
			userProfile.setDateOfBirth(updatedUserProfile.getDateOfBirth());
			repository.save(userProfile);
		}
	}

	/**
	 * Delete the selected user profile record
	 *
	 * @param userProfile the user profile object
	 */
	public void delete(UserProfile userProfile) {
		repository.delete(userProfile);
	}

	/**
	 * Search user profile by keyword (First name, last name, city and country)
	 *
	 * @param keyword the searching keyword
	 * @return the user list found
	 */
	public List<UserProfile> searchUserProfile(String keyword) {
		return repository.search(keyword);
	}
}
