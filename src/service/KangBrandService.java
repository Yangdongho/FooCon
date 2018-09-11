package service;

import java.util.Map;

public interface KangBrandService {
	
	
	/*관리자 본사 로그인 시작*/
	public boolean login(String master, String officePassword);
	public Map<String, Object> getBrandInfo(String master);
	/*관리자 본사 로그인 종료*/
	
	
	/*관리자 패스워드 찾기 시작*/
	public boolean checkEmailpwFind(String ownerEmail);
	public String tempPassPwFind(String ownerEmail);
	public Map<String, Object> EmailPwFind(String ownerEmail);
	/*관리자 패스워드 찾기 종료*/
	
	
	/*관리자 브랜드 계정 관리생성 시작*/
	public boolean checkEmailNewBrand(String ownerEmail);
	public boolean checkPhoneNumNewBrand(String ownerPhone);
	public boolean insertBrandOwnerNewBrand(Map<String, Object> brandOwner);
	public boolean updateEmailNewBrand(String ownerEmail, String brandOwnerNum);
	public boolean updateNameNewBrand(String ownerName, String brandOwnerNum);
	public boolean updatePasswordNewBrand(String ownerPassword, String brandOwnerNum);
	public boolean updatePhoneNumNewBrand(String ownerPhoneNum, String brandOwnerNum);
	/*관리자 브랜드 계정 관리생성 종료*/
	
	
	
	
	
	
	
}
