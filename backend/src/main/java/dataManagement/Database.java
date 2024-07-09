package dataManagement;
import objects.serializable.*;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class Database {
    private static Database instance;


    //addresses
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

    //basic methods
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
    public void printNewData(String data, String path){
        data = data.trim();
        try(FileWriter fw = new FileWriter(new File(path))){
            fw.write(data);
        } catch (Exception e){
            e.printStackTrace();
        }
    }


    //users method
    private String getPassword(String username){
        return getInstance().getUsersDataMap().get(username).get("password");
    }
    public String getId(String username){
        return getInstance().getUsersDataMap().get(username).get("id");
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
        info = Convertor.mapOfDataToString(getCoursesDataMap());
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
    private List<Task> getOngoingTasksTitle(String username){
        String tasksStr= getInstance().getUsersDataMap().get(username).get("tasks");
        if(tasksStr.equals("{}")){
            return new ArrayList<>();
        }
        tasksStr = tasksStr.substring(1, tasksStr.length()-1);
        String[] tasksArray = tasksStr.split("//");
        return Arrays.stream(tasksArray)
                .filter(a -> a.split("~")[1].equals("no"))
                .map(a -> new Task(a.split("~")[0], a.split("~")[1].equals("yes"), a.split("~")[2]))
                .collect(Collectors.toList());
    }
    private int getTheCredits(String username){
        //todo different process and meaning for the students and teachers
        int totalCredits = 0;
        String[] coursesIds = getCourseIds(username);
        if(coursesIds.length == 0){
            return totalCredits;
        }
        for(String coursesId : coursesIds){
            totalCredits = totalCredits + Integer.parseInt(getInstance().getCoursesDataMap().get(coursesId).get("credit"));
        }
        return totalCredits;
    }
    private Double getScore(String username, String which, String today){
        Double res = 0.0;
        String id = getId(username);
        String[] coursesIds = getCourseIds(username);
        if(coursesIds.length == 0){
            return 0.0;
        }
        List<Double> list = new ArrayList<>();
        list = Arrays.stream(coursesIds)
                .map(a -> getInstance().getCoursesDataMap().get(a).get("assignments"))
                .filter(a -> !a.equals("{}"))
                .map(a -> a.substring(1, a.length()-1))
                .flatMap(a -> Stream.of(a.split("//")))
                .map(a -> a.split("~")[0])
                .filter(a -> !getInstance().checkAssignmentActive(today, getInstance().getAssignmentsDataMap().get(a).get("deadline")))
                .map(a -> getInstance().getAssignmentsDataMap().get(a).get("students"))
                .filter(a -> !a.equals("{}"))
                .map(a -> a.substring(1, a.length()-1))
                .flatMap(students -> Arrays.stream(students.split("//")))
                .filter(student -> student.startsWith(id))
                .filter(student -> !student.split("~")[1].equals("null"))
                .map(a -> a.split("~")[1])
                .map(a -> Double.parseDouble(a))
                .sorted()
                .collect(Collectors.toList());
        switch(which){
            case "min":
                if(list.size() == 0){
                    return 0.0;
                }
                return list.getFirst();
            case "max":
                if(list.size() == 0){
                    return 0.0;
                }
                return list.getLast();
        }
        return null;
    }
    private int numberOfLeftAssignments(String username, String today){ //todo ommit the active part and work with deadline
        String[] coursesIds = getCourseIds(username);
        if(coursesIds.length == 0){
            return 0;
        }
        return Arrays.stream(coursesIds)
                .map(id -> getInstance().getCoursesDataMap().get(id).get("assignments"))
                .filter(assignments -> !assignments.equals("{}"))
                .map(assignments -> assignments.substring(1, assignments.length()-1))
                .flatMap(assignments -> Stream.of(assignments.split("//")))
                .filter(assignment -> checkAssignmentActive(today, getInstance().getAssignmentsDataMap().get(assignment).get("deadline")))
                .map(assignment -> getInstance().getAssignmentsDataMap().get(assignment).get("students"))
                .filter(a -> !a.equals("{}"))
                .map(a -> a.substring(1, a.length()-1))
                .flatMap(a -> Stream.of(a.split("//")))
                .filter(a -> a.split("~")[0].equals(getId(username)))
                .filter(a -> a.endsWith("no")) //not sent
                .toList()
                .size();
    }
    public boolean checkAssignmentActive(String today, String deadline){
        today = today.substring(1, today.length()-1);
        String[] todayArray = today.split("::");
        int nowYear = Integer.parseInt(todayArray[0]);
        int nowMonth = Integer.parseInt(todayArray[1]);
        int nowDay = Integer.parseInt(todayArray[2]);
        int nowHour = Integer.parseInt(todayArray[3]);
        int nowMinute = Integer.parseInt(todayArray[4]);

        deadline = deadline.substring(1, deadline.length()-1);
        String[] deadlineArray = deadline.split("::");
        int deadlineYear = Integer.parseInt(deadlineArray[0]);
        int deadlineMonth = Integer.parseInt(deadlineArray[1]);
        int deadlineDay = Integer.parseInt(deadlineArray[2]);
        int deadlineHour = Integer.parseInt(deadlineArray[3]);
        int deadlineMinute = Integer.parseInt(deadlineArray[4]);

        boolean year = deadlineYear>nowYear;
        boolean month = (deadlineYear==nowYear &&  deadlineMonth>nowMonth);
        boolean day = deadlineYear==nowYear && deadlineMonth==nowMonth &&  deadlineDay>nowDay;
        boolean hour = deadlineYear==nowYear && deadlineMonth==nowMonth &&  deadlineDay==nowDay && deadlineHour>nowHour;
        boolean minute = deadlineYear==nowYear && deadlineMonth==nowMonth &&  deadlineDay==nowDay && deadlineHour==nowHour && deadlineMinute>nowMinute;

        if(year || month || day || hour || minute){
            return true;
        }else{
            return false;
        }
    }
    private int numberOfLostAssignments(String username, String today){ //todo ommit the active part and work with deadline
        String[] coursesIds = getCourseIds(username);
        if(coursesIds.length == 0){
            return 0;
        }
        return Arrays.stream(coursesIds)
                .map(a -> getInstance().getCoursesDataMap().get(a).get("assignments"))
                .filter(a -> !a.equals("{}"))
                .map(a -> a.substring(1, a.length()-1))
                .flatMap(a -> Stream.of(a.split("//")))
                .map(a -> a.split("~")[0])
                .filter(a -> checkAssignmentActive(today, getInstance().getAssignmentsDataMap().get(a).get("deadline")))
                .map(a -> getInstance().getAssignmentsDataMap().get(a).get("students"))
                .filter(a -> !a.equals("{}"))
                .map(a -> a.substring(1, a.length()-1))
                .flatMap(a -> Stream.of(a.split("//")))
                .filter(a -> a.startsWith(getId(username)))
                .filter(a -> a.endsWith("no")) //not sent
                .toList()
                .size();
    }
    private HashMap<String, HashMap<String, String>> getDoneAssignments(String username){
        String[] coursesIds = getCourseIds(username);
        if(coursesIds.length == 0){
            return new HashMap<>();
        }
        HashMap<String, HashMap<String, String>> res = new HashMap<>();
        Arrays.stream(coursesIds)
                .map(courseId -> getInstance().getCoursesDataMap().get(courseId).get("assignments"))
                .filter(assignments -> !assignments.equals("{}"))
                .map(assignments -> assignments.substring(1, assignments.length()-1))
                .flatMap(assignments -> Stream.of(assignments.split("//")))
                .filter(assignmentId -> Arrays.stream(
                        getInstance().getAssignmentsDataMap().get(assignmentId).get("students").substring(1, getInstance().getAssignmentsDataMap().get(assignmentId).get("students").length()-1).split("//"))
                        .filter(element -> !element.isEmpty())
                        .anyMatch(student -> student.split("~")[0].equals(getId(username))&&student.split("~")[2].equals("yes"))
                )
                .forEach(a -> res.put(a, getInstance().getAssignmentsDataMap().get(a)));

        return res;
    }
    public User getUserInfo(String username, String today){
        //todo checkTasksExpiration(username, today);
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
                double totalGrade = totalGrade(username);
                int totalCredits = getTheCredits(username);
                List<Task> ongoingTasks = getOngoingTasksTitle(username);
                Double minScore = getScore(username, "min", today);
                Double maxScore = getScore(username, "max", today);
                int numberOfLeftAssignments = numberOfLeftAssignments(username, today);
                int numberOfLostAssignments = numberOfLostAssignments(username, today);

                //make the object
                Student student = new Student(name, username);
                student.setPassword(password);
                student.setBirthday(birthStr);
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
                student.setNumberOfLostAssignments(numberOfLostAssignments);
                student.setDoneAssignments(Convertor.mapToListOfAssignments(getId(username) ,getDoneAssignments(username), getInstance().getCoursesDataMap(), today));

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
    private String[] getCourseIds(String username){
        String[] str = {};
        String id = getId(username);
        String courses = getInstance().getTermsDataMap()
                .get(id+'&'+getInstance().getUsersDataMap().get(username).get("currentTerm"))
                .get("courses");
        if(courses.equals("{}")){
            return str;
        }
        courses = courses.substring(1, courses.length()-1);
        return courses.split("//");
    }
    private String getUsername(String id){
        StringBuilder res = new StringBuilder();
        getInstance().getUsersDataMap().values().stream()
                .filter(a -> a.get("id").equals(id))
                .map(a -> a.get("username"))
                .findAny()
                .ifPresent(res::append);
        return res.toString();
    }
    public void createStudent(String username, String password, String name, String id, String email){
        var user = getInstance().getUsersDataMap();
        HashMap<String, String> littleMap = new HashMap<>();
        littleMap.put("username", username);
        littleMap.put("password", password);
        littleMap.put("name", name);
        littleMap.put("id", id);
        littleMap.put("email", email);
        littleMap.put("role", "student");
        littleMap.put("currentTerm", "1");
        littleMap.put("birthday", "{}");
        littleMap.put("terms", "{}");
        littleMap.put("tasks", "{}");
        littleMap.put("nExams", "0");
        user.put(username, littleMap);
        getInstance().printNewData(Convertor.mapOfDataToString(user), usersPath);
    }
    public void createTeacher(String username, String password, String name, String code, String email){
        var user = getInstance().getUsersDataMap();
        HashMap<String, String> littleMap = new HashMap<>();
        littleMap.put("username", username);
        littleMap.put("password", password);
        littleMap.put("name", name);
        littleMap.put("code", code);
        littleMap.put("email", email);
        littleMap.put("role", "teacher");
        littleMap.put("birthday", "{}");
        littleMap.put("courses", "{}");
        littleMap.put("tasks", "{}");
        user.put(username, littleMap);
        getInstance().printNewData(Convertor.mapOfDataToString(user), usersPath);
    }
    public void addBirthday(String username, String birthday){
        var user = getInstance().getUsersDataMap();
        user.get(username).put("birthday", birthday);
        printNewData(Convertor.mapOfDataToString(user), usersPath);
    }
    public void deleteBirthday(String username){
        var user = getInstance().getUsersDataMap();
        user.get(username).put("birthday", "{}");
        printNewData(Convertor.mapOfDataToString(user), usersPath);
    }
    public String getTeacherCodeByUsername(String username){
        return getInstance().getUsersDataMap().get(username).get("code");
    }
    public void setNumberOfExams(String username, int numberOfExams){
        var user = getInstance().getUsersDataMap();
        user.get(username).put("nExams", String.valueOf(numberOfExams));
        printNewData(Convertor.mapOfDataToString(user), usersPath);
    }


    //task methods
    public List<Task> getTasks(String username){
        String tasksInfoStr = getInstance().getUsersDataMap().get(username).get("tasks");
        if(tasksInfoStr.equals("{}")){
            return new ArrayList<>();
        }
        tasksInfoStr = tasksInfoStr.substring(1, tasksInfoStr.length()-1);
        String[] tasksInfo = tasksInfoStr.split("//");
        List<Task> tasks = new ArrayList<>();
        for(String eachTask : tasksInfo){
            System.out.println(eachTask);
            String title = eachTask.split("~")[0];
            boolean done = eachTask.split("~")[1].equals("yes");
            String time = eachTask.split("~")[2];
            Task task = new Task(title, done, time);
            tasks.add(task);
        }
        return tasks;
    }
    public void createTask(String username, String title, String time, boolean done){
        try{
            var usersMap = getInstance().getUsersDataMap();
            String tasks = usersMap.get(username).get("tasks").toString();
            if(tasks.equals("{}")){
                tasks = title+(done ? "~yes" : "~no")+"~"+time;
            }else{
                tasks = tasks.substring(1, tasks.length()-1);
                tasks = tasks + "//" + title + (done ? "~yes" : "~no") + "~" + time;
            }
            tasks = "{" + tasks + "}";
            usersMap.get(username).put("tasks", tasks);
            printNewData(Convertor.mapOfDataToString(usersMap), usersPath);
        } catch (Exception e){
            System.out.println(e.getMessage());
        }
    }
    public boolean setDoneTask(String username, String title, boolean done){
        var usersMap = getInstance().getUsersDataMap();
        String tasks = usersMap.get(username).get("tasks");
        try{
            if(tasks.equals("{}")){
                throw new Exception();
            }
            tasks = tasks.substring(1, tasks.length()-1);
            String[] tasksInfo = tasks.split("//");
            boolean exist = Arrays.stream(tasksInfo)
                    .map(a -> a.split("~")[0])
                    .anyMatch(a -> a.equals(title));
            if(!exist){
                throw new Exception();
            }
            String time =  Arrays.stream(tasksInfo)
                    .filter(a -> a.split("~")[0].equals(title))
                    .map(a -> a.split("~")[2])
                    .findAny()
                    .get();

            deleteTask(username, title);
            createTask(username, title, time, done);
        } catch (Exception e){
            e.printStackTrace();
            return false;
        }
        return true;
    }
    public boolean deleteTask(String username, String title) {
        var usersMap = getInstance().getUsersDataMap();
        String tasks = usersMap.get(username).get("tasks");
        tasks = tasks.substring(1, tasks.length()-1);
        boolean condition = Arrays.stream(tasks.split("//"))
                .map(a -> a.split("~")[0])
                .anyMatch(a -> a.equals(title));
        if(!condition){
            return false;
        }
        String[] taskInfo = tasks.split("//");
        String newTask = "";

        for(String eachTask : taskInfo){
            if(eachTask.split("~")[0].equals(title)){
                continue;
            }
            if(newTask.equals("")){
                newTask = eachTask;
                continue;
            }
            newTask = newTask + "//" + eachTask;
        }

        newTask = "{" + newTask + "}";
        usersMap.get(username).put("tasks", newTask);

        printNewData(Convertor.mapOfDataToString(usersMap), usersPath);
        return true;
    }
    public void editTheTask(String username, String title, String newTitle){
        var usersMap = getInstance().getUsersDataMap();
        String tasks = usersMap.get(username).get("tasks");
        tasks = tasks.substring(1, tasks.length()-1);
        String[] taskStr = tasks.split("//");
        String time="", done = "";
        for(String eachTask : taskStr){
            if(eachTask.split("~")[0].equals(title)){
                done = eachTask.split("~")[1];
                time = eachTask.split("~")[2];
                break;
            }
        }
        deleteTask(username, title);
        createTask(username, newTitle, time, done.equals("yes") ? true : false);
    }
    private void checkTasksExpiration(String username, String today){
        String tasks = getInstance().getUsersDataMap().get(username).get("tasks");
        if(tasks.equals("{}")){
            return;
        }
        tasks = tasks.substring(1, tasks.length()-1);
        String[] eachTask = tasks.split("//");

        int thisYear = Integer.parseInt(today.split("::")[0]);
        int thisMonth = Integer.parseInt(today.split("::")[1]);
        int thisDay = Integer.parseInt(today.split("::")[2]);

        String day1 = eachTask[0].split("~")[2];

        day1 = day1.substring(1, day1.length()-1);

        int year = Integer.parseInt(day1.split("::")[0]);
        int month = Integer.parseInt(day1.split("::")[1]);
        int day = Integer.parseInt(day1.split("::")[2]);

        if(thisYear > year || (thisYear==year && thisMonth > month) || (thisYear==year && thisMonth==month && thisDay > day)){
            for(String each : eachTask){
                deleteTask(username, each.split("~")[0]);
            }
        }
    }
    public void changePassword(String username, String newPassword){
        var user = getInstance().getUsersDataMap();
        user.get(username).put("password", newPassword);
        printNewData(Convertor.mapOfDataToString(user), usersPath);
    }
    public void changeUsername(String username, String newUsername){
        var user = getInstance().getUsersDataMap();
        user.get(username).put("username", newUsername);
        user.put(newUsername, user.get(username));
        user.remove(username);
        printNewData(Convertor.mapOfDataToString(user), usersPath);
    }
    public void changeEmail(String username, String newEmail){
        var user = getInstance().getUsersDataMap();
        user.get(username).put("email", newEmail);
        printNewData(Convertor.mapOfDataToString(user), usersPath);
    }
    public void deleteStudent(String username){
        String[] courseIds = getCourseIds(username);

        //delete the assignments
        var assignments = getInstance().getAssignmentsDataMap();
        List<String> assignmentIds = Stream.of(courseIds)
                .map(id -> getInstance().getCoursesDataMap().get(id))
                .map(course -> course.get("assignments"))
                .filter(a -> !a.equals("{}"))
                .map(a -> a.substring(1, a.length()-1))
                .flatMap(a -> Stream.of(a.split("//")))
                .collect(Collectors.toList());

        for(String assignmentId : assignmentIds){
            String students = getInstance().getAssignmentsDataMap().get(assignmentId).get("students");
            if(students.equals("{}")){
                continue;
            }
            students = students.substring(1, students.length()-1);
            String[] studentIds = students.split("//");
            String studentInfo = "";
            for(int i=0 ; i<studentIds.length ; i++){
                if(studentIds[i].split("~")[0].equals(getId(username))){
                    continue;
                }
                studentInfo = studentInfo + studentIds[i];
                if(i != studentIds.length-1){
                    studentInfo = studentInfo + "//";
                }
            }
            if(studentInfo.endsWith("//"))
                studentInfo = studentInfo.substring(0, studentInfo.length()-2);
            studentInfo = "{" + studentInfo + "}";
            assignments.get(assignmentId).put("students", studentInfo);
        }
        getInstance().printNewData(Convertor.mapOfDataToString(assignments), assignmentsPath);

        //delete from courses
        var courseMap = getInstance().getCoursesDataMap();
        for(String courseId : courseMap.keySet()){
            String students = getInstance().getCoursesDataMap().get(courseId).get("students");
            if(students.equals("{}")){
                continue;
            }
            students = students.substring(1, students.length()-1);
            String[] studentIds = students.split("//");
            String studentInfo = "";
            for(int i=0 ; i<studentIds.length ; i++){
                if(studentIds[i].split("~")[0].equals(getId(username))){
                    continue;
                }
                studentInfo = studentInfo + studentIds[i];
                if(i != studentIds.length-1){
                    studentInfo = studentInfo + "//";
                }
            }
            if(studentInfo.endsWith("//"))
                studentInfo = studentInfo.substring(0, studentInfo.length()-2);
            studentInfo = "{" + studentInfo + "}";
            courseMap.get(courseId).put("students", studentInfo);
        }
       getInstance().printNewData(Convertor.mapOfDataToString(courseMap), coursesPath);


        //delete from the users
        var usersMap = getInstance().getUsersDataMap();
        usersMap.remove(username);
       printNewData(Convertor.mapOfDataToString(usersMap), usersPath);
    }


    //course methods
    public List<Course> getCourses(String username){
        String[] courseIds = getCourseIds(username);
        List<Course> courses = new ArrayList<>();
        for(String eachCourseId : courseIds){
            HashMap<String, String> map = getInstance().getCoursesDataMap().get(eachCourseId);
            String bestStudentId = map.get("best");
            String teacherUsername = map.get("teacher");
            String teacherName = getInstance().getUsersDataMap().get(teacherUsername).get("name");
            String nameOfTheBestStudent = getInstance().getUsersDataMap().get(getUsername(bestStudentId)).get("name");
            Course course = Convertor.mapToCourse(map, nameOfTheBestStudent, teacherName);
            courses.add(course);
        }
        return courses;
    }
    public String addStudentToCourse(String username, String courseCode){
        //check validation
        if(!getInstance().getCoursesDataMap().containsKey(courseCode)){
            return "404";
        }

        String currentTerm = getInstance().getUsersDataMap().get(username).get("currentTerm");
        String currentTermId = getId(username)+'&'+currentTerm;
        var TermMap = getInstance().getTermsDataMap();

        boolean studentAlreadyExists = false;


        //add course to the current term of the student
        String coursesOfStudent = TermMap.get(currentTermId).get("courses");
        if(!coursesOfStudent.equals("{}")){
            String[] courseIds = coursesOfStudent.substring(1, coursesOfStudent.length()-1).split("//");
            for(String courseId : courseIds){
                if(courseCode.equals(courseId)){
                    studentAlreadyExists = true;
                }
            }
        }

        if(studentAlreadyExists){
            return "409";
        }

        String newCourseData;
        if(coursesOfStudent.equals("{}")){
            newCourseData = "{" + courseCode + "}";
        }else{
            coursesOfStudent = coursesOfStudent.substring(1, coursesOfStudent.length()-1);
            newCourseData = "{"+coursesOfStudent+"//"+courseCode+"}";
        }
        TermMap.get(currentTermId).put("courses", newCourseData);
        printNewData(Convertor.mapOfDataToString(TermMap), termsPath);

        //add student to the courses data
        var courseMap = getInstance().getCoursesDataMap();
        var thisCourseData = courseMap.get(courseCode);
        var studentsInThisCourse = thisCourseData.get("students");
        String newStudentData;
        if(studentsInThisCourse.equals("{}")){
            newStudentData = "{" + getId(username) + "~" + 0 + "}";
        } else{
            studentsInThisCourse = studentsInThisCourse.substring(1, studentsInThisCourse.length()-1);
            newStudentData = "{"+ studentsInThisCourse + "//" + getId(username) + "~" + 0 + "}";
        }
        courseMap.get(courseCode).put("students", newStudentData);
        printNewData(Convertor.mapOfDataToString(courseMap), coursesPath);


        //add student to assignments of the course
        String assignments = courseMap.get(courseCode).get("assignments");
        String[] assignmentInfo;
        if(assignments.equals("{}")){
            return "200";
        } else{
            assignments = assignments.substring(1, assignments.length()-1);
            assignmentInfo = assignments.split("//");
        }
        var assignmentMap = getInstance().getAssignmentsDataMap();

        for(String each : assignmentInfo){
            String assignmentId = each.split("~")[0];
            var thisAssignment = assignmentMap.get(assignmentId);
            String students = thisAssignment.get("students");
            String newStudents;
            if(students.equals("{}")){
                newStudents = "{" + getId(username) + "~" + "0" + "~" + "no" + "}";
            } else{
                students = students.substring(1, students.length()-1);
                newStudents = "{"+students+"//" + getId(username) + "~" + "0" + "~" + "no" + "}";
            }
            assignmentMap.get(assignmentId).put("students", newStudents);
        }

        printNewData(Convertor.mapOfDataToString(assignmentMap), assignmentsPath);

        return "200";
    }
    public void deleteStudentFromCourse(String username, String courseCode){
        String currentTerm = getInstance().getUsersDataMap().get(username).get("currentTerm");
        String[] courseIds = getCourseIds(username);
        String newCourseData = "";
        for(int i=0; i<courseIds.length; i++){
            if(courseCode.equals(courseIds[i])){
                continue;
            }
            newCourseData = newCourseData + courseIds[i];
            if(i != courseIds.length - 1){
                newCourseData = newCourseData + "//";
            }
        }
        if(newCourseData.endsWith("//")){
            newCourseData = newCourseData.substring(0, newCourseData.length()-2);
        }
        newCourseData = "{"+newCourseData+"}";
        String currentTermId = getId(username)+'&'+currentTerm;
        var termMap = getInstance().getTermsDataMap();
        termMap.get(currentTermId).put("courses", newCourseData);
        printNewData(Convertor.mapOfDataToString(termMap), termsPath);

        //delete from course
        var courseMap = getInstance().getCoursesDataMap();
        String students = courseMap.get(courseCode).get("students");
        String newStudents = "";
        if(!students.equals("{}")){
            students = students.substring(1, students.length()-1);
            String[] studentsInfo = students.split("//");

            for(int i=0; i<studentsInfo.length; i++){
                if(studentsInfo[i].split("~")[0].equals(getId(username))){
                    continue;
                }
                newStudents = newStudents + studentsInfo[i];
                if(i != studentsInfo.length - 1){
                    newStudents = newStudents + "//";
                }
            }
            if(newStudents.endsWith("//")){
                newStudents = newStudents.substring(0, newStudents.length()-2);
            }
            newStudents = "{" + newStudents + "}";
            courseMap.get(courseCode).put("students", newStudents);
            printNewData(Convertor.mapOfDataToString(courseMap), coursesPath);
        }

        //delete from assignments

        var assignmentMap = getInstance().getAssignmentsDataMap();
        String assignments = courseMap.get(courseCode).get("assignments");
        String newAssignments;
        if(!assignments.equals("{}")){
            assignments = assignments.substring(1, assignments.length()-1);
            String[] assignmentsInfo = assignments.split("//");
            for(int i=0; i<assignmentsInfo.length; i++){
                String StudentsInAssignments = assignmentMap.get(assignmentsInfo[i]).get("students");
                if(!StudentsInAssignments.equals("{}")){
                    StudentsInAssignments = StudentsInAssignments.substring(1, StudentsInAssignments.length()-1);
                    String[] studentsInfo = StudentsInAssignments.split("//");
                    String newStudentsData = "";
                    for(int j=0; j<studentsInfo.length; j++){
                        if(studentsInfo[j].split("~")[0].equals(getId(username))){
                            continue;
                        }
                        newStudentsData = newStudentsData + studentsInfo[j];
                        if(j != studentsInfo.length - 1){
                            newStudentsData = newStudentsData + "//";
                        }
                    }
                    if(newStudentsData.endsWith("//")){
                        newStudentsData = newStudentsData.substring(0, newStudentsData.length()-2);
                    }
                    newStudentsData = "{" + newStudentsData + "}";
                    assignmentMap.get(assignmentsInfo[i]).put("students", newStudentsData);
                }
            }
            printNewData(Convertor.mapOfDataToString(assignmentMap), assignmentsPath);
        }
    }
    public void deleteCourse(String courseId){
        //delete from the terms
        var termMap = getInstance().getTermsDataMap();
        var termIds = termMap.keySet();
        var termIdArray =  termIds.toArray();
        for(var termId : termIdArray){
            String id = (String) termId;
            String courses = termMap.get(id).get("courses");
            if(courses.equals("{}")){
                continue;
            }
            courses = courses.substring(1, courses.length()-1);
            String[] courseIds = courses.split("//");
            String courseInfo = "";
            for(int i=0 ; i<courseIds.length ; i++){
                if(courseIds[i].equals(courseId)){
                    continue;
                }
                courseInfo = courseInfo + courseIds[i];
                if(i != courseIds.length - 1){
                    courseInfo += "//";
                }
            }
            if(courseInfo.endsWith("//")){
                courseInfo = courseInfo.substring(0, courseInfo.length()-2);
            }
            courseInfo = "{" + courseInfo + "}";
            termMap.get(termId).put("courses", courseInfo);
        }
        printNewData(Convertor.mapOfDataToString(termMap), termsPath);


        //delete the assignments
        var courseMap = getInstance().getCoursesDataMap();
        String assignments = courseMap.get(courseId).get("assignments");
        if(!assignments.equals("{}")){
            assignments = assignments.substring(1, assignments.length()-1);
            String[] assignmentInfo = assignments.split("//");
            for(String each : assignmentInfo){
                deleteAssignment(each);
            }
        }

        //delete the main course
        courseMap.remove(courseId);
        printNewData(Convertor.mapOfDataToString(courseMap), coursesPath);

    }
    public void createCourse(String username, String title, String credit, String time){
        String teacherName = getInstance().getUsersDataMap().get(username).get("name");
        String code = getTeacherCodeByUsername(username);
        var courseIds = getInstance().getCoursesDataMap().keySet();
        String[] courseIdArray = Arrays.stream(courseIds.toArray()).map(a -> (String) a).toArray(String[]::new);
        int greatest = Arrays.stream(courseIdArray)
                .filter(a -> a.split("&")[0].equals(code))
                .map(a -> a.split("&")[1])
                .map(Integer::parseInt)
                .max(Comparator.comparingInt(a -> a))
                .orElse(0); //todo best
        greatest++;
        String newCourseId =  code+"&"+greatest;
        HashMap<String, String> map = new HashMap<>();
        map.put("teacher", teacherName);
        map.put("assignments", "{}");
        map.put("students", "{}");
        map.put("best", "");
        map.put("time", time);
        map.put("title", title);
        map.put("credit", credit);
        map.put("courseId", newCourseId);
        map.put("done", "false");

        var courseMap = getInstance().getCoursesDataMap();
        courseMap.put(newCourseId, map);
        printNewData(Convertor.mapOfDataToString(courseMap), coursesPath);
    }
    public void setBestStudent(String id, String courseId){
        var courseMap = getInstance().getCoursesDataMap();
        courseMap.get(courseId).put("best", id);
        printNewData(Convertor.mapOfDataToString(courseMap), coursesPath);
    }
    public void setDoneForCourse(String courseId){
        var courseMap = getInstance().getCoursesDataMap();
        courseMap.get(courseId).put("done", "true");
        printNewData(Convertor.mapOfDataToString(courseMap), coursesPath);
    }
    public void setScore(String username, String assignmentId, String score){
        String students = getInstance().getAssignmentsDataMap().get(assignmentId).get("students");
        students = students.substring(1, students.length()-1);
        String newStudents = "" ;
        String[] studentIds = students.split("//");
        for(int i=0 ; i<studentIds.length ; i++){
            if(studentIds[i].split("~")[0].equals(getId(username))){
                newStudents += studentIds[i].split("~")[0]+"~"+score+"~"+studentIds[i].split("~")[2]+"//";
            } else{
                newStudents += studentIds[i]+"//";
            }
        }
        newStudents = newStudents.substring(0, newStudents.length()-2);
        newStudents = "{" + newStudents+ "}";
        var map = getInstance().getAssignmentsDataMap();
        map.get(assignmentId).put("students", newStudents);
        printNewData(Convertor.mapOfDataToString(map), assignmentsPath);
    }


    //assignments method
    public List<Assignment> getAssignments(String username, String today){
        HashMap<String, HashMap<String, String>> assignmentMap = new HashMap<>();
        String[] courseIds = getCourseIds(username);
        Arrays.stream(courseIds)
                .map(courseId -> getInstance().getCoursesDataMap().get(courseId))
                .map(course -> course.get("assignments"))
                .filter(assignment -> !assignment.equals("{}"))
                .map(assignments -> assignments.substring(1, assignments.length()-1))
                .flatMap(assignments -> Stream.of(assignments.split("//")))
                .filter(assignmentId -> Arrays.stream(
                                getInstance().getAssignmentsDataMap().get(assignmentId).get("students").substring(1, getInstance().getAssignmentsDataMap().get(assignmentId).get("students").length()-1).split("//"))
                        .filter(element -> !element.isEmpty())
                        .anyMatch(student -> student.split("~")[0].equals(getId(username)))
                ).forEach(assignment -> assignmentMap.put(assignment, getInstance().getAssignmentsDataMap().get(assignment)));

        return Convertor.mapToListOfAssignments(getId(username), assignmentMap, getInstance().getCoursesDataMap(), today);
    }
    public String editAssignment(String username, String assignmentId, String estimatedTime, String description, boolean uploaded){
        var assignmentMap = getInstance().getAssignmentsDataMap();
        assignmentMap.get(assignmentId).put("estimatedTime", estimatedTime);
        assignmentMap.get(assignmentId).put("description", description);
        String newStudents = "";
        String students = assignmentMap.get(assignmentId).get("students");
        if(uploaded){
            students = students.substring(1, students.length()-1);
            String[] studentIds = students.split("//");
            int i = 1;
            int size = studentIds.length;
            for(String eachStudent : studentIds){
                if(eachStudent.split("~")[0].equals(getId(username))){
                    newStudents =  newStudents + getId(username)  + "~null~yes";
                } else {
                    newStudents = newStudents  + eachStudent;
                }
                if(i != size){
                    i++;
                    newStudents = newStudents + "//";
                }
            }

            newStudents = "{" + newStudents + "}";
        } else{
            newStudents = students;
        }
        assignmentMap.get(assignmentId).put("students", newStudents);
        printNewData(Convertor.mapOfDataToString(assignmentMap), assignmentsPath);
        return "200";
    }
    public void deleteAssignment(String assignmentId){
        var assignmentMap = getInstance().getAssignmentsDataMap();
        assignmentMap.remove(assignmentId);
        printNewData(Convertor.mapOfDataToString(assignmentMap), assignmentsPath);
        String courseId = assignmentId.split("&")[0]+"&"+assignmentId.split("&")[1];
        String assignments = getCoursesDataMap().get(courseId).get("assignments");
        if(assignments.equals("{}")){
            return;
        }
        assignments = assignments.substring(1, assignments.length()-1);
        String[] assignmentIds = assignments.split("//");
        String assignmentInfo = "";
        for(int i=0 ; i<assignmentIds.length ; i++){
            if(assignmentIds[i].equals(assignmentId)){
                continue;
            }
            assignmentInfo = assignmentInfo + assignmentIds[i];
            if(i != assignmentIds.length - 1){
                assignmentInfo += "//";
            }
        }
        if(assignmentInfo.endsWith("//")){
            assignmentInfo = assignmentInfo.substring(0, assignmentInfo.length()-2);
        }
        assignmentInfo = "{" + assignmentInfo + "}";
        var courseMap = getInstance().getCoursesDataMap();
        courseMap.get(courseId).put("assignments", assignmentInfo);
        printNewData(Convertor.mapOfDataToString(courseMap), coursesPath);
    }
    public void createAssignment(String courseCode, String title,String type , String definedTime, String description, String estimatedTime, String deadline, String score){
        String assignments = getCoursesDataMap().get(courseCode).get("assignments");
        var courseMap = getInstance().getCoursesDataMap();

        assignments = assignments.substring(1, assignments.length()-1);
        String[] assignmentIds = assignments.split("//");
        int greatest =0;
        String newAssignments = "";
        for(int i=0 ; i<assignmentIds.length ; i++){
            if(greatest<Integer.parseInt(assignmentIds[i].split("&")[2])){
                greatest=Integer.parseInt(assignmentIds[i].split("&")[2]);
            }
            newAssignments = newAssignments + assignmentIds[i] + "//";
        }
        greatest++;
        String newAssignmentId = courseCode+"&"+greatest;
        newAssignments = newAssignments+newAssignmentId;
        newAssignments = "{" + newAssignments + "}";
        courseMap.get(courseCode).put("assignments", newAssignments);
        printNewData(Convertor.mapOfDataToString(courseMap), coursesPath);

        //add to the assignment
        String students = courseMap.get(courseCode).get("students");
        students = students.substring(1, students.length()-1);
        String[] studentIds = students.split("//");
        HashMap<String, String> map = new HashMap<>();
        String studentInfo = "";
        for(String eachStudent : studentIds){
            studentInfo = studentInfo + eachStudent.split("~")[0] + "~null~no//";
        }
        studentInfo = studentInfo.substring(0, studentInfo.length()-2);
        studentInfo = "{" + studentInfo + "}";
        map.put("students", studentInfo);
        map.put("definedTime", definedTime);
        map.put("description", description);
        map.put("estimatedTime", estimatedTime);
        map.put("deadline", deadline);
        map.put("score", score);
        map.put("title", title);
        map.put("type", type);
        map.put("assignmentId", newAssignmentId);

        var assignmentMap = getInstance().getAssignmentsDataMap();
        assignmentMap.put(newAssignmentId, map);
        printNewData(Convertor.mapOfDataToString(assignmentMap), assignmentsPath);
    }


    public static void main(String[] args) {
        getInstance().setScore("nazanin", "1111&2&1", "18");
    }

}