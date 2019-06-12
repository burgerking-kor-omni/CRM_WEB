
fileReply = {}; 
/**
 * fileReply.action :  file input 창에 대해서 이벤트를 bind 한다.
 * @param id        :  첨부파일 양식을 구성하는 <a></a>로 된 버튼 id   <br>
 * 					   <p> 
 * 					   예시 : <a href="#none" id="replyFile"><img src="../page/images/board/btn_upload.png" alt="upload"></a>
 * 					   <p>
 * @param formId    :  첨부파일 양식을 구성하는 <form><form>으로 된 id <br>
 * 					   <p> 
 * 					   예시 :<form id="replyFileForm" name="replyFileForm" method="POST" encoding="multipart/form-data" enctype="multipart/form-data">
 *							<p class="upload" style="display: none;">
 *								<input type="file">
 *							</p>
 *					   </form>
 *					   <p>
 */    
fileReply.action = function(id, formId){
	var $this = $('#'+id);
	var $form = $('#'+formId);
	var options = {
		  divId : id
		, formId : formId
		, holder:$this 
		, tests : {
			  filereader: typeof FileReader != 'undefined' 
			, dnd: 'draggable' in document.createElement('span')
			, formdata: !!window.FormData
			, progress: "upload" in new XMLHttpRequest
		}
		, fileupload : $('.upload', $form)
		, target : $('ul', $this.parent().parent())
	};  
	// 실제 기능
	if(options.tests.dnd){
		
		// console.debug("LOG001 fileReply.js fileReply.action() :::: "+options.tests.dnd);
		
		options.holder[0].onclick = function(){
	  		if($('input[type="hidden"][id="file_info.delYn"][value="N"]', options.target).length != 0){
	  			uxl.showMessage('첨부는 한개만 가능합니다.');
	  			return;
	  		}
	  		options.fileupload.find('input').click();
	  		// alert('after click');
	  	};
	  	options.fileupload.find('input')[0].onchange = function(e){
	  		fileReply.readFiles(options, event.srcElement.files);
	  		// console.debug("LOG002 fileReply.js fileReply.action()::::");
	  	};
	} else {

		$(options.fileupload.find('input')).attr('id', id + 'Uploder').attr('name', id + 'Uploder');
		
	  	$(options.fileupload).show();
	  	$(options.fileupload.find('input')).css('width', '98px');
	  	$(options.holder).remove();
	  	
	  	// console.debug("LOG003 fileReply.js fileReply.action() ::::");
	  	  
//	  	options.fileupload.find('input')[0].onchange = function(e){
//	  		fileReply.readFiles(options, this.files);
//	  	};
	}
	
	// console.debug("LOG004 fileReply.js fileReply.action()::::");  
};
/**
 * fileReply.readFiles  
 * @param option
 * @param files
 */
fileReply.readFiles = function(options, files){   
	// console.debug("LOG006 fileReply.js fileReply.readFiles() ::::"+options.tests.formdata);  
	var uploadUrl = "/file/upload"+ '.ub?attachType='+options.divId;
	if(options.tests.formdata){
		var formData = new FormData();
		for (var i = 0; i < files.length; i++) {
			formData.append('file'+(i+1), files[i]);
		  	var xhr = new XMLHttpRequest();
		  	   
		  	xhr.open('POST', uploadUrl, 'true');
		  	
		  	xhr.onreadystatechange = function(oEvent){
		  		if (xhr.readyState === 4) {
					if (xhr.status === 200) { // 업로드가 정상적으로 진행된 경우		  	
				  		var result = JSON.parse(xhr.responseText).result;
				  		if(result.serviceMessage.resultStatus == 'Success'){
				  			var uploadFiles = result.dataList[0].rows;
					  		
					  		for(var i = 0 ; i < uploadFiles.length; i++){
					  			if(options.target != null && options.target != ''){
					  				var viewFile = fileReply.setFileContent(uploadFiles[i]);
					  				
					  				viewFile += ' <span class="del" onclick="javascript:fileReply.deleteFileNow(\''+uploadFiles[i].id+'\',\''+options.formId+'\')"><a href="#none"></a></span>';
						  			viewFile += '<input type="hidden" name ="file_info.id" id="file_info.id" value="'+uploadFiles[i].id+'">';
						  			viewFile += '<input type="hidden" name ="file_info.delYn" id="file_info.delYn" value="'+uploadFiles[i].delYn+'">';
						  			viewFile += '</li>';
						  			$(options.target).append(viewFile);
					  			}
					  		}
				  		}else{
				  			var message = result.serviceMessage.message;
				  			alert(message);
				  		}
					} else {
						alert("파일 업로드가 정상적으로 진행되지 않았습니다.");
					}
		  		}
		  	};
		  	
		  	xhr.onload = function() {};
		
		  	xhr.send(formData);
		}
	}else{
		
		var option = {
			data:{}
		  , success:function(result) {
				var uploadFile = result.getDataList(0).rows[0];
				if(options.target != null && options.target != ''){
	  				var viewFile = fileReply.setFileContent(uploadFile);   

	  				viewFile += ' <span class="del" onclick="javascript:fileReply.deleteFileNow(\''+uploadFile.id+'\',\''+options.formId+'\')"><a href="#none"></a></span>';
		  			viewFile += '<input type="hidden" name ="file_info.id" id="file_info.id" value="'+uploadFile.id+'">';
		  			viewFile += '<input type="hidden" name ="file_info.delYn" id="file_info.delYn" value="'+uploadFile.delYn+'">';
		  			viewFile += '</li>';
		  			$(options.target).append(viewFile);
	  			}
			}
		  , async:true
		};
		uxl.callSubmitFunction($('#'+options.formId), uploadUrl, option);		
	}
	
	
};
/**
 * fileReply.loadingFile
 * @param fileInfo
 * @param target
 */
