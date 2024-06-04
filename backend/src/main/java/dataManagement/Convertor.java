package dataManagement;

import java.util.ArrayList;
import java.util.HashMap;

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
}
