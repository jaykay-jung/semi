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
	
	/**
	 * 
	 * @param beginIndex
	 * @param endIndex
	 * @return
	 * @throws SQLException
	 */
	public List<Review> getReviews(int beginIndex, int endIndex) throws SQLException {
		String sql = "select R.review_no, R.product_no, P.product_name, R.review_title, R.user_no, U.user_name, R.review_created_date "
					+ "from (select review_no,product_no, review_title, user_no,  review_created_date, "
					+ "		 		row_number() over (order by review_no desc) row_number "
					+ "		 from semi_reviews "
					+ "		 where review_deleted = 'N') R, semi_users U, semi_products P "
					+ "where R.row_number >= ? and R.row_number <= ? "
					+ "and R.user_no = U.user_no "
					+ "and R.product_no = P.product_no "
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
	
	
 /**
	 * 
	 * @param reviewNo
	 * @return
	 * @throws SQLException
	 */
	public Review getReviewByNo(int reviewNo) throws SQLException {
		String sql = "select R.review_no, R.product_no, P.product_name, R.review_title, R.user_no, U.user_name, "
					+ "		 R.review_content, R.review_deleted, R.review_created_date "
					+ "from semi_reviews R, semi_users U, semi_products P "
					+ "where R.review_no = ? "
					+ "and R.user_no = U.user_no "
					+ "and R.product_no = P.product_no ";
		
		return helper.selectOne(sql, rs -> {
			Review review = new Review();
			review.setNo(rs.getInt("review_no"));
			review.setTitle(rs.getString("review_title"));
			
			User user = new User();
			user.setNo(rs.getInt("user_no"));
			user.setName(rs.getString("user_name"));
			review.setUser(user);
			
			review.setContent(rs.getString("review_content"));
			review.setDeleted(rs.getString("review_deleted"));
			review.setCreatedDate(rs.getDate("review_created_date"));
			
			return review;
		}, reviewNo);
	}
  
 /**
	 * 지정된 사용자번호로 저장된 리뷰목록을 조회한다.
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	public List<Review> getAllReviewsByNo(int userNo) throws SQLException {
		String sql = "SELECT R.REVIEW_NO, R.PRODUCT_NO, P.PRODUCT_IMAGE_NAME, R.REVIEW_TITLE, R.REVIEW_CONTENT, R.REVIEW_CREATED_DATE "
				+ "FROM SEMI_REVIEWS R, SEMI_PRODUCTS P "
				+ "WHERE R.REVIEW_DELETED = 'N' "
				+ "AND P.PRODUCT_NO = R.PRODUCT_NO "
				+ "ORDER BY R.REVIEW_NO DESC ";
		
		return helper.selectList(sql, rs -> {
			
			Review review = new Review();
			review.setNo(rs.getInt("REVIEW_NO"));
			
			Product product = new Product();
			product.setNo(rs.getInt("PRODUCT_NO"));
			product.setImageName(rs.getString("PRODUCT_IMAGE_NAME"));
			
			review.setTitle(rs.getString("REVIEW_TITLE"));
			review.setContent(rs.getString("REVIEW_CONTENT"));
			review.setCreatedDate(rs.getDate("REVIEW_CREATED_DATE"));
			
			return review;
			
		}, userNo);
	}
	
}
