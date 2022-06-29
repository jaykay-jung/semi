package dao;

import helper.DaoHelper;

public class ImageListDao {

	private static ImageListDao instance = new ImageListDao();
	
	private ImageListDao() {}
	
	public static ImageListDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	
	
	
}

	