import dataManagement.Database;
import objects.*;

import java.util.Scanner;

public class UserManager {
    String role="";
    public void start(){
        Database database;
        Scanner scanner = new Scanner(System.in);
        String result = "";
        result = menu("first");
        switch (result) {
            case "1":
                role = "admin";
                result = menu("1");
                switch (result) {
                    case "1":
                        result = menu("user");
                        CreateUser("student", result);
                        break;
                    case "2":
                        result = menu("user");
                        CreateUser("teacher", result);
                        break;
                    case "3":
                        result = menu("delete");
                        String name = result.split("\\$")[0];
                        String username = result.split("\\$")[1];
                        Student student = new Student(name, username);
                        Database.getInstance().deleteUser(student);
                        break;
                    case "4":
                        result = menu("delete");
                        name = result.split("\\$")[0];
                        username = result.split("\\$")[1];
                        Teacher teacher = new Teacher(name, username);
                        Database.getInstance().deleteUser(teacher);
                        break;
                }
                break;
            case "2":
                role = "teacher";
                result = menu("2");
                switch (result) {
                    case "1": result = menu("user");
                        CreateUser("student", result);
                        break;
                    case "2":
                        result = menu("course");
                        Teacher teacher = new Teacher(result.split("\\$")[3], result.split("\\$")[4]);
                        Course course = new Course(result.split("\\$")[0],teacher, Integer.parseInt(result.split("\\$")[1]), Integer.parseInt(result.split("\\$")[2]));
                        Database.getInstance().AddCourseToTeacher(teacher, course);
                        break;
                    case "3":
                        result = menu("assignment");
                        String[] info = result.split("\\$");
                        teacher = new Teacher(info[7], info[8]);
                        Assignment assignment;
                        if(result.split("\\$")[1].equals("project")){
                            assignment = new Assignment(Integer.parseInt(info[2]), info[0], Assignment.type("project"), Integer.parseInt(info[3]));
                        } else{
                            assignment = new Assignment(Integer.parseInt(info[2]), info[0], Assignment.type("hw"), Integer.parseInt(result.split("\\$")[3]));
                        }
                        course = new Course(info[4], teacher, Integer.parseInt(info[5]), Integer.parseInt(info[6]));
                        Database.getInstance().addAssignment(assignment, teacher, course);
                        break;
                        case "4":
                            result = menu("deleteCourse");
                            teacher = new Teacher(result.split("\\$")[2], result.split("\\$")[1]);
                            Database.getInstance().deleteCourse(teacher, result.split("\\$")[0]);
                            break;
                        default:
                        System.out.println("Invalid choice");
            }
        }

    }

    public String menu(String command){
        clearConsole();
        Scanner scanner = new Scanner(System.in);
        String result="";
        switch (command){
            case "first":
                System.out.println("Please choose your role:");
                System.out.println("1. Admin");
                System.out.println("2. Teacher");
                System.out.println("4. exit");
                result = scanner.nextLine();
                break;
            case "1":
                System.out.println("1. create student");
                System.out.println("2. create teacher");
                System.out.println("3. delete student");
                System.out.println("4. delete teacher");
                result = scanner.nextLine();
                break;
            case "2":
                System.out.println("1. add student");
                System.out.println("2. add course");
                System.out.println("3. add assignment");
                System.out.println("4. remove course");
                result = scanner.nextLine();
                break;
            case "user":
                String name="", username="";
                System.out.println("Please enter the following options:");
                System.out.print("Name:");
                name = scanner.nextLine();
                System.out.print("username:");
                username = scanner.nextLine();
                result = name + "$" + username;
                break;
            case "course":
                System.out.println("Please enter the following information for course:");
                System.out.print("title:");
                result = scanner.nextLine();
                System.out.print("credit:");
                result = result+'$'+scanner.nextLine();
                System.out.print("id:");
                result = result+'$'+scanner.nextLine();
                System.out.print("your name:");
                result = result+'$'+scanner.nextLine();
                System.out.print("your username:");
                result = result+'$'+scanner.nextLine();
                break;
            case "delete":
                System.out.println("Please enter the following information:");
                System.out.print("name:");
                result = scanner.nextLine();
                System.out.print("username:");
                result = result+'$'+scanner.nextLine();
                break;
            case "assignment":
                System.out.println("Please enter the following information:");
                System.out.print("title:");
                result = scanner.nextLine();
                System.out.print("type: ");
                System.out.print("1. Project  ");
                System.out.println("2. Hw");
                int type = scanner.nextInt();
                if(type==1){
                    result = result+'$'+"project";
                } else{
                    result = result+'$'+"hw";
                }
                scanner.nextLine();
                System.out.print("the max score:");
                String maxScore = scanner.nextLine();
                result = result+'$'+maxScore;
                System.out.print("deadline:");
                String deadline = scanner.nextLine();
                result = result+'$'+deadline;
                result = result+'$'+menu("course");
                break;
            case "deleteCourse":
                System.out.print("Please enter the id of the course:");
                result = scanner.nextLine();
                System.out.print("Please enter the teacher's username:");
                result = result+"$"+scanner.nextLine();
                System.out.print("Please enter the teacher's name:");
                result = result+"$"+scanner.nextLine();
                break;


            default: return "done";
        }

        return result;
    }

