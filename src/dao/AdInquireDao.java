package dao;

import java.util.List;
import java.util.Map;

public interface AdInquireDao {
	public int adReferenceInsert(Map<String,Object> param);
	public int totalAdInquire(Map<String,Object> param);
	public List<Map<String,Object>> searchAdInquire(Map<String,Object> param);
	public Map<String,Object> adReferenceSelectOne(String addInquireNUM);
}
