package com.abcjobs.model;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Type;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * Represents an education details of the user profile
 */
@Entity
@Table(name = "education")
public class Education {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "education_id", nullable = false)
	private Long educationId;

	@NotBlank(message = "School name is required")
	@Column(name = "school_name", nullable = false)
    private String schoolName;

	@Column(name = "course_name")
    private String courseName;

	@NotNull(message = "Education start date is required")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "edu_start_date")
    private Date startDate;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "edu_end_date")
    private Date endDate;

	@Column(name = "edu_description")
	@Type(type = "text")
    private String description;

	@Column(name = "grade")
    private String grade;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "profile_id", nullable = false)
	private UserProfile userProfile;

	/**
	 * Returns the education id
	 *
	 * @return the education id
	 */
	public Long getEducationId() {
		return educationId;
	}

	/**
	 * Sets the education id
	 *
	 * @param educationId the new education id
	 */
	public void setEducationId(Long educationId) {
		this.educationId = educationId;
	}

	/**
	 * Returns the school name
	 *
	 * @return the school name
	 */
	public String getSchoolName() {
		return schoolName;
	}

	/**
	 * Sets the school name
	 *
	 * @param schoolName the new school name
	 */
	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}

	/**
	 * Returns the course name
	 *
	 * @return the course name
	 */
	public String getCourseName() {
		return courseName;
	}

	/**
	 * Sets the course name
	 *
	 * @param courseName the new course name
	 */
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	/**
	 * Returns the start date
	 *
	 * @return the start date
	 */
	public Date getStartDate() {
		return startDate;
	}

	/**
	 * Sets the start date
	 *
	 * @param startDate the new start date
	 */
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	/**
	 * Returns the end date
	 *
	 * @return the end date
	 */
	public Date getEndDate() {
		return endDate;
	}

	/**
	 * Sets the end date
	 *
	 * @param endDate the new end date
	 */
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	/**
	 * Returns the description
	 *
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * Sets the description
	 *
	 * @param description the new description
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * Returns the grade
	 *
	 * @return the grade
	 */
	public String getGrade() {
		return grade;
	}

	/**
	 * Sets the grade
	 *
	 * @param grade the new grade
	 */
	public void setGrade(String grade) {
		this.grade = grade;
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
