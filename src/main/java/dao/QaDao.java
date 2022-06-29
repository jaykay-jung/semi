package dao;

import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.Product;
import vo.Qa;
import vo.User;

public class QaDao {


	private static QaDao instance = new QaDao();
	private QaDao () {}
	public static QaDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	// QA 등록 
	public void insertQa(Qa qa) throws SQLException {
		String sql = "insert into semi_qas"
					+ "(qa_NO, user_no, product_no, qa_title, qa_content) "
					+ "values "
					+ "(semi_qas_seq.nextval, ?, ?, ?, ?) ";
		
		helper.insert(sql, qa.getUser().getName(), qa.getProduct().getName(), qa.getTitle(), qa.getContent());
	}
	
	
	// 전체 QA 개수
	public int getTotalRows() throws SQLException {
		String sql = "select count(*) cnt "
					+ "from semi_qas "
					+ "where qa_deleted = 'N' ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		});
	}
	
	// 키워드 검색 결과에 의한 전체 QA 개수
	public int getTotalRows(String keyword) throws SQLException {
		String sql = "select count(*) cnt "
					+ "from semi_qas "
					+ "where qa_deleted = 'N' and qa_title like '%' || ? || '%' ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, keyword);
	}
	
	// 상품번호에 의한 전체 QA 개수
		public int getTotalRows(int productNo) throws SQLException {
			String sql = "select count(*) cnt "
						+ "from semi_qas "
						+ "where qa_deleted = 'N' "
						+ "and product_no = ? ";
			
			return helper.selectOne(sql, rs -> {
				return rs.getInt("cnt");
			}, productNo);
		}
	
	//qa 리스트 페이징 처리
	public List<Qa> getQas(int beginIndex, int endIndex) throws SQLException {
		String sql = "select q.qa_no, q.product_no, p.product_name, p.product_image_name, q.qa_title, q.user_no, u.user_name, q.qa_created_date "
					+ "from (select qa_no, product_no, qa_title, user_no, qa_created_date, "
					+ "		 		row_number() over (order by qa_no desc) row_number "
					+ "		 from semi_qas "
					+ "		 where qa_deleted = 'N') q, semi_users u, semi_products p "
					+ "where q.row_number >= ? and q.row_number <= ? "
					+ "and q.user_no = u.user_no "
					+ "and q.product_no = p.product_no "
					+ "order by q.qa_no desc ";
		
		return helper.selectList(sql, rs -> {
			Qa qa = new Qa();
			qa.setNo(rs.getInt("qa_no"));
			
			Product product = new Product();
			product.setNo(rs.getInt("product_no"));
			product.setName(rs.getString("product_name"));
			product.setImageName(rs.getString("product_image_name"));
			qa.setProduct(product);
			
			qa.setTitle(rs.getString("qa_title"));
			
			User user = new User();
			user.setNo(rs.getInt("user_no"));
			user.setName(rs.getString("user_name"));
			qa.setUser(user);
			
			qa.setCreatedDate(rs.getDate("qa_created_date"));
			
			return qa;
			
		}, beginIndex, endIndex);
	}
	
