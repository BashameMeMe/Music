package model;

public class Favorite {
    private int userId;
    private int musicId;

    // Constructor mặc định
    public Favorite() {}

    // Constructor đầy đủ
    public Favorite(int userId, int musicId) {
        this.userId = userId;
        this.musicId = musicId;
    }

    // Getter và Setter
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getMusicId() {
        return musicId;
    }

    public void setMusicId(int musicId) {
        this.musicId = musicId;
    }
}
