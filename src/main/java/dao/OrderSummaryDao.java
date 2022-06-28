package dao;

import java.sql.SQLException;
import helper.DaoHelper;
import vo.OrderSummary;


public class OrderSummaryDao {
	
	
	private static OrderSummaryDao instance = new OrderSummaryDao();
	private OrderSummaryDao() {}
	public static OrderSummaryDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
    /**
     * 총 구매금액과 총 주문건수를 반환하는 메소드를 작성, 
     * @param userNo
     * @return
     * @throws SQLException
     */
    public OrderSummary getOrderSummaryByUserNo(int userNo) throws SQLException {
    	String sql = "SELECT SUM(TOTAL_PAYMENT_PRICE) TOT, COUNT(*)CNT "
    				+ "FROM SEMI_ORDERS "
    				+ "WHERE USER_NO = ? ";
    	return helper.selectOne(sql, rs -> {
    		OrderSummary orderSummary = new OrderSummary();
    		orderSummary.setTotalPay(rs.getInt("TOT"));
    		orderSummary.setTotalNo(rs.getInt("CNT"));
    		return orderSummary;
    		
    	}, userNo);
    }

}
