var flag = false;
var startCalendar;
var endCalendar;
var type;
	$(function() {
		$(".datepicker").datepicker();
		$(".datepicker").datepicker("option", "dateFormat",'yy-mm-dd');
		$("#startCalendar").val(startCalendar);
		$("#endCalendar").val(endCalendar);
		
	
		$("#imgInp").on('change', function(){
		        
			if( $("#imgInp").val() != "" ){
				var ext = $('#imgInp').val().split('.').pop().toLowerCase();
				     if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {
				    	 $("#imgInp").val("");	 
				    	 $("#blah1").removeAttr("src");
						 alert('gif,png,jpg,jpeg 파일만 업로드 할수 있습니다.');
						 return;
				      }
			}
			
			var file = $("#imgInp")[0].files[0];
		        var url = window.URL.createObjectURL(file);
		        $("#blah1").attr("src",url);
        });
		 $("#thumnail").on('change', function(){
			 if( $("#thumnail").val() != "" ){
					var ext = $('#thumnail').val().split('.').pop().toLowerCase();
					     if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {
					    	$("#thumnail").val("");
					    	$("#blah2").removeAttr("src");
					    	flag = false;
						 	alert('gif,png,jpg,jpeg 파일만 업로드 할수 있습니다.');
						 	return;
					      }
				}
		        var file = $("#thumnail")[0].files[0];
		        var url = window.URL.createObjectURL(file);
		        $("#blah2").attr("src",url);
		        flag = true;
        });
		 
		 
		 $("#endCalendar").on('change',function(){
			 if($("#startCalendar").val()!=""){
				 if(!countDate()){
					$("#endCalendar").val("");
					alert("이벤트 종료 날짜를 확인해주세요.")
				 }
			 }

		 });
		 $("#startCalendar").on('change',function(){
			 if($("#endCalendar").val()!=""){
				 if(!countDate()){
						$("#startCalendar").val("");
						alert("이벤트 시작 날짜를 확인해주세요.")
					 }
			 }

		 });

		 
	});

	
	 function countDate(){
			var start = $("#startCalendar").val();
			var end = $("#endCalendar").val();
			var sTemp = start.split("-");
			var eTemp = end.split("-");
		
			var stratDate = new Date(sTemp[0],sTemp[1]-1,sTemp[2]);
			var endDate = new Date(eTemp[0],eTemp[1]-1,eTemp[2]);
			

			var diff = stratDate-endDate;
			if(diff<0){
				return true;
			}else{
				return false;
			}
			

		}

	 
	function check(){
	
		if($("#startCalendar").val()!="" && $("#endCalendar").val()!="" && $("#title").val()!=""){
			if(type == 0){
				if(flag){
					return true;	
				}
				else{
					alert("입력 정보를 확인하세요.");
					return false;
				}
			} 	
			return true;
		}else{
			alert("입력 정보를 확인하세요.");
			return false;
		}
	}
	