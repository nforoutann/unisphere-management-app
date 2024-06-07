import dataManagement.Database;
import objects.Course;
import objects.Student;
import objects.Teacher;

import java.util.Scanner;

public class UserManager {
    String role="";
    public void start(){

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
                        String name = result.split(" ")[0];
                        String username = result.split(" ")[1];
                        CreateUser("student", name, username);
                        break;
                    case "2":
                        result = menu("user");
                        name = result.split(" ")[0];
                        username = result.split(" ")[1];
                        CreateUser("teacher", name, username);
                        break;
                    case "3":
                    case "4":
                }
                break;
            case "2":
                role = "teacher";
                result = menu("2");
                switch (result) {
                    case "1": result = menu("user");
                        String name = result.split(" ")[0];
                        String username = result.split(" ")[1];
                        CreateUser("student", name, username);
                        break;
                    case "2":
                        result = menu("course");
                        Teacher teacher = new Teacher(result.split(" ")[3], result.split(" ")[4]);
                        Course course = new Course(result.split(" ")[0],teacher, Integer.parseInt(result.split(" ")[1]), Integer.parseInt(result.split(" ")[2]));
                        Database.getInstance().AddCourseToTeacher(teacher, course);
                        break;
                    case "3":
                    case "4":
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
                System.out.println("4. remove student");
                result = scanner.nextLine();
                break;
            case "user":
                System.out.println("Please enter the following options:");
                System.out.print("Name:");
                result = scanner.nextLine();
                System.out.print("username:");
                result = result+' '+scanner.nextLine();
                break;
            case "course":
                System.out.println("Please enter the following information:");
                System.out.print("title:");
                result = scanner.nextLine();
                System.out.print("credit:");
                result = result+' '+scanner.nextLine();
                System.out.print("id:");
                result = result+' '+scanner.nextLine();
                System.out.print("your name:");
                result = result+' '+scanner.nextLine();
                System.out.print("your username:");
                result = result+' '+scanner.nextLine();
                break;
            default: return "done";
        }

        return result;
    }

    public void CreateUser(String role, String name, String username){
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