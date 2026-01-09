package model;

import util.*;
import java.sql.*;
import java.util.*;

public class MusicDao {
	public List<Music> getAllMusic() {
		List<Music> list = new ArrayList<>();
		try (Connection conn = KetNoiDB.getConnection()) {
			String sql = "SELECT * FROM music";
			ResultSet rs = conn.createStatement().executeQuery(sql);
			while (rs.next()) {
				list.add(new Music(rs.getInt("id"), rs.getString("title"), rs.getString("artist"),
						rs.getString("file_path"), rs.getString("cover_image")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public Music getMusicById(int id) {
		try (Connection conn = KetNoiDB.getConnection()) {
			String sql = "SELECT * FROM music WHERE id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				return new Music(rs.getInt("id"), rs.getString("title"), rs.getString("artist"),
						rs.getString("file_path"), rs.getString("cover_image"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<Music> search(String keyword) {
		List<Music> list = new ArrayList<>();
		try (Connection conn = KetNoiDB.getConnection()) {
			String sql = "SELECT * FROM music WHERE title LIKE ? OR artist LIKE ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + keyword + "%");
			ps.setString(2, "%" + keyword + "%");
			ResultSet rs = ps.executeQuery();
			while (rs.next())
				list.add(new Music(rs.getInt("id"), rs.getString("title"), rs.getString("artist"),
						rs.getString("file_path"), rs.getString("cover_image")));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public void addMusic(Music m) {
	    String sql = "INSERT INTO music(title,artist,file_path,cover_image) VALUES(?,?,?,?)";
	    try (Connection c = KetNoiDB.getConnection();
	         PreparedStatement ps = c.prepareStatement(sql)) {

	        ps.setString(1, m.getTitle());
	        ps.setString(2, m.getArtist());
	        ps.setString(3, m.getFilePath());
	        ps.setString(4, m.getCoverImage());
	        ps.executeUpdate();

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

	public void deleteMusic(int id) {
	    String sql = "DELETE FROM music WHERE id=?";
	    try (Connection c = KetNoiDB.getConnection();
	         PreparedStatement ps = c.prepareStatement(sql)) {

	        ps.setInt(1, id);
	        ps.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    }

	public void updateMusic(Music m) {
	    String sql = """
	        UPDATE music
	        SET title=?, artist=?, file_path=?, cover_image=?
	        WHERE id=?
	    """;

	    try (Connection c = KetNoiDB.getConnection();
	         PreparedStatement ps = c.prepareStatement(sql)) {

	        ps.setString(1, m.getTitle());
	        ps.setString(2, m.getArtist());
	        ps.setString(3, m.getFilePath());
	        ps.setString(4, m.getCoverImage());
	        ps.setInt(5, m.getId());

	        ps.executeUpdate();

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	
	
	
	public int countMusic() {
	    String sql = "SELECT COUNT(*) FROM music";
	    try (Connection c = KetNoiDB.getConnection();
	         PreparedStatement ps = c.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {
	        if (rs.next()) return rs.getInt(1);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return 0;
	}

}
