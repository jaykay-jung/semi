package dao;

import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.WishList;
import vo.Product;
import vo.User;

public class WishListDao {

	private static WishListDao instance = new WishListDao();
	private WishListDao() {}
	public static WishListDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	
	/**
	 * 위시리스트에 등록한다.
	 * @param wishList 위시리스트 상품정보
	 * @throws SQLException
	 */
	public void insertWishList(WishList wishList) throws SQLException {
		String sql = "INSERT INTO SEMI_WISH_PRODUCTS "
					+ "(WISH_ITEM_NO, USER_NO, PRODUCT_NO) "
					+ "values "
					+ "(SEMI_WISH_PRODUCTS_seq.nextval, ?, ?) ";
		
		helper.insert(sql, wishList.getUser().getName(), wishList.getProduct().getNo());
	}
	

	/**
	 * 지정된 위시리스트 번호와 일치하는 위시리스트 정보를 반환한다.
	 * @param wishNo
	 * @return 위시리스트 상품
	 * @throws SQLException
	 */
	public WishList getWishListByWishListNo(int wishNo) throws SQLException {
		String sql = "select WISH_ITEM_NO, USER_NO, PRODUCT_NO, WISH_ITEM_CREATED_DATE "
				   + "from SEMI_WISH_PRODUCTS "
				   + "where WISH_ITEM_NO = ? ";
		
		
		return helper.selectOne(sql, rs -> {
			
			WishList wishList = new WishList();
			wishList.setNo(rs.getInt("WISH_ITEM_NO"));
			
			User user = new User();
			user.setNo(rs.getInt("USER_NO"));
			wishList.setUser(user);
			
			Product product = new Product();
			product.setNo(rs.getInt("PRODUCT_NO"));
			wishList.setProduct(product);
			
			wishList.setCreatedDate(rs.getDate("WISH_ITEM_CREATED_DATE"));
			return wishList;
			
		}, wishNo);
				
	}
	
	
	/**
	 * 지정된 사용자번호로 저장된 위시리스트 상품을 조회한다.
	 * @param userNo 사용자번호
	 * @return 위시리스트 목록
	 * @throws SQLException
	 */
	public List<WishList> getAllWishList(int userNo) throws SQLException {
		String sql = "select W.WISH_ITEM_NO, U.USER_NO, P.PRODUCT_IMAGE_NAME, P.PRODUCT_NAME, P.PRODUCT_SELL_PRICE, P.PRODUCT_DEPOSIT_POINT, P.PRODUCT_DELIVERY_FEE "
					+ "	FROM SEMI_USERS U, SEMI_WISH_PRODUCTS W, SEMI_PRODUCTS "
					+ "	WHERE U.USER_NO = ? "
					+ "	AND U.USER_NO = W.USER_NO "
					+ "	AND P.PRODUCT_NO = W.PRODUCT_NO "
					+ "	ORDER BY W.WISH_ITEM_NO DESC ";

		return helper.selectList(sql, rs -> {
		
			WishList wishList = new WishList();
			wishList.setNo(rs.getInt("WISH_ITEM_NO"));
			
			User user = new User();
			user.setNo(rs.getInt("USER_NO"));
			wishList.setUser(user);
			
			Product product = new Product();
			product.setNo(rs.getInt("PRODUCT_NO"));
			product.setImageName(rs.getString("PRODUCT_IMAGE_NAME"));
			product.setName(rs.getString("PRODUCT_NAME"));
			product.setSellPrice(rs.getInt("PRODUCT_SELL_PRICE"));
			product.setDepositPoint(rs.getInt("PRODUCT_DEPOSIT_POINT"));
			product.setDeliveryFee(rs.getInt("PRODUCT_DELIVERY_FEE"));	
			wishList.setProduct(product);
			
			return wishList;			
		}, userNo);
	}
	
	/**
	 * 입력한 위시리스트 번호와 일치하는 위시리스트 아이템 정보를 삭제한다.
	 * @param wishNo
	 * @throws SQLException
	 */
	public void deleteWishItem(int wishNo) throws SQLException {
		String sql = "DELETE FROM SEMI_WISH_PRODUCTS "
					+ "WHERE WISH_ITEM_NO = ? ";
		
		helper.delete(sql, wishNo);
	}

	
}
