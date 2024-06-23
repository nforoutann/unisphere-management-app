package dataManagement;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
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

    public boolean isUsernameAvailable(String username) {
        return getStudentDataMap().containsKey(username) || getTeacherDataMap().containsKey(username);
    }

    public void createUser(String role, String username, String password, String name, String email){
        String result="", info="";
        switch(role.split("\\$")[0]){
            case "student":
                int id = Integer.parseInt(role.split("\\$")[1]);
                result="username:"+username+",,password:"+password+",,name:"+name+",,id:"+id+",,email:"+email+",,terms:{}";
                info = Convertor.mapOfUsersToString(getStudentDataMap());
                info = info + result;
                try{
                    PrintWriter pw = new PrintWriter(new FileWriter(studentsPath), true);
                    pw.print(info);
                    pw.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
                break;
            case "teacher":
                result="username:"+username+",,password:"+password+",,name:"+name+",,email:"+email+",,courses:{}";
                info = Convertor.mapOfUsersToString(getTeacherDataMap());
                info = info + result;
                try{
                    PrintWriter pw = new PrintWriter(new FileWriter(teachersPath), true);
                    pw.print(info);
                    pw.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
                break;
        }
    }

    public static boolean doesUsernameMatchPassword(String username, String password){
        boolean studentSide = getInstance().getStudentDataMap().containsKey(username) && getInstance().getStudentDataMap().get(username).get("password").equals(password);
        boolean teacherSide = getInstance().getTeacherDataMap().containsKey(username) && getInstance().getTeacherDataMap().get(username).get("password").equals(password);
        return studentSide || teacherSide;
    }
}