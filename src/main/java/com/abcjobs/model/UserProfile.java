package com.abcjobs.model;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Past;

import com.abcjobs.annotation.AgeConstraint;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * Represents a profile of the user
 */
@Entity
@Table(name = "user_profile")
public class UserProfile {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "profile_id", nullable = false)
	private long profileId;

	@NotBlank(message = "First name is required")
	@Column(name = "first_name", nullable = false)
	private String firstName;

	@Column(name = "last_name")
	private String lastName;

	@Column(name = "pronouns")
	private String pronouns;

	@Lob
	@Column(name = "profile_pic")
	private byte[] profilePic;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Past(message = "Enter valid date for birthday")
	@AgeConstraint
	@Column(name = "date_of_birth")
	private Date dateOfBirth;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "location_id", nullable = false)
	private Location location;

	@OneToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "user_id", nullable = false)
	private UserAccount userAccount;

	@OneToMany(mappedBy = "userProfile", cascade = CascadeType.ALL)
	private Set<Education> educations = new HashSet<>();

	@OneToMany(mappedBy = "userProfile", cascade = CascadeType.ALL)
	private Set<Position> positions = new HashSet<>();;

	/**
	 * Returns the profile id
	 *
	 * @return the profile id
	 */
	public long getProfileId() {
		return profileId;
	}

	/**
	 * Sets the profile id
	 *
	 * @param profileId the new profile id
	 */
	public void setProfileId(long profileId) {
		this.profileId = profileId;
	}

	/**
	 * Returns the first name
	 *
	 * @return the first name
	 */
	public String getFirstName() {
		return firstName;
	}

	/**
	 * Sets the first name
	 *
	 * @param firstName the new first name
	 */
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	/**
	 * Returns the last name
	 *
	 * @return the last name
	 */
	public String getLastName() {
		return lastName;
	}

	/**
	 * Sets the last name
	 *
	 * @param lastName the new last name
	 */
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	/**
	 * Returns the pronouns
	 *
	 * @return the pronouns
	 */
	public String getPronouns() {
		return pronouns;
	}

	/**
	 * Sets the pronouns
	 *
	 * @param pronouns the new pronouns
	 */
	public void setPronouns(String pronouns) {
		this.pronouns = pronouns;
	}

	/**
	 * Returns the profile picture
	 *
	 * @return the profile picture
	 */
	public byte[] getProfilePic() {
		return profilePic;
	}

	/**
	 * Sets the profile picture
	 *
	 * @param profilePic the new profile picture
	 */
	public void setProfilePic(byte[] profilePic) {
		this.profilePic = profilePic;
	}

	/**
	 * Returns the date of birth
	 *
	 * @return the date of birth
	 */
	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	/**
	 * Sets the date of birth
	 *
	 * @param dateOfBirth the new date of birth
	 */
	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	/**
	 * Returns the location
	 *
	 * @return the location
	 */
	public Location getLocation() {
		return location;
	}

	/**
	 * Sets the location
	 *
	 * @param location the new location
	 */
	public void setLocation(Location location) {
		this.location = location;
	}

	/**
	 * Returns the user account
	 *
	 * @return the user account
	 */
	public UserAccount getUserAccount() {
		return userAccount;
	}

	/**
	 * Sets the user account
	 *
	 * @param userAccount the new user account
	 */
	public void setUserAccount(UserAccount userAccount) {
		this.userAccount = userAccount;
	}

	/**
	 * Gets the educations
	 *
	 * @return the educations
	 */
	public Set<Education> getEducations() {
		return educations;
	}

	/**
	 * Sets the educations
	 *
	 * @param educations the new educations
	 */
	public void setEducations(Set<Education> educations) {
		this.educations = educations;
	}

	/**
	 * Gets the positions
	 *
	 * @return the positions
	 */
	public Set<Position> getPositions() {
		return positions;
	}

	/**
	 * Sets the positions
	 *
	 * @param positions the new positions
	 */
	public void setPositions(Set<Position> positions) {
		this.positions = positions;
	}
}
