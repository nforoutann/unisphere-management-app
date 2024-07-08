package network;
import controller.Controller;
import com.google.gson.Gson;
import objects.serializable.*;


import java.util.*;
import java.io.*;

import java.net.Socket;

public class RequestHandler extends Thread {
    private Socket socket;
    private DataOutputStream dos;
    private DataInputStream dis;

    public RequestHandler(Socket socket) throws IOException{
        this.socket = socket;
        dos = new DataOutputStream(socket.getOutputStream());
        dis = new DataInputStream(socket.getInputStream());

        System.out.println("connected to server");
    }

    @Override
    public void run() {
        super.run();
        String command;
        try {
            command = listener();
            System.out.println("command received: { " + command + " }");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        Object res = new Controller().run(command); //todo maybe review again for run in controller
        try{
            if(res instanceof String){
                writer((String)res);
            } else{
                writerObj(res);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public String listener() throws IOException {
        try{
            System.out.println("listener is activated");
            StringBuilder sb = new StringBuilder();
            int index = dis.read();
            while (index != 0) {
                sb.append((char) index);
                index = dis.read();
            }
            Scanner s = new Scanner(sb.toString());
            StringBuilder request = new StringBuilder();
            while (s.hasNextLine()) {
                request.append(s.nextLine());
            }
            System.out.println("listener2 -> read command successfully");
            return request.toString();}
        catch (IOException e) {
            System.out.println("error in listener : " + e);}
        return "Error!";
    }

    public void writerObj(Object obj) throws IOException {
        Gson gson = new Gson();
        String json = "";

        if (obj instanceof Student) {
            Student student = (Student) obj;
            json = gson.toJson(student);
        } else if (obj instanceof TaskListWrapper) {
            TaskListWrapper taskList = (TaskListWrapper) obj;
            List<Task> tasks = taskList.getTasks();
            json = gson.toJson(tasks);
        } else if(obj instanceof CourseListWrapper){
            CourseListWrapper courseList = (CourseListWrapper) obj;
            List<Course> courses = courseList.getCourses();
            json = gson.toJson(courses);
        } else {
            throw new IllegalArgumentException("Unsupported object type");
        }

        PrintWriter writer = new PrintWriter(dos, true);
        writer.println(json);
        dos.close();
        dis.close();
        writer.close();
        socket.close();
        System.out.println(obj.toString());
        System.out.println("Command finished and response sent to server");
    }

    public void writer(String write) throws IOException {
        dos.writeBytes(write);
        dos.flush();
        dos.close();
        dis.close();
        socket.close();
        System.out.println(write);
        System.out.println("command finished and response sent to server");
    }
}
