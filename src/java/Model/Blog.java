/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class Blog {

    private String id;
    private String title;
    private String content;
    private User author;
    private String image;
    private String status;
    private Date publishedAt;
    private Date createdAt;
    private Date updatedAt;
    private int reactionCount;
    private int commentCount;
    private List<String> tagsAsList;
    private List<Tag> tags;

    

    public Blog() {
    }

    public Blog(String id, String title, String content, User author, String image, String status, Date publishedAt, Date createdAt, Date updatedAt, int reactionCount, int commentCount, List<String> tagsAsList, List<Tag> tags) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.author = author;
        this.image = image;
        this.status = status;
        this.publishedAt = publishedAt;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.reactionCount = reactionCount;
        this.commentCount = commentCount;
        this.tagsAsList = tagsAsList;
        this.tags = tags;
    }

    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getPublishedAt() {
        return publishedAt;
    }

    public void setPublishedAt(Date publishedAt) {
        this.publishedAt = publishedAt;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public int getReactionCount() {
        return reactionCount;
    }

    public void setReactionCount(int reactionCount) {
        this.reactionCount = reactionCount;
    }

    public int getCommentCount() {
        return commentCount;
    }

    public void setCommentCount(int commentCount) {
        this.commentCount = commentCount;
    }

    public List<String> getTagsAsList() {
        return tagsAsList;
    }

    public void setTagsAsList(List<String> tagsAsList) {
        this.tagsAsList = tagsAsList;
    }

    public List<Tag> getTags() {
        return tags;
    }

    public void setTags(List<Tag> tags) {
        this.tags = tags;
    }

}
