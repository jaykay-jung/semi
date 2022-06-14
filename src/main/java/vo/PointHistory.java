package vo;

import java.sql.Date;

public class PointHistory {

	private int pointNo;
	private String title;
	private int pointtAmount;
	private Date createdDate;
	
	public PointHistory() {
	}

	public int getPointNo() {
		return pointNo;
	}

	public void setPointNo(int pointNo) {
		this.pointNo = pointNo;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getPointtAmount() {
		return pointtAmount;
	}

	public void setPointtAmount(int pointtAmount) {
		this.pointtAmount = pointtAmount;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}


	
}
