package dataManagement;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Scanner;

public class Table {
    private String PATH;
    public Table(String PATH) {
        this.PATH = PATH;
    }
    public ArrayList<HashMap <String, String>> get() {
        try {
            File file=new File(this.PATH);
            Scanner sc = new Scanner(file);
            ArrayList<HashMap<String, String>> res = new ArrayList<>();
            while (sc.hasNextLine())
                res.add(Convertor.stringToMap(sc.nextLine()));
            sc.close();
            return res;
        }
        catch (Exception e) {
            return new ArrayList<>();
        }
    }

}
