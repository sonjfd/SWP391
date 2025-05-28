/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ASUS
 */
public class Breed {
    private int id;
    private Specie specie;
    private String name;

    public Breed() {
    }

    public Breed(int id, Specie specie, String name) {
        this.id = id;
        this.specie = specie;
        this.name = name;
    }

    public Breed(int id) {
        this.id = id;
    }

    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Specie getSpecie() {
        return specie;
    }

    public void setSpecie(Specie specie) {
        this.specie = specie;
    }

    

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Breed{" + "id=" + id + ", specie=" + specie + ", name=" + name + '}';
    }
    
    
}
