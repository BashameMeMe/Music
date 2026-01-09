package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class KetNoiDB {
	public static Connection getConnection() throws Exception {
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		Connection conn = DriverManager.getConnection(
				"jdbc:sqlserver://localhost:1433;databaseName=Music;user=sa;password=123;trustServerCertificate=true;");
		conn.setAutoCommit(true); // <-- THÊM DÒNG NÀY
		return conn;
	}

	public static void main(String[] args) throws Exception {
		Connection cn = KetNoiDB.getConnection();
		if (cn != null)
			System.out.println("Ket noi thanh cong");
		else
			System.out.println("Co loi");
	}
}