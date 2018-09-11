package dao;

import java.util.Map;

public interface BrandOwnerDao {
	public Map<String,Object> brandOwnerSelectOne(String brandOwnerNUM);
	public int brandOwneUpdate(Map<String,Object> param);
}
