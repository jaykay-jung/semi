package dao;

import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.Product;
import vo.Review;
import vo.User;

public class ReviewDao {

	private static ReviewDao instance = new ReviewDao();
	private ReviewDao () {}
	public static ReviewDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	/**
	 * 리뷰 등록
	 * @param review
	 * @throws SQLException
	 */
	public void insertReview(Review review) throws SQLException {
		String sql = "insert into semi_reviews "
					+ "(review_no, user_no, product_no, review_title, review_content) "
					+ "values "
					+ "(semi_reviews_seq.nextval, ?, ?, ?, ?) ";
		
		helper.insert(sql, review.getUser().getName(), review.getProduct().getName(), review.getTitle(), review.getContent());
	}
	
	/**
	 * 전체 리뷰 갯수 
	 * @return
	 * @throws SQLException
	 */
	public int getTotalRows() throws SQLException {
		String sql = "select count(*) cnt "
					+ "from semi_reviews "
					+ "where review_deleted = 'N' ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		});
	}
	
	public int getTotalRows(String keyword) throws SQLException {
		String sql = "select count(*) cnt "
					+ "from semi_reviews "
					+ "where review_deleted = 'N' and review_title like '%' || ? || '%' ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, keyword);
	}
	
	
	public List<Review> getReviews(int beginIndex, int endIndex) throws SQLException {
		String sql = "select R.review_no, R.product_no, P.product_name, R.review_title, R.user_no, U.user_name, R.review_created_date "
					+ "from (select review_no,product_no, review_title, user_no,  review_created_date, "
					+ "		 		row_number() over (order by review_no desc) row_number "
					+ "		 from semi_reviews "
					+ "		 where review_deleted = 'N') R, semi_users U, semi_products P "
					+ "where R.row_number >= ? and R.row_number <= ? "
					+ "and R.user_no = U.user_no "
					+ "and R.product_no = P.category_no "
					+ "order by R.review_no desc ";
		
		return helper.selectList(sql, rs -> {
			Review review = new Review();
			review.setNo(rs.getInt("review_no"));
			
			Product product = new Product();
			product.setNo(rs.getInt("product_no"));
			product.setName(rs.getString("product_name"));
			review.setProduct(product);
			
			review.setTitle(rs.getString("review_title"));
			
			User user = new User();
			user.setNo(rs.getInt("user_no"));
			user.setName(rs.getString("user_name"));
			review.setUser(user);
			
			review.setCreatedDate(rs.getDate("review_created_date"));
			
			return review;
			
		}, beginIndex, endIndex);
	}
	
	public List<Review> getReviews(int beginIndex, int endIndex, String keyword) throws SQLException {
		String sql = "select R.review_no, R.product_no, P.product_name, R.review_title, R.user_no, U.user_name, R.review_created_date "
					+ "from (select review_no,product_no, review_title, user_no,  review_created_date, "
					+ "		 		row_number() over (order by review_no desc) row_number "
					+ "		 from semi_reviews "
					+ "		 where review_deleted = 'N' and review_title like '%' || ? || '%') R, semi_users U, semi_products P "
					+ "where R.row_number >= ? and R.row_number <= ? "
					+ "and R.user_no = U.user_no "
					+ "and R.product_no = P.category_no "
					+ "order by R.review_no desc ";
		
		return helper.selectList(sql, rs -> {
			Review review = new Review();
			review.setNo(rs.getInt("review_no"));
			
			Product product = new Product();
			product.setNo(rs.getInt("product_no"));
			product.setName(rs.getString("product_name"));
			review.setProduct(product);
			
			review.setTitle(rs.getString("review_title"));
			
			User user = new User();
			user.setNo(rs.getInt("user_no"));
			user.setName(rs.getString("user_name"));
			review.setUser(user);
			
			review.setCreatedDate(rs.getDate("review_created_date"));
			
			return review;
			
		},keyword, beginIndex, endIndex);
	}
	
	
}
