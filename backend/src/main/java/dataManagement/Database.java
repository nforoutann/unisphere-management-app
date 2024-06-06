package dataManagement;
import objects.Course;
import objects.Student;
import objects.Teacher;
import objects.Term;

import java.io.*;
import java.util.HashMap;

public class Database {
    private static Database instance;
    private static String studentsPath = "src/main/java/data/students.txt";
    private static String teachersPath = "src/main/java/data/teachers.txt";
    private HashMap<String, Table> tables;
    private HashMap <String, HashMap <String, String>> studentDataMap;
    private HashMap <String, HashMap <String, String>> teacherDataMap;

    public static Database getInstance() {
        if (instance == null) {
            instance = new Database();
        }
        return instance;
    }
    private Database() {
        tables = new HashMap<>();
        tables.put("studentData", new Table(studentsPath));
        tables.put("teacherData", new Table(teachersPath));

        studentDataMap = Convertor.UserArrayToMap(tables.get("studentData").get());
        teacherDataMap = Convertor.UserArrayToMap(tables.get("teacherData").get());
    }

    public Table getTable(String tableName) {
        return tables.get(tableName);
    }

    public HashMap<String, HashMap<String, String>> getStudentDataMap() {
        studentDataMap = Convertor.UserArrayToMap(tables.get("studentData").get());
        return studentDataMap;
    }

    public HashMap<String, HashMap<String, String>> getTeacherDataMap() {
        teacherDataMap = Convertor.UserArrayToMap(tables.get("teacherData").get());
        return teacherDataMap;
    }

    public HashMap <String, String> getTotalUsernamePassword(){
        HashMap <String, String> result = new HashMap<>();
        for(var entry : getStudentDataMap().entrySet()){
            result.put(entry.getKey(), entry.getValue().get("password"));
        }
        for(var entry : getTeacherDataMap().entrySet()){
            result.put(entry.getKey(), entry.getValue().get("password"));
        }
        return result;
    }

    public void ceateStudent(Student student) {
        String username = student.getUsername();
        String password = student.getPassword();
        String name= student.getName();
        String result="";
        result="username:"+username+",,password:"+password+",,name:"+name+",,terms:{}";
        String info = Convertor.mapOfUsersToString(getStudentDataMap());
        info = info + '\n' + result;
        try{
            PrintWriter pw = new PrintWriter(new FileWriter(studentsPath));
            pw.println(info);
            pw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    public void ceateTeacher(Teacher teacher) {
        String username = teacher.getUsername();
        String password = teacher.getPassword();
        String name= teacher.getName();
        String result="";
        result="username:"+username+",,password:"+password+",,name:"+name+",,courses:{}";
        String info = Convertor.mapOfUsersToString(getTeacherDataMap());
        info = info + '\n' + result;
        try{
            PrintWriter pw = new PrintWriter(new FileWriter(teachersPath));
            pw.println(info);
            pw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void addTerm(Student student, Term term) {
        String username = student.getUsername();
        HashMap<String, String> info = getStudentDataMap().get(username);
        String termStr = info.get("terms");
        termStr=termStr+" ";
        String currentTerm = Convertor.termObjectToString(term, student);
        String complete = termStr + currentTerm;
        getStudentDataMap().get(username).put("terms", complete);


    }

    public static void printMap(HashMap <String, HashMap <String, String>> map, String path, String role) {
        String result="";
        int i=0;
        try{
            ObjectOutputStream outputStream = new ObjectOutputStream(new FileOutputStream(path));
            PrintWriter writer = new PrintWriter(new FileWriter(new File(path)));
            for(var entry : map.entrySet()){
                if(i!=0){
                    result=result+'\n';
                    i++;
                }
                if(role.equals("teacher")){
                    result=result+"username:"+entry.getKey()+",,password:"+entry.getValue().get("password:")+",,name:"+entry.getValue().get("name")+",,courses:"+entry.getValue().get("courses");
                } else{
                    result=result+"username:"+entry.getKey()+",,password:"+entry.getValue().get("password:")+",,name:"+entry.getValue().get("name")+",,terms:"+entry.getValue().get("terms");
                }
            }
            writer.write(result);
            writer.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void AddCourseToTeacher(Teacher teacher, Course course){
        String courses="";
        String username = teacher.getUsername();
        for(var entry : getTeacherDataMap().entrySet()){
            if(entry.getKey().equals(teacher.getUsername())){
                courses = entry.getValue().get("courses");
                courses = courses+"/id="+course.getId()+"-name="+course.getTitle();
                entry.getValue().put("courses", courses);
                break;
            }
        }
        teacherDataMap.get(username).put("courses", courses);
        printMap(teacherDataMap,teachersPath ,"teacher");

    }

}