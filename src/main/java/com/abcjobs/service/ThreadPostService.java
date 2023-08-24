package com.abcjobs.service;

import com.abcjobs.model.ThreadPost;
import com.abcjobs.model.UserProfile;
import com.abcjobs.repository.ThreadPostRepository;
import com.abcjobs.repository.UserProfileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

/**
 * The Service class for managing thread post details posted by the user.
 *
 * @author Ch'ng Sin Yi
 */
@Service
@Transactional
public class ThreadPostService {
    @Autowired
    ThreadPostRepository repository;

    @Autowired
    UserProfileRepository userProfileRepository;

    /**
     * Creates a new thread post
     *
     * @param threadPost the thread post to create
     * @param profileId the profile id to associate the thread post with
     * @return the created thread post
     */
    public ThreadPost create(ThreadPost threadPost, Long profileId) {
        Optional<UserProfile> userProfile = userProfileRepository.findById(profileId);

        if (userProfile.isPresent()) {
            threadPost.setUserProfile(userProfile.get());
            return repository.save(threadPost);
        }

        throw new IllegalArgumentException("User profile not found");
    }

    /**
     * Returns a list of all thread posts sorted by created date in descending order.
     *
     * @return the list of educations of the user profile sorted by end date in descending order
     */
    public List<ThreadPost> getThreadPostsSorted() {
        return repository.findAllOrderByThreadCreatedAtDesc();
    }
}
