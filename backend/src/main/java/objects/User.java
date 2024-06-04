package objects;

public class User {
    private String firstName;
    private String lastName;
    private int id;
    private String password;
    private String email;

    public User(String firstName, String lastName, int id) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.id = id;
    }

    public int getId(){
        return id;
    }

    public String getFirstName() {
        return firstName;
    }
    public String getLastName() {
        return lastName;
    }
    public String getPassword() {
        return password;
    }

    @Override
    public boolean equals(Object o) {
        return this.id == ((User) o).id;
    }
}
