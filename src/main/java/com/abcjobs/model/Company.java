package com.abcjobs.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Represents a company
 */
@Entity
@Table(name = "company")
public class Company {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "company_id", nullable = false)
	private Long companyId;

	@Column(name = "company_name", nullable = false)
    private String companyName;

	@ManyToMany(mappedBy = "companies")
    private Set<Location> locations;

	@OneToMany(mappedBy = "company", cascade = CascadeType.ALL)
	private Set<Position> positions = new HashSet<>();

	/**
	 * Returns the company id
	 *
	 * @return the company id
	 */
	public Long getCompanyId() {
		return companyId;
	}

	/**
	 * Sets the company id
	 *
	 * @param companyId the new company id
	 */
	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}

	/**
	 * Returns the company name
	 *
	 * @return the company name
	 */
	public String getCompanyName() {
		return companyName;
	}

	/**
	 * Sets the company name
	 *
	 * @param companyName the new company name
	 */
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	/**
	 * Returns the locations of the company
	 *
	 * @return the locations
	 */
	public Set<Location> getLocations() {
		return locations;
	}

	/**
	 * Sets the locations of the company
	 *
	 * @param locations the new locations
	 */
	public void setLocations(Set<Location> locations) {
		this.locations = locations;
	}

}
