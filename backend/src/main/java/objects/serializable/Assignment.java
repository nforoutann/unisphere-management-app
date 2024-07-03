package objects.serializable;

import java.io.Serializable;
import java.util.Date;

public class Assignment implements Serializable {
    private String assignmentId;
    private String title;
    private double score;
    private AssignmentType type;
    private int estimateTime;
    private Date deadline;
    private Date definedTime;

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

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public AssignmentType getType() {
        return type;
    }

    public void setType(AssignmentType type) {
        this.type = type;
    }

    public int getEstimateTime() {
        return estimateTime;
    }

    public void setEstimateTime(int estimateTime) {
        this.estimateTime = estimateTime;
    }

    public Date getDeadline() {
        return deadline;
    }

    public void setDeadline(Date deadline) {
        this.deadline = deadline;
    }

    public Date getDefinedTime() {
        return definedTime;
    }

    public void setDefinedTime(Date definedTime) {
        this.definedTime = definedTime;
    }
}

