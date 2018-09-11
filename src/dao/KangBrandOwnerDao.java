package dao;

import java.util.Map;

public interface KangBrandOwnerDao {
	
	/*관리자 로그인 시작*/
	public Map<String,Object> select_idLogin(String id);
	public Map<String,Object> select_getBrand(String id);
	/*관리자 로그인 종료*/
	
	/*관리자 비밀번호 찾기 시작*/
	public Map<String,Object> select_idPwFind(String id);
	public int update_pw(Map<String, Object> param);
	/*관리자 비밀번호 찾기 종료*/
	
	/*관리자 브랜드 아이디 관리 생성 시작*/
	public Map<String,Object> select_EmailNewBrand(String id);
	public Map<String,Object> select_PhoneNumNewBrand(String ownerPhone);
	public int insertBrandOwner(Map<String, Object> brandOwner);
	
	public int update_emailNewBrand(Map<String, Object> param);
	public int update_nameNewBrand(Map<String, Object> param);
	public int update_passwordNewBrand(Map<String, Object> param);
	public int update_phoneNumNewBrand(Map<String, Object> param);
	/*관리자 브랜드 아이디 관리 생성 종료*/	
}
