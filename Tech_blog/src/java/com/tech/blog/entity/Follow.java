/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tech.blog.entity;

public class Follow {

    private int followerId;
    private int followedId;

    // Constructor
    public Follow(int followerId, int followedId) {
        this.followerId = followerId;
        this.followedId = followedId;
    }

    public Follow() {
    }

    // Getter methods
    public int getFollowerId() {
        return followerId;
    }

    public int getFollowedId() {
        return followedId;
    }

    // Setter methods (if needed)
    public void setFollowerId(int followerId) {
        this.followerId = followerId;
    }

    public void setFollowedId(int followedId) {
        this.followedId = followedId;
    }
}
