package controller;

import dataManagement.Database;
import objects.serializable.CourseListWrapper;
import objects.serializable.Student;
import objects.serializable.Task;
import objects.serializable.TaskListWrapper;

import java.util.List;

public class Controller {

    public Object run(String request){
        Object res = "";
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
                    res = "404";
                }else if(!Database.getInstance().doesUsernameMatchPassword(username, password)){
                    res = "409";
                }else{
                    res = "200";
                }
                break;
            case "GET: userInfo":
                username = request.split("\\$")[1];
                String year = request.split("\\$")[2];
                String month = request.split("\\$")[3];
                String day = request.split("\\$")[4];
                String time = year+"::"+month+"::"+day;
                res = Database.getInstance().getUserInfo(username, time); //the res is user now
                Student student = (Student) res;
                System.out.println("the users name is: "+((Student) res).getName());
                break;
            case "POST assignments":
                username = request.split("\\$")[1];
                //todo
                break;
            case "POST: doneTask":
                username = request.split("\\$")[1];
                String title = request.split("\\$")[2];
                boolean done = request.split("\\$")[3].equals("yes");
                boolean check = Database.getInstance().setDoneTask(username, title, done);
                res = check ? "200" : "409";
                break;
            case "POST: deleteTask":
                username = request.split("\\$")[1];
                title = request.split("\\$")[2];
                check = Database.getInstance().deleteTask(username, title);
                res = check ? "200" : "409";
                break;
            case "GET: getTasks":
                username = request.split("\\$")[1];
                List<Task> task = Database.getInstance().getTasks(username);
                res = new TaskListWrapper(task);
                break;
            case "POST: createTask":
                username = request.split("\\$")[1];
                title = request.split("\\$")[2];
                time = request.split("\\$")[3];
                done = request.split("\\$")[4].equals("yes");
                Database.getInstance().createTask(username, title, time, done);
                res = "200";
                break;
            case "GET: getCourses":
                username = request.split("\\$")[1];
                res = new CourseListWrapper(Database.getInstance().getCourses(username));
                break;
            default:
                res = "404";
        }
        return res;
    }
}