    public void CreateUser(String role, String str){
        String name = str.split("\\$")[0];
        String username = str.split("\\$")[1];
        switch (role){
            case "teacher":
                Teacher teacher = new Teacher(name, username);
                Database.getInstance().ceateTeacher(teacher);
                break;
            case "student":
                Student student = new Student(name, username);
                Database.getInstance().ceateStudent(student);
                break;
        }
    }

    public void clearConsole() {
        System.out.print("\033[H\033[2J");
        System.out.flush();
    }

    public String login(String info) throws Exception{
        return Process(info, "login");
    }

    public String signup(String info) throws Exception{
        return Process(info, "signup");
    }

    private String Process(String info, String stage){
        String name = info.split("\\$")[0];
        String username = info.split("\\$")[1];
        String password = info.split("\\$")[2];
        String role = info.split("\\$")[3];

        switch (stage){
            case "login":{
                if(!Database.getInstance().getTotalUsernamePassword().containsKey(username)){
                    return "not found";
                }
                if(Database.getInstance().getTotalUsernamePassword().containsKey(password)){
                    if(Database.getInstance().getTotalUsernamePassword().get(username).equals(password)){
                        return "done";
                    } else{
                        return "password and username does not match";
                    }
                }else{
                    return "wrong password";
                }
            }
            case "signup":{
                if(Database.getInstance().getTotalUsernamePassword().containsKey(username)){
                    return "username already taken";
                }
                if(PasswordCheck(password).equals("done")){
                    if(role.equals("teacher")){
                        Teacher teacher=new Teacher(name, username);
                        teacher.setPassword(password);
                        Database.getInstance().ceateTeacher(teacher);
                    } else{
                        Student student=new Student(name, username);
                        student.setPassword(password);
                        Database.getInstance().ceateStudent(student);
                    }
                    return "done";
                } else{
                    return PasswordCheck(password);
                }
            } default: return "error occurred";
        }
    }

    private String PasswordCheck(String password){
        boolean NumberOfCharacter = password.length() >= 8;
        boolean ConsistNumber = password.matches("[0-9]");
        boolean consistUpperLower =password.matches("[a-z]") && password.matches("[A-Z]");
        if(NumberOfCharacter && ConsistNumber && consistUpperLower){
            return "done";
        } else if(!NumberOfCharacter){
            return "the number of characters must be more than 8";
        } else if(!ConsistNumber){
            return "the password must have numbers";
        } else if(!consistUpperLower){
            return "the password must have upper case and lower letters";
        } else{
            return "invalid";
        }
    }

    public static void main(String[] args){
        UserManager userManager=new UserManager();
        userManager.start();
    }
}