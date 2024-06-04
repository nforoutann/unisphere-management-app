package database;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Scanner;

public class Table {
    private String studentPath;
    private String teacherPath;
    public Table(String studentPath, String teacherPath) {
        this.studentPath = studentPath;
        this.teacherPath = teacherPath;
    }
    public ArrayList<HashMap <String, String>> get(String role) throws Exception {
        File file=null;
        switch (role) {
            case "student": file = new File(studentPath); break;
            case "teacher": file = new File(teacherPath); break;
            default: throw new Exception("Invalid role");
        }
        try {
            Scanner sc = new Scanner(file);
            ArrayList<HashMap<String, String>> res = new ArrayList<>();
            while (sc.hasNextLine())
                res.add(Convertor.stringToMap(sc.nextLine()));
            sc.close();
            return res;
        }
        catch (Exception e) {
            return new ArrayList<>();
        }
    }
    
}
