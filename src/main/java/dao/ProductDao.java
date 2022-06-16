package dao;

import java.sql.SQLException;

import helper.DaoHelper;
import vo.Category;

import vo.Product;

public class ProductDao {

	private static ProductDao instance = new ProductDao();
	private ProductDao() {}
	public static ProductDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	

	
	// 상품 정보 등록
	public void insertProduct(Product product) throws SQLException { 
		String sql = "insert into semi_products "
				   + "(product_no, product_name, product_image_name, product_description, product_customer_price, product_sell_price, product_deposit_point, product_delivery_fee, product_stock, product_on_sell, category_no, product_deleted)"
				   + "values "
				   + "(semi_products_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		helper.insert(sql, product.getName(), product.getImageName(), product.getDescription(), product.getCustomerPrice(), product.getSellPrice(), product.getDepositPoint(), product.getDeliveryFee(), product.getStock(), product.getOnSell(), product.getCategoryNo(), product.getDeleted());
	}
	
	
	// 등록된 모든 상품 정보 조회 (카테고리 명칭도 포함)
	public Product getAllProduct() throws SQLException {
	String sql = "select p.product_no, p.product_name, p.product_image_name, p.product_description, p.product_customer_price, p.product_sell_price, p.product_deposit_point, p.product_delivery_fee, p.product_stock, p.product_on_sell, p.category_no, c.cateogry_name, p.product_deleted, p.product_created_date, p.product_updated_date "      
			   + "from semi_products p, semi_product_category c "
			   + "where p.cateogry_no = c.category_no "
			   + "and p.product_deleted = 'n' ";
	
	return helper.selectOne(sql, rs -> {
		Product product = new Product();
		product.setNo(rs.getInt("product_no"));
		product.setName(rs.getString("product_name"));
		product.setImageName(rs.getString("product_image_name"));
		product.setDescription(rs.getString("product_description"));
		product.setCustomerPrice(rs.getInt("product_customer_price"));
		product.setSellPrice(rs.getInt("product_sell_price"));
		product.setDepositPoint(rs.getInt("product_deposit_point"));
		product.setDeliveryFee(rs.getInt("product_delivery_fee"));
		product.setStock(rs.getInt("product_stock"));
		product.setOnSell(rs.getString("product_on_sell"));
		product.setCategoryNo(rs.getInt("category_no"));
		
		Category category = new Category();
		category.setName(rs.getString("category_name"));
		//category.setNo(rs.getInt("category_no"));
		//Product.setCategory(category);
		
		product.setDeleted(rs.getString("product_deleted"));
		product.setCreatedDate(rs.getDate("product_created_date"));
		product.setUpdatedDate(rs.getDate("product_updated_date"));
		
		return product;
	});
}
	
	
	// 등록된 상품 정보 목록의 수를 카운트
	public int getTotalRows() throws SQLException { 
		String sql = "select count(*) cnt "
				   + "from semi_products "
				   + "where product_deleted = 'N' ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		});
	}
	
	
	// 등록된 상품 정보를 특정 키워드로 검색시 출력하는 목록의 수를 카운트
	public int getTotalRows(String keyword) throws SQLException { 
		String sql = "select count(*) cnt "
				+ "from semi_products "
				+ "where product_deleted = 'N' and product_name like '%' || ? || '%' ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, keyword);
	}
	
	
}	
	

