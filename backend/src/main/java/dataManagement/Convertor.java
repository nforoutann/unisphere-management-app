package dataManagement;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

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

}
