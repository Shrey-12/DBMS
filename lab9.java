import java.sql.*;
import java.util.Scanner;

public class lab9 {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int snum = 0;
        String sname = "";
        String major = "";
        String level = "";
        String cname="";
        int sage = 0;
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
            String sql = "insert into Student1 (snum, sname, major, level, sage) values (?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);

            int count = 5;

            while (count >0) {
                String input = sc.nextLine();
                String[] values = input.split(", ");

                snum = Integer.parseInt(values[0]);
                sname = values[1];
                major = values[2];
                level = values[3];
                sage = Integer.parseInt(values[4].trim());

                pstmt.setInt(1, snum);
                pstmt.setString(2, sname);
                pstmt.setString(3, major);
                pstmt.setString(4, level);
                pstmt.setInt(5, sage);
                count--;
                pstmt.execute();
            }

            String sql2 = "insert into NewEnrolled (snum,cname) values (?, ?)";
            PreparedStatement pstmt2 = conn.prepareStatement(sql2);

            int count2 = 5;

            while (count2 >0) {
                String input = sc.nextLine();
                String[] values = input.split(", ");

                snum = Integer.parseInt(values[0]);
                cname = values[1];

                pstmt2.setInt(1, snum);
                pstmt2.setString(2, cname);
                count2--;
                pstmt2.execute();
            }


        } catch (SQLException e) {
            System.out.println(e);
        }
        sc.close();

    }
}
