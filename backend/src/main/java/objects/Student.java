package objects;

import java.util.ArrayList;
import java.util.List;

public class Student extends User {
    public Student(String name, String username) {
        super(name, username);
        terms = new ArrayList<>();
    }
    private List<Term> terms;
    private Term currentTerm;
    private List<Course> courses = new ArrayList<>(); //todo to map
    private int numberOfCourses;
    private int numberOfCredits;
    private double currentGrade=0;
    private double totalGrade=0;

    public int getNumberOfCredits() throws Exception{
        update();
        return numberOfCredits;
    }

    public void update() throws Exception{
        numberOfCredits = currentTerm.getTotalCredits();
        currentGrade =0;
        courses = currentTerm.getCourses();
        numberOfCourses = courses.size();
    }

    public Double getCurrentGrade() throws Exception{
        Double currentGrade = 0.0;
        int counter=0;
        for(int i=0 ; i<courses.size() ; i++){
            counter += courses.get(i).getCredit();
            currentGrade += (courses.get(i).getGradeByStudent(this)*courses.get(i).getCredit());
        }
        this.currentGrade = currentGrade/counter;
        return this.currentGrade;
    }

    public double getToltalGrade() throws Exception{
        totalGrade = getTotalGrade();
        return totalGrade;
    }

    public void addCourse(Course course) throws Exception {
        for (Course c : courses) {
            if(c.equals(course)) {
                throw new Exception("Course already exists");
            }
        }
        currentTerm.addCourse(course);
        courses = currentTerm.getCourses();
    }

    public void addTerm(Term term) throws Exception{
        for(int i=0 ; i<terms.size(); i++){
            if(terms.get(i).getTermNumber() == term.getTermNumber())
                throw new Exception("Term already exists");
        }

        terms.add(term);
        terms.sort((t1, t2) -> Integer.compare(t1.getTermNumber(), t2.getTermNumber()));
        for(int i=0 ; i<terms.size()-1; i++){
            terms.get(i).setActive(true);
        }
        currentTerm = terms.get(terms.size()-1);
        update();

    }

    public int getNumberOfCourses() throws Exception{
        update();
        return numberOfCourses;
    }

    public double getTotalGrade() throws Exception{
        double totalGrade = 0;
        int counter=0;
        for(int i=0 ; i<terms.size() ; i++){
            for(int j=0 ; j<courses.size() ; j++){
                if(courses.get(j).getStudents().contains(this)){
                    totalGrade += (courses.get(j).getGradeByStudent(this)*courses.get(j).getCredit());
                    counter += courses.get(j).getCredit();
                }
            }
        }
        this.totalGrade = totalGrade/counter;
        return totalGrade;
    }

    public List<Course> getCourses() throws Exception{
        if(courses.isEmpty())
            throw new Exception("Course list is empty");

        return courses;
    }

    public double getCourseScoreByTerm(Term term, Course course) throws Exception{
        if(term == null){
            throw new Exception("Term is null");
        }
        if(!term.getCourses().contains(course)){
            throw new Exception("Course does not exist");
        }
        for(var thisTerm: terms){
            for(var thisCourse: thisTerm.getCourses()){
                if(thisCourse.equals(course)){
                    return thisCourse.getGradeByStudent(this);
                }
            }
        }
        throw new Exception("Course does not exist");
    }

}
