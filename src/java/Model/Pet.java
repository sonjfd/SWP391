/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author Dell
 */
public class Pet {
    private String id;
    private String pet_code;
    private User user;
    private String name;
    private Date birthDate;
    
    private Breed breed;
    private String gender;
    private String avatar;
    private String description;
    private String status;
    private Date createDate;
    private Date updateDate;


    public Pet() {
    }

    public Pet(String id, String pet_code, User user, String name, Date birthDate, Breed breed, String gender, String avatar, String description, String status, Date createDate, Date updateDate) {
        this.id = id;
        this.pet_code = pet_code;
        this.user = user;
        this.name = name;
        this.birthDate = birthDate;
        this.breed = breed;
        this.gender = gender;
        this.avatar = avatar;
        this.description = description;
        this.status = status;
        this.createDate = createDate;
        this.updateDate = updateDate;
    }

    public String getPet_code() {
        return pet_code;
    }

    public void setPet_code(String pet_code) {
        this.pet_code = pet_code;
    }

   

    
    public Breed getBreed() {
        return breed;
    }

    public void setBreed(Breed breed) {
        this.breed = breed;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

   
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    @Override
    public String toString() {
        return "Pet{" + "id=" + id + ", pet_code=" + pet_code + ", user=" + user + ", name=" + name + ", birthDate=" + birthDate + ", breed=" + breed + ", gender=" + gender + ", avatar=" + avatar + ", description=" + description + ", status=" + status + ", createDate=" + createDate + ", updateDate=" + updateDate + '}';
    }


    
    
    
}
