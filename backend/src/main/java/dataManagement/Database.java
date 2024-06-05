package dataManagement;
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
        return studentDataMap;
    }

    public HashMap<String, HashMap<String, String>> getTeacherDataMap() {
        return teacherDataMap;
    }

    public HashMap <String, String> getTotalUsernamePassword(){
        HashMap <String, String> result = new HashMap<>();
        for(var entry : studentDataMap.entrySet()){
            result.put(entry.getKey(), entry.getValue().get("password"));
        }
        for(var entry : teacherDataMap.entrySet()){
            result.put(entry.getKey(), entry.getValue().get("password"));
        }
        return result;
    }
}