fileReply.loadingFile = function(fileInfo, target){	
	if(fileInfo.rowCount != 0){
		var uploadFiles = fileInfo.rows;
		
		for(var i = 0 ; i < uploadFiles.length; i++){
			var viewFile = fileReply.setFileContent(uploadFiles[i]);
			
			
			viewFile += '<span class="del" onclick="javascript:fileReply.deleteFile(\''+uploadFiles[i].id+'\')"><a href="#none"></a></span>';
			viewFile += '<input type="hidden" name ="file_info.id" id="file_info.id" value="'+uploadFiles[i].id+'">';
			viewFile += '<input type="hidden" name ="file_info.delYn" id="file_info.delYn" value="N">';
			viewFile += '</li>';
			target.append(viewFile);
	  	}	
	}
};

/**
 * fileReply.setFileContent
 * @param uploadFile
 */
fileReply.setFileContent = function(uploadFile){
	
	var fileUrl = uxl.getContextURL('/file/download.' + uxl.CONSTANT.URL_EXTENTION + '?fileId=' + uploadFile.id);

	var viewFile = '<li fileId="'+uploadFile.id+'" title="'+uploadFile.fileName+'">';
	
	viewFile += '<span onclick="location.href=\''+fileUrl+'\'">' + uploadFile.fileName + '</span>';
	
	return viewFile;
};

/**
 * fileReply.deleteFile 삭제 상태인 file에 대한 정보를 담고 있는 엘리멘트를 숨긴다.
 * @param fileId : 파일의 ID ex)14223 형식으로 숫자로 되어있다.
 */
fileReply.deleteFile = function(fileId){
	$('li[fileId="'+fileId+'"] > input[id="file_info.delYn"]').val('Y');
	$('li[fileId="'+fileId+'"]').css("display","none");
};
/**
 * fileReply.deleteFileNow 덧글에 첨부된 파일ID를 통해서 파일을 삭제한다.
 *@param fileId : 파일의 ID ex)14223 형식으로 숫자로 되어있다. 
 *@param formId : formID 
 */
fileReply.deleteFileNow = function(fileId, formId){
	$.ajax({
		  type:"POST"
		, url:uxl.getContextURL("/file/remove")+ '.ub?fileId='+fileId
		, data:{}
	 	, dataType: "json"
		, success:function(data){
			/* 원 인: 이미 업로드 된 파일이름인 경우 onchange 이벤트 리스너가 동작을 하지않는다.
			 * 해결 방법: formId를 가져와 해당 폼을 강제로 reset() 호출하여 리셋시킴  
			 * 버그 내용 : 덧글 파일 첨부에서 파일을 올린후 , 삭제버튼으로 지운 상태에서 다시 업로드할 때, 
			 *             동일 파일이 업로드가 경우가 발생함
			 */
			 $('#'+formId)[0].reset();       
			// console.log("formId ---------========================"+formId);      
			$('li[fileId="'+fileId+'"]').remove();
		}
		, error:function(){
			alert('File Delete Error !');
		}
	});
};

