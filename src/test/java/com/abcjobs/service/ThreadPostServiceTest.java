package com.abcjobs.service;

import com.abcjobs.config.JpaConfig;
import com.abcjobs.config.WebMvcConfig;
import com.abcjobs.model.ThreadPost;
import com.abcjobs.model.UserProfile;
import com.abcjobs.repository.ThreadPostRepository;
import com.abcjobs.repository.UserProfileRepository;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.util.*;

import static org.junit.Assert.*;
import static org.mockito.Mockito.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={WebMvcConfig.class, JpaConfig.class})
@WebAppConfiguration
public class ThreadPostServiceTest {
    @Mock
    ThreadPostRepository repository;
    
    @Mock
    UserProfileRepository userProfileRepository;
    
    @InjectMocks
    ThreadPostService threadPostService;

    Long profileId = 1L;

    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        // Create a mock UserProfile object with the specified ID
        UserProfile userProfile = new UserProfile();
        userProfile.setProfileId(profileId);

        // Configure the mock user profile repository to return the mock UserProfile object
        when(userProfileRepository.findById(profileId)).thenReturn(Optional.of(userProfile));
    }

    @Test
    public void testCreate() throws Exception {
        ThreadPost threadPost = new ThreadPost();
        threadPost.setThreadPostTitle("Test thread title");
        threadPost.setThreadPostContent("Test thread content");

        // Configure the mock repository to return the mock ThreadPost object
        when(repository.save(any(ThreadPost.class))).thenReturn(threadPost);

        ThreadPost newThread = threadPostService.create(threadPost, profileId);

        // Assert that the result contains the expected ThreadPost object
        assertNotNull(newThread);
        assertEquals(newThread.getThreadPostTitle(), "Test thread title");
    }

    @Test
    public void testGetSortedThreadPosts() throws Exception {
        ThreadPost post1 = new ThreadPost();
        post1.setThreadPostTitle("Test post 1");
        ThreadPost post2 = new ThreadPost();
        post2.setThreadPostTitle("Test post 2");
        ThreadPost post3 = new ThreadPost();
        post3.setThreadPostTitle("Test post 3");

        List<ThreadPost> mockThreadList = new ArrayList<>();
        mockThreadList.add(post1);
        mockThreadList.add(post2);
        mockThreadList.add(post3);

        when(repository.findAllOrderByThreadCreatedAtDesc()).thenReturn(mockThreadList);

        List<ThreadPost> result = threadPostService.getThreadPostsSorted();

        assertEquals(mockThreadList, result);
    }
}
