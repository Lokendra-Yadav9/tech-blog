/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tech.blog.entity;
import java.sql.*;

public class Comment {
    private int commentId;
    private int userId;
    private int postId;
    private String commentText;
    private Timestamp timestamp;

    // Constructor
    public Comment(int commentId, int userId, int postId, String commentText, Timestamp timestamp) {
        this.commentId = commentId;
        this.userId = userId;
        this.postId = postId;
        this.commentText = commentText;
        this.timestamp = timestamp;
    }
    
    public Comment(){
        
    }

    // Getters and setters
    // You need to provide getters and setters for each field to access and modify them

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getCommentText() {
        return commentText;
    }

    public void setCommentText(String commentText) {
        this.commentText = commentText;
    }

    public Timestamp getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }
}
