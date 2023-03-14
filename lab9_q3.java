import java.sql.*;
import java.util.Scanner;

public class lab9_q3 {
    public static void main(String[] args) {
        int snum = 0;
        String paper_id = "";

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
            String sql = "CREATE TABLE IF NOT EXISTS student_research(snum INT NOT NULL,paper_id VARCHAR(20),PRIMARY KEY (snum, paper_id),FOREIGN KEY (snum) REFERENCES Student(snum))";
            Statement stmt = conn.createStatement();
            stmt.executeUpdate(sql);
            System.out.println("Created student_reseach relation");

            String sql2 = "INSERT INTO student_research (snum, paper_id) VALUES (?,?)";
            PreparedStatement pstmt = conn.prepareStatement(sql2);

            int count = 3;
            System.out.println("Enter values for student_research table:");

            while (count > 0) {
                String input = sc.nextLine();
                String[] values = input.split(", ");

                snum = Integer.parseInt(values[0]);
                paper_id = values[1];

                pstmt.setInt(1, snum);
                pstmt.setString(2, paper_id);
                pstmt.execute();
                count--;
            }
            pstmt.close();
            conn.close();


        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());

        }
        
        sc.close();
        
    }
}

