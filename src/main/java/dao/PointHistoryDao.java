package dao;

import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.Order;
import vo.PointHistory;
import vo.User;

public class PointHistoryDao {

	
	private static PointHistoryDao instance = new PointHistoryDao();
	private PointHistoryDao() {}
	public static PointHistoryDao getInstance() {
		return instance;
	}
    
    private DaoHelper helper = DaoHelper.getInstance();
    
    /**
     * 
     * @param pointHistory
     * @throws SQLException
     */
    public void insertPointHistory(PointHistory pointHistory) throws SQLException {
    	String sql = "INSERT INTO SEMI_USER_POINT_HISTORIES "
	    			+ "(HISTORY_NO, HISTORY_TITLE, POINT_AMOUNT, USER_NO, ORDER_NO) "
	    			+ "VALUES "
	    			+ "(SEMI_USER_POINT_HISTORIES_SEQ.nextval, ?, ?, ?, ?)	";
    	helper.insert(sql, pointHistory.getTitle(), pointHistory.getPointAmount(), pointHistory.getUser().getNo(), pointHistory.getOrder().getNo());
    }
    
    
    
	public int getTotalRows(int userNo) throws SQLException {
		String sql = "SELECT COUNT(*) CNT "
					+ "FROM SEMI_USER_POINT_HISTORIES "
					+ "WHERE USER_NO = ? ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("CNT");
		}, userNo);
	}
	
	/**
	 * 사용자번호를 받아 포인트내역을 가져오는 메소드. ORDER테이블은 조인하지 않음. (주문하지 않아도 HISTORY가 생성될 수 있기 때문)
	 * @param userNo
	 * @param beginIndex
	 * @param endIndex
	 * @return
	 */
    public List<PointHistory> getPointHistoryByUserNo(int userNo, int beginIndex, int endIndex) throws SQLException {
    	String sql = "SELECT R.HISTORY_NO, R.HISTORY_TITLE, R.POINT_AMOUNT, R.HISTORY_CREATED_DATE, R.USER_NO, R.ORDER_NO "
	    			+ "FROM    (SELECT HISTORY_NO, HISTORY_TITLE, POINT_AMOUNT, HISTORY_CREATED_DATE, USER_NO, ORDER_NO, ROW_NUMBER() OVER (ORDER BY HISTORY_NO DESC) ROW_NUMBER "
	    			+ "        FROM SEMI_USER_POINT_HISTORIES "
	    			+ "        WHERE USER_NO = ?) R "
	    			+ "WHERE R.ROW_NUMBER >= ? AND R.ROW_NUMBER <= ? "
	    			+ "ORDER BY R.HISTORY_NO DESC ";
	    return helper.selectList(sql, rs -> {
	    	
	    	PointHistory pointHistory = new PointHistory();
	    	
	    	pointHistory.setPointNo(rs.getInt("HISTORY_NO"));
	    	pointHistory.setTitle(rs.getString("HISTORY_TITLE"));
	    	pointHistory.setPointAmount(rs.getInt("POINT_AMOUNT"));
	    	pointHistory.setCreatedDate(rs.getDate("HISTORY_CREATED_DATE"));
	    	
	    	User user = new User();
	    	user.setNo(rs.getInt("USER_NO"));
	    	pointHistory.setUser(user);
	    	
	    	Order order = new Order();
	    	order.setNo(rs.getInt("ORDER_NO"));
	    	pointHistory.setOrder(order);
	    	
	    	return pointHistory;
	    
	    }, userNo, beginIndex, endIndex);
    }

}
