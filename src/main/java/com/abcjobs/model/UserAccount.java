package com.abcjobs.model;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.*;

import org.hibernate.annotations.CreationTimestamp;

/**
 * Represents a user in the system
 */
@Entity
@Table(name = "user_account")
public class UserAccount {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "user_id", nullable = false)
	private Long userId;

	@NotBlank(message = "Email address is required")
	@Email(regexp = "^(?!\\.)[a-zA-Z0-9._%+-]*[a-zA-Z0-9]@(?!-)[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}(?:\\.[a-zA-Z]{2,})?$", message = "Please enter a valid email address")
	@Column(name = "email", nullable = false, unique = true)
	private String email;

	@NotBlank(message = "Password is required")
	@Size(min = 8, max = 100, message = "Password must at least 8 characters")
	@Column(name = "password", nullable = false)
	private String password;

	@CreationTimestamp
	@Column(name = "joined_at", nullable = false)
	private Date joinedAt;

	@NotBlank(message = "Role is required")
	private String role;

	@Transient
	private String confirmPassword;

	@OneToOne(mappedBy = "userAccount", cascade = CascadeType.ALL)
	private UserProfile userProfile;

	@Override
	public String toString() {
		return "UserAccount [userId=" + userId + ", email=" + email + ", password=" + password + ", joinedAt="
				+ joinedAt + ", role=" + role + ", confirmPassword=" + confirmPassword + ", userProfile=" + userProfile
				+ "]";
	}

	/**
	 * Returns the user id
	 *
	 * @return the user id
	 */
	public Long getUserId() {
		return userId;
	}

	/**
	 * Sets the user id
	 *
	 * @param userId the new user id
	 */
	public void setUserId(Long userId) {
		this.userId = userId;
	}

	/**
	 * Returns the email
	 *
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * Sets the email
	 *
	 * @param email the new email
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * Returns the password
	 *
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * Sets the password
	 *
	 * @param password the new password
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * Returns the joined at
	 *
	 * @return the joined at
	 */
	public Date getJoinedAt() {
		return joinedAt;
	}

	/**
	 * Sets the joined at
	 *
	 * @param joinedAt the new joined at
	 */
	public void setJoinedAt(Date joinedAt) {
		this.joinedAt = joinedAt;
	}

	/**
	 * Returns the role
	 *
	 * @return the role
	 */
	public String getRole() {
		return role;
	}

	/**
	 * Sets the role
	 *
	 * @param role the new role
	 */
	public void setRole(String role) {
		this.role = role;
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
	 * Returns the user profile
	 *
	 * @return the user profile
	 */
	public UserProfile getUserProfile() {
		return userProfile;
	}

	/**
	 * Sets the user profile
	 *
	 * @param userProfile the new user profile
	 */
	public void setUserProfile(UserProfile userProfile) {
		this.userProfile = userProfile;
	}

}
