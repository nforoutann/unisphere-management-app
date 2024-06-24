package controller;

import dataManagement.Database;
import jdk.jfr.DataAmount;

public class Controller {
    Database database = Database.getInstance();

    public String run(String request){
        String res = "";
        String command = request.split("\\$")[0];
        switch (command){
            case "GET: SignUpChecker":
                String role = request.split("\\$")[1];
                String name = request.split("\\$")[2];
                String username = request.split("\\$")[3];
                String email, password, studentId;
                if(role.equals("student")){
                    studentId = request.split("\\$")[4];
                    role = "student"+"$"+studentId;
                    email = request.split("\\$")[5];
                    password = request.split("\\$")[6];
                } else{
                    email = request.split("\\$")[4];
                    password = request.split("\\$")[5];
                }
                if(Database.getInstance().isUsernameAvailable(username)){
                    res = "409";
                } else{
                    Database.getInstance().createUser(role, username, password, name, email);
                    res = "200";
                }
                break;
            case "GET: logInChecker":
                username = request.split("\\$")[1];
                password = request.split("\\$")[2];
                if(!Database.getInstance().isUsernameAvailable(username)){
                    System.out.println(Database.getInstance().getUsersDataMap());
                    res = "404";
                }else if(!Database.getInstance().doesUsernameMatchPassword(username, password)){
                    res = "409";
                }else{
                    res = "200";
                }
                break;
                
        }
        return res;
    }
}
