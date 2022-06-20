package dao;

import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.Product;
import vo.Review;

public class MyBoardDao {

	private static MyBoardDao instance = new MyBoardDao();
	private MyBoardDao () {}
	public static MyBoardDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	/**
	 * 특정 유저가 작성한 전체 리뷰 갯수
	 * @param userNo
	 * @return 
	 * @throws SQLException
	 */
	public int getTotalRowsByNo(int userNo) throws SQLException {
		String sql = "SELECT COUNT(*) "
				+ "FROM SEMI_REVIEWS "
				+ "WHERE USER_NO = ? "
				+ "AND REVIEW_DELETED = 'N' ";
		
		return helper.selectOne(sql, rs-> {			
			return rs.getInt("cnt");
			
		}, userNo);
	}
	
	/**
	 * 특정유저가 작성한 전체 리뷰 갯수 (키워드)
	 * @param keyword
	 * @return
	 * @throws SQLException
	 */
	public int getTotalRowsByKeyNByNo(String keyword, int userNo) throws SQLException {
		String sql = "SELECT COUNT(*) "
				+ "FROM SEMI_REVIEWS "
				+ "WHERE USER_NO = ? "
				+ "AND REVIEW_DELETED = 'N' "
				+ "AND REVIEW_TITLE LIKE '%' || ? || '%' ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, keyword, userNo);
	}
	

	/**
	 * 유저번호로 리뷰 페이징
	 * @param beginIndex
	 * @param endIndex
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	public List<Review> getReviewsByNo(int beginIndex, int endIndex, int userNo) throws SQLException {
		String sql = "SELECT R.REVIEW_NO, R.PRODUCT_NO, P.PRODUCT_IMAGE_NAME, P.PRODUCT_NAME, R.REVIEW_TITLE, R.REVIEW_CREATED_DATE "
				+ "FROM(SELECT REVIEW_NO, PRODUCT_NO, REVIEW_TITLE, USER_NO, REVIEW_CREATED_DATE, ROW_NUMBER() OVER (ORDER BY REVIEW_NO DESC) ROW_NUMBER "
				+ "FROM SEMI_REVIEWS WHERE REVIEW_DELETED = 'N') R, SEMI_PRODUCTS P "
				+ "WHERE R.ROW_NUMBER >= ? AND R.ROW_NUMBER <= ? "
				+ "AND R.USER_NO = ? "
				+ "AND R.PRODUCT_NO = P.PRODUCT_NO "
				+ "ORDER BY R.REVIEW_NO DESC ";
		
		return helper.selectList(sql, rs -> {
			Review review = new Review();
			review.setNo(rs.getInt("REVIEW_NO"));
			
			Product product = new Product();
			product.setNo(rs.getInt("PRODUCT_NO"));
			product.setImageName(rs.getString("PRODUCT_IMAGE_NAME"));
			product.setName(rs.getString("PRODUCT_NAME"));
			review.setProduct(product);
			
			review.setTitle(rs.getString("REVIEW_TITLE"));
			review.setCreatedDate(rs.getDate("REVIEW_CREATED_DATE"));
			
			return review;
			
		}, beginIndex, endIndex, userNo);
	}
	

	/**
	 * 유저번호와 키워드로 리뷰 페이징
	 * @param beginIndex
	 * @param endIndex
	 * @param userNo
	 * @param keyword
	 * @return
	 * @throws SQLException
	 */
	public List<Review> getReviewsByKeyNByNo(int beginIndex, int endIndex, int userNo, String keyword) throws SQLException {
		String sql = "SELECT R.REVIEW_NO, R.PRODUCT_NO, P.PRODUCT_IMAGE_NAME, P.PRODUCT_NAME, R.REVIEW_TITLE, R.REVIEW_CREATED_DATE "
				+ "FROM(SELECT REVIEW_NO, PRODUCT_NO, REVIEW_TITLE, USER_NO, REVIEW_CREATED_DATE, ROW_NUMBER() OVER (ORDER BY REVIEW_NO DESC) ROW_NUMBER "
				+ "FROM SEMI_REVIEWS WHERE REVIEW_DELETED = 'N' AND REVIEW_TITLE LIKE '%' || ? || '%') R, SEMI_PRODUCTS P "
				+ "WHERE R.ROW_NUMBER >= ? AND R.ROW_NUMBER <= ? "
				+ "AND R.USER_NO = ? "
				+ "AND R.PRODUCT_NO = P.PRODUCT_NO "
				+ "ORDER BY R.REVIEW_NO DESC ";
		
		return helper.selectList(sql, rs -> {
			Review review = new Review();
			review.setNo(rs.getInt("REVIEW_NO"));
			
			Product product = new Product();
			product.setNo(rs.getInt("PRODUCT_NO"));
			product.setImageName(rs.getString("PRODUCT_IMAGE_NAME"));
			product.setName(rs.getString("PRODUCT_NAME"));
			review.setProduct(product);
			
			review.setTitle(rs.getString("REVIEW_TITLE"));
			review.setCreatedDate(rs.getDate("REVIEW_CREATED_DATE"));
			
			return review;
			
		}, beginIndex, endIndex, userNo, keyword);
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

