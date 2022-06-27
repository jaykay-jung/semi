package dao;

import java.sql.SQLException;

import helper.DaoHelper;
import vo.User;

public class UserDao {

    private static UserDao instance = new UserDao();
	private UserDao() {}
	public static UserDao getInstance() {
		return instance;
	}
    
    private DaoHelper helper = DaoHelper.getInstance();

    /**
     * 회원가입 기능 메소드 
     * @param user 사용자 정보
     * @throws SQLException
     */
    public void insertUser(User user) throws SQLException {
        String sql = "insert into semi_users "
                   + "(user_no, user_id, user_password, user_email, user_name, user_phone, user_gender, user_birthday, user_grade) "
                   + "values "
                   + "(semi_users_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?) ";

        helper.insert(sql, user.getId(), user.getPassword(), user.getEmail(), user.getName(), user.getPhone(), user.getGender(), user.getBirthday(), user.getGrade());
    }

    /**
     * 아이디를 받아 사용자 정보를 반환하는 메소드
     * @param id 사용자 아이디
     * @return user 사용자 정보
     * @throws SQLException
     */
    public User getUserById(String id) throws SQLException {
        String sql = "select * "
                   + "from semi_users "
                   + "where user_id = ? ";

        return helper.selectOne(sql, rs -> {
            User user = new User();
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
            user.setCreatedDate(rs.getDate("user_updated_date"));
            user.setGrade(rs.getString("user_grade"));

            return user;
        }, id);
    }

    /**
     * 이메일을 받아 사용자 정보를 반환하는 메소드
     * @param email 이메일
     * @return user 사용자 정보
     * @throws SQLException
     */
    public User getUserByEmail(String email) throws SQLException {
        String sql = "select * "
                   + "from semi_users "
                   + "where user_email = ? ";

        return helper.selectOne(sql, rs -> {
            User user = new User();
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
            user.setCreatedDate(rs.getDate("user_updated_date"));
            user.setGrade(rs.getString("user_grade"));

            return user;
        }, email);
    }
    
    /**
     * 가장 최근에 가입한 유저정보 반환
     * @param rownum 1로 설정
     * @return
     * @throws SQLException
     */
    public User getUserByRownum(int rownum) throws SQLException {
    	String sql = "select * "
    			   + "from (select * "
    			   + "		from semi_users "
    			   + "		order by user_created_date desc) "
    			   + "where rownum = ? ";
    	
    	return helper.selectOne(sql, rs -> {
    		User user = new User();
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
            user.setCreatedDate(rs.getDate("user_updated_date"));
            user.setGrade(rs.getString("user_grade"));
    		
    		return user;
    	}, rownum);
    }

}

