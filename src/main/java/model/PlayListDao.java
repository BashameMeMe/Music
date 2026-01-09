package model;

import util.*;
import java.sql.*;
import java.util.*;

public class PlayListDao {
	public void createPlaylist(String name, int userId) {
		try (Connection conn = KetNoiDB.getConnection()) {
			String sql = "INSERT INTO playlist(name,user_id) VALUES(?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setInt(2, userId);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<PlayList> getPlaylists(int userId) {
		List<PlayList> list = new ArrayList<>();
		try (Connection conn = KetNoiDB.getConnection()) {
			String sql = "SELECT * FROM playlist WHERE user_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			while (rs.next())
				list.add(new PlayList(rs.getInt("id"), rs.getString("name"), rs.getInt("user_id")));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public void addMusicToPlaylist(int playlistId, int musicId) throws Exception {
		String checkSql = "SELECT * FROM playlist_music WHERE playlist_id = ? AND music_id = ?";
		String insertSql = "INSERT INTO playlist_music(playlist_id, music_id) VALUES(?, ?)";
		try (Connection conn = KetNoiDB.getConnection(); PreparedStatement checkPs = conn.prepareStatement(checkSql)) {

			checkPs.setInt(1, playlistId);
			checkPs.setInt(2, musicId);
			ResultSet rs = checkPs.executeQuery();
			if (!rs.next()) {
				PreparedStatement insertPs = conn.prepareStatement(insertSql);
				insertPs.setInt(1, playlistId);
				insertPs.setInt(2, musicId);
				insertPs.executeUpdate();
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public List<Music> getMusicInPlaylist(int playlistId) throws Exception {
		List<Music> list = new ArrayList<>();
		String sql = """
				    SELECT m.id, m.title, m.artist, m.file_path, m.cover_image
				    FROM music m
				    JOIN playlist_music pm ON m.id = pm.music_id
				    WHERE pm.playlist_id = ?
				""";

		try (Connection conn = KetNoiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, playlistId);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				list.add(new Music(rs.getInt("id"), rs.getString("title"), rs.getString("artist"),
						rs.getString("file_path"), rs.getString("cover_image")));
			}
		}
		return list;
	}

	public List<PlayList> getUserPlaylists(int userId) {
		List<PlayList> list = new ArrayList<>();

		String sql = "SELECT id, name, user_id FROM playlist WHERE user_id = ?";

		try (Connection conn = KetNoiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				list.add(new PlayList(rs.getInt("id"), rs.getString("name"), rs.getInt("user_id")));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public PlayList getPlaylistById(int playlistId) throws Exception {
		PlayList p = null;
		String sql = "SELECT id, name, user_id FROM playlist WHERE id = ?";

		try (Connection conn = KetNoiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, playlistId);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				p = new PlayList(rs.getInt("id"), rs.getString("name"), rs.getInt("user_id"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return p;
	}

	public void removeMusicFromPlaylist(int playlistId, int musicId) {
		String sql = "DELETE FROM playlist_music WHERE playlist_id=? AND music_id=?";

		try (Connection c = KetNoiDB.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {

			ps.setInt(1, playlistId);
			ps.setInt(2, musicId);

			int rows = ps.executeUpdate();
			System.out.println("Deleted rows = " + rows);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public boolean isPlaylistOwnedByUser(int playlistId, int userId) {
		String sql = "SELECT 1 FROM playlist WHERE id=? AND user_id=?";
		try (Connection c = KetNoiDB.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {

			ps.setInt(1, playlistId);
			ps.setInt(2, userId);
			return ps.executeQuery().next();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public void deletePlaylist(int playlistId) {
		String deletePlaylistMusic = "DELETE FROM playlist_music WHERE playlist_id=?";
		String deletePlaylist = "DELETE FROM playlist WHERE id=?";

		try (Connection c = KetNoiDB.getConnection()) {

			PreparedStatement ps1 = c.prepareStatement(deletePlaylistMusic);
			ps1.setInt(1, playlistId);
			ps1.executeUpdate();

			PreparedStatement ps2 = c.prepareStatement(deletePlaylist);
			ps2.setInt(1, playlistId);
			ps2.executeUpdate();

			System.out.println("Deleted playlist id = " + playlistId);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
