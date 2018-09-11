package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class temp {
	
	@RequestMapping("/imageView")
	public String imageView() {
		return "image";
	}
	
	@RequestMapping("/temp")
	public String getImageAsByteArray(Model model) {
		//특정 이미지 읽어와서 byte[] 배열로 만들어서 반환
		// C:\boardImage
		byte []temp = null ;
	
		//파일 읽어오기 
		String fileName = "d5c4446e-18db-4fc0-88bf-5070e5a99985_다운로드 (1).jpg";
		File originFile = new File("C:/temp/"+fileName);
		InputStream targetStream = null;
		try {
			targetStream = new FileInputStream(originFile);
			//스트림을 byte[] 변환하기 >>IOUtils, commons.io 
		
			temp = IOUtils.toByteArray(targetStream);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(temp.toString());
		System.out.println(temp.length);
	
		model.addAttribute("img",temp);
		
		
		
		return "NewFile1";
	}
}
