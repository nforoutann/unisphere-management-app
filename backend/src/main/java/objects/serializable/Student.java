package objects.serializable;

import java.util.List;

public class Student extends User {
    private int id;
    private int credits;
    private int currentTerm;
    private double totalGrade;
    private double bestScore;
    private double worstScore;
    private int numberOfLostAssignments;
    private int numberOfLeftAssignments;
    private int numberOfExams;
    private List<Assignment> doneAssignments;


    public Student(String name, String username) {
        super(name, username);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCredits() {
        return credits;
    }

    public void setCredits(int credits) {
        this.credits = credits;
    }

    public int getCurrentTerm() {
        return currentTerm;
    }

    public void setCurrentTerm(int currentTerm) {
        this.currentTerm = currentTerm;
    }

    public double getTotalGrade() {
        return totalGrade;
    }

    public void setTotalGrade(double totalGrade) {
        this.totalGrade = totalGrade;
    }

    public double getBestScore() {
        return bestScore;
    }

    public void setBestScore(double bestScore) {
        this.bestScore = bestScore;
    }

    public double getWorstScore() {
        return worstScore;
    }

    public void setWorstScore(double worstScore) {
        this.worstScore = worstScore;
    }

    public int getNumberOfLeftAssignments() {
        return numberOfLeftAssignments;
    }

    public void setNumberOfLeftAssignments(int numberOfLeftAssignments) {
        this.numberOfLeftAssignments = numberOfLeftAssignments;
    }

    public int getNumberOfExams() {
        return numberOfExams;
    }

    public void setNumberOfExams(int numberOfExams) {
        this.numberOfExams = numberOfExams;
    }

    public List<Assignment> getDoneAssignments() {
        return doneAssignments;
    }

    public void setDoneAssignments(List<Assignment> doneAssignments) {
        this.doneAssignments = doneAssignments;
    }

    public int getNumberOfLostAssignments() {
        return numberOfLostAssignments;
    }

    public void setNumberOfLostAssignments(int numberOfLostAssignments) {
        this.numberOfLostAssignments = numberOfLostAssignments;
    }
}