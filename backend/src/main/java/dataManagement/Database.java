package dataManagement;
import objects.serializable.Student;
import objects.serializable.User;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

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

        usersDataMap = Convertor.ArrayToMap(tables.get("usersData").get(), "username");
        termsDataMap = Convertor.ArrayToMap(tables.get("termsData").get(), "termId");
        coursesDataMap = Convertor.ArrayToMap(tables.get("coursesData").get(), "courseId");
        assignmentsDataMap = Convertor.ArrayToMap(tables.get("assignmentsData").get(), "assignmentId");
        newsDataMap = Convertor.ArrayToMap(tables.get("newsData").get(), "title");
    }

    //todo use ReentrantReadWriteLock for reading and writing in multithreading

    public Table getTable(String tableName) {
        return tables.get(tableName);
    }

    public HashMap<String, HashMap<String, String>> getUsersDataMap() {
        usersDataMap = Convertor.ArrayToMap(tables.get("usersData").get(), "username");
        return usersDataMap;
    }

    public HashMap<String, HashMap<String, String>> getTermsDataMap() {
        termsDataMap = Convertor.ArrayToMap(tables.get("termsData").get(), "termId");
        return termsDataMap;
    }

    public HashMap<String, HashMap<String, String>> getCoursesDataMap() {
        coursesDataMap = Convertor.ArrayToMap(tables.get("coursesData").get(), "courseId");
        return coursesDataMap;
    }

    public HashMap<String, HashMap<String, String>> getAssignmentsDataMap() {
        assignmentsDataMap = Convertor.ArrayToMap(tables.get("assignmentsData").get(), "assignmentId");
        return assignmentsDataMap;
    }

    public HashMap<String, HashMap<String, String>> getNewsDataMap() {
        newsDataMap = Convertor.ArrayToMap(tables.get("newsData").get(), "title");
        return newsDataMap;
    }


    //todo change the way u use file reading in each step of getDataMap, u can for example add to the list and add to the file,, see which one is better

    public String getPassword(String username){
        return getInstance().getUsersDataMap().get(username).get("password");
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

    public boolean doesUsernameMatchPassword(String username, String password){
        return getInstance().getUsersDataMap().containsKey(username) && getInstance().getUsersDataMap().get(username).get("password").equals(password);
    }

    public String getId(String username){
        return getInstance().getUsersDataMap().get(username).get("id");
    }

    private List<String> getOngoingTasksTitle(String username){
        String tasksStr= getInstance().getUsersDataMap().get(username).get("tasks");
        if(tasksStr.equals("{}")){
            return new ArrayList<>();
        }
        tasksStr = tasksStr.substring(1, tasksStr.length()-1);
        String[] tasksArray = tasksStr.split("//");
        return Arrays.stream(tasksArray)
                .filter(a -> a.split("~")[1].equals("yes"))
                .map(a -> a.split("~")[0])
                .collect(Collectors.toList());
    }

    private int getTheCredits(String username){
        //todo different process and meaning for the students and teachers
        int totalCredits = 0;
        String currentTerm = getInstance().getUsersDataMap().get(username).get("currentTerm");
        String currentTermId = getId(username)+'&'+currentTerm;
        String courses = getInstance().getTermsDataMap().get(currentTermId).get("courses");
        courses = courses.substring(1, courses.length()-1);
        String[] coursesIds = courses.split("//");
        for(String coursesId : coursesIds){
            totalCredits = totalCredits + Integer.parseInt(getInstance().getCoursesDataMap().get(coursesId).get("credit"));
        }
        return totalCredits;
    }

    private Double getScore(String username, String which){
        Double res = 0.0;
        String id = getId(username);
        String currentTermId = id+'&'+getInstance().getUsersDataMap().get(username).get("currentTerm");
        String courses = getInstance().getTermsDataMap().get(currentTermId).get("courses");
        if(courses.equals("{}")){
            return null;
        }
        List<Double> list = new ArrayList<>();
        courses = courses.substring(1, courses.length()-1);
        String[] coursesIds = courses.split("//");
        list = Arrays.stream(coursesIds)
                .map(a -> getInstance().getCoursesDataMap().get(a).get("assignments"))
                .filter(a -> !a.equals("{}"))
                .map(a -> a.substring(1, a.length()-1))
                .flatMap(a -> Stream.of(a.split("//")))
                .filter(a -> a.endsWith("~yes"))
                .map(a -> a.split("~")[0])
                .map(a -> getInstance().getAssignmentsDataMap().get(a).get("students"))
                .filter(a -> !a.equals("{}"))
                .map(a -> a.substring(1, a.length()-1))
                .flatMap(students -> Arrays.stream(students.split("//")))
                .filter(student -> student.startsWith(id))
                .map(a -> a.split("~")[1])
                .map(a -> Double.parseDouble(a))
                .sorted()
                .collect(Collectors.toList());
        switch(which){
            case "min":
                return list.getFirst();
            case "max":
                return list.getLast();
        }
        return null;
    }

    private int numberOfDoneAssignments(String username){
        String courses = getInstance().getTermsDataMap()
                .get(getId(username)+'&'+getInstance().getUsersDataMap().get(username).get("currentTerm"))
                .get("courses");
        if(courses.equals("{}")){
            return 0;
        }
        courses = courses.substring(1, courses.length()-1);
        String[] coursesIds = courses.split("//");
        return Arrays.stream(coursesIds)
                .map(a -> getInstance().getCoursesDataMap().get(a).get("assignments"))
                .filter(a -> !a.equals("{}"))
                .map(a -> a.substring(1, a.length()-1))
                .flatMap(a -> Stream.of(a.split("//")))
                //.filter(a -> a.split("~")[1].equals("yes"))
                .map(a -> a.split("~")[0])
                .map(a -> getInstance().getAssignmentsDataMap().get(a).get("students"))
                .filter(a -> !a.equals("{}"))
                .map(a -> a.substring(1, a.length()-1))
                .flatMap(a -> Stream.of(a.split("//")))
                .filter(a -> a.startsWith(getId(username)))
                .filter(a -> a.endsWith("no"))
                .toList()
                .size();
    }

    private HashMap<String, HashMap<String, String>> getDoneAssignments(String username){
        String courses = getInstance().getTermsDataMap()
                .get(getId(username)+'&'+getInstance().getUsersDataMap().get(username).get("currentTerm"))
                .get("courses");
        if(courses.equals("{}")){
            return null;
        }
        courses = courses.substring(1, courses.length()-1);
        String[] coursesIds = courses.split("//");
        HashMap<String, HashMap<String, String>> res = new HashMap<>();
        Arrays.stream(coursesIds)
                .map(a -> getInstance().getCoursesDataMap().get(a).get("assignments"))
                .filter(a -> !a.equals("{}"))
                .map(a -> a.substring(1, a.length()-1))
                .flatMap(a -> Stream.of(a.split("//")))
                .map(a -> a.split("~")[0])
                .forEach(a -> res.put(a, getInstance().getAssignmentsDataMap().get(a)));
        return res;
    }

    public User getUserInfo(String username){

        if(getUsersDataMap().containsKey(username)){
            if(getInstance().getUsersDataMap().get(username).get("role").equals("student")){
                //preparing the data
                String name = getInstance().getUsersDataMap().get(username).get("name");
                String password = getPassword(username);
                int id = Integer.parseInt(getInstance().getUsersDataMap().get(username).get("id"));
                int currentTerm = Integer.parseInt(getInstance().getUsersDataMap().get(username).get("currentTerm"));
                int numberOfExams = Integer.parseInt(getInstance().getUsersDataMap().get(username).get("nExams"));
                String email = getInstance().getUsersDataMap().get(username).get("email");
                String birthStr = getInstance().getUsersDataMap().get(username).get("birthday");
                Date birthday = null;
                if(!birthStr.equals("{}")){
                    birthStr = birthStr.substring(1, birthStr.length()-1);
                    String[] birthdayArray = birthStr.split("-");
                    birthday = new Date(Integer.parseInt(birthdayArray[0]), Integer.parseInt(birthdayArray[1]), Integer.parseInt(birthdayArray[2]));
                }
                double totalGrade = totalGrade(username);
                int totalCredits = getTheCredits(username);
                List<String> ongoingTasks = getOngoingTasksTitle(username);
                Double minScore = getScore(username, "min");
                Double maxScore = getScore(username, "max");
                int numberOfLeftAssignments = numberOfDoneAssignments(username);

                //make the object
                Student student = new Student(name, username);
                student.setPassword(password);
                student.setBirthday(birthday);
                student.setEmail(email);
                student.setOngoingTasks(ongoingTasks);
                student.setId(id);
                student.setCredits(totalCredits);
                student.setCurrentTerm(currentTerm);
                student.setTotalGrade(totalGrade);
                student.setBestScore(maxScore);
                student.setWorstScore(minScore);
                student.setNumberOfLeftAssignments(numberOfLeftAssignments);
                student.setNumberOfExams(numberOfExams);
                student.setDoneAssignments(Convertor.mapToListOfAssignments(getDoneAssignments(username)));

                return student;
            }else{
                // todo for teacher info = info + getInstance().getUsersDataMap().get(username).get("name") + '$' + getInstance().getUsersDataMap().get(username).get("currentTerm") + '$' + getInstance().getUsersDataMap().get(username).get("email") + '$' + getInstance().getUsersDataMap().get(username).get("birthday") + '$' + getInstance().getUsersDataMap().get(username).get("tasks");
            }
        } else{
            return null;
        }
        return null;
    }

    public double totalGrade(String username){
        String id = getId(username);
        int currentTerm = Integer.parseInt(getInstance().getUsersDataMap().get(username).get("currentTerm"));
        if(currentTerm == 1){
            return 0;
        }
        String term;
        double totalScore = 0.0;
        int totalCredit = 0;
        HashMap<String, Double> grades = new HashMap<>();
        String courses;
        String studentsScore;
        String[] info;

        for(int i=1 ; i<currentTerm ; i++){
            term = id+'&'+i;
            courses = getInstance().getTermsDataMap().get(term).get("courses");
            if(courses.equals("{}")){
                continue;
            }
            courses = courses.substring(1, courses.length()-1);
            String[] courseIds = courses.split("//");
            for(String courseId : courseIds){
                int thisCredit = Integer.parseInt(getInstance().getCoursesDataMap().get(courseId).get("credit"));
                totalCredit = totalCredit + thisCredit;
                studentsScore = getInstance().getCoursesDataMap().get(courseId).get("students");
                if(studentsScore.equals("{}")){
                    continue;
                }
                studentsScore.substring(1, studentsScore.length()-1);
                if(studentsScore.contains("//")){
                    info = studentsScore.split("//");
                } else{
                    info = new String[]{studentsScore};
                }

                for(String eachStudent : info){
                    eachStudent = eachStudent.substring(1, eachStudent.length()-1);
                    if(eachStudent.split("~")[0].equals(id)){
                        double score = Double.parseDouble(eachStudent.split("~")[1]);
                        totalScore += score*thisCredit;
                        break;
                    }
                }

            }
        }
        return totalScore/totalCredit;
    }

    public String getAssignments(String username){
        String id = getId(username);
        String currentTermId = id+'$'+getInstance().getUsersDataMap().get(username).get("currentTerm");
        String courses = getInstance().getTermsDataMap().get(currentTermId).get("courses");
        if(courses.equals("{}")){
            return "error, term is empty";
        }
        String[] courseIds = courses.substring(1, courses.length()-1).split("//");
        Map<String, String> assignmentIds = new HashMap<>();
        for(String courseId : courseIds){
            String assignmentIdsForThisCourse = getInstance().getCoursesDataMap().get(courseId).get("assignments");
            if(assignmentIdsForThisCourse.equals("{}")){
                continue;
            }
            assignmentIdsForThisCourse = assignmentIdsForThisCourse.substring(1, assignmentIdsForThisCourse.length()-1);
            String[] arrayOfAssignmentIds = assignmentIdsForThisCourse.split("//");
            for(String eachAssignment : arrayOfAssignmentIds){
                assignmentIds.put(eachAssignment.split("~")[0], eachAssignment.split("~")[1]);
            }
        }


        return "";
    }
}