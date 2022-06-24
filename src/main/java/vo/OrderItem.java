package vo;

public class OrderItem {
	
	private int no;
    private Order order;
    private Product product;
    private User user;
    
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
	
	public User getUser() {
		return user;
	}
	
	public void setUser(User user) {
		this.user = user;
	}

}