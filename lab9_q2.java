import java.sql.*;
import java.util.Scanner;

public class lab9_q2 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println(e);
        }

        try {
            String url = "jdbc:mysql://localhost:3306/test";
            String username = "shreya";
            String password = "shreya123_";

            Connection conn = DriverManager.getConnection(url, username, password);
            String sql = "SELECT * FROM Student1 WHERE snum = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);

            System.out.println("Enter Student id: ");
            int studentId = sc.nextInt();
            pstmt.setInt(1, studentId);

            ResultSet rsA = pstmt.executeQuery();
            if (rsA.next()) {
                System.out.println("Student Details:");
                System.out.println("Student ID: " + rsA.getInt("snum"));
                System.out.println("Student Name: " + rsA.getString("sname"));
                System.out.println("Major: " + rsA.getString("major"));
                System.out.println("Level: " + rsA.getString("level"));
                System.out.println("Age: " + rsA.getInt("sage"));

                sql = "SELECT * FROM Enrolled WHERE snum = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, studentId);

                ResultSet rsB = pstmt.executeQuery();
                if (rsB.next()) {
                    System.out.println("Classes Enrolled:");
                    do {
                        System.out.println(rsB.getString("cname"));
                    } while (rsB.next());
                } else {
                    System.out.println("No classes enrolled.");
                    sql = "SELECT * FROM Class";
                    pstmt = conn.prepareStatement(sql);
                    ResultSet rsC = pstmt.executeQuery();
                    System.out.println("Available Classes:");
                    while (rsC.next()) {
                        System.out.println(rsC.getString("name"));
                    }

                    System.out.println("Enter class name to enroll:");
                    String className = sc.next();

                    sql = "INSERT INTO NewEnrolled (snum, cname) VALUES (?, ?)";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, studentId);
                    pstmt.setString(2, className);
                    int rowsInserted = pstmt.executeUpdate();
                    if (rowsInserted > 0) {
                        System.out.println("Enrolled in " + className);
                    } else {
                        System.out.println("Error enrolling in " + className);
                    }
                }
            } else {
                System.out.println("Error: Student ID not found.");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        sc.close();

    }
}
