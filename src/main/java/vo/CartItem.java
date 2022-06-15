package vo;

import java.util.Date;

public class CartItem {

	private int cartNo;
    private User userNo;
    private Product productNo;
    private Date createdDate;

    public CartItem() {}

	public int getCartNo() {
		return cartNo;
	}

	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
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