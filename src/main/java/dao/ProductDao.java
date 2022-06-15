package dao;

import java.sql.SQLException;

import helper.DaoHelper;
import vo.Product;

public class ProductDao {

	private static ProductDao instance = new ProductDao();
	private ProductDao() {}
	public static ProductDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	public void insertProducts(Product product) throws SQLException {
		
	}
}
