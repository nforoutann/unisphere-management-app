package objects.serializable;

import java.io.Serializable;

public class Task implements Serializable {
    String title;
    boolean done;

    Task(String title, boolean done) {
        this.title = title;
        this.done = done;
    }
}
