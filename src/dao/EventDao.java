package dao;

import java.util.List;
import java.util.Map;

public interface EventDao {

	public Map<String,Object> selectOne(String eventNum);
	public List<Map<String,Object>> selectAll(Map<String,Object> param);
	public int update(Map<String,Object> event);
	public int delete(String eventNum);
	public int insert(Map<String,Object> event);
	public int countEvent(Map<String,Object> param);
	public List<Map<String,Object>> userSelectAll(Map<String,Object> param);
	public int updateViewCount(String eventNum);
}
