package model;

import util.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class UserDao {
	public List<User> getAll() {
		List<User> list = new ArrayList<>();
		String sql = "SELECT * FROM users";

		try (Connection c = KetNoiDB.getConnection();
				PreparedStatement ps = c.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				list.add(mapRow(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public User getById(int id) {
		String sql = "SELECT * FROM users WHERE id=?";
		try (Connection c = KetNoiDB.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {

			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return mapRow(rs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public User login(String username, String password) {
		String sql = "SELECT * FROM users WHERE username=?";
		try (Connection c = KetNoiDB.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {

			ps.setString(1, username);

			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				String hp = rs.getString("password");
				if(HashPassword.checkPassword(password, hp)) {
					return mapRow(rs);
				}
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	
	// 4. Đăng ký (Mặc định balance = 0, vip = null do DB tự set hoặc để null)
	public boolean register(User user) {
		String sql = "INSERT INTO users(username, email, password, role, balance) VALUES(?,?,?,'USER', 0)";
		try (Connection conn = KetNoiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, user.getUsername());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPassword());

			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	
	public void insert(String username, String password, String email, String avatar, String role, double balance,
			Timestamp vipExpirationDate) {
		String sql = "INSERT INTO users(username, password, email, avatar, role, balance, vip_expiration_date) VALUES(?,?,?,?,?,?,?)";
		try (Connection c = KetNoiDB.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
			ps.setString(1, username);
			ps.setString(2, password);
			ps.setString(3, email);
			ps.setString(4, avatar);
			ps.setString(5, role);
			ps.setDouble(6, balance);
			if (vipExpirationDate != null) {
				ps.setTimestamp(7, vipExpirationDate);
			} else {
				ps.setNull(7, java.sql.Types.TIMESTAMP);
			}
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Lỗi khi insert User: " + e.getMessage());
		}
	}
	
	public void update(User u) {
	    String sql = """
	        UPDATE users 
	        SET username=?, 
	            email=?, 
	            avatar=?, 
	            role=?, 
	            balance=?, 
	            vip_expiration_date=?
	        WHERE id=?
	    """;

	    try (Connection c = KetNoiDB.getConnection();
	         PreparedStatement ps = c.prepareStatement(sql)) {

	        ps.setString(1, u.getUsername());
	        ps.setString(2, u.getEmail());
	        ps.setString(3, u.getAvatar());
	        ps.setString(4, u.getRole());
	        ps.setDouble(5, u.getBalance());

	        if (u.getVipExpirationDate() != null)
	            ps.setTimestamp(6, u.getVipExpirationDate());
	        else
	            ps.setNull(6, Types.TIMESTAMP);

	        ps.setInt(7, u.getId());

	        ps.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}


	// 6. Xóa user
	public void delete(int id) {
		String sql = "DELETE FROM users WHERE id=?";
		try (Connection c = KetNoiDB.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
			ps.setInt(1, id);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// ================= CÁC HÀM NÂNG CAO CHO VIP & VÍ TIỀN =================

	// 7. Cập nhật ngày hết hạn VIP
	public boolean updateVipDate(int userId, Timestamp newDate) {
		String sql = "UPDATE users SET vip_expiration_date = ? WHERE id = ?";
		try (Connection conn = KetNoiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setTimestamp(1, newDate);
			ps.setInt(2, userId);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// 8. Trừ tiền (Dùng khi mua gói VIP)
	public boolean deductBalance(int userId, double amount) {

		String sql = "UPDATE users SET balance = balance - ? WHERE id = ? AND balance >= ?";
		try (Connection conn = KetNoiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setDouble(1, amount);
			ps.setInt(2, userId);
			ps.setDouble(3, amount);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean depositBalance(int userId, double amount) {
		String sql = "UPDATE users SET balance = balance + ? WHERE id = ?";
		try (Connection conn = KetNoiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setDouble(1, amount);
			ps.setInt(2, userId);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// ================= CÁC HÀM TIỆN ÍCH KHÁC =================

	public boolean checkPassword(int userId, String password) {
		String sql = "SELECT id FROM users WHERE id=? AND password=?";
		try (Connection con = KetNoiDB.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, userId);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			return rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public void updatePassword(int userId, String newPassword) {
		String sql = "UPDATE users SET password=? WHERE id=?";
		try (Connection con = KetNoiDB.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, newPassword);
			ps.setInt(2, userId);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void updateAvatar(int userId, String avatar) {
		String sql = "UPDATE users SET avatar=? WHERE id=?";
		try (Connection con = KetNoiDB.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, avatar);
			ps.setInt(2, userId);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void updateEmail(int userId, String email) {
		String sql = "UPDATE users SET email=? WHERE id=?";
		try (Connection con = KetNoiDB.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, email);
			ps.setInt(2, userId);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int countUsers() {
		String sql = "SELECT COUNT(*) FROM users";
		try (Connection c = KetNoiDB.getConnection();
				PreparedStatement ps = c.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			if (rs.next())
				return rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	// Lấy user mới nhất (Sửa LIMIT thành SELECT TOP cho SQL Server)
	public List<User> getLatestUsers(int limit) {
		List<User> list = new ArrayList<>();
		String sql = "SELECT TOP (?) * FROM users ORDER BY id DESC";

		try (Connection c = KetNoiDB.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
			ps.setInt(1, limit);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(mapRow(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	private User mapRow(ResultSet rs) throws SQLException {
		return new User(rs.getInt("id"), rs.getString("username"), rs.getString("password"), rs.getString("email"),
				rs.getString("avatar"), rs.getString("role"), rs.getDouble("balance"),
				rs.getTimestamp("vip_expiration_date"),rs.getBoolean("is_vip"));
	}

	

	

}
