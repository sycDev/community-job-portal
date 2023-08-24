package com.abcjobs.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.abcjobs.model.Location;

/**
 * The Interface LocationRepository provides methods for managing 
 * Location objects in the database. 
 * It uses Spring Data JPA to perform CRUD operations and generate SQL queries.
 */
@Repository
public interface LocationRepository extends JpaRepository<Location, Long> {
	/**
	 * Finds all distinct countries
	 *
	 * @return the list of all distinct countries
	 */
	@Query("SELECT DISTINCT l.country FROM Location l")
	List<String> findAllCountries();

	/**
	 * Finds a list of location with specific country name
	 *
	 * @param country the country name
	 * @return the list of Location that matched the given country name
	 */
	@Query("SELECT l FROM Location l WHERE l.country = :country")
	List<Location> findByCountry(@Param("country") String country);

	/**
	 * Finds a location by country and city
	 *
	 * @param city the city name
	 * @param country the country name
	 * @return the UserAccount with the given email
	 */
	// returns a Location object that matches the given city and country names
	@Query("SELECT l FROM Location l WHERE l.city = :city AND l.country = :country")
	Location findByCityAndCountry(@Param("city") String city, @Param("country") String country);
}
