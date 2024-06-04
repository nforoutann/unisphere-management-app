package objects;

public class Assignment {
    private boolean active=true;
    private int MaxScore;
    private String title;
    private assingmentType type;
    private int deadline; //todo better use Date class for deadline. here just for easy use

    public Assignment(int MaxScore, String title, assingmentType type, int deadline) {
        this.MaxScore = MaxScore;
        this.title = title;
        this.type = type;
        this.deadline = deadline;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public void setDeadline(int deadline) {
        this.deadline = deadline;
    }

}

enum assingmentType{
    EXERCISE, PROJECT
}