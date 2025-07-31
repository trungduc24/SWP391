/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Course {
     private int id;
    private String name;
    private String code;
    private String room;

    // Constructors, getters, setters
    public Course() {}

    public Course(int id, String name, String code, String room) {
        this.id = id;
        this.name = name;
        this.code = code;
        this.room = room;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public String getRoom() { return room; }
    public void setRoom(String room) { this.room = room; }
}