package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.ConnectionUtil;
import vo.User;

public class UserDao {

	private static UserDao instance = new UserDao();
	private UserDao() {}
	public static UserDao getInstance() {
		return instance;
	}
	
	/**
	 *  지정된 아이디와 일치하는 사용자 정보 반환
	 * @param id
	 * @return 사용자 정보, 일치하는 정보 없으면 null
	 * @throws SQLException
	 */
	public User getUserById(String id) throws SQLException {
		String sql = "select * "
				 	+ "from semi_users "
				 	+ "where user_id = ? ";
		
		User user = null;
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()) {
			user = new User();
			user.setNo(rs.getInt("user_no"));
			user.setId(rs.getString("user_id"));
			user.setPassword(rs.getString("user_password"));
			user.setEmail(rs.getString("user_email"));
			user.setName(rs.getString("user_name"));
			user.setPhone(rs.getString("user_phone"));
			user.setGender(rs.getString("user_gender"));
			user.setBirthday(rs.getDate("user_birthday"));
			user.setAdmin(rs.getString("user_admin"));
			user.setAddress(rs.getString("user_address"));
			user.setDeleted(rs.getString("user_deleted"));
			user.setCreatedDate(rs.getDate("user_created_date"));
			user.setUpdatedDate(rs.getDate("user_updated_date"));
			user.setGrade(rs.getString("user_grade"));
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return user;
	}
}