	//키워드로 조회한 qa리스트 페이징 처리 
	public List<Qa> getQas(int beginIndex, int endIndex, String keyword) throws SQLException {
		String sql = "select q.qa_no, q.product_no, p.product_name, p.product_image_name, q.qa_title, q.user_no, u.user_name, q.qa_created_date "
					+ "from (select qa_no,product_no, qa_title, user_no, qa_created_date, "
					+ "		 		row_number() over (order by qa_no desc) row_number "
					+ "		 from semi_qas "
					+ "		 where qa_deleted = 'N' and qa_title like '%' || ? || '%') q, semi_users u, semi_products p "
					+ "where q.row_number >= ? and q.row_number <= ? "
					+ "and q.user_no = u.user_no "
					+ "and q.product_no = p.product_no "
					+ "order by q.qa_no desc ";
		
		return helper.selectList(sql, rs -> {
			Qa qa = new Qa();
			qa.setNo(rs.getInt("qa_no"));
			
			Product product = new Product();
			product.setNo(rs.getInt("product_no"));
			product.setName(rs.getString("product_name"));
			product.setImageName(rs.getString("product_image_name"));
			qa.setProduct(product);
			
			qa.setTitle(rs.getString("qa_title"));
			
			User user = new User();
			user.setNo(rs.getInt("user_no"));
			user.setName(rs.getString("user_name"));
			qa.setUser(user);
			
			qa.setCreatedDate(rs.getDate("qa_created_date"));
			
			return qa;
			
		},keyword, beginIndex, endIndex);
	}
	
	
	//상품번호로 조회한 qa리스트 페이징 처리 
		public List<Qa> getQas(int beginIndex, int endIndex, int productNo) throws SQLException {
			String sql = "select q.qa_no, q.product_no, p.product_name, p.product_image_name, q.qa_title, q.user_no, u.user_name, q.qa_created_date "
						+ "from (select qa_no,product_no, qa_title, user_no, qa_created_date, "
						+ "		 		row_number() over (order by qa_no desc) row_number "
						+ "		 from semi_qas "
						+ "		 where qa_deleted = 'N' and product_no = ?) q, semi_users u, semi_products p "
						+ "where q.row_number >= ? and q.row_number <= ? "
						+ "and q.user_no = u.user_no "
						+ "and q.product_no = p.product_no "
						+ "order by q.qa_no desc ";
			
			return helper.selectList(sql, rs -> {
				Qa qa = new Qa();
				qa.setNo(rs.getInt("qa_no"));
				
				Product product = new Product();
				product.setNo(rs.getInt("product_no"));
				product.setName(rs.getString("product_name"));
				product.setImageName(rs.getString("product_image_name"));
				qa.setProduct(product);
				
				qa.setTitle(rs.getString("qa_title"));
				
				User user = new User();
				user.setNo(rs.getInt("user_no"));
				user.setName(rs.getString("user_name"));
				qa.setUser(user);
				
				qa.setCreatedDate(rs.getDate("qa_created_date"));
				
				return qa;
				
			},productNo, beginIndex, endIndex);
		}
	
	//QA 번호로 해당 QA의 정보 조회 
	public Qa getQaByNo(int qaNo) throws SQLException {
		String sql = "select q.qa_no, q.product_no, p.product_name, p.product_image_name, q.qa_title, q.user_no, u.user_name, "
					+ "		 q.qa_content, q.qa_deleted, q.qa_created_date "
					+ "from semi_qas q, semi_users u, semi_products p "
					+ "where q.qa_no = ? "
					+ "and q.user_no = u.user_no "
					+ "and q.product_no = u.product_no ";
		
		return helper.selectOne(sql, rs -> {
			Qa qa = new Qa();
			qa.setNo(rs.getInt("qa_no"));
			qa.setTitle(rs.getString("qa_title"));
			
			User user = new User();
			user.setNo(rs.getInt("user_no"));
			user.setName(rs.getString("user_name"));
			qa.setUser(user);

			Product product = new Product();
			product.setNo(rs.getInt("product_no"));
			product.setName(rs.getString("product_name"));
			product.setImageName(rs.getString("product_image_name"));
			qa.setProduct(product);
			
			qa.setContent(rs.getString("qa_content"));
			qa.setDeleted(rs.getString("qa_deleted"));
			qa.setCreatedDate(rs.getDate("qa_created_date"));
			
			return qa;
		}, qaNo);
	}
	
	public void updatedQa(Qa qa) throws SQLException {
		String sql = "update semi_qas "
					+ "set "
					+ "		qa_title = ?, "
					+ "		qa_content = ?, "
					+ "		qa_deleted = ? "
					+ "where qa_no = ? ";
		helper.update(sql, qa.getTitle(), qa.getContent(), qa.getDeleted(), qa.getNo());;
	}
  

}
