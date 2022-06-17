package dao;

import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.Address;
import vo.Order;
import vo.OrderItem;
import vo.Product;
import vo.User;

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
        
        helper.insert(sql, orderItem.getOrderNo(), orderItem.getProduct().getNo(), orderItem.getQuantity(), orderItem.getPrice());
    }
    
    /**
     * 사용자번호로 주문한 주문상품정보를 반환한다.
     * @param userNo 사용자번호
     * @return 주문내역
     * @throws SQLException
     */
    public List<OrderItem> getOrderItemsByUserNo(int userNo) throws SQLException {
        String sql = "select * "
                   + "from semi_order_item "
                   + "order by order_item_no ";
        
        return helper.selectList(sql, rs -> {
            OrderItem orderItem = new OrderItem();
            orderItem.setNo(rs.getInt("order_item_no"));
            orderItem.setOrderNo(rs.getInt("order_no"));
            orderItem.setQuantity(rs.getInt("order_item_quantity"));
            orderItem.setPrice(rs.getInt(rs.getInt("order_item_price")));
            
            Product product = new Product();
            product.setNo(rs.getInt("product_no"));
            orderItem.setProduct(product);
            
            return orderItem;
        }, userNo);
    }
    
    /**
     * 입력한 주문번호와 일치하는 주문상품정보를 삭제
     * @param orderNo 주문번호
     * @throws SQLException
     */
    public void deletedOrderItem(int orderItemNo) throws SQLException {
    	String sql = "DELETE FROM SEMI_ORDER_ITEM "
				   + "WHERE ORDER_ITEM_NO = ? ";
	
	helper.delete(sql, orderItemNo);
    }
}