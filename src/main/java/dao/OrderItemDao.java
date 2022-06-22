package dao;

import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.Order;
import vo.OrderItem;
import vo.Product;

public class OrderItemDao {

    private static OrderItemDao instance = new OrderItemDao();
    private OrderItemDao() {}
    public static OrderItemDao getInstance() {
        return instance;
    }

    private DaoHelper helper = DaoHelper.getInstance();

    /**
     * 주문한 상품정보를 전달받아 테이블에 저장하는 메소드
     * @param orderItem 주문상품정보
     * @throws SQLException
     */
    public void insertOrderItem(OrderItem orderItem) throws SQLException {
        String sql = "insert into order_item "
                   + "(order_item_no, order_no, product_no, order_item_quantity, order_item_price) "
                   + "values "
                   + "(order_item_seq.nextval, ?, ?, ?, ?) ";
        
        helper.insert(sql, orderItem.getOrder().getNo(), orderItem.getProduct().getNo(), orderItem.getQuantity(), orderItem.getPrice());
    }
    
    // 사용자정보와 날짜로 검색해서 주문상세정보를 반환한다.
    public List<OrderItem> getOrdersByDate(int userNo, Date startDate, Date endDate) throws SQLException {
    	String sql = "SELECT O.ORDER_CREATED_DATE, O.TOTAL_PAYMENT_PRICE, O.ORDER_STATUS, I.ORDER_NO, I.PRODUCT_NO, P.PRODUCT_NAME, P.PRODUCT_IMAGE_NAME, I.ORDER_ITEM_QUANTITY "
    			+ "FROM SEMI_ORDERS O, ORDER_ITEM I, SEMI_PRODUCTS P "
				+ "WHERE O.USER_NO = ? "
    			+ "AND (ORDER_CREATED_DATE "
    			+ "	BETWEEN TO_DATE( ? ,'YYYY-MM-DD') "
    			+ "	AND TO_DATE( ? ,'YYYY-MM-DD')) "
    			+ "AND O.ORDER_NO = I.ORDER_NO "
    			+ "AND I.PRODUCT_NO = P.PRODUCT_NO "
    			+ "ORDER BY O.ORDER_NO DESC ";
    	
    	return helper.selectList(sql, rs-> {
    		
    		OrderItem orderItem = new OrderItem();
    		
    		
    		Order order = new Order();
    		order.setCreatedDate(rs.getDate("ORDER_CREATED_DATE"));
    		order.setTotalpay(rs.getInt("TOTAL_PAYMENT_PRICE"));
    		order.setStatus(rs.getString("ORDER_STATUS"));
    		order.setNo(rs.getInt("ORDER_NO"));
    		orderItem.setOrder(order);
    		
    		Product product = new Product();
    		product.setNo(rs.getInt("PRODUCT_NO"));
    		product.setName(rs.getString("PRODUCT_NAME"));
    		product.setImageName(rs.getString("PRODUCT_IMAGE_NAME"));
    		orderItem.setProduct(product);
    		
    		orderItem.setQuantity(rs.getInt("ORDER_ITEM_QUANTITY"));
    		return orderItem;
    		
    	}, userNo, startDate, endDate);
    }
    
}
