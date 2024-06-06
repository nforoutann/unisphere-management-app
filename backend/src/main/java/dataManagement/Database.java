package dataManagement;
import objects.Student;
import objects.Teacher;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.util.Formatter;
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
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    public void ceateTeacher(Teacher teacher) {
        String username = teacher.getUsername();
        String password = teacher.getPassword();
        String name= teacher.getName();
        String result="";
        result="username:"+username+",,password:"+password+",,name:"+name+",,terms:{}";
        String info = Convertor.mapOfUsersToString(getTeacherDataMap());
        info = info + '\n' + result;
        try{
            PrintWriter pw = new PrintWriter(new FileWriter(teachersPath));
            pw.println(info);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
