package service;

import java.util.Map;

public interface KangHeadOfficeService {
	
	/*관리자 본사 로그인 시작*/
	public boolean login(String master, String officePassword);
	public Map<String, Object> getHeadOfficeInfo(String master);
	/*관리자 본사 로그인 종료*/

}
