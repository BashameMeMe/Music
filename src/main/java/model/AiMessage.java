package model;

import java.util.Date;

public class AiMessage {
	private long id;
	private long userId;
	private String role;
	private String content;
	private Date createdAt;

	public AiMessage() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AiMessage(long id, long userId, String role, String content, Date createdAt) {
		super();
		this.id = id;
		this.userId = userId;
		this.role = role;
		this.content = content;
		this.createdAt = createdAt;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

}