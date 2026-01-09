package model;

import java.sql.Timestamp;

public class User {
	private int id;
	private String username;
	private String password;
	private String email;
	private String avatar;
	private String role;
	private double balance;
	private Timestamp vipExpirationDate;
	private boolean is_vip;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAvatar() {
		return avatar;
	}
	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public Timestamp getVipExpirationDate() {
		return vipExpirationDate;
	}
	public void setVipExpirationDate(Timestamp vipExpirationDate) {
		this.vipExpirationDate = vipExpirationDate;
	}
	public double getBalance() {
		return balance;
	}
	public void setBalance(double balance) {
		this.balance = balance;
	}
	
	public boolean isIs_vip() {
		return is_vip;
	}
	public void setIs_vip(boolean is_vip) {
		this.is_vip = is_vip;
	}
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}
	public User(int id, String username, String password, String email, String avatar, String role, double balance,
			Timestamp vipExpirationDate, boolean is_vip) {
		super();
		this.id = id;
		this.username = username;
		this.password = password;
		this.email = email;
		this.avatar = avatar;
		this.role = role;
		this.balance = balance;
		this.vipExpirationDate = vipExpirationDate;
		this.is_vip = is_vip;
	}



	
}
