package dao;

import java.sql.SQLException;

import helper.DaoHelper;
import vo.OrderItem;

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
    
}
