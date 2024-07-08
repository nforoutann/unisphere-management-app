package objects.serializable;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public class Course implements Serializable {
    private String code;
    private String title;
    private String teacher;
    private String credit;
    private String numberOfDefinedAssignments;
    private String nameOfBestStudent;
    private List<String> time;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTeacher() {
        return teacher;
    }

    public void setTeacher(String teacher) {
        this.teacher = teacher;
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

    public List<String> getTime() {
        return time;
    }

    public void setTime(List<String> time) {
        this.time = time;
    }
}
