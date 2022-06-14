package vo;

import java.sql.Date;

public class PointHistory {

	private int pointHistoryNo;
	private String historyTitle;
	private int pointAmount;
	private Date pointHistoryCreatedDate;
	
	public PointHistory() {
		super();
	}
	public PointHistory(int pointHistoryNo, String historyTitle, int pointAmount, Date pointHistoryCreatedDate) {
		super();
		this.pointHistoryNo = pointHistoryNo;
		this.historyTitle = historyTitle;
		this.pointAmount = pointAmount;
		this.pointHistoryCreatedDate = pointHistoryCreatedDate;
	}
	
	public int getPointHistoryNo() {
		return pointHistoryNo;
	}
	public void setPointHistoryNo(int pointHistoryNo) {
		this.pointHistoryNo = pointHistoryNo;
	}
	public String getHistoryTitle() {
		return historyTitle;
	}
	public void setHistoryTitle(String historyTitle) {
		this.historyTitle = historyTitle;
	}
	public int getPointAmount() {
		return pointAmount;
	}
	public void setPointAmount(int pointAmount) {
		this.pointAmount = pointAmount;
	}
	public Date getPointHistoryCreatedDate() {
		return pointHistoryCreatedDate;
	}
	public void setPointHistoryCreatedDate(Date pointHistoryCreatedDate) {
		this.pointHistoryCreatedDate = pointHistoryCreatedDate;
	}
	
	
}
