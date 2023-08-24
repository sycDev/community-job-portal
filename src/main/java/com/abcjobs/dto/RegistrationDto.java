package com.abcjobs.dto;

import javax.validation.constraints.*;

/**
 * The Data Transfer Object for the registration form
 * 
 * @author Ch'ng Sin Yi
 */
public class RegistrationDto {
	@NotBlank(message = "Email address is required")
	@Email(regexp = "^(?!\\.)[a-zA-Z0-9._%+-]*[a-zA-Z0-9]@(?!-)[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}(?:\\.[a-zA-Z]{2,})?$", message = "Please enter a valid email address")
	private String email;

	@NotBlank(message = "Password is required")
	@Size(min = 8, max = 100, message = "Password must at least 8 characters")
	private String password;

	@NotBlank(message = "Confirm password is required")
	private String confirmPassword;

	@NotBlank(message = "First name is required")
	private String firstName;
	
	private String lastName;

	@NotBlank(message = "Role is required")
	private String role;

	@NotNull(message = "Location is required")
	private Long locationId;

	@Override
	public String toString() {
		return "RegistrationDto [email=" + email + ", password=" + password + ", confirmPassword=" + confirmPassword
				+ ", firstName=" + firstName + ", lastName=" + lastName + ", role=" + role + ", locationId="
				+ locationId + "]";
	}

	public RegistrationDto() {
	}

	public RegistrationDto(String email, String password, String confirmPassword, String firstName, String lastName, String role, Long locationId) {
		this.email = email;
		this.password = password;
		this.confirmPassword = confirmPassword;
		this.firstName = firstName;
		this.lastName = lastName;
		this.role = role;
		this.locationId = locationId;
	}

	/**
	 * Checks if the password and confirm password fields in this registration DTO match.
	 * @return true if the passwords match, false otherwise
	 */
	@AssertTrue(message = "Passwords do not match")
	public boolean isPasswordsMatched() {
		return password.equals(confirmPassword);
	}

	/**
	 * Returns the user's email address
	 *
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * Sets the user's email address
	 *
	 * @param email the new email
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * Returns the password of the user account
	 *
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * Sets the password of the user account
	 *
	 * @param password the new password
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * Returns the confirm password
	 *
	 * @return the confirm password
	 */
	public String getConfirmPassword() {
		return confirmPassword;
	}

	/**
	 * Sets the confirm password
	 *
	 * @param confirmPassword the new confirm password
	 */
	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

	/**
	 * Returns the user's first name
	 *
	 * @return the first name
	 */
	public String getFirstName() {
		return firstName;
	}

	/**
	 * Sets the user's first name
	 *
	 * @param firstName the new first name
	 */
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	/**
	 * Returns the user's last name
	 *
	 * @return the last name
	 */
	public String getLastName() {
		return lastName;
	}

	/**
	 * Sets the user's last name
	 *
	 * @param lastName the new last name
	 */
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	/**
	 * Returns the role of the user account
	 *
	 * @return the role
	 */
	public String getRole() {
		return role;
	}

	/**
	 * Sets the role of the user account
	 *
	 * @param role the new role
	 */
	public void setRole(String role) {
		this.role = role;
	}

	/**
	 * Returns the location id
	 *
	 * @return the location id
	 */
	public Long getLocationId() {
		return locationId;
	}

	/**
	 * Sets the location id
	 *
	 * @param locationId the new location id
	 */
	public void setLocationId(Long locationId) {
		this.locationId = locationId;
	}

}
