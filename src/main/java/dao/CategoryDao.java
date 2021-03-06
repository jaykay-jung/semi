package dao;

import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.Category;

public class CategoryDao {
	private static CategoryDao instance = new CategoryDao();
	private CategoryDao() {}
	public static CategoryDao getInstance() {
		return instance;
	}

	private DaoHelper helper = DaoHelper.getInstance();
	
	public Category getCategoryByNo(int category_no) throws SQLException {
		String sql = "select * "      
				   + "from semi_product_category c  "	
				   + "where c.category_no = ? ";	
		
		return helper.selectOne(sql, rs -> {
			Category category = new Category();
			category.setNo(rs.getInt("category_no")); 
			category.setName(rs.getString("category_name"));		
				
			return category;
		}, category_no);
	}
	
	
	public List<Category> getCategoryList() throws SQLException {
		String sql = "select * "
				   + "from semi_product_category "
				   + "order by category_no asc ";
		
		return helper.selectList(sql, rs -> {
			Category category = new Category();
			category.setNo(rs.getInt("category_no"));
			category.setName(rs.getString("category_name"));
			
			return category;
		});
	}
}
