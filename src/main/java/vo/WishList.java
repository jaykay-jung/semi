package vo;

import java.util.Date;

public class WishList {

	private int wishNo;
	private User userNo;
	private Product productNo;
	private Date createdDate;
	
	public WishList() {}

	public int getWishNo() {
		return wishNo;
	}

	public void setWishNo(int wishNo) {
		this.wishNo = wishNo;
	}

	public User getUserNo() {
		return userNo;
	}

	public void setUserNo(User userNo) {
		this.userNo = userNo;
	}

	public Product getProductNo() {
		return productNo;
	}

	public void setProductNo(Product productNo) {
		this.productNo = productNo;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	
}
