package vo;

import java.sql.Date;

public class Product {
	
    private int no;
    private String name;
    private String imageName;
    private String description;
    private int customerPrice;
    private int sellPrice;
    private int depositPoint;
    private int deleveryFee;
    private int stock;
    private boolean onSell;
    private Date createdDate;
    private Date updatedDate;
    private int categoryNo;
    private boolean deleted;

    public Product() {}

    public int getNo() {
        return this.no;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImageName() {
        return this.imageName;
    }

    public void setImageName(String imageName) {
        this.imageName = imageName;
    }

    public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getCustomerPrice() {
        return this.customerPrice;
    }

    public void setCustomerPrice(int customerPrice) {
        this.customerPrice = customerPrice;
    }

    public int getSellPrice() {
        return this.sellPrice;
    }

    public void setSellPrice(int sellPrice) {
        this.sellPrice = sellPrice;
    }

    public int getDepositPoint() {
        return this.depositPoint;
    }

    public void setDepositPoint(int depositPoint) {
        this.depositPoint = depositPoint;
    }

    public int getDeleveryFee() {
        return this.deleveryFee;
    }

    public void setDeleveryFee(int deleveryFee) {
        this.deleveryFee = deleveryFee;
    }

    public int getStock() {
        return this.stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public boolean isOnSell() {
        return this.onSell;
    }

    public boolean getOnSell() {
        return this.onSell;
    }

    public void setOnSell(boolean onSell) {
        this.onSell = onSell;
    }

    public Date getCreatedDate() {
        return this.createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getUpdatedDate() {
        return this.updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }

    public int getCategoryNo() {
        return this.categoryNo;
    }

    public void setCategoryNo(int categoryNo) {
        this.categoryNo = categoryNo;
    }

    public boolean isDeleted() {
        return this.deleted;
    }

    public boolean getDeleted() {
        return this.deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

}
