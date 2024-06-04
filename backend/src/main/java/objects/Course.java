package objects;

import java.util.*;


public class Course {
    private String title;
    private Teacher teacher;
    private int credit;
    private int id;

    private boolean active=true;
    private List<Student> students = new ArrayList<>();
    private Map<Student, Double> finalScores = new HashMap<>();
    private List<Assignment> assignments=new ArrayList<>();
    private Map<Exam, Date> examDates=new HashMap<>();

    public Course(String title, Teacher teacher, int credit, int id) {
        this.title = title;
        this.teacher = teacher;
        this.credit = credit;
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public Teacher getTeacher() {
        return teacher;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public String getTitle() {
        return title;
    }

    public List<Assignment> getAssignments() {
        return assignments;
    }

    public int getCredit() {
        return credit;
    }

    public int getNumberOfAssignments() {
        return assignments.size();
    }

    public List<Student> getStudents() {
        return students;
    }

    public int getNumStudents() {
        return students.size();
    }

    public double getGradeByStudent(Student student) throws Exception{
        boolean found=false;
        int index=0;
        Double grade=0.0;

        for(Map.Entry<Student, Double> entry : finalScores.entrySet()){
            if(entry.getKey().equals(student)){
                found=true;
                grade=entry.getValue();
                break;
            }
        }
        if(!found)
            throw new Exception("Student not found");
        return grade;
    }

    public void setGradesAll(List<Double> grades) throws Exception{ //todo check what are you doing exactly
        if(grades.isEmpty())
            throw new Exception("the list is empty");
        if(grades.size()!=students.size())
            throw new Exception("the number of students does not match the number of grades");


        Iterator<Map.Entry<Student, Double>> mapIterator = finalScores.entrySet().iterator();
        Iterator<Double> listIterator = grades.iterator();
        while(mapIterator.hasNext() && listIterator.hasNext()){
            Map.Entry<Student, Double> entry = mapIterator.next();
            Double score = listIterator.next();
            entry.setValue(score);
        }

    }

    public void setExamDate(Date examDate, Exam exam) throws Exception {
        if(examDate==null || exam==null)
            throw new Exception("the exam or exam date cannot be null");
        examDates.put(exam, examDate);
    }

    public List<Double> getFinalScores() {
        List<Double> result = new ArrayList<>();
        for(Map.Entry<Student, Double> entry : finalScores.entrySet()){
            result.add(entry.getValue());
        }
        return result;
    }

    public Map<Student, Double> getFinalScoreMap() {
        return finalScores;
    }

    public void UpdateAssignment(Assignment assignment, boolean active) throws Exception{
        if(assignments.contains(assignment)){
            assignment.setActive(active);
        } else
            throw new Exception("Assignment not found");
    }

    public void ChangeDeadline(Assignment assignment, int deadline) throws Exception{
        if(assignments.contains(assignment)){
            assignment.setDeadline(deadline);
        } else
            throw new Exception();
    }

    public void removeStudent(Student student) throws Exception{
        if(!students.contains(student))
            throw new Exception("Student not found");

        students.remove(student);
        finalScores.remove(student);
    }

    public void addStudent(Student student) throws Exception{
        boolean found=false;
        for(Map.Entry<Student, Double> entry : finalScores.entrySet()){
            if(entry.getKey().equals(student)){
                found=true;
                break;
            }
        }
        for(int i=0 ; i<students.size(); i++){
            if(students.get(i).equals(student)){
                found=true;
                break;
            }
        }
        if(found){
            throw new Exception("Student already exists");
        }

        students.add(student);
        finalScores.put(student, 0.0);
    }

    public Double findMaxScore(){
        Double max=0.0;
        for(Map.Entry<Student, Double> entry : finalScores.entrySet()){
            if(entry.getValue()>max)
                max = entry.getValue();
        }
        return max;
    }

    public void setAllScores(Map<Student, Double> scores) throws Exception{
        if(scores.size()!=finalScores.size() || scores.size()!=students.size())
            throw new Exception("the number of students does not match with the scores");

        this.finalScores = scores;
    }

    @Override
    public boolean equals(Object object){
        return this.id == ((Course)object).getId();
    }

}
