package com.abcjobs.repository;

import com.abcjobs.model.UserAccount;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.abcjobs.model.UserProfile;

import java.util.List;
import java.util.Optional;

/**
 * The Interface UserProfileRepository provides methods for managing 
 * UserProfile objects in the database. 
 * It uses Spring Data JPA to perform CRUD operations and generate SQL queries.
 */
@Repository
public interface UserProfileRepository extends JpaRepository<UserProfile, Long>{
    Optional<UserProfile> findByUserAccount(UserAccount userAccount);

    @Query("SELECT up FROM UserProfile up JOIN up.location loc JOIN up.userAccount ua WHERE ("
            + "up.firstName LIKE CONCAT('%', :keyword, '%') OR "
            + "up.lastName LIKE CONCAT('%', :keyword, '%') OR "
            + "loc.city LIKE CONCAT('%', :keyword, '%') OR "
            + "loc.country LIKE CONCAT('%', :keyword, '%')) AND "
            + "ua.role != 'ADMINISTRATOR' AND "
            + "TRIM(:keyword) != ''")
    List<UserProfile> search(@Param("keyword") String keyword);
}
