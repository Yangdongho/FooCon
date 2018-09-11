package dao;

import java.util.Map;

public interface KangHeadOfficeDao {
	
	/*관리자 로그인 시작*/
	public Map<String,Object> select_idLogin(String id);
	public Map<String, Object> select_getHeadOffice(String id);
	/*관리자 로그인 종료*/
}
