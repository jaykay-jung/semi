package dao;

import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.Address;
import vo.User;

public class AddressDao {
	
	private static AddressDao instance = new AddressDao();
	private AddressDao() {}
	public static AddressDao getInstance() {
		return instance;
	}

	private DaoHelper helper = DaoHelper.getInstance();
	
	/**
	 * 주소를 전달받아서, 주소록에 추가한다.
	 * @param address
	 * @throws SQLException
	 */
	public void insertAddress(Address address) throws SQLException {
		String sql = "INSERT INTO SEMI_USER_ADDRESS "
					+ "(ADDRESS_NO, NICKNAME, ADDRESS_NAME, POSTAL_CODE, ADDRESS, ADDRESS_DETAIL, TEL, USER_NO) "
					+ "VALUES "
					+ "(SEMI_USER_ADDRESS_SEQ.nextval, ?, ?, ?, ?, ?, ?, ?) ";
		
		helper.insert(sql, address.getNickName(), address.getName(), address.getZip(), address.getCity(), address.getStreet(), address.getTel(), address.getUser().getNo());
	}


	/**
	 * 주소를 전달받아서, 주소를 수정한다.
	 * @param address
	 * @throws SQLException
	 */
	public void updateAddress(Address address) throws SQLException {
		String sql = "UPDATE SEMI_USER_ADDRESS "
				   + "SET "
				   + "		ADDRESS_NAME = ?, "
				   + "		POSTAL_CODE = ?, "
				   + "		ADDRESS = ?, "
				   + "		ADDRESS_DETAIL = ?, "
				   + "		TEL = ?, "
				   + "		USER_NO = ?, "
				   + "		BASIC = ?, "
				   + "		NICKNAME = ? "
				   + "WHERE ADDRESS_NO = ? ";
		
		helper.update(sql, address.getName(), address.getZip(), address.getCity(), address.getStreet(), address.getTel(), address.getUser().getNo(), address.getBasic(), address.getNickName(), address.getNo());
	}
	
	/**
	 * 주소번호를 전달받아서 주소를 반환한다.
	 * @param addressNo
	 * @return
	 * @throws SQLException
	 */
	public Address getAddress(int addressNo) throws SQLException {
		String sql = "SELECT ADDRESS_NO, ADDRESS_NAME, POSTAL_CODE, ADDRESS, ADDRESS_DETAIL, TEL, ADDRESS_CREATED_DATE, USER_NO, NICKNAME, BASIC "
					+ "FROM SEMI_USER_ADDRESS "
					+ "WHERE ADDRESS_NO = ? ";
		return helper.selectOne(sql, rs -> {
			
			Address address = new Address();
			address.setNo(rs.getInt("ADDRESS_NO"));
			address.setName(rs.getString("ADDRESS_NAME"));
			address.setZip(rs.getInt("POSTAL_CODE"));
			address.setCity(rs.getString("ADDRESS"));
			address.setStreet(rs.getString("ADDRESS_DETAIL"));
			address.setTel(rs.getString("TEL"));
			address.setCreatedDate(rs.getDate("ADDRESS_CREATED_DATE"));
			
			User user = new User();
			user.setNo(rs.getInt("USER_NO"));
			address.setUser(user);
			
			address.setNickName(rs.getString("NICKNAME"));
			address.setBasic(rs.getString("BASIC"));
			return address;
		
		}, addressNo);
				
	}
	
	/**
	 * 사용자 번호로 주소정보 반환
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	public Address getAddressByUserNo(int userNo) throws SQLException {
		String sql = "SELECT ADDRESS_NO, ADDRESS_NAME, POSTAL_CODE, ADDRESS, ADDRESS_DETAIL, TEL, ADDRESS_CREATED_DATE, USER_NO, NICKNAME, BASIC "
				+ "FROM SEMI_USER_ADDRESS "
				+ "WHERE USER_NO = ? ";
		return helper.selectOne(sql, rs -> {
			
			Address address = new Address();
			address.setNo(rs.getInt("ADDRESS_NO"));
			address.setName(rs.getString("ADDRESS_NAME"));
			address.setZip(rs.getInt("POSTAL_CODE"));
			address.setCity(rs.getString("ADDRESS"));
			address.setStreet(rs.getString("ADDRESS_DETAIL"));
			address.setTel(rs.getString("TEL"));
			address.setCreatedDate(rs.getDate("ADDRESS_CREATED_DATE"));
			
			User user = new User();
			user.setNo(rs.getInt("USER_NO"));
			address.setUser(user);
			
			address.setNickName(rs.getString("NICKNAME"));
			address.setBasic(rs.getString("BASIC"));
			return address;
		
		}, userNo);
	}
	
	/**
	 * 회원번호를 전달받아서, 회원의 주소록 리스트을 반환한다.
	 * @param userNo
	 * @return 주소록 목록
	 * @throws SQLException
	 */
	public List<Address> getAllAddress(int userNo) throws SQLException {
		String sql = "SELECT A.ADDRESS_NO, A.ADDRESS_NAME, A.POSTAL_CODE, A.ADDRESS, A.ADDRESS_DETAIL, A.TEL, A.BASIC, A.NICKNAME, A.USER_NO, U.USER_NAME "
				+ "FROM SEMI_USER_ADDRESS A, SEMI_USERS U "
				+ "WHERE A.USER_NO = ? "
				+ "AND A.USER_NO = U.USER_NO ";
		return helper.selectList(sql, rs -> {
			
			Address address = new Address();
			address.setNo(rs.getInt("ADDRESS_NO"));
			address.setName(rs.getString("ADDRESS_NAME"));
			address.setZip(rs.getInt("POSTAL_CODE"));
			address.setCity(rs.getString("ADDRESS"));
			address.setStreet(rs.getString("ADDRESS_DETAIL"));
			address.setTel(rs.getString("TEL"));
			address.setBasic(rs.getString("BASIC"));
			address.setNickName(rs.getString("NICKNAME"));
			
			User user = new User();
			user.setNo(rs.getInt("USER_NO"));
			user.setName(rs.getString("USER_NAME"));
			address.setUser(user);
			
			return address;
		
		}, userNo);
				
	}
	
	/**
	 * 주소록번호를 입력받아 일치하는 주소 정보를 삭제한다.
	 * @param wishNo 주소록번호
	 * @throws SQLException
	 */
	public void deleteAddressByNo(int addressNo) throws SQLException {
		String sql = "DELETE FROM SEMI_USER_ADDRESS "
					+ "WHERE USER_NO = ? ";
		
		helper.delete(sql, addressNo);
	}
		
}
	
	

