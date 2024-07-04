package objects.serializable;

import java.io.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class User implements Serializable {
    private String name;
    private String username;
    private String password;
    private String birthday;
    private String email;
    private List<String> ongoingTasks = new ArrayList<>();

    public User(String name, String username) {
        this.name = name;
        this.username = username;
    }

    public String getName() {
        return name;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getBirthday() {
        return birthday;
    }

    public List<String> getOngoingTasks() {
        return ongoingTasks;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public void setOngoingTasks(List<String> ongoingTasksTitle) {
        this.ongoingTasks = ongoingTasksTitle;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEmail() {
        return email;
    }

    @Override
    public boolean equals(Object o) {
        return this.username.equals(((User) o).username);
    }
}
