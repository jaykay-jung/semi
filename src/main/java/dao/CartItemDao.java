package dao;


import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.CartItem;
import vo.Product;
import vo.User;

public class CartItemDao {
	
	private static CartItemDao instance = new CartItemDao();
	private CartItemDao() {}
	public static CartItemDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	/**
	 * 장바구니아이템 객체를 전달받아서, 동일한 아이템이 장바구니에 존재하면 수량을 증가시키고, 정보가 존재하지 않으면 추가한다.
	 * @param cartItem 전달받은 장바구니아이템 정보
	 * @throws SQLException
	 */
	public void mergeCartItem(CartItem cartItem) throws SQLException {
		String sql = "MERGE INTO SEMI_CART_ITEMS "
				+ "USING DUAL "
				+ "ON USER_NO = ? AND PRODUCT_NO =? "
				+ "WHEN MATCHED THEN "
				+ "UPDATE "
				+ "SET "
				+ "CART_ITEM_QUANTITY = CART_ITEM_QUANTITY + 1 "
				+ "WHEN NOT MATCHED THEN "
				+ "INSERT (CART_ITEM_NO, USER_NO, PRODUCT_NO, CART_ITEM_QUANTITY) "
				+ "VALUES (SEMI_CART_ITEMS_SEQ.nextval, ?, ?, 1) ";
		
		helper.update(sql, cartItem.getUser().getNo(), cartItem.getProduct().getNo());
		helper.insert(sql, cartItem.getUser().getNo(), cartItem.getProduct().getNo());

	}
	


	/**
	 * 전달받은 장바구니 아이템 번호와 일치하는 상품 정보를 삭제한다.
	 * @param wishNo
	 * @throws SQLException
	 */
	public void deleteWishItem(int no) throws SQLException {
		String sql = "DELETE FROM SEMI_CART_ITEMS "
					+ "WHERE CART_ITEM_NO = ? ";
		
		helper.delete(sql, no);
	}

	/**
	 * 사용자번호를 전달받아 저장된 장바구니 상품들을 조회한다.
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	public List<CartItem> getAllCartItemByUserNo(int userNo) throws SQLException {
		String sql = "SELECT C.CART_ITEM_NO, C.CART_ITEM_QUANTITY, C.USER_NO, U.USER_NAME, C.PRODUCT_NO, P.PRODUCT_IMAGE_NAME, P.PRODUCT_NAME, P.PRODUCT_SELL_PRICE, P.PRODUCT_DEPOSIT_POINT, P.PRODUCT_DELIVERY_FEE "
				+ "FROM SEMI_CART_ITEMS C, SEMI_USERS U, SEMI_PRODUCTS P "
				+ "WHERE C.USER_NO = ? "
				+ "AND C.USER_NO = U.USER_NO "
				+ "AND C.PRODUCT_NO = P.PRODUCT_NO "
				+ "ORDER BY C.CART_ITEM_CREATED_DATE DESC ";

		return helper.selectList(sql, rs -> {
			
			CartItem cartItem = new CartItem();
			cartItem.setNo(rs.getInt("CART_ITEM.NO"));
			cartItem.setQuantity(rs.getInt("CART_ITEM_QUANTITY"));
			
			User user = new User();
			user.setNo(rs.getInt("USER_NO"));
			user.setName(rs.getString("USER_NAME"));
			cartItem.setUser(user);
			
			Product product = new Product();
			product.setNo(rs.getInt("PRODUCT_NO"));
			product.setImageName(rs.getString("PRODUCT_IMAGE_NAME"));
			product.setName(rs.getString("PRODUCT_NAME"));
			product.setSellPrice(rs.getInt("PRODUCT_SELL_PRICE"));
			product.setDepositPoint(rs.getInt("PRODUCT_DEPOSIT_POINT"));
			product.setDeliveryFee(rs.getInt("PRODUCT_DELIVERY_FEE"));	
			cartItem.setProduct(product);
						
			return cartItem;
			
		}, userNo);
	
	}
}
