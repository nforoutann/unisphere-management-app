package objects.main;

import java.util.List;


public class Term {
    private int termNumber =0;
    boolean active = false;
    private List<Course> courses;

    public Term(int termNumber, List<Course> courses) {
        this.termNumber = termNumber;
        this.courses = courses;
    }

    public int getTotalCredits(){
        int Credits=0;
        for(int i=0 ; i<courses.size() ; i++){
            Credits+=courses.get(i).getCredit();
        }
        return Credits;
    }

    public int getTermNumber(){
        return termNumber;
    }

    public List<Course> getCourses() {
        return courses;
    }

    public void addCourse(Course course){
        courses.add(course);
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public boolean isActive() {return active;}
}
