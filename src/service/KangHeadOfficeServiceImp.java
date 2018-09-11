package service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import commons.Constants;
import dao.KangHeadOfficeDao;

@Service
public class KangHeadOfficeServiceImp implements KangHeadOfficeService{
	
	
	@Autowired
	KangHeadOfficeDao headOfficeDao;
	
	
	/***********************관리자 로그인 시작***********************/
	/*본사 아이디 DB상에 검사 시작*/
	@Override
	public boolean login(String master, String officePassword) {
		String id = master;
		String pw = officePassword;
		
		Map<String, Object> admin = headOfficeDao.select_idLogin(id);
		
		if(admin == null) {
			return false;
		}
		
		String originPass = (String) admin.get(Constants.Office.OFFICEPASSWORD);
		if (admin != null) {
			if (originPass.equals(pw)) {
				return true;
			}
		}
		return false;
	}
	/*본사 아이디 DB상에 검사 종료*/
	
	
	/*입력된 아이디의 DB 모든정보를 읽어오기 시작*/
	public Map<String, Object> getHeadOfficeInfo(String master){
		Map<String, Object> member = headOfficeDao.select_getHeadOffice(master);
		return member;
	}
	/*입력된 아이디의 DB 모든정보를 읽어오기 종료*/
	/***********************관리자 로그인 종료***********************/
	
}
