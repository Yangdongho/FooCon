package dao;

import java.util.List;
import java.util.Map;

public interface OrderDao {
	
	public List<Map<String,Object>> selectOrderList(Map<String,Object> param);
	public Map<String,Object> selectOrder(String orderNum);
	public List<Map<String,Object>> selectMenuList(String orderNum);
	public int countOrder(Map<String,Object> param);
	public String selectReview(Map<String,Object> param);
	public Map<String,Object> selectNonMemberOrderList(String orderNumber);
	public Map<String,Object> selectNonMemberOrderInfo(String orderNumber);
}
