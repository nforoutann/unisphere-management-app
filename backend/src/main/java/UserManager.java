import dataManagement.Database;
import objects.Student;
import objects.Teacher;

import java.util.Scanner;

public class UserManager {
    String role="";
    public void start(){
        Scanner scanner = new Scanner(System.in);
        String command="first";
        String result="";
        try{
            result = menu(command);
            command = "entrance";
            switch (result) {
                case "1":
                    role="admin";
                    result = menu(command);
                    if (result.equals("1111")) {

                    }
                    break;
                case "2":
                case "3":
                    if(result.equals("2")){
                        role="teacher";
                    } else{
                        role="student";
                    }
                    result = menu(command);
                    String stage = result.split(" ")[0];
                    result = result.split(" ")[1];
                    switch (stage) {
                        case "login":
                            result = login(result);
                            if(!result.equals("done")){
                                System.out.println(result);
                                return;
                            }
                            break;
                        case "signup":
                            result = signup(result);
                            if(!result.equals("done")){
                                System.out.println(result);
                                return;
                            }
                            break;
                    }
                break;
            }


        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public String menu(String command){
        Scanner scanner = new Scanner(System.in);
        clearConsole();
        String result="error";
        switch (command){
            case "first":
                System.out.println("Please choose your role:");
                System.out.println("1. Admin");
                System.out.println("2. Teacher");
                System.out.println("3. Student");
                System.out.println("4. exit");
                result = scanner.nextLine();
                 break;
            case "entrance":
                switch (role){
                    case "admin":
                        System.out.println("Please enter your code:");
                        result = scanner.nextLine();
                        break;
                    case "teacher":
                    case "student":
                        System.out.println("Please login to continue.(If you do not have an account sign up first)");
                        System.out.println("1. sign up");
                        System.out.println("2. login");
                        result = scanner.nextLine();
                        if(result.equals("1")){
                            command = "login";
                        } else{
                            command = "signup";
                        }
                        result = menu(command);
                        result = command+" "+result;
                }
            case "login":
            case "signUp":
                System.out.println("Please enter the following information:");
                System.out.print("name:");
                String name = scanner.nextLine();
                System.out.print("username:");
                String username=scanner.nextLine();
                System.out.print("password:");
                String password=scanner.nextLine();
                result = name+'$'+username+'$'+password+'$'+role;
                break;


        }
        return result;
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