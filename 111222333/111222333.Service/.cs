public class StudentServiceImpl implements IStudentService {
    @Override
    public Student getStudentById(int id) {
        // Fetch student detail from the database
        // and set the student instance
        return student;
    }

    @Override
    public List<Student> getAllStudents() {
        // Fetch all the student details from the database
        // and set the student instances in the List
        return studentList;
    }

    @Override
    public boolean addStudent(Student student) {
        // Add the student detail to the database
        return isAdded;
    }

    @Override
    public boolean updateStudent(Student student) {
        // Update the student detail in the database
        return isUpdated;
    }

    @Override
    public boolean deleteStudent(int id) {
        // Delete the student detail from the database
        return isDeleted;
    }
}