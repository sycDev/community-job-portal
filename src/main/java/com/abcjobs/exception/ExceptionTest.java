package com.abcjobs.exception;

import com.abcjobs.model.UserAccount;

public class ExceptionTest {
	// existing record in database
	static UserAccount dbUserAccount  = new UserAccount();
	
	public static void main(String[] args) {
		// set the existing user account
		dbUserAccount.setEmail("john@email.com");
		
		// new user registration
		UserAccount newUa = new UserAccount();
		newUa.setEmail("user@gmail.com");
		System.out.println(dbUserAccount);

		try {
			insert(newUa);
			System.out.println("Inserted succesfully!");
		} catch (DuplicateEmailException e) {
			System.out.println(e.getMessage());
		}
		
	}

	public static void insert(UserAccount newUser) throws DuplicateEmailException {
		if (dbUserAccount.getEmail().equals(newUser.getEmail()))
			throw new DuplicateEmailException(newUser.getEmail()) ;
	}

}
