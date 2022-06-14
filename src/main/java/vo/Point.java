package vo;

public class Point {

	private int totalPoint;
	private int usedPoint;
	private int availablePoint;
	private int unUsedPoint;
	
	public Point() {
		super();
	}
	public Point(int totalPoint, int usedPoint, int availablePoint, int unUsedPoint) {
		super();
		this.totalPoint = totalPoint;
		this.usedPoint = usedPoint;
		this.availablePoint = availablePoint;
		this.unUsedPoint = unUsedPoint;
	}
	
	public int getTotalPoint() {
		return totalPoint;
	}
	public void setTotalPoint(int totalPoint) {
		this.totalPoint = totalPoint;
	}
	public int getUsedPoint() {
		return usedPoint;
	}
	public void setUsedPoint(int usedPoint) {
		this.usedPoint = usedPoint;
	}
	public int getAvailablePoint() {
		return availablePoint;
	}
	public void setAvailablePoint(int availablePoint) {
		this.availablePoint = availablePoint;
	}
	public int getUnUsedPoint() {
		return unUsedPoint;
	}
	public void setUnUsedPoint(int unUsedPoint) {
		this.unUsedPoint = unUsedPoint;
	}
	
	
	
}
