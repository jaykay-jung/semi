package dao;

import java.sql.SQLException;

import helper.DaoHelper;
import vo.Point;
import vo.User;

public class PointDao {
	
	private static PointDao instance = new PointDao();
	private PointDao() {}
	public static PointDao getInstance() {
		return instance;
	}
    
    private DaoHelper helper = DaoHelper.getInstance();
    
    /**
     * 포인트 정보 저장
     * @param point
     * @throws SQLException
     */
    public void insertPoint(Point point) throws SQLException {
		String sql = "INSERT INTO SEMI_USER_POINTS "
					+ "(USER_POINT_NO, USER_TOTAL_POINT, USER_USED_POINT, USER_AVAILABLE_POINT, USER_NO) "
					+ "VALUES "
					+ "(SEMI_USER_POINTS_SEQ.nextval, ?, ?, ?, ? ) ";
		
		helper.insert(sql, point.getTot(), point.getUsed(), point.getAvailble(), point.getUser().getNo());
	}
    
    /**
     * 포인트 사용 뒤 포인트 정보 업데이트
     * @param point
     * @throws SQLException
     */
    public void updatePoint(Point point) throws SQLException {
		String sql = "UPDATE SEMI_USER_POINTS "
				   + "SET "
				   + "		USER_TOTAL_POINT = ?, "
				   + "		USER_USED_POINT = ?, "
				   + "		USER_AVAILABLE_POINT = ? "
				   + "WHERE USER_POINT_NO = ? ";
		
		helper.update(sql, point.getTot(), point.getUsed(), point.getAvailble(), point.getNo());
	}
    
    /**
     * 사용자 번호를 받아 포인트현황정보를 반환하는 메소드
     * @param userNo
     * @return
     * @throws SQLException
     */
    public Point getPointByUserNo(int userNo) throws SQLException {
		String sql = "SELECT USER_POINT_NO, USER_TOTAL_POINT, USER_USED_POINT, USER_AVAILABLE_POINT, USER_NO "
				   + "FROM SEMI_USER_POINTS "
				   + "WHERE USER_NO = ? ";
		
		return helper.selectOne(sql, rs -> {
			Point point = new Point();
			point.setNo(rs.getInt("USER_POINT_NO"));
			point.setTot(rs.getInt("USER_TOTAL_POINT"));
			point.setUsed(rs.getInt("USER_USED_POINT"));
			point.setAvailble(rs.getInt("USER_AVAILABLE_POINT"));
			
			User user = new User();
			user.setNo(rs.getInt("USER_NO"));
			point.setUser(user);
			
			return point;

		}, userNo);
				
	}
    

}

