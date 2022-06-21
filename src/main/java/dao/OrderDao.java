package dao;

import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.Address;
import vo.Order;
import vo.Product;
import vo.User;

public class OrderDao {
	
	private static OrderDao instance = new OrderDao();
	private OrderDao() {}
	public static OrderDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();

    /**
     * 주문정보를 전달받아 테이블에 저장하는 메소드
     * @param order 주문정보
     * @throws SQLException
     */
    public  void insertOrder(Order order) throws SQLException {
        String sql = "insert into semi_orders "
                   + "(order_no, order_created_date, order_status, "
                   + "order_total_price, used_point, total_payment_price, deposit_point, "
                   + "payment_type, receive_date, user_no, address_no, product_no) "
                   + "values "
                   + "(semi_orders_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
        
        helper.insert(sql, order.getCreatedDate(), order.getStatus(), order.getTotalPrice(), order.getUsedPoint(), order.getTotalpay(), order.getDepositPoint(),
            order.getPayType(), order.getReceiveDate(), order.getUser().getNo(), order.getAddress().getNo(), order.getProduct().getNo());
    }

    /**
     * 사용자번호와 일치하는 모든 주문 정보를 반환
     * @param userNo 사용자번호
     * @return 주문내역
     * @throws SQLException
     */
    public List<Order> getOrdersByUserNo(int userNo) throws SQLException {
        String sql = "select * "
                   + "from semi_orders "
                   + "where user_no = ? "
                   + "order by order_no ";
        
        return helper.selectList(sql, rs -> {
            Order order = new Order();
            order.setNo(rs.getInt("order_no"));
            order.setCreatedDate(rs.getDate("order_created_date"));
            order.setStatus(rs.getString("order_status"));
            order.setTotalPrice(rs.getInt("order_total_price"));
            order.setUsedPoint(rs.getInt("used_point"));
            order.setTotalpay(rs.getInt("order_no"));
            order.setDepositPoint(rs.getInt("deposit_point"));
            order.setPayType(rs.getString("payment_type"));
            order.setUpdatedDate(rs.getDate("order_updated_date"));
            order.setReceiveDate(rs.getDate("receive_date"));
            
            User user = new User();
            user.setNo(rs.getInt("user_no"));
            order.setUser(user);

            Address address = new Address();
            address.setNo(rs.getInt("address_no"));
            order.setAddress(address);
            
            Product product = new Product();
            product.setNo(rs.getInt("product_no"));
            order.setProduct(product);

            return order;
        }, userNo);
    }
    
}
