package dataManagement;

import objects.serializable.Assignment;
import objects.serializable.AssignmentType;

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

    public static List<Assignment> mapToListOfAssignments(HashMap<String, HashMap<String, String>> map) {
        List<Assignment> res = new ArrayList<>();
        HashMap<String, AssignmentType> type = new HashMap<>();
        type.put("HW", AssignmentType.HW);
        type.put("PROJECT", AssignmentType.PROJECT);
        for(Map.Entry<String, HashMap<String, String>> entry : map.entrySet()) {
            Assignment assignment = new Assignment();
            assignment.setAssignmentId(entry.getKey());
            assignment.setTitle(entry.getValue().get("title"));
            assignment.setScore(Double.parseDouble(entry.getValue().get("score")));
            assignment.setType(type.get(entry.getValue().get("type")));
            assignment.setEstimateTime(Integer.parseInt(entry.getValue().get("estimatedTime")));
            String deadlineStr = entry.getValue().get("deadline");
            deadlineStr = deadlineStr.substring(1, deadlineStr.length() - 1);
            String[] deadline = deadlineStr.split("~");
            assignment.setDeadline(new Date(Integer.parseInt(deadline[0]), Integer.parseInt(deadline[1]), Integer.parseInt(deadline[2]))); //todo change the Date type with LocalDate
            String definedTimeStr = entry.getValue().get("definedTime");
            definedTimeStr = definedTimeStr.substring(1, definedTimeStr.length() - 1);
            String[] definedTime = definedTimeStr.split("~");
            assignment.setDefinedTime(new Date(Integer.parseInt(definedTime[0]), Integer.parseInt(definedTime[1]), Integer.parseInt(definedTime[2])));
            res.add(assignment);
        }
        return res;
    }

}
