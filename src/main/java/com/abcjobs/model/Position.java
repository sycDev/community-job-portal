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

import org.springframework.format.annotation.DateTimeFormat;

/**
 * Represents a work experience details of the user profile
 */
@Entity
@Table(name = "position")
public class Position {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "position_id", nullable = false)
	private Long positionId;

	@NotBlank(message = "Job title is required")
	@Column(name = "pos_job_title", nullable = false)
    private String jobTitle;

	@NotNull(message = "Work Experience start date is required")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "pos_start_date", nullable = false)
    private Date startDate;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "pos_end_date", nullable = false)
    private Date endDate;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "company_id", nullable = false)
	private Company company;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "profile_id", nullable = false)
	private UserProfile userProfile;

	/**
	 * Returns the position id
	 *
	 * @return the position id
	 */
	public Long getPositionId() {
		return positionId;
	}

	/**
	 * Sets the position id
	 *
	 * @param positionId the new position id
	 */
	public void setPositionId(Long positionId) {
		this.positionId = positionId;
	}

	/**
	 * Returns the job title
	 *
	 * @return the job title
	 */
	public String getJobTitle() {
		return jobTitle;
	}

	/**
	 * Sets the job title
	 *
	 * @param jobTitle the new job title
	 */
	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
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
	 * Returns the company
	 *
	 * @return the company
	 */
	public Company getCompany() {
		return company;
	}

	/**
	 * Sets the company
	 *
	 * @param company the new company
	 */
	public void setCompany(Company company) {
		this.company = company;
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
