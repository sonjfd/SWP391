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
    private User user;
    private String name;
    private Date birthDate;
    private Specie specie;
    private String gender;
    private String avatar;
    private Date createDate;
    private Date updateDate;

    public Pet() {
    }

    public Pet(String id, User user, String name, Date birthDate, Specie specie, String gender, String avatar, Date createDate, Date updateDate) {
        this.id = id;
        this.user = user;
        this.name = name;
        this.birthDate = birthDate;
        this.specie = specie;
        this.gender = gender;
        this.avatar = avatar;
        this.createDate = createDate;
        this.updateDate = updateDate;
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

    public Specie getSpecie() {
        return specie;
    }

    public void setSpecie(Specie specie) {
        this.specie = specie;
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
        return "Pet{" + "id=" + id + ", user=" + user + ", name=" + name + ", birthDate=" + birthDate + ", specie=" + specie + ", gender=" + gender + ", avatar=" + avatar + ", createDate=" + createDate + ", updateDate=" + updateDate + '}';
    }
    
    
    
}
