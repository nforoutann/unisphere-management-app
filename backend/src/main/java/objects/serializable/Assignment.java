package objects.serializable;

import java.io.Serializable;

public class Assignment implements Serializable {
    private String assignmentId;
    private String title;
    private String score;
    private boolean active;
    private boolean done;
    private AssignmentType type;
    private String deadline;
    private String definedTime;
    private String courseName;
    private String description;

    public String getAssignmentId() {
        return assignmentId;
    }

    public void setAssignmentId(String assignmentId) {
        this.assignmentId = assignmentId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public AssignmentType getType() {
        return type;
    }

    public void setType(AssignmentType type) {
        this.type = type;
    }

    public String getDeadline() {
        return deadline;
    }

    public void setDeadline(String deadline) {
        this.deadline = deadline;
    }

    public String getDefinedTime() {
        return definedTime;
    }

    public void setDefinedTime(String definedTime) {
        this.definedTime = definedTime;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public boolean isDone() {
        return done;
    }

    public void setDone(boolean done) {
        this.done = done;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}