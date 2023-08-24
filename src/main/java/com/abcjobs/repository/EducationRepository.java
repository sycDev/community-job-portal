package com.abcjobs.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.abcjobs.model.Education;

/**
 * The Interface EducationRepository provides methods for managing 
 * Education objects in the database. 
 * It uses Spring Data JPA to perform CRUD operations and generate SQL queries.
 */
@Repository
public interface EducationRepository extends JpaRepository<Education, Long> {
	/**
	 * Finds a list of education records by profile id sorted by end date in descending order
	 *
	 * @param profileId the profile id
	 * @return the list of all education with the given profile id
	 */
	@Query("SELECT e FROM Education e WHERE e.userProfile.profileId = :profileId ORDER BY CASE WHEN e.endDate IS NULL THEN 0 ELSE 1 END ASC, e.endDate DESC")
	List<Education> findByProfileIdSortedByEndDateDesc(@Param("profileId") Long profileId);

	/**
	 * Delete education by education id
	 *
	 * @param educationId the education id
	 */
	@Modifying
	@Query("DELETE FROM Education e WHERE e.educationId = :educationId")
	void deleteEducationByEducationId(@Param("educationId") Long educationId);
}
