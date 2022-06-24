package vo;

public class Point {

	private int no;
	private int tot;
	private int used;
	private int availble;
	private int unUsed;
	private User user;
	
	public Point() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}
	
	public int getTot() {
		return tot;
	}

	public void setTot(int tot) {
		this.tot = tot;
	}

	public int getUsed() {
		return used;
	}

	public void setUsed(int used) {
		this.used = used;
	}

	public int getAvailble() {
		return availble;
	}

	public void setAvailble(int availble) {
		this.availble = availble;
	}

	public int getUnUsed() {
		return unUsed;
	}

	public void setUnUsed(int unUsed) {
		this.unUsed = unUsed;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}

