package dataManagement;
import objects.*;

import java.io.*;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

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

    public void deleteUser(User user) {
        HashMap<String, HashMap<String, String>> map;
        String filePath;

        if (user instanceof Student) {
            map = Convertor.copyHashMap(getStudentDataMap());
            filePath = studentsPath;
        } else {
            map = Convertor.copyHashMap(getTeacherDataMap());
            filePath = teachersPath;
        }

        map.remove(user.getUsername());
        printMap(map, filePath);
    }


    public void addAssignment(Assignment assignment, Teacher teacher, Course course) {
        HashMap<String, HashMap<String, String>> map = Convertor.copyHashMap(getTeacherDataMap());
        Iterator<Map.Entry<String, HashMap<String, String>>> iterator = map.entrySet().iterator();
        String teacherCourse;
        String newAssignment = "name?" + assignment.getTitle() + "~type?" + assignment.getType() + "~score?" + assignment.getMaxScore();
        String resCourses = "";

        while (iterator.hasNext()) {
            Map.Entry<String, HashMap<String, String>> entry = iterator.next();
            if (entry.getKey().equals(teacher.getUsername())) {
                teacherCourse = entry.getValue().get("courses").substring(1, entry.getValue().get("courses").length() - 1);
                HashMap<String, HashMap<String, String>> courseMap = Convertor.courseToMap(teacherCourse);
                for (Map.Entry<String, HashMap<String, String>> courseEntry : courseMap.entrySet()) {
                    if (courseEntry.getKey().equals(String.valueOf(course.getId()))) {
                        String assignmentsString = courseEntry.getValue().get("assignments");
                        if (assignmentsString == null || assignmentsString.isEmpty()) {
                            assignmentsString = "{" + newAssignment + "}";
                        } else {
                            assignmentsString = assignmentsString.substring(1, assignmentsString.length() - 1);
                            assignmentsString = "{" + assignmentsString + "|" + newAssignment + "}";
                        }
                        courseEntry.getValue().put("assignments", assignmentsString);
                    }
                }

                // Reconstruct the course string and update it in the map
                StringBuilder coursesBuilder = new StringBuilder("{");
                for (Map.Entry<String, HashMap<String, String>> courseEntry : courseMap.entrySet()) {
                    coursesBuilder.append("id=").append(courseEntry.getKey());
                    for (Map.Entry<String, String> detailEntry : courseEntry.getValue().entrySet()) {
                        coursesBuilder.append("-").append(detailEntry.getKey()).append("=").append(detailEntry.getValue());
                    }
                    coursesBuilder.append("/");
                }
                // Remove the last '/' character
                coursesBuilder.deleteCharAt(coursesBuilder.length() - 1);
                coursesBuilder.append("}");

                entry.getValue().put("courses", coursesBuilder.toString());
                break;
            }
        }

        printMap(map, teachersPath);
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
        info = info + result;
        try{
            PrintWriter pw = new PrintWriter(new FileWriter(studentsPath));
            pw.print(info);
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
        info = info + result;
        try{
            PrintWriter pw = new PrintWriter(new FileWriter(teachersPath), true);
            pw.print(info);
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

    public void printNotAppend(HashMap <String, HashMap <String, String>> map, String path){
        String result="";
        int i=0;
        int j=0;
        try(PrintWriter writer = new PrintWriter(new FileWriter(new File(path), true))){
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
                if(courses.equals("{}")){
                    courses = "";
                    courses = "{"+courses+"id="+course.getId()+"-name="+course.getTitle()+'}';
                } else{
                    courses = courses.substring(0, courses.length());
                    courses = "{"+courses+"/id="+course.getId()+"-name="+course.getTitle()+'}';
                }
                entry.getValue().put("courses", courses);
            }
        }
        map.get(username).put("courses", courses);
        System.out.println(courses);
        printMap(map, teachersPath);
    }

    public void deleteCourse(Teacher teacher, String courseId) {
        HashMap<String, HashMap<String, String>> map = Convertor.copyHashMap(getTeacherDataMap());

        String regex = "id=" + courseId + "-name=[^-]+-assignments=\\{[^}]+\\}-exams=\\{[^}]+\\}";

        for (var entry : map.entrySet()) {
            if (entry.getKey().equals(teacher.getUsername())) {
                String courses = entry.getValue().get("courses");
                if (courses != null) {
                    courses = courses.replaceAll(regex, "");

                    courses = courses.replaceAll(",{2,}", ",");
                    courses = courses.replaceAll("^,|,$", "");

                    entry.getValue().put("courses", courses);
                }
            }
        }
        printMap(map, teachersPath);
    }

}