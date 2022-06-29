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
					+ "(notice_no, notice_title, notice_content) "
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
	 * 공지 페이징 처리
	 * @param beginIndex
	 * @param endIndex
	 * @return
	 * @throws SQLException
	 */
	public List<Notice> getNotices(int beginIndex, int endIndex) throws SQLException {
		String sql = "select * "
					+ "from (select row_number() over (order by notice_no desc) row_number, notice_no, notice_title, notice_content, notice_created_date, notice_view_count "
					+ "		 from semi_notices "
					+" 		 where notice_deleted = 'N') "
					+ "where row_number >= ? and row_number <= ? ";
		
		return helper.selectList(sql, rs -> {
			Notice notice = new Notice();
			notice.setNo(rs.getInt("notice_no"));
			notice.setTitle(rs.getString("notice_title"));
			notice.setContent(rs.getString("notice_content"));
			notice.setCreatedDate(rs.getDate("notice_created_date"));
			notice.setViewCount(rs.getInt("notice_view_count"));
			
			return notice;
		}, beginIndex, endIndex);
	}
	
	/**
	 * 공지 페이징처리 (키워드)
	 * @param beginIndex
	 * @param endIndex
	 * @param keyword
	 * @return
	 * @throws SQLException
	 */
	public List<Notice> getNotices(int beginIndex, int endIndex, String keyword) throws SQLException {
		String sql = "select * "
					+ "from (select row_number() over (order by notice_no desc) row_number, notice_no, notice_title, notice_content, notice_created_date, notice_view_count "
					+ "		 from semi_notices "
					+" 		 where notice_deleted = 'N' and notice_title like '%' || ? || '%') "
					+ "where row_number >= ? and row_number <= ? ";
		
		return helper.selectList(sql, rs -> {
			Notice notice = new Notice();
			notice.setNo(rs.getInt("notice_no"));
			notice.setTitle(rs.getString("notice_title"));
			notice.setContent(rs.getString("notice_content"));
			notice.setCreatedDate(rs.getDate("notice_created_date"));
			notice.setViewCount(rs.getInt("notice_view_count"));
			
			return notice;
		}, keyword, beginIndex, endIndex);
	}
	
	public Notice getNotcieByNo(int noticeNo) throws SQLException {
		String sql = "select notice_no, notice_title, notice_content, notice_created_date, notice_view_count "
					+ "from semi_notices "
					+ "where notice_no = ? ";
		
		return helper.selectOne(sql, rs -> {
			Notice notice = new Notice();
			notice.setNo(rs.getInt("notice_no"));
			notice.setTitle(rs.getString("notice_title"));
			notice.setContent(rs.getString("notice_content"));
			notice.setCreatedDate(rs.getDate("notice_created_date"));
			notice.setViewCount(rs.getInt("notice_view_count"));
			
			return notice;
		}, noticeNo);
	}
	
	public void updateNotice(Notice notice) throws SQLException {
		String sql = "update semi_notices "
					+ "set "
					+ "		notice_title = ?, "
					+ "		notice_content = ?, "
					+ "		notice_view_count = ?, "
					+ "		notice_deleted = ?, "
					+ "where notice_no = ? ";
		
		helper.update(sql, notice.getTitle(), notice.getContent(), notice.getViewCount(), notice.getDeleted(), notice.getNo());			
	}
	
}
