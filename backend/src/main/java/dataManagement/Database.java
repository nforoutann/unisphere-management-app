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


    public static void printMap(HashMap <String, HashMap <String, String>> map, String path) {
        String result="";
        int i=0;
        int j=0;
        try(PrintWriter writer = new PrintWriter(new FileWriter(new File(path)))){
            for(var entry : map.entrySet()){
                for(var entry2 : entry.getValue().entrySet()){
                    result = result + entry2.getKey() + ":" + entry2.getValue();
                    if(entry.getValue().entrySet().size()-1 != j) {
                        result = result + ",,";
                    }
                    j++;
                }
                if(map.entrySet().size()-1==i){
                    break;
                } else{
                    j=0;
                    result = result+'\n';
                }
                i++;
            }
            writer.write(result);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void AddCourseToTeacher(Teacher teacher, Course course){ //todo add assignments and exam??
        String courses="";
        String username = teacher.getUsername();
        HashMap<String, HashMap<String, String>> map = Convertor.copyHashMap(teacherDataMap);
        for(var entry : map.entrySet()){
            if(entry.getKey().equals(teacher.getUsername())){
                courses = entry.getValue().get("courses");
                courses = courses.substring(0, courses.length());
                courses = courses+"/id="+course.getId()+"-name="+course.getTitle()+'}';
                entry.getValue().put("courses", courses);
            }
        }
        map.get(username).put("courses", courses);
        System.out.println(courses);
        printMap(map, teachersPath);
    }
}