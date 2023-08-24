package com.abcjobs.repository;

import com.abcjobs.model.ThreadPost;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * The Interface ThreadPostRepository provides methods for managing
 * ThreadPost objects in the database.
 * It uses Spring Data JPA to perform CRUD operations and generate SQL queries.
 */
@Repository
public interface ThreadPostRepository extends JpaRepository<ThreadPost, Long> {
    /**
     * Find all order by thread created at in descending order
     *
     * @return the thread post list
     */
    @Query("SELECT t FROM ThreadPost t ORDER BY t.threadCreatedAt DESC")
    List<ThreadPost> findAllOrderByThreadCreatedAtDesc();
}
