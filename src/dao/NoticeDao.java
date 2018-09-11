package dao;

import java.util.List;
import java.util.Map;

public interface NoticeDao {
	public int insertNotice(Map<String, Object>params);
	public int updateNotice(Map<String,Object>params);
	public int updateViewCount(Map<String,Object>params);
	public int deleteNotice(String noticeNum);
	public Map<String, Object> selectOneNotice(String NOTICENUM);
	public List<Map<String, Object>> selectAllNotice(Map<String, Object>params);
	public Map<String,Object> userPage(String rnum);
	public int countNotice(Map<String, Object>params);
}
