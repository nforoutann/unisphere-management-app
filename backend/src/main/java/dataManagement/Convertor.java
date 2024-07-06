package dataManagement;

import objects.serializable.Assignment;
import objects.serializable.AssignmentType;
import objects.serializable.Course;
import objects.serializable.Student;

import java.util.*;

public class Convertor {

    public static HashMap<String, String > stringToMap (String s) {
        String [] info = s.split(",,");
        HashMap <String, String> res = new HashMap<>();
        for (var each : info) {
            int colon = each.indexOf('>');
            String key = each.substring(0, colon);
            String value = each.substring(colon + 1);
            res.put(key, value);
        }
        return res;
    }

    public static HashMap <String, HashMap <String, String>> ArrayToMap(ArrayList<HashMap <String, String>> list, String key) {
        HashMap <String, HashMap <String, String>> res = new HashMap<>();
        for (var i : list){
            res.put(i.get(key), i);
        }
        return res;
    }

    public static String mapOfUsersToString(HashMap <String, HashMap <String, String>> m) {
        try {
            StringBuilder res = new StringBuilder();
            for (Map.Entry<String, HashMap <String, String>> entry : m.entrySet()) {
                for (Map.Entry<String, String> entry1 : entry.getValue().entrySet())
                    res.append(String.format("%s>%s,,", entry1.getKey(), entry1.getValue()));
                res.deleteCharAt(res.length() - 1);
                res.deleteCharAt(res.length() - 1);
                res.append('\n');
            }
            return res.toString();
        }
        catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    public static List<Assignment> mapToListOfAssignments(HashMap<String, HashMap<String, String>> map, HashMap<String, HashMap<String, String>> map2) {
        List<Assignment> res = new ArrayList<>();
        HashMap<String, AssignmentType> type = new HashMap<>();
        type.put("HW", AssignmentType.HW);
        type.put("PROJECT", AssignmentType.PROJECT);
        for(Map.Entry<String, HashMap<String, String>> entry : map.entrySet()) {
            Assignment assignment = new Assignment();
            String courseId = entry.getValue().get("assignmentId").split("&")[0]+"&"+entry.getValue().get("assignmentId").split("&")[1];
            String courseName = map2.get(courseId).get("title");
            assignment.setCourseName(courseName);
            assignment.setAssignmentId(entry.getKey());
            assignment.setTitle(entry.getValue().get("title"));
            assignment.setScore(Double.parseDouble(entry.getValue().get("score")));
            assignment.setType(type.get(entry.getValue().get("type")));
            assignment.setEstimateTime(Integer.parseInt(entry.getValue().get("estimatedTime")));
            String deadlineStr = entry.getValue().get("deadline");
            assignment.setDeadline(deadlineStr); //todo change the Date type with LocalDate
            String definedTimeStr = entry.getValue().get("definedTime");
            assignment.setDefinedTime(definedTimeStr);
            res.add(assignment);
        }
        return res;
    }

    public static Course mapToCourse(HashMap<String, String> map, String nameOfTheBestStudent, String teacherName){
        Course course = new Course();
        course.setCourseId(map.get("courseId"));
        course.setTitle(map.get("title"));
        course.setTeacherName(teacherName);
        course.setCredit(map.get("credit"));
        course.setNumberOfDefinedAssignments(String.valueOf(map.get("assignments").split("//").length));
        course.setNameOfBestStudent(nameOfTheBestStudent);
        return course;
    }
}