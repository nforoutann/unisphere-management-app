package objects.serializable;

import java.util.ArrayList;
import java.util.List;

public class AssignmentListWrapper {
    List<Assignment> assignments;

    public AssignmentListWrapper(List<Assignment> assignments) {
        this.assignments = assignments;
    }

    public List<Assignment> getAssignments() {
        return assignments;
    }

    public void setAssignments(List<Assignment> assignments) {
        this.assignments = assignments;
    }
}
