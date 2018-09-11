package dao;

import java.util.List;
import java.util.Map;


public interface FaqDao {
	public int insertFaq(Map<String,Object>params);
	public int updateFaq(Map<String,Object>params);
	public int deleteFaq(String faqNum);
	public Map<String, Object> selectOne(String faqNum);
	public List<Map<String, Object>> selectAll();
	
}
