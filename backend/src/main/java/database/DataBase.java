package database;

import java.util.HashMap;
import java.util.Map;

public class DataBase {
    private static DataBase instance;
    private static String StudentPATH = "./student.txt";
    private static String TeacherPath = "./teacher.txt";
    private DataBase(){

    }

    public static DataBase getInstance(){return instance==null?instance=new DataBase():instance;}
    public static Map<String, String> studentPasswordUsername(){
        return new HashMap<String, String>();
    }
    public static Map<String, String> teacherPasswordUsername(){
        return new HashMap<String, String>();
    }
    public static Map<String, String> getUserDataMap(){
        return new HashMap<String, String>();
    }
    public static Map<String, String> getTeacherDataMap(){
        return new HashMap<String, String>();
    }


}
