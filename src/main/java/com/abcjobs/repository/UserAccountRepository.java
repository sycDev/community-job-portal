package com.abcjobs.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.abcjobs.model.UserAccount;

/**
 * The Interface UserAccountRepository provides methods for managing 
 * UserAccount objects in the database. 
 * It uses Spring Data JPA to perform CRUD operations and generate SQL queries.
 */
@Repository
public interface UserAccountRepository extends JpaRepository<UserAccount, Long> {
	/**
	 * Finds the matching user by email and password
	 *
	 * @param email the email address of the user account
	 * @param password the password of the user account
	 * @return the UserAccount with the given email and password
	 */
	Optional<UserAccount> findByEmailAndPassword(String email, String password);

	/**
	 * Finds a user by email
	 *
	 * @param email the email address of the user account
	 * @return the UserAccount with the given email
	 */
	UserAccount findByEmail(String email);
}
