package model;

public class Music {
    private int id;
    private String title;
    private String artist;
    private String filePath;
    private String coverImage;

    public Music() {}

	public Music(int id, String title, String artist, String filePath, String coverImage) {
		super();
		this.id = id;
		this.title = title;
		this.artist = artist;
		this.filePath = filePath;
		this.coverImage = coverImage;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getArtist() {
		return artist;
	}

	public void setArtist(String artist) {
		this.artist = artist;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getCoverImage() {
		return coverImage;
	}

	public void setCoverImage(String coverImage) {
		this.coverImage = coverImage;
	}
    
    
}
