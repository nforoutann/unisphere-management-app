package dataManagement;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

public class Database {
    private static Database instance;

    private static final String usersPath = "src/main/java/data/users.txt";
    private static final String termsPath = "src/main/java/data/terms.txt";
    private static final String coursesPath = "src/main/java/data/courses.txt";
    private static final String assignmentsPath = "src/main/java/data/assignments.txt";
    private static final String newsPath = "src/main/java/data/news.txt";

    private final HashMap<String, Table> tables;

    private HashMap <String, HashMap <String, String>> usersDataMap;
    private HashMap <String, HashMap <String, String>> termsDataMap;
    private HashMap <String, HashMap <String, String>> coursesDataMap;
    private HashMap <String, HashMap <String, String>> assignmentsDataMap;
    private HashMap <String, HashMap <String, String>> newsDataMap;

    public static Database getInstance() {
        if (instance == null) {
            instance = new Database();
        }
        return instance;
    }

    private Database() {
        tables = new HashMap<>();
        tables.put("usersData", new Table(usersPath));
        tables.put("termsData", new Table(termsPath));
        tables.put("coursesData", new Table(coursesPath));
        tables.put("assignmentsData", new Table(assignmentsPath));
        tables.put("newsData", new Table(newsPath));

        usersDataMap = Convertor.UserArrayToMap(tables.get("usersData").get());
        termsDataMap = Convertor.UserArrayToMap(tables.get("termsData").get());
        coursesDataMap = Convertor.UserArrayToMap(tables.get("coursesData").get());
        assignmentsDataMap = Convertor.UserArrayToMap(tables.get("assignmentsData").get());
        newsDataMap = Convertor.UserArrayToMap(tables.get("newsData").get());
    }

    public Table getTable(String tableName) {
        return tables.get(tableName);
    }

    public HashMap<String, HashMap<String, String>> getUsersDataMap() {
        usersDataMap = Convertor.UserArrayToMap(tables.get("usersData").get());
        return usersDataMap;
    }

    public HashMap<String, HashMap<String, String>> getTermsDataMap() {
        termsDataMap = Convertor.UserArrayToMap(tables.get("termsData").get());
        return termsDataMap;
    }

    public HashMap<String, HashMap<String, String>> getCoursesDataMap() {
        coursesDataMap = Convertor.UserArrayToMap(tables.get("coursesData").get());
        return coursesDataMap;
    }

    public HashMap<String, HashMap<String, String>> getAssignmentsDataMap() {
        assignmentsDataMap = Convertor.UserArrayToMap(tables.get("assignmentsData").get());
        return assignmentsDataMap;
    }

    public HashMap<String, HashMap<String, String>> getNewsDataMap() {
        newsDataMap = Convertor.UserArrayToMap(tables.get("newsData").get());
        return newsDataMap;
    }

    public boolean isUsernameAvailable(String username){
        return getUsersDataMap().containsKey(username);
    }

    public void createUser(String role, String username, String password, String name, String email){
        String result="", info="";
        switch(role.split("\\$")[0]){
            case "student":
                int id = Integer.parseInt(role.split("\\$")[1]);
                result="username>"+username+",,password>"+password+",,name>"+name+",,id>"+id+",,email>"+email+",,role>student,,terms>{},,currentTerm>1,,tasks>{}";
                break;
            case "teacher":
                result="username>"+username+",,password>"+password+",,name>"+name+",,email>"+email+",,courses>{}";
                break;
        }
        info = Convertor.mapOfUsersToString(getCoursesDataMap());
        info = info + result;
        try{
            PrintWriter pw = new PrintWriter(new FileWriter(usersPath), true);
            pw.print(info);
            pw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static boolean doesUsernameMatchPassword(String username, String password){
        return getInstance().getUsersDataMap().containsKey(username) && getInstance().getUsersDataMap().get(username).get("password").equals(password);
    }
}