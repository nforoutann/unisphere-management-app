package objects.serializable;

import java.util.List;

public class CourseListWrapper {
    List<Course> courses;
    public CourseListWrapper(List<Course> courses) {
        this.courses = courses;
    }
    public List<Course> getCourses() {
        return courses;
    }
    public void setCourses(List<Course> courses) {
        this.courses = courses;
    }
}
