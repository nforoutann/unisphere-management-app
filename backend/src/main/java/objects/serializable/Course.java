package objects.serializable;

import java.io.Serializable;

public class Course implements Serializable {
    private String courseId;
    private String title;
    private String teacherName;
    private String credit;
    private String numberOfDefinedAssignments;
    private String nameOfBestStudent;

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getCredit() {
        return credit;
    }

    public void setCredit(String credit) {
        this.credit = credit;
    }

    public String getNumberOfDefinedAssignments() {
        return numberOfDefinedAssignments;
    }

    public void setNumberOfDefinedAssignments(String numberOfDefinedAssignments) {
        this.numberOfDefinedAssignments = numberOfDefinedAssignments;
    }

    public String getNameOfBestStudent() {
        return nameOfBestStudent;
    }

    public void setNameOfBestStudent(String nameOfBestStudent) {
        this.nameOfBestStudent = nameOfBestStudent;
    }
}
