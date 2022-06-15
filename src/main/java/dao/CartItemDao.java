package dao;

import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.CartItem;
import vo.Product;

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
        String sql = "select c.cart_item_no, p.product_no, p.product_name, p.sell_price, p.deposit_point, p.delivery_fee, p.cart_item_quantity "
                   + "(p.sell_price * c.cart_item_quantity) + p.delivery_fee as order_price "
                   + "from semi_cart_items c, semi_products p "
                   + "where c.product_no = p.product_no "
                   + "and c.user_no = ? "
                   + "order by c.cart_item_no desc ";

        return helper.selectList(sql, rs -> {
            CartItem cartItem = new CartItem();
            cartItem.setNo(rs.getInt("cart_item_no"));
            cartItem.setCartItemQuantity(rs.getInt("cart_item_quantity"));

            Product product = new Product();
            product.setNo(rs.getInt("product_no"));
            product.setName(rs.getString("product_name"));
            product.setSellPrice(rs.getInt("sell_price"));
            product.setDepositPoint(rs.getInt("deposit_point"));
            product.setDeliveryFee(rs.getInt("delivery_fee"));
            cartItem.setProduct(product);

            cartItem.setOrderPrice(rs.getInt("order_price"));
            
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
				   + "from store_cart_items "
				   + "where cart_item_no = ? ";
		
		return helper.selectOne(sql, rs -> {
            CartItem cartItem = new CartItem();
            cartItem.setNo(rs.getInt("cart_item_no"));
            cartItem.setCartItemQuantity(rs.getInt("cart_item_quantity"));

            Product product = new Product();
            product.setNo(rs.getInt("product_no"));
            product.setName(rs.getString("product_name"));
            product.setSellPrice(rs.getInt("sell_price"));
            product.setDepositPoint(rs.getInt("deposit_point"));
            product.setDeliveryFee(rs.getInt("delivery_fee"));
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
                   + "  into store_cart_items C "
                   + "using dual "
                   + "  on (C.user_no = ? and C.product_no = ?) "
                   + "when matched then "
                   + "  update "
                   + "      set "
                   + "          C.cart_item_quantity = C.cart_item_quantity + 1 "
                   + "when not matched then "
                   + "  insert (cart_item_no, user_no, product_no, cart_item_quantity) "
                   + "  values (semi_cart_items_seq.nextval, ?, ?, 1) ";

        helper.insert(sql, cartItem.getUser().getNo(), cartItem.getProduct().getNo());
    }

    /**
     * 사용자번호를 전달받아 일치하면 모든 장바구니 아이템을 삭제하는 메소드
     * @param userNo 사용자번호
     * @throws SQLException
     */
    public void deleteCartItemByUserNo(int userNo) throws SQLException {
        String sql = "delete from store_cart_items "
                   + "where user_no = ? ";

        helper.delete(sql, userNo);
    }

    /**
     * 아이템번호를 전달받아 일치하는 장바구니 아이템을 삭제하는 메소드
     * @param itemNo
     * @throws SQLException
     */
    public void deleteCartItem(int itemNo) throws SQLException {
		String sql = "delete from store_cart_items "
				   + "where cart_item_no = ? ";
		
		helper.delete(sql, itemNo);
	} 


}
