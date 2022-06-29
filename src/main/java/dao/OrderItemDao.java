package dao;

import java.util.Date;
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
                   + "(order_item_seq.nextval, ?, ?, ?, ? ) ";
        
        helper.insert(sql, orderItem.getOrder().getNo(), orderItem.getProduct().getNo(), orderItem.getQuantity(), orderItem.getPrice());
    }
    
    /**
	 * 전체 주문상품 리스트 갯수 반환
	 * @return
	 * @throws SQLException
	 */
	public int getTotalRows() throws SQLException {
		String sql = "select count(*) cnt "
					+ "from semi_reviews ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		});
	}
    
	/**
	 * 베스트 상품 등록을 위해서 제일 많이 팔린 상품정보 조회하기
	 * @return orderItem 
	 * @throws SQLException
	 */
	public List<OrderItem> getBestSeller() throws SQLException {
		String sql = "select product_no "
				   + "from (select product_no "
				   + "		from order_item "
				   + "		group by product_no) "
				   + "where rownum <= 3 ";
		
		return helper.selectList(sql, rs -> {
			OrderItem orderItem = new OrderItem();
			Product product = new Product();
			product.setNo(rs.getInt("product_no"));
			orderItem.setProduct(product);
			return orderItem;
		});
	}
	
	/**
	 * 페이징 처리를 위한 상품주문 리스트 반환
	 * @param beginIndex
	 * @param endIndex
	 * @return
	 * @throws SQLException
	 */
	public List<OrderItem> getOrderItems(int beginIndex, int endIndex) throws SQLException {
		String sql = "select I.order_item_no, I.order_item_quantity, I.order_item_price, I.order_no, P.product_no, P.product_name, P.product_image_name, O.order_created_date, O.order_status, O.order_total_price, O.used_point, O.total_payment_price, O.deposit_point, O.payment_type, O.receive_date "
					+ "from (select order_item_no, order_no, product_no, order_item_quantity, order_item_price, "
					+ "		 		row_number() over (order by order_item_no desc) row_number "
					+ "		 from order_item) I, semi_orders O, semi_products P "
					+ "where I.row_number >= ? and I.row_number <= ? "
					+ "and I.order_no = O.order_no "
					+ "and I.product_no = P.product_no "
					+ "order by I.order_item_no desc ";
		
		return helper.selectList(sql, rs -> {
			
			OrderItem orderItem = new OrderItem();
			orderItem.setNo(rs.getInt("order_item_no"));
			orderItem.setQuantity(rs.getInt("order_item_quantity"));
			orderItem.setPrice(rs.getInt("order_item_price"));
		
			Product product = new Product();			
			product.setNo(rs.getInt("product_no"));
			product.setName(rs.getString("product_name"));
			product.setImageName(rs.getString("product_image_name"));
			orderItem.setProduct(product);
			
			Order order = new Order();
			order.setNo(rs.getInt("order_no"));
			order.setCreatedDate(rs.getDate("order_created_date"));
			order.setStatus(rs.getString("order_status"));
			order.setTotalPrice(rs.getInt("order_total_price"));
			order.setUsedPoint(rs.getInt("used_point"));
			order.setTotalpay(rs.getInt("total_payment_price"));
			order.setDepositPoint(rs.getInt("deposit_point"));
			order.setPayType(rs.getString("payment_type"));
			order.setReceiveDate(rs.getDate("receive_date"));
			orderItem.setOrder(order);
			
			return orderItem;
			
		}, beginIndex, endIndex);
	}
	
    /**
     * 사용자정보와 날짜로 검색해서 주문상세정보를 반환
     * @param userNo 사용자 번호
     * @param startDate 날짜범위
     * @param endDate 날짜범위
     * @return
     * @throws SQLException
     */
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
    	
    		return orderItem;
    		
    	}, userNo, startDate, endDate);
    }
    
}
