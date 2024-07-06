package objects.serializable;

import java.io.Serializable;

public class Task implements Serializable {
    private String title;
    private boolean done;
    private String doAtTime;

    public Task(String title, boolean done, String doAtTime) {
        this.title = title;
        this.done = done;
        this.doAtTime = doAtTime;
    }

    public String getTitle() {
        return title;
    }

    public boolean isDone() {
        return done;
    }

    public String getDoAtTime() {
        return doAtTime;
    }

    public void setDoAtTime(String doAtTime) {
        this.doAtTime = doAtTime;
    }
}
