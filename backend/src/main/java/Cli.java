import dataManagement.*;
import objects.serializable.*;

import java.util.Scanner;

public class Cli {
    static String command;
    public static void main(String[] args) {
        String res = menu("role");
        switch (res) {
            case "1":
                res = menu("Admin Request");
                switch (res) {
                    case "1":
                        res = menu("Add Teacher");
                        String[] teachersInfo = res.split("\\$");
                        System.out.println(teachersInfo[0]);
                        Database.getInstance().createTeacher(teachersInfo[0], teachersInfo[1], teachersInfo[2], teachersInfo[3], teachersInfo[4]);
                        break;
                    case "2":
                        res = menu("Add Student");
                        String[] studentsInfo = res.split("\\$");
                        Database.getInstance().createStudent(studentsInfo[0], studentsInfo[1], studentsInfo[2], studentsInfo[3], studentsInfo[4]);
                        break;
                    case "3":
                        res = menu("Delete Student");
                        Database.getInstance().deleteStudent(res);
                        break;
                    case "4":
                        res = menu("Create Course");
                        String[] courseInfo = res.split("\\$");
                        Database.getInstance().createCourse(courseInfo[0], courseInfo[1], courseInfo[2], courseInfo[3]);
                        break;
                    case "5":
                        res = menu("Delete Course");
                        Database.getInstance().deleteCourse(res);
                        break;
                    case "6":
                        res = menu("Add Student To Course");
                        String[] studentToCourseInfo = res.split("\\$");
                        Database.getInstance().addStudentToCourse(studentToCourseInfo[0], studentToCourseInfo[1]);
                        break;
                    case "7":
                        res = menu("Remove Student From Course");
                        studentToCourseInfo = res.split("\\$");
                        Database.getInstance().deleteStudentFromCourse(studentToCourseInfo[0], studentToCourseInfo[1]);
                        break;

                }break;
            case "2":
                res = menu("Teacher");
                String username = res.split("\\$")[0];
                String password = res.split("\\$")[1];
                if(!Database.getInstance().doesUsernameMatchPassword(username, password)){
                    System.out.println("Sorry, Try Again");
                    break;
                } else{
                    res = menu("Teacher Request");
                }
                switch (res) {
                    case "1":
                        res = menu("Add Student To Course");
                        String[] studentToCourseInfo = res.split("//$");
                        Database.getInstance().addStudentToCourse(studentToCourseInfo[0], studentToCourseInfo[1]);
                        break;
                    case "2":
                        res = menu("Remove Student From Course");
                        studentToCourseInfo = res.split("//$");
                        Database.getInstance().deleteStudentFromCourse(studentToCourseInfo[0], studentToCourseInfo[1]);
                        break;
                    case "3":
                        res = menu("Add Assignment");
                        String[] assignmentInfo = res.split("//$");
                        Database.getInstance().createAssignment(assignmentInfo[0], assignmentInfo[1], assignmentInfo[2], assignmentInfo[3], assignmentInfo[4], assignmentInfo[5], assignmentInfo[6], assignmentInfo[7]);
                        break;
                    case "4":
                        res = menu("Delete Assignment");
                        Database.getInstance().deleteAssignment(res);
                        break;
                    case "5":
                        res = menu("Set Score");
                        String[] scoreInfo = res.split("//$");
                        Database.getInstance().setScore(scoreInfo[0], scoreInfo[1], scoreInfo[2]);
                        break;
                }
            case "3": return;
        }
    }


