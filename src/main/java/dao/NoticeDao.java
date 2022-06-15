package dao;

public class NoticeDao {

	private static NoticeDao instance = new NoticeDao();
	private NoticeDao() {}
	public static NoticeDao getInstance() {
		return instance;
	}
}
