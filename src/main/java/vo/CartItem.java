package vo;

import java.util.Date;

public class CartItem {

	private int no;
    private int userNo;
    private int productNo;
    private Date createdDate;

    public CartItem() {}
    
    public int getNo() {
        return this.no;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public int getUserNo() {
        return this.userNo;
    }

    public void setUserNo(int userNo) {
        this.userNo = userNo;
    }

    public int getProductNo() {
        return this.productNo;
    }

    public void setProductNo(int productNo) {
        this.productNo = productNo;
    }

    public Date getCreatedDate() {
        return this.createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }
}
