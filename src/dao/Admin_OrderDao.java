package dao;

import java.util.List;
import java.util.Map;

public interface Admin_OrderDao {
	public Map<String,Object> selectOrder(String orderNum);
	public List<Map<String,Object>> selectOrderList(Map<String,Object> param);
	public int countOrder(Map<String,Object> param);
	public int updateMemo(Map<String,Object> param);
	public List<Map<String,Object>> selectAllOrder(String brandNum);
	public String selectBrandNum(String brandOwnerNum);
}
