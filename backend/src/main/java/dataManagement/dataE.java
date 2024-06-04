package dataManagement;

import java.util.HashMap;
import java.util.Map;

public class dataE {
    private static dataE instance;
    private static String StudentPATH = "./student.txt";
    private static String TeacherPath = "./teacher.txt";
    private dataE(){

    }

    public static dataE getInstance(){return instance==null?instance=new dataE():instance;}
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
