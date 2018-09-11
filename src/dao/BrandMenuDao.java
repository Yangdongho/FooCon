package dao;

import java.util.List;
import java.util.Map;

public interface BrandMenuDao {
	public int menuTotalCountView(Map<String, Object> param);
	public int menuCountView(Map<String,Object> param);
	public List<Map<String, Object>> menuSearchTotalView(Map<String, Object> params);
	public List<Map<String, Object>> menuSearchView(Map<String, Object> params);
	public int menuQuitMenuUpdate(Map<String,Object> param);
	public Map<String,Object> menuSelectOne(String brandMenuNUM);
	public Map<String,Object> menuTurnSelectOne(int menuTurn);
	public int menuInsert(Map<String,Object> param);
	public int menuUpdate(Map<String,Object> param);
	public int menuTotalOrderUpdate(Map<String,Object> param);
	public int menuUpDownUpdate(Map<String,Object> param);
}
