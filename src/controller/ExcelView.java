package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.servlet.view.AbstractView;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

public class ExcelView extends AbstractView{
	
	List<Map<String,Object>> orderList;
	 private static final String CONTENT_TYPE_XLSX = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
	 public ExcelView(List<Map<String,Object>> orderList) {
		// TODO Auto-generated constructor stub
		 this.orderList = orderList;
		 setContentType("application/download; utf-8");
		 
	}
	 
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub
		 Workbook workbook = createWorkbook();
		 
	        setContentType(CONTENT_TYPE_XLSX);
	 
	        buildExcelDocument(model, workbook, request, response);
	        
	        // Set the content type.
	        response.setContentType(getContentType());
	        response.setHeader("Content-disposition", "attachment; filename=전체 주문내역 .xlsx");
			response.setHeader("Content-Transfer-Encoding", "bianry");
	        // Flush byte array to servlet output stream.
	        ServletOutputStream out = response.getOutputStream();
	        out.flush();
	        workbook.write(out);
	        out.flush();
	        if (workbook instanceof SXSSFWorkbook) {
	            ((SXSSFWorkbook) workbook).dispose();
	        }
		
	}

	@Override
	protected boolean generatesDownloadContent() {
		// TODO Auto-generated method stub
		return true;
	}
	
	 protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
	
         //Sheet 생성
         Sheet sheet = workbook.createSheet("주문내역");
         Row row = null;
         int rowCount = 0;
         int cellCount = 0;
     

         row = sheet.createRow(rowCount++);

         row.createCell(cellCount++).setCellValue("주문번호");
         row.createCell(cellCount++).setCellValue("트럭명");
         row.createCell(cellCount++).setCellValue("총금액");
         row.createCell(cellCount++).setCellValue("적림금사용");
         row.createCell(cellCount++).setCellValue("실 결제금액");
         row.createCell(cellCount++).setCellValue("주문형태");
         row.createCell(cellCount++).setCellValue("취소여부");
         row.createCell(cellCount++).setCellValue("주문일");
         
         // 데이터 Cell 생성
         for (Map<String, Object> order : orderList) {
             row = sheet.createRow(rowCount++);
             cellCount = 0;
             int totalPay = Integer.valueOf(String.valueOf(order.get("PAYMENTAMOUNT"))) ;
             
             int point = Integer.valueOf(String.valueOf(order.get("USEDPOINT"))) ; 
             
             String type = "배달";
             if(((String)order.get("DELIVREGICHECK")).equals("R")) {
            	 type = "예약";
             }
             row.createCell(cellCount++).setCellValue((String)order.get("ORDERNUMBER")); //데이터를 가져와 입력
             row.createCell(cellCount++).setCellValue((String)order.get("BRANDNAME"));
             row.createCell(cellCount++).setCellValue(totalPay);
             row.createCell(cellCount++).setCellValue(point);
             row.createCell(cellCount++).setCellValue((totalPay-point));
             row.createCell(cellCount++).setCellValue(type);
             row.createCell(cellCount++).setCellValue((String)order.get("CANCLESTATUS"));
             row.createCell(cellCount++).setCellValue((String)order.get("ORDERDATE"));

         }
      

	}
	 
	 protected Workbook createWorkbook() {
		 return new XSSFWorkbook();
	 }

}
