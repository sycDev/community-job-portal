package com.abcjobs.model;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.util.Date;

/**
 * Represents a thread post details posted by the user
 */
@Entity
@Table(name = "thread_post")
public class ThreadPost {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "th_post_id", nullable = false)
    private Long threadPostId;

    @NotBlank(message = "Thread post title is required")
    @Column(name = "th_post_title", nullable = false)
    private String threadPostTitle;

    @Column(name = "th_post_content")
    @Type(type = "text")
    private String threadPostContent;

    @Lob
    @Column(name = "th_post_img")
    private byte[] threadPostImage;

    @CreationTimestamp
    @Column(name = "th_created_at")
    private Date threadCreatedAt;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "profile_id", nullable = false)
    private UserProfile userProfile;

    /**
     * Gets thread post id
     *
     * @return the thread post id
     */
    public Long getThreadPostId() {
        return threadPostId;
    }

    /**
     * Sets thread post id
     *
     * @param threadPostId the thread post id
     */
    public void setThreadPostId(Long threadPostId) {
        this.threadPostId = threadPostId;
    }

    /**
     * Gets thread post title
     *
     * @return the thread post title
     */
    public String getThreadPostTitle() {
        return threadPostTitle;
    }

    /**
     * Sets thread post title
     *
     * @param threadPostTitle the thread post title
     */
    public void setThreadPostTitle(String threadPostTitle) {
        this.threadPostTitle = threadPostTitle;
    }

    /**
     * Gets thread post content
     *
     * @return the thread post content
     */
    public String getThreadPostContent() {
        return threadPostContent;
    }

    /**
     * Sets thread post content
     *
     * @param threadPostContent the thread post content
     */
    public void setThreadPostContent(String threadPostContent) {
        this.threadPostContent = threadPostContent;
    }

    /**
     * Get thread post image byte [ ]
     *
     * @return the byte [ ]
     */
    public byte[] getThreadPostImage() {
        return threadPostImage;
    }

    /**
     * Sets thread post image
     *
     * @param threadPostImage the thread post image
     */
    public void setThreadPostImage(byte[] threadPostImage) {
        this.threadPostImage = threadPostImage;
    }

    /**
     * Gets thread created at
     *
     * @return the thread created at
     */
    public Date getThreadCreatedAt() {
        return threadCreatedAt;
    }

    /**
     * Sets thread created at
     *
     * @param threadCreatedAt the thread created at
     */
    public void setThreadCreatedAt(Date threadCreatedAt) {
        this.threadCreatedAt = threadCreatedAt;
    }

    /**
     * Gets user profile
     *
     * @return the user profile
     */
    public UserProfile getUserProfile() {
        return userProfile;
    }

    /**
     * Sets user profile
     *
     * @param userProfile the user profile
     */
    public void setUserProfile(UserProfile userProfile) {
        this.userProfile = userProfile;
    }
}
