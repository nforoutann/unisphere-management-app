package objects.main;

import java.util.Date;

public class Exam {
    private ExamType type;
    private Date date;
    private boolean active;
    private int id;


    Exam(ExamType type, Date date) {
        this.type = type;
        this.date = date;
    }
    public ExamType getType() {
        return type;
    }
    public Date getDate() {
        return date;
    }
    public boolean isActive() {
        return active;
    }
    public int getId() {
        return id;
    }

    public void setActive(boolean active){
        this.active = active;
    }
    public void setId(int id){
        this.id = id;
    }
    public void setType(ExamType type){
        this.type = type;
    }
    public void setDate(Date date){
        this.date = date;
    }


    @Override
    public boolean equals(Object o) {
        return this.id == ((Exam) o).id;
    }

}

enum ExamType{
    Quiz,
    MidTerm,
    FinalTerm,
}