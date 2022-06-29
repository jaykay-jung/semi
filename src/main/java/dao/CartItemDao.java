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
     * 장바구니 아이템정보를 테이블에 저장하는 메소드
     * @param cartItem 새 장바구니 아이템
     * @throws SQLException
     */
    public void insertCartItem(CartItem cartItem) throws SQLException {
        String sql = "insert into semi_cart_items (cart_item_no, user_no, product_no) "
                   + "values (semi_cart_items_seq, ?, ?) ";
         
        helper.insert(sql, cartItem.getUser().getNo(), cartItem.getProduct().getNo());
    }

    /**
     * 사용자번호를 전달받아서 일치하는 사용자의 장바구니 아이템정보를 반환하는 메소드
     * @param userNo 사용자번호
     * @return 장바구니 아이템정보
     * @throws SQLException
     */
    public List<CartItem> getCartItemsByUserNo(int userNo) throws SQLException {
    	String sql = "select C.cart_item_no, C.cart_item_quantity, C.user_no, C.product_no, P.product_name, P.product_customer_price, P.product_sell_price, P.product_image_name, P.product_deposit_point, P.product_delivery_fee "
				   + "from semi_cart_items C, semi_products P "
				   + "where C.user_no = ?"
				   + "and C.product_no = P.product_no ";

        return helper.selectList(sql, rs -> {
        	CartItem cartItem = new CartItem();
            cartItem.setNo(rs.getInt("cart_item_no"));
            cartItem.setQuantity(rs.getInt("cart_item_quantity"));

            User user = new User();
            user.setNo(rs.getInt("user_no"));
            cartItem.setUser(user);
            
            Product product = new Product();
            product.setNo(rs.getInt("product_no"));
            product.setName(rs.getString("product_name"));
            product.setCustomerPrice(rs.getInt("product_customer_price"));
            product.setSellPrice(rs.getInt("product_sell_price"));
            product.setImageName(rs.getString("product_image_name"));
            product.setDepositPoint(rs.getInt("product_deposit_point"));
            product.setDeliveryFee(rs.getInt("product_delivery_fee"));
            cartItem.setProduct(product);
            
            return cartItem;
        }, userNo);
    }

    /**
     * 지정된 아이템번호와 일치하는 장바구니 아이템정보를 반환하는 메소드 
     * @param itemNo
     * @return
     * @throws SQLException
     */
    public CartItem getCartItemByItemNo(int itemNo) throws SQLException {
		String sql = "select * "
				   + "from semi_cart_items "
				   + "where cart_item_no = ? ";
		
		return helper.selectOne(sql, rs -> {
            CartItem cartItem = new CartItem();
            cartItem.setNo(rs.getInt("cart_item_no"));
            cartItem.setQuantity(rs.getInt("cart_item_quantity"));

            User user = new User();
            user.setNo(rs.getInt("user_no"));
            cartItem.setUser(user);
            
            Product product = new Product();
            product.setNo(rs.getInt("product_no"));
            cartItem.setProduct(product);
            
            return cartItem;
        }, itemNo);
	}
    
    /**
     * 지정된 아이템 번호와 일치하는 장바구니 아이템정보 여러개를 반환하는 메소드
     * @param itemNo
     * @return
     * @throws SQLException
     */
    public List<CartItem> getCartItemsByItemNo(int itemNo) throws SQLException {
    	String sql = "select * "
    			   + "from semi_cart_items "
    			   + "where cart_item_no = ? ";
    	
    	return helper.selectList(sql, rs -> {
            CartItem cartItem = new CartItem();
            cartItem.setNo(rs.getInt("cart_item_no"));
            cartItem.setQuantity(rs.getInt("cart_item_quantity"));

            User user = new User();
            user.setNo(rs.getInt("user_no"));
            cartItem.setUser(user);
            
            Product product = new Product();
            product.setNo(rs.getInt("product_no"));
            cartItem.setProduct(product);
            
            return cartItem;
        }, itemNo);
    }

    /**
     * 지정된 장바구니 아이템정보를 전달받아서 동일한 정보가 존재하면 수량을 증가시키고, 정보가 존재하지 않으면 추가
     * @param cartItem
     * @throws SQLException
     */
    public void mergeCartItem(CartItem cartItem) throws SQLException {
        String sql = "merge "
                   + "  into semi_cart_items C "
                   + "using dual "
                   + "  on (C.user_no = ? and C.product_no = ?) "
                   + "when matched then "
                   + "  update "
                   + "      set "
                   + "          C.cart_item_quantity = C.cart_item_quantity + 1 "
                   + "when not matched then "
                   + "  insert (cart_item_no, user_no, product_no, cart_item_quantity) "
                   + "  values (semi_cart_items_seq.nextval, ?, ?, 1) ";

        helper.insert(sql, cartItem.getUser().getNo(), cartItem.getProduct().getNo(), cartItem.getUser().getNo(), cartItem.getProduct().getNo());
    }

    /**
     * 사용자번호를 전달받아 일치하면 모든 장바구니 아이템을 삭제하는 메소드
     * @param userNo 사용자번호
     * @throws SQLException
     */
    public void deleteAllCartItemByUserNo(int userNo) throws SQLException {
        String sql = "delete from semi_cart_items "
                   + "where user_no = ? ";

        helper.delete(sql, userNo);
    }

    /**
     * 아이템번호를 전달받아 일치하는 장바구니 아이템을 삭제하는 메소드
     * @param productNo
     * @throws SQLException
     */
    public void deleteCartItem(int itemNo) throws SQLException {
		String sql = "delete from semi_cart_items "
				   + "where cart_item_no = ? ";
		
		helper.delete(sql, itemNo);
	} 

    /**
     * 상품수량, 상품번호를 전달받아 일치하는 장바구니 아이템의 수량을 변경하는 메소드
     * @param quantity 상품수량
     * @param productNo 상품번호
     * @throws SQLException
     */
    public void updateCartItemQuantity(int quantity, int itemNo) throws SQLException{
    	String sql = "update semi_cart_items "
    			   + "set cart_item_quantity = ? "
    			   + "where cart_item_no = ? ";
    	
    	helper.update(sql, quantity, itemNo);
    }

	/**
	 * 사용자번호를 전달받아 저장된 장바구니 상품들을 조회한다.
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	public List<CartItem> getAllCartItemByUserNo(int userNo) throws SQLException {
		String sql = "SELECT C.CART_ITEM_NO, C.CART_ITEM_QUANTITY , C.USER_NO, U.USER_NAME, C.PRODUCT_NO, P.PRODUCT_IMAGE_NAME, P.PRODUCT_NAME, P.PRODUCT_SELL_PRICE, P.PRODUCT_DEPOSIT_POINT, P.PRODUCT_DELIVERY_FEE "
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
