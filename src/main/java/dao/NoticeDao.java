package dao;

import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.Notice;

public class NoticeDao {

	private static NoticeDao instance = new NoticeDao();
	private NoticeDao() {}
	public static NoticeDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	/**
	 * 공지 등록
	 * @param notice
	 * @throws SQLException
	 */
	public void insertNotice(Notice notice) throws SQLException {
		String sql = "insert into semi_notices "
					+ "(notice_no, notice_title, notice_content "
					+ "values "
					+ "(semi_notices_seq.nextval, ?, ?) ";
		helper.insert(sql, notice.getTitle(), notice.getContent());
	}
	
	/**
	 * 전체 공지 갯수
	 * @return
	 * @throws SQLException
	 */
	public int getTotalRows() throws SQLException {
		String sql = "select count(*) cnt "
					+ "from semi_notices "
					+ "where notice_deleted = 'N' ";
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		});
	}
	
	/**
	 * 전체 공지 갯수 (키워드)
	 * @param keyword
	 * @return
	 * @throws SQLException
	 */
	public int getTotalRows(String keyword) throws SQLException {
		String sql = "select count(*) cnt "
					+ "from semi_notices "
					+ "where notice_deleted = 'N' and notice_title like '%' || ? || '%' ";
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
	public List<Notice> getNotices(int beginIndex, int endIndex) throws SQLException {
		String sql = "select "
					+ "from ";
		
		return helper.selectList(sql, rs -> {
			Notice notice = new Notice();
			
			return notice;
		}, beginIndex, endIndex);
	}
	
}
