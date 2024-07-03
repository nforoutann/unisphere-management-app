package objects.main;

import java.util.Date;

public class Admin{
    private static int id;
    public static int getId(){
        return id;
    }
    public static void setId(int id){
        Admin.id = id;
    }

    public Teacher createTeacher(String name, String username){
        return new Teacher(name, username);
    }
    //todo remove teacher

    public Student createStudent(String name, String username){
        return new Student(name, username);
    }
    //todo remove student
    public Assignment createAssignment(int MaxScore, String title, assingmentType type, int deadline){
        return new Assignment(MaxScore, title, type, deadline);
    }
    //todo remove assignment
    public Course createCourse(String title, Teacher teacher, int credit, int id){
        return new Course(title, teacher, credit, id);
    }
    //todo remove course
    public Exam createExam(ExamType type, Date date){
        return new Exam(type, date);
    }
}
