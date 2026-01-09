package model;

import util.*;
import java.sql.*;
import java.util.*;

public class FavoriteDao {
	// checkfavorite
	public boolean isFavorite(int userId, int musicId) {
		String sql = "SELECT 1 FROM favorite WHERE user_id=? AND music_id=?";
		try (Connection c = KetNoiDB.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {

			ps.setInt(1, userId);
			ps.setInt(2, musicId);
			ResultSet rs = ps.executeQuery();
			return rs.next();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// add
	public void addFavorite(int userId, int musicId) throws Exception {
		String checkSql = "SELECT * FROM favorite WHERE user_id=? AND music_id=?";
		String insertSql = "INSERT INTO favorite(user_id, music_id) VALUES(?, ?)";
		try (Connection conn = KetNoiDB.getConnection(); PreparedStatement checkPs = conn.prepareStatement(checkSql)) {

			checkPs.setInt(1, userId);
			checkPs.setInt(2, musicId);
			ResultSet rs = checkPs.executeQuery();

			// Nếu chưa có trong favorite thì thêm
			if (!rs.next()) {
				PreparedStatement insertPs = conn.prepareStatement(insertSql);
				insertPs.setInt(1, userId);
				insertPs.setInt(2, musicId);
				insertPs.executeUpdate();
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// xóa
	public void removeFavorite(int userId, int musicId) throws Exception {
		String sql = "DELETE FROM favorite WHERE user_id=? AND music_id=?";
		try (Connection conn = KetNoiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userId);
			ps.setInt(2, musicId);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// Lấy danh sách
	public List<Music> getFavoriteMusic(int userId) throws Exception {
		List<Music> list = new ArrayList<>();
		String sql = "SELECT m.id, m.title, m.artist, m.file_path "
				+ "FROM music m INNER JOIN favorite f ON m.id = f.music_id " + "WHERE f.user_id = ?";
		try (Connection conn = KetNoiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(new Music(rs.getInt("id"), rs.getString("title"), rs.getString("artist"),
						rs.getString("file_path"), rs.getString("cover_image")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Music> getFavoriteMusicByUser(int userId) {
		List<Music> list = new ArrayList<>();

		String sql = """
				    SELECT m.*
				    FROM music m
				    JOIN favorite f ON m.id = f.music_id
				    WHERE f.user_id = ?
				    ORDER BY m.title
				""";

		try (Connection c = KetNoiDB.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {

			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Music m = new Music();
				m.setId(rs.getInt("id"));
				m.setTitle(rs.getString("title"));
				m.setArtist(rs.getString("artist"));
				m.setFilePath(rs.getString("file_path"));
				m.setCoverImage(rs.getString("cover_image"));
				list.add(m);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
