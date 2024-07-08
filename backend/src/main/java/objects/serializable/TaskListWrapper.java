package objects.serializable;

import java.util.List;

public class TaskListWrapper {

    private List<Task> tasks;

    public TaskListWrapper(List<Task> tasks) {
        this.tasks = tasks;
    }

    public List<Task> getTasks() {
        return tasks;
    }

    public void setTasks(List<Task> tasks) {
        this.tasks = tasks;
    }
}
