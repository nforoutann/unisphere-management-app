import dataManagement.Database;

import java.util.Scanner;

public class UserManagerNot {
    String role="";
    public void start(){
        Scanner scanner = new Scanner(System.in);
        String command="";
        int code;

        try{
            code = menu("first");
            switch(code){
                case 1: role = "admin"; command="admin" ; break;
                case 2: role = "teacher"; command="userEnter" ; break;
                case 3: role = "student"; command="userEnter" ; break;
            }
            code = menu(command);


        }  catch(Exception e){
            e.printStackTrace();
        }
    }

    public int menu(String command) throws Exception{
        Scanner scanner = new Scanner(System.in);
        int result=0;
        clearConsole();
        switch (command){
            case "first":
                System.out.println("Please choose your role:");
                System.out.println("1. Admin");
                System.out.println("2. Teacher");
                System.out.println("3. Student");
                System.out.println("4. exit");
                result = scanner.nextInt();
                break;
            case "admin":
                System.out.println("Please enter your admin password:"); break;
            case "userEnter":
                System.out.println("Please login first. If do not have an account sign up!");
                System.out.println("1. Sign up");
                System.out.println("2. Login");
                result = scanner.nextInt();
                System.out.println("Please enter your username:");
                String username=scanner.nextLine();
                System.out.println("Please enter your password:");
                String password=scanner.nextLine();
                String entrance = username+'$'+password+'$'+role;
                switch(result){
                    case 1: signup(entrance); break;
                    case 2: login(entrance); break;
                }


            default: throw new Exception("Invalid choice");
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
        String username = info.split("\\$")[0];
        String password = info.split("\\$")[1];
        String role = info.split("\\$")[2];

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
                    return "success";
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
}
