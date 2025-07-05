package model;

public class Course {
    private int courseId;
    private String name;
    private String code;

    // Constructors
    public Course() {
    }

    public Course(int courseId, String name, String code) {
        this.courseId = courseId;
        this.name = name;
        this.code = code;
    }

    // Getters and Setters
    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Override
    public String toString() {
        return "Course{" +
               "courseId=" + courseId +
               ", name='" + name + '\'' +
               ", code='" + code + '\'' +
               '}';
    }
}