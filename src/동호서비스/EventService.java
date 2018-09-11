package 동호서비스;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import dao.EventDao;

@Service
public class EventService {
	private static final int NUM_OF_EVENT_PER_PAGE = 10;
	private static final int NUM_OF_NAVI_PAGE = 5;
	private static final String uploadPath = "C:\\temp";
	
	@Autowired
	EventDao dao;
	
	public void addViewCount(String eventNum) {
		dao.updateViewCount(eventNum);
	}
	public Map<String, Object> getEvent(String eventNum) {
		return dao.selectOne(eventNum);
	}

	public boolean removeEvent(String eventNum) {
		dao.delete(eventNum);
		return true;
	}
	
	public List<Map<String,Object>> getUserEventList(){
		Map<String,Object> param = new HashMap<String,Object>();
		int totalCount = dao.countEvent(param);
		param.put("firstRow",totalCount-5);
		param.put("endRow",totalCount);
		return dao.userSelectAll(param);
	}

	public boolean addEvent(Map<String,Object> event ,MultipartFile eventImg,MultipartFile thumnail ) {
		if(eventImg.getSize()!=0) {
			event.put("eventImg", writeFile(eventImg));
		}
		if(thumnail.getSize()!=0) {
			event.put("thumnail", writeFile(thumnail));
		}
		if(dao.insert(event)==1) {
			return true;
		}else {
			return false;
		}
	}
	
	public boolean modifyEvent(Map<String,Object> event ,MultipartFile eventImg,MultipartFile thumnail) {
	
		if(eventImg.getSize()!=0 && thumnail.getSize()!=0) {
			event.put("thumnail", writeFile(thumnail));
			event.put("eventImg", writeFile(eventImg));
		}else if(eventImg.getSize()!=0) {
			event.put("eventImg", writeFile(eventImg));
		}else if(thumnail.getSize()!=0) {
			event.put("thumnail", writeFile(thumnail));
		
		}
	
		if(dao.update(event)==1) {
			return true;
		}else {
			return false;
		}
		
		
	}
	//다운로드할때
	public File getAttachName(String eventNum) {
		//게시글에 포함된 첨부파일 가져오기 
				//게시글 번호를 이용해서 file fullName 얻어오고,
				//fullName을 이용해서 파일 얻어오기 
				//attach table에서 파일이름 얻어오기 
			Map<String, Object> event = dao.selectOne(eventNum);
			String fullName = (String)event.get("EVENTUPLOADFILE");
			return new File(uploadPath,fullName);
	}
	
	//서버에서 이미지 보내주기
	public byte[] getImegeAsByteArray(String type,String eventNum) {
		//특정이미지를 바이터 배열로 만들어서 반환한다!!!
		//C:\boardimg 이미지 경로
		String fileName = null;
		Map<String, Object> event = dao.selectOne(eventNum);
		if(type.equals("1")) {
			fileName = (String)event.get("EVENTUPLOADFILE");
		}else if(type.equals("2")){
			
			fileName = (String)event.get("EVENTTHUMNAIL");
		}
		
	
		
		File originFile = new File("C:/temp/"+fileName);
		//이셉션을 어디다가 보내야 하는지 물어보기
		InputStream targetStream = null;
		try {
			targetStream  = new FileInputStream(originFile);
			//스트림을 바이트로 변환 -> IOUtils , commons.io
			return IOUtils.toByteArray(targetStream);
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}

	
	public String writeFile(MultipartFile file) {
		//파일 저장하고 uuid가 붙은 파일이름 반환
		String fullName = null;
		UUID uuid = UUID.randomUUID();
		fullName = uuid.toString()+"_"+file.getOriginalFilename();
		File target = new File(uploadPath,fullName);
		try {
			FileCopyUtils.copy(file.getBytes(), target);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return fullName;
	}
	

	public Map<String, Object> getEventList(Map<String,Object> temp) {
			
		Map<String, Object> viewData = new HashMap<String,Object>();
		
		int firstRow = 0;
		int endRow =0;
		int totalCount = 0;  //총 메시지의 개수, 총 페이지수를 구하기 위해 필요
		
		int pageNumber = (int) temp.get("pageNumber");
		firstRow = (pageNumber-1)*NUM_OF_EVENT_PER_PAGE +1;
		endRow = pageNumber*NUM_OF_EVENT_PER_PAGE;
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("firstRow", firstRow);
		param.put("endRow", endRow);

		if(temp.get("keyword")!=null) {
			param.put("keyword",temp.get("keyword"));
		}
			totalCount  = dao.countEvent(temp); //이벤트 개수
		
		List<Map<String,Object>> eventList 
		  = dao.selectAll(param);
		
		viewData.put("currentPage",pageNumber);
		viewData.put("eventList", eventList);
		viewData.put("pageTotalCount",calPageTotalCount(totalCount));
		viewData.put("startPage", getStartPage(pageNumber));
		viewData.put("endPage", getEndPage(pageNumber));
		viewData.put("keyword", temp.get("keyword"));
		
		return viewData;
	}
	
	
	private int calPageTotalCount(int totalCount) {
	
		int pageTotalCount = 0;
		if(totalCount != 0) {
			pageTotalCount = (int)Math.ceil(
					((double)totalCount / NUM_OF_EVENT_PER_PAGE));
		}
		return pageTotalCount;
	}
	
	
	public int getStartPage(int pageNum) {
	
		int startPage = ((pageNum-1)/NUM_OF_NAVI_PAGE)*NUM_OF_NAVI_PAGE + 1;
		
		return startPage;
	}
	
	
	public int getEndPage(int pageNum) {
		
		int endPage 
		= (((pageNum-1)/NUM_OF_NAVI_PAGE)+1)
		* NUM_OF_NAVI_PAGE;
		return endPage;
	}
	
}
