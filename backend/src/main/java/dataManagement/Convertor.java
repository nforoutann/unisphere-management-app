package dataManagement;

import objects.Student;
import objects.Term;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class Convertor {
    public static HashMap<String, String > stringToMap (String s) {
        String [] info = s.split(",,");
        HashMap <String, String> res = new HashMap<>();
        for (var each : info) {
            int colon = each.indexOf(':');
            String key = each.substring(0, colon);
            String value = each.substring(colon + 1);
            res.put(key, value);
        }
        return res;
    }
    public static HashMap <String, HashMap <String, String>> UserArrayToMap(ArrayList<HashMap <String, String>> list) {
        HashMap <String, HashMap <String, String>> res = new HashMap<>();
        for (var i : list)
            res.put(i.get("username"), i);
        return res;
    }

    public static String mapOfUsersToString(HashMap <String, HashMap <String, String>> m) {
        try {
            StringBuilder res = new StringBuilder();
            for (Map.Entry<String, HashMap <String, String>> entry : m.entrySet()) {
                for (Map.Entry<String, String> entry1 : entry.getValue().entrySet())
                    res.append(String.format("%s:%s,,", entry1.getKey(), entry1.getValue()));
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

    public static String termObjectToString(Term term, Student student) { //todo how to handle the score
        String result = "term"+term.getTermNumber()+">"+"active?"+term.isActive();
        try{
            for(var course : term.getCourses()){
                result='/'+"title="+course.getTitle()+"-teacher="+course.getTeacher().getName()+"-teacherId="+course.getTeacher().getUsername()+"-score="+20;
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

    public static HashMap<String, HashMap<String, String>> copyHashMap(HashMap<String, HashMap<String, String>> map){
        HashMap<String, HashMap<String, String>> res = new HashMap<>();
        for (Map.Entry<String, HashMap<String, String>> entry : map.entrySet()) {
            res.put(entry.getKey(), entry.getValue());
        }
        return res;
    }

}
