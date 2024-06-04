package objects;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Teacher extends User {

    List<Course> courses;

    public Teacher(String firstName, String lastName, int id) {
        super(firstName, lastName, id);
        courses = new ArrayList<>();
    }

    public int numberOfCourses() {
        return courses.size();
    }

    public void addCourseOneByOne(Course course) throws Exception {
        if(courses.contains(course) && course.getTeacher().equals(this)) {
            courses.add(course);
        } else{
            throw new Exception("Action not valid");
        }
    }

    public void addListCourses(List<Course> listOfCourses) throws Exception {
        if(listOfCourses.isEmpty()) {
            throw new Exception("List of courses is empty");
        }
        for(Course course : listOfCourses) {
            if(course.getTeacher().equals(this) && !courses.contains(course)) {
                courses.add(course);
            }
        }
    }

    public void defineAssignment(Course course, Assignment assignment) throws Exception{
        if(!this.courses.contains(course)){
            throw new Exception("Course does not exist");
        }
        if(course.getAssignments().contains(assignment))
            throw new Exception("Assignment already exists");

        course.getAssignments().add(assignment);
    }

    public void removeAssignment(Course course, Assignment assignment) throws Exception{
        if(!this.courses.contains(course))
            throw new Exception("Course does not exist");
        if(!course.getAssignments().contains(assignment))
            throw new Exception("Assignment does not exist");

        course.getAssignments().remove(assignment);
    }

    public void addStudent(Student student, Course course) throws Exception{
        if(!this.equals(course.getTeacher())){
            throw new Exception("This teacher is not the teacher of the course");
        }
        if(course.getStudents().contains(student)){
            throw new Exception("This Student already exists");
        }
        course.getStudents().add(student);
        course.getFinalScoreMap().put(student, 0.0);
        student.getCourses().add(course);
    }

    public void removeStudent(Student student, Course course) throws Exception{
        if(!this.equals(course.getTeacher())){
            throw new Exception("This teacher is not the teacher of the course");
        }
        if(!course.getStudents().contains(student)){
            throw new Exception("This Student is not the Student of the course");
        }
        course.getStudents().remove(student);
        course.getFinalScoreMap().remove(student);
        student.getCourses().remove(course);
    }

    public void setScoreByStudent(Course course, Student student, double score) throws Exception{
        if(!this.courses.contains(course))
            throw new Exception("Course does not exist");
        if(!course.getStudents().contains(student))
            throw new Exception("Student does not exist");
        if(!student.getCourses().contains(course))
            throw new Exception("Student does not have the course");

        course.getFinalScoreMap().put(student, score);
    }


    public void addScoreAll(Course course, List<Double> scores) throws Exception{
        boolean exists = false;
        for(Course course1 : courses){
            if(course1.getTitle().equals(course.getTitle())){
                exists = true;
                break;
            }
        }
        if(!exists){
            throw new Exception("Course does not exist");
        }
        if(course.getStudents().size() != scores.size()){
            throw new Exception("the number of students does not match the number of courses");
        }

        course.getFinalScoreMap().clear();
        List<Student> students = course.getStudents();
        Iterator<Double> scoresIterator = scores.iterator();
        for(Student student : students){
             course.getFinalScoreMap().put(student, scoresIterator.next());
        }
    }

    public void addCourseOne(Course course) throws Exception{
        boolean exists = false;
        for(Course course1 : courses){
            if(course1.equals(course)){
                exists = true;
            }
        }
        if(exists)
            throw new Exception("Course already exists");

        courses.add(course);
    }
}
