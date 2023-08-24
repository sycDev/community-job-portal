package com.abcjobs.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.abcjobs.model.Location;
import com.abcjobs.repository.LocationRepository;

/**
 * The Service class for managing Location.
 * 
 * @author Ch'ng Sin Yi
 */
@Service
@Transactional
public class LocationService {
	@Autowired
	LocationRepository repository;
	
	/**
	 * Returns a list of all locations
	 *
	 * @return the list of all locations
	 */
	public List<Location> getAllLocation() {
		return repository.findAll();
	}
	
	/**
	 * Returns a list of all countries
	 *
	 * @return the list of all countries
	 */
	public List<String> getAllCountries() {
		return repository.findAllCountries();
	}
	
	/**
	 * Returns a list of location for the specific country
	 *
	 * @param country the country name
	 * @return the list of location for the specified country
	 */
	public List<Location> getCitiesByCountry(String country) {
        return repository.findByCountry(country);
    }
	
	/**
	 * Returns the location by location id if it exists
	 *
	 * @param id the location id
	 * @return the location if it exists
	 */
	public Optional<Location> getLocationById(Long id) {
        return repository.findById(id);
    }
}
