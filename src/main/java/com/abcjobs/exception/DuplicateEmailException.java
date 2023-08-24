package com.abcjobs.exception;

/**
 * The Exception Class that indicate the given email has 
 * already been registered.
 */
public class DuplicateEmailException extends Exception {

	private static final long serialVersionUID = 1L;

	/**
	 * Creates a new instance of {@link DuplicateEmailException} with a default error message.
	 * 
	 * @see DuplicateEmailException
	 */
	public DuplicateEmailException() {
		super("Email has registered before!");
	}

	/**
	 * Creates a new instance of {@link DuplicateEmailException} with a custom error message.
	 * 
	 * @param email the email that has already been registered.
	 */
	public DuplicateEmailException(String email) {
		super(email + " has taken before!");
	}
}
