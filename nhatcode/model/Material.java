/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class Material {private int id;
    private int courseId;
    private String title;
    private String description;
    private String fileUrl;
    private Date uploadedAt;

    public Material() {}

    public Material(int id, int courseId, String title, String description, String fileUrl, Date uploadedAt) {
        this.id = id;
        this.courseId = courseId;
        this.title = title;
        this.description = description;
        this.fileUrl = fileUrl;
        this.uploadedAt = uploadedAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCourseId() { return courseId; }
    public void setCourseId(int courseId) { this.courseId = courseId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getFileUrl() { return fileUrl; }
    public void setFileUrl(String fileUrl) { this.fileUrl = fileUrl; }

    public Date getUploadedAt() { return uploadedAt; }
    public void setUploadedAt(Date uploadedAt) { this.uploadedAt = uploadedAt; }
}