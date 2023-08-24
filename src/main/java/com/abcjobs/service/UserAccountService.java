package com.abcjobs.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.abcjobs.model.UserAccount;
import com.abcjobs.repository.UserAccountRepository;

/**
 * The Service class for managing user accounts.
 *
 * @author Ch 'ng Sin Yi
 */
@Service
@Transactional
public class UserAccountService {
	/**
	 * The Repository.
	 */
	@Autowired
	UserAccountRepository repository;

	/**
	 * Retrieves a user account by email
	 *
	 * @param email the email of the user account to retrieve
	 * @return the user account with the given email, or null if not found
	 */
	public UserAccount findByEmail(String email) {
		return repository.findByEmail(email);
	}

	/**
	 * Retrieves a user account by user id
	 *
	 * @param userId the User ID
	 * @return the optional User Account object
	 */
	public Optional<UserAccount> findByUserId(Long userId) {
		return repository.findById(userId);
	}

	/**
	 * Delete one user account
	 *
	 * @param userAccount the User Account object
	 */
	public void delete(UserAccount userAccount) {
		repository.delete(userAccount);
    }
}
