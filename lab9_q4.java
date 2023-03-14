import java.sql.*;
import java.util.Scanner;
import java.io.File;
import java.awt.Desktop;

public class lab9_q4 {
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
            String sql = "SELECT paper_id FROM student_research WHERE snum = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);

            System.out.println("Enter Student id: ");
            int snum = sc.nextInt();
            pstmt.setInt(1, snum);

            ResultSet rsA = pstmt.executeQuery();
            if (rsA.next()) {
                System.out.println("paper details:");
                String paper_id = rsA.getString("paper_id");
                System.out.println("Paper id: " + paper_id);

                String filePath = "files/" + paper_id + ".pdf";
                File file = new File(filePath);
                // Open the file in the default PDF viewer
                if (Desktop.isDesktopSupported()) {
                    Desktop.getDesktop().open(file);
                }

            }
        } catch (Exception e) {
            System.out.println(e);
        }

        sc.close();
    }
}
