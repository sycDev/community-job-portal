package com.abcjobs.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;

/**
 * Represents the countries and cities
 */
@Entity
@Table(name = "location")
public class Location {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "location_id", nullable = false)
	private Long locationId;

    private String city;

    @NotBlank
    private String country;

    @OneToMany(mappedBy = "location", cascade = CascadeType.ALL)
	private Set<UserProfile> userProfiles = new HashSet<>();

    @ManyToMany
    @JoinTable(
		name = "company_location",
		joinColumns = @JoinColumn(name = "location_id"),
		inverseJoinColumns = @JoinColumn(name = "company_id")
    )
    private Set<Company> companies = new HashSet<>();

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

	/**
	 * Returns the city
	 *
	 * @return the city
	 */
	public String getCity() {
		return city;
	}

	/**
	 * Sets the city
	 *
	 * @param city the new city
	 */
	public void setCity(String city) {
		this.city = city;
	}

	/**
	 * Returns the country
	 *
	 * @return the country
	 */
	public String getCountry() {
		return country;
	}

	/**
	 * Sets the country
	 *
	 * @param country the new country
	 */
	public void setCountry(String country) {
		this.country = country;
	}

	/**
	 * Returns the user profiles
	 *
	 * @return the user profiles
	 */
	public Set<UserProfile> getUserProfiles() {
		return userProfiles;
	}

	/**
	 * Sets the user profiles
	 *
	 * @param userProfiles the new user profiles
	 */
	public void setUserProfiles(Set<UserProfile> userProfiles) {
		this.userProfiles = userProfiles;
	}

	/**
	 * Returns the companies
	 *
	 * @return the companies
	 */
	public Set<Company> getCompanies() {
		return companies;
	}

	/**
	 * Sets the companies
	 *
	 * @param companies the new companies
	 */
	public void setCompanies(Set<Company> companies) {
		this.companies = companies;
	}

}