    public static String menu(String command){
        Scanner scanner = new Scanner(System.in);
        Scanner scanner1 = new Scanner(System.in);
        String res = "";

        switch(command){
            case "role":
                System.out.println("Please specify a role");
                System.out.println("1. Admin");
                System.out.println("2. Teacher");
                System.out.println("3. Exist");
                res = scanner.next();
                break;
            case "Teacher":
                System.out.println("Please Enter Your Username And Password First");
                String username = scanner.nextLine();
                String password = scanner.nextLine();
                res = username+"$"+password;
                break;
            case "Admin Request":
                System.out.println("What Is Your Request?");
                System.out.println("1. Add Teacher");
                System.out.println("2. Add Student");
                System.out.println("3. Delete Student");
                System.out.println("4. Create Course");
                System.out.println("5. Delete Course");
                System.out.println("6. Add Student To Course");
                System.out.println("7. Remove Student From Course");
                res = scanner.next();
                break;
            case "Teacher Request":
                System.out.println("What Is Your Request?");
                System.out.println("1. Add Student To Course");
                System.out.println("2. Remove Student From Course");
                System.out.println("3. Add Assignment");
                System.out.println("4. Delete Assignment");
                System.out.println("5. Set Score");
                res = scanner.next();
                break;
            case "Add Teacher":
                System.out.println("Please Enter The Following Info:");
                System.out.print("Username: ");
                res = scanner.nextLine();
                System.out.print("Password: ");
                res = res+"$"+scanner.nextLine();
                System.out.print("Name: ");
                res = res + "$"+scanner.nextLine();
                System.out.print("Teacher's Code: ");
                res = res + "$"+scanner.nextLine();
                System.out.print("Teacher's Email: ");
                res = res + "$"+scanner.nextLine();
                break;
            case "Add Student":
                System.out.println("Please Enter The Following Info:");
                System.out.print("Username: ");
                res = scanner.nextLine();
                System.out.print("Password: ");
                res = res+"$"+scanner.nextLine();
                System.out.print("Name: ");
                res = res + "$"+scanner.nextLine();
                System.out.print("Student's id: ");
                res = res + "$"+scanner.nextLine();
                System.out.print("Student's Email: ");
                res = res + "$"+scanner.nextLine();
                break;
            case "Delete Student":
                System.out.println("Please Enter The Student's username:");
                System.out.print("Username: ");
                res = scanner.nextLine();
                break;
            case "Create Course":
                System.out.println("Please Enter The Following Info:");
                System.out.print("Teacher's Username: ");
                res = scanner.nextLine();
                System.out.println("Course Title: ");
                res = res+ "$"+ scanner.nextLine();
                System.out.println("Credit: ");
                res = res + "$"+ scanner.nextLine();
                res = res + "$" + menu("Time");
                break;
            case "Time":
                String time = "";
                System.out.print("How Many Times The Course Occur Weekly?");
                res = scanner.nextLine();
                for(int i=0 ; i<Integer.parseInt(res); i++){
                    System.out.print("Enter The Week Day: ");
                    time = time + scanner.nextLine().toUpperCase()+"=";
                    System.out.print("Enter The Starting Hour: ");
                    time = time + "~" + scanner.nextLine();
                    System.out.print("Enter The Ending Hour: ");
                    time = time + "~" + scanner.nextLine()+"//";
                }
                time = time.substring(0, time.length()-2);
                time = "{" + time + "}";
                res = time;
                break;
            case "Delete Course":
                System.out.print("Enter The CourseId:");
                res = scanner.nextLine();
                break;
            case "Add Student To Course":
            case ("Remove Student From Course"):
                System.out.print("Enter The Student Username:");
                res = scanner.nextLine();
                System.out.print("Enter The CourseId:");
                res = res + "$"+ scanner.nextLine();
                break;
            case "Add Assignment":
                System.out.println("Please Enter The Following Info:");
                System.out.println("Course Id: ");
                res = scanner.nextLine();
                System.out.println("Assignment Title: ");
                res = res + "$"+ scanner.nextLine();
                System.out.println("Assignment Type: HW or  PROJECT? ");
                res = res + "$"+ scanner.nextLine();
                System.out.println("Today's Date As Defined Time: ");
                System.out.print("Year: ");
                String year = scanner.nextLine();
                System.out.print("Month: ");
                String month = scanner.nextLine();
                System.out.print("Day: ");
                String day = scanner.nextLine();
                time = "{"+year+"::"+month+"::"+day+"}";
                res = res + "$"+ time;
                System.out.print("Description: ");
                res = res + "$"+ scanner.nextLine();
                System.out.print("Estimated Time(Hours): ");
                res = res + "$"+ scanner.nextLine();
                System.out.println("Deadline: ");
                System.out.print("Year: ");
                year = scanner.nextLine();
                System.out.print("Month: ");
                month = scanner.nextLine();
                System.out.print("Day: ");
                day = scanner.nextLine();
                time = "{"+year+"::"+month+"::"+day+"}";
                res = res + "$" + time;
                System.out.print("Socre: ");
                res = res + "$"+ scanner.nextLine();
                break;
            case "Delete Assignment":
                System.out.print("Please Enter The Assignment Id:");
                res = scanner.nextLine();
                break;
            case "Set Score":
                System.out.print("Please Enter The Student's Username:");
                res = scanner.nextLine();
                System.out.print("Please Enter The Assignment Id:");
                res = res + "$" + scanner.nextLine();
                System.out.print("Please Enter The Score:");
                res = res + "$"+ scanner.nextLine();
                break;

        }

        return res;
    }

}
