package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.KetNoiDB;

public class AiMessageDao {

	public static void save(long userId, String role, String content) {
	    String sql = "INSERT INTO AiMessage (user_id, role, content) VALUES (?, ?, ?)";
	    Connection conn = null;
	    PreparedStatement ps = null;
	    try {
	        conn = KetNoiDB.getConnection();
	        conn.setAutoCommit(false);  

	        ps = conn.prepareStatement(sql);
	        ps.setLong(1, userId);
	        ps.setString(2, role);
	        ps.setString(3, content);
	        ps.executeUpdate();

	        conn.commit();  // <-- QUAN TRỌNG: commit thủ công
	        System.out.println("Lưu tin nhắn AI thành công: " + role);
	    } catch (Exception e) {
	        if (conn != null) {
	            try { conn.rollback(); } catch (Exception ex) {}
	        }
	        e.printStackTrace();
	    } finally {
	    }
	}

	public static List<AiMessage> getHistory(int userId) {
		List<AiMessage> list = new ArrayList<>();

		String sql = " SELECT id, user_id, role, content, created_at FROM AiMessage WHERE user_id = ? ORDER BY created_at ASC";

		try (Connection conn = KetNoiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				AiMessage m = new AiMessage();
				m.setId(rs.getInt("id"));
				m.setUserId(rs.getInt("user_id"));
				m.setRole(rs.getString("role"));
				m.setContent(rs.getString("content"));
				m.setCreatedAt(rs.getTimestamp("created_at"));
				list.add(m);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
}
