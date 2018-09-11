package service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import commons.Constants;
import dao.KangBrandOwnerDao;

@Service
public class KangBrandServiceImp implements KangBrandService{
	
	@Autowired
	KangBrandOwnerDao brandOwnerDao;
	
	/***********************관리자 로그인 시작***********************/
	/*본사 아이디 DB상에 검사 시작*/
	@Override
	public boolean login(String master, String officePassword) {
		String id = master;
		String pw = officePassword;
		
		Map<String, Object> admin = brandOwnerDao.select_idLogin(id);	
		if(admin == null) {
			return false;
		}
		
		String originPass = (String) admin.get(Constants.Brand.OWNERPASSWORD);
		if (admin != null) {
			if (originPass.equals(pw)) {
				return true;
			}
		}
		return false;
	}
	/*본사 아이디 DB상에 검사 종료*/
	
	/*입력된 아이디의 DB 모든정보를 읽어오기 시작*/
	public Map<String, Object> getBrandInfo(String master){
		Map<String, Object> admin = brandOwnerDao.select_getBrand(master);
		return admin;
	}
	/*입력된 아이디의 DB 모든정보를 읽어오기 종료*/
	/***********************관리자 로그인 종료***********************/
	
	
	/***********************관리자 비밀번호 찾기 시작***********************/
	/*DB에 있는 이메일인지 확인 절차 시작*/
	@Override
	public boolean checkEmailpwFind(String ownerEmail) {
		String email = ownerEmail;
		
		Map<String, Object> brandOwner = brandOwnerDao.select_idPwFind(email);
		// 원래 이메일과 입력받은 이메일 비교
		if (brandOwner != null) {
			return true;
		} else {
			return false;
		}
	}
	/*DB에 있는 이메일인지 확인 절차 종료*/
	
	/*이메일 통해 회원의 값을 가져오기 시작*/
	public Map<String, Object> EmailPwFind(String ownerEmail){
		Map<String, Object> owner = brandOwnerDao.select_idPwFind(ownerEmail);
		return owner;
	}
	/*이메일 통해 회원의 값을 가져오기 시작*/
	
	/*임시비밀번호 발급 시작*/
	@Override
	public String tempPassPwFind(String ownerEmail) {
		String memberPassword = "";
		for (int i = 0; i < 12; i++) {
			memberPassword += (char) ((Math.random() * 26) + 97);
		}
		
		// 비밀번호 변경
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("OWNERPASSWORD", memberPassword);
		param.put("OWNEREMAIL", ownerEmail);
		
		if(brandOwnerDao.update_pw(param)>0) {
		}else {
			return null;
		}
		return memberPassword;
	}
	/*임시비밀번호 발급 종료*/
	/***********************관리자 비밀번호 찾기 종료***********************/
	
	
	/***********************관리자 브랜드 아이디 관리 생성 시작***********************/
	/*이메일 DB에서 확인하는 절차 시작*/
	@Override
	public boolean checkEmailNewBrand(String ownerEmail) {
		Map<String, Object> param = brandOwnerDao.select_EmailNewBrand(ownerEmail);
		
		if(param == null) {
			return true;
		}else {
			return false;
		}
	}
	/*이메일 DB에서 확인하는 절차 종료*/
	
	/*핸드폰 번호 DB에서 확인하는 절차 시작*/
	@Override
	public boolean checkPhoneNumNewBrand(String ownerPhone) {
		Map<String, Object> param = brandOwnerDao.select_PhoneNumNewBrand(ownerPhone);
			
		if(param == null) {
			return true;
		}else {
			return false;
		}
	}
	/*핸드폰 번호 DB에서 확인하는 절차 종료*/
	
	/*입력된 값으로 계정 생성 시작*/
	@Override
	public boolean insertBrandOwnerNewBrand(Map<String, Object> brandOwner) {
		int result = brandOwnerDao.insertBrandOwner(brandOwner);
		if(result >0) {
			return true;
		}
		return false;
	}
	/*입력된 값으로 계정 생성 종료*/
	
	/*새로 작성된 이메일 업데이트 시작*/
	@Override
	public boolean updateEmailNewBrand(String ownerEmail, String brandOwnerNum) {
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("OWNEREMAIL", ownerEmail);
		param.put("BRANDOWNERNUM", brandOwnerNum);
		
		int result = brandOwnerDao.update_emailNewBrand(param);
		
		if (result > 0) {
			return true;
		}
		return false;
	}
	/*새로 작성된 이메일 업데이트 종료*/

	/*새로 작성된 이름 업데이트 시작*/
	@Override
	public boolean updateNameNewBrand(String ownerName, String brandOwnerNum) {
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("OWNERNAME", ownerName);
		param.put("BRANDOWNERNUM", brandOwnerNum);
		
		int result = brandOwnerDao.update_nameNewBrand(param);
		
		if (result > 0) {
			return true;
		}
		return false;
	}
	/*새로 작성된 이름 업데이트 종료*/
	
	/*새로 작성된 비밀번호 업데이트 시작*/
	@Override
	public boolean updatePasswordNewBrand(String ownerPassword, String brandOwnerNum) {
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("OWNERPASSWORD", ownerPassword);
		param.put("BRANDOWNERNUM", brandOwnerNum);
		
		int result = brandOwnerDao.update_passwordNewBrand(param);
		
		if (result > 0) {
			return true;
		}
		return false;
	}
	/*새로 작성된 비밀번호 업데이트 종료*/
	
	/*새로 작성된 핸드폰번호 업데이트 시작*/
	@Override
	public boolean updatePhoneNumNewBrand(String ownerPhoneNum, String brandOwnerNum) {
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("OWNERPHONE", ownerPhoneNum);
		param.put("BRANDOWNERNUM", brandOwnerNum);
		
		int result = brandOwnerDao.update_phoneNumNewBrand(param);
		
		if (result > 0) {
			return true;
		}
		return false;
	}
	/*새로 작성된 핸드폰번호 업데이트 종료*/
	/***********************관리자 브랜드 아이디 관리 생성 종료***********************/
}
