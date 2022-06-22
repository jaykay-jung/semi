package dao;


import java.sql.SQLException;

import java.util.List;

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
	

	
	// 상품 관리자 페이지에서 상품 정보 등록 (완료)
	public void insertProduct(Product product) throws SQLException { 
		String sql = "insert into semi_products "
				   + "(product_no, product_name, product_image_name, product_description, product_customer_price, product_sell_price, product_deposit_point, product_delivery_fee, product_stock, product_on_sell, category_no, product_deleted)"
				   + "values "
				   + "(semi_products_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		helper.insert(sql, product.getName(), product.getImageName(), product.getDescription(), product.getCustomerPrice(), product.getSellPrice(), product.getDepositPoint(), product.getDeliveryFee(), product.getStock(), product.getOnSell(), product.getCategoryNo(), product.getDeleted());
	}
	
	// 상품 관리자 페이지에서 상품 수정 (미구현)
	
	// 상품 관리자 페이지에서 상품 비활성화 (미구현)
	
	
	// 상품 번호로 등록된 모든 상품 정보 조회하여 product에 담기  (이미지 4개에 대한 처리 고민))
	public Product getAllProductByNo(int product_no) throws SQLException {
	String sql = "select p.product_no, p.product_name, p.product_image_name, p.product_description, p.product_customer_price, p.product_sell_price, p.product_deposit_point, p.product_delivery_fee, p.product_stock, p.product_on_sell, p.product_deleted, p.product_created_date, p.product_updated_date, c.category_no, c.category_name "      
			   + "from semi_products p, semi_product_category c  "	
			   + "where p.product_no = ? "
			   + "and p.category_no = c.category_no "
			   + "and p.product_deleted = 'N' ";	
	
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
		product.setDeleted(rs.getString("product_deleted"));
		product.setCreatedDate(rs.getDate("product_created_date"));
		product.setUpdatedDate(rs.getDate("product_updated_date"));
		
		Category category = new Category();
		category.setNo(rs.getInt("category_no")); //product.setCategoryNo(rs.getInt("category_no")); ->p.category_no
		category.setName(rs.getString("category_name"));
		product.setCategory(category);
		
			
		return product;
	}, product_no);
}
	
	
	// 등록된 상품 정보 목록의 수를 카운트 (완료)
	public int getTotalRows() throws SQLException { 
		String sql = "select count(*) cnt "
				   + "from semi_products "
				   + "where product_deleted = 'N' ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		});
	}
		
	
	//카테고리별 상품 목록 조회 출력 (해당 인덱스에 해당하는 상품들 출력, 카테고리 명칭 포함) 
	public List<Product> getProductByIndex(int beginIndex, int endIndex) throws SQLException {
		String sql = "select p.product_no, p.category_no, C.category_name, p.product_name, p.product_customer_price, p.product_sell_price, p.product_description "
				   + "from (select product_no, category_no, product_name, product_customer_price, product_sell_price, product_description, "
				   + "             row_number() over (order by product_no desc) row_number "
				   + "      from semi_products "
				   + "      where product_deleted = 'N') p, semi_product_category c "
				   + "where p.row_number >= ? and p.row_number <= ? "
				   + "and p.category_no = c.category_no "
				   + "order by p.product_no desc ";
		
		return helper.selectList(sql, rs -> {
			Product product = new Product();
			product.setNo(rs.getInt("product_no"));
			product.setCategoryNo(rs.getInt("category_no"));
			
			Category category = new Category();
			category.setName(rs.getString("category_name"));
			product.setCategory(category);
			
			product.setName(rs.getString("product_name"));
			product.setCustomerPrice(rs.getInt("product_customer_price"));
			product.setSellPrice(rs.getInt("product_sell_price"));
			product.setDescription(rs.getString("product_description"));
			
			return product;
		}, beginIndex, endIndex);
	}
	
	
	
	
	
	
	// 등록된 상품 정보를 특정 키워드로 검색시 출력되는 목록의 수를 카운트 (완료)
	public int getTotalRows(String keyword) throws SQLException { 
		String sql = "select count(*) cnt "
				+ "from semi_products "
				+ "where product_deleted = 'N' and product_name like '%' || ? || '%' ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, keyword);
	}

	
	//특정 키워드(상품 이름)에 따른 카테고리별 상품 목록 조회 출력 (해당 인덱스에 해당하는 상품들 출력, 카테고리 명칭 포함) 
	public List<Product> getProductByIndexNKeyword(int beginIndex, int endIndex, String keyword) throws SQLException {
		String sql = "select p.product_no, p.category_no, C.category_name, p.product_name, p.product_customer_price, p.product_sell_price, p.product_description "
				   + "from (select product_no, category_no, product_name, product_customer_price, product_sell_price, product_description, "
				   + "             row_number() over (order by product_no desc) row_number "
				   + "      from semi_products "
				   + "      where product_deleted = 'N' and product_title like '%' || ? || '%') p, semi_product_category c "
				   + "where p.row_number >= ? and p.row_number <= ? "
				   + "and p.category_no = c.category_no "
				   + "order by p.product_no desc ";
		
		return helper.selectList(sql, rs -> {
			Product product = new Product();
			product.setNo(rs.getInt("product_no"));
			product.setCategoryNo(rs.getInt("category_no"));
			
			Category category = new Category();
			category.setName(rs.getString("category_name"));
			product.setCategory(category);
			
			product.setName(rs.getString("product_name"));
			product.setCustomerPrice(rs.getInt("product_customer_price"));
			product.setSellPrice(rs.getInt("product_sell_price"));
			product.setDescription(rs.getString("product_description"));
			
			return product;
		}, keyword, beginIndex, endIndex);
	}

	
	
	
	
	
	
	
	
//	// 제품 상세 정보 표시용 List (페이징 처리 불필요, 상품 번호로 등록된 모든 상품 정보 조회하여 product에 담은 것들중 제품 상세 정보에 필요한 항목만을 담아서 products 리스트에 담은 것) (이미지 처리에 대한 고민, p.product_deposit_point 넣지 않음)
//	public List<Product> getAllProducts() throws SQLException {
//		String sql = "select p.product_no, p.product_name, p.product_image_name, p.product_customer_price, p.product_sell_price, p.product_delivery_fee "      
//				   + "from semi_products p"
//				   + "where product_deleted ='N' "
//				   + "order by p.product_no desc ";
//		
//		return helper.selectList(sql, rs -> {
//			Product product = new Product();
//			product.setNo(rs.getInt("product_no"));
//			product.setName(rs.getString("product_name"));
//			product.setImageName(rs.getString("product_image_name"));
//			product.setCustomerPrice(rs.getInt("product_customer_price"));
//			product.setSellPrice(rs.getInt("product_sell_price"));
//			product.setDeliveryFee(rs.getInt("product_delivery_fee"));
//			
////			Category category = new Category();
////			category.setNo(rs.getInt("category_no"));
////			category.setName(rs.getString("category_name"));
////			product.setCategory(category);
//			
//			return product;
//			
//			
//		});
//	}
}	
	

