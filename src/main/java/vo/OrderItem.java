package vo;

public class OrderItem {
	
	private int no;
    private Order order;
    private Product product;
    private int quantity;
    private int price;
    
    public OrderItem() {}    
    
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}

}