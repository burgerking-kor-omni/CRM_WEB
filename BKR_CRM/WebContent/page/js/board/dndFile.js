
dndFile = {}; 

dndFile.dndAction = function(options){
	if(uxl.isNull(options.divId)){
		uxl.showMessage('dndFile error :: id is undifined.');
		return;
	}
	
	var $this = $('#'+options.divId+'.ub-dnd-image');
	
	//file control은 form 밖에 append한다. form 내부로 포함되면 multiple 타입으로 전송됨.
	var fileUpload = '<div class="upload hidden" style="display:none;" id="dnd_upload_'+options.divId+'"><input type="file" multiple></div>';
	$('body').append(fileUpload);
	
	options = $.extend({
		  holder:$('.holder', $this)
		, attachType : 'file'
		, readonly : false
		, tests : {
			  filereader: typeof FileReader != 'undefined' 
			, dnd: 'draggable' in document.createElement('span')
			, formdata: !!window.FormData
			, progress: "upload" in new XMLHttpRequest
		}
	    , support : {
		}
	    , progress : $('#'+options.targetId+' > ul')
		, fileupload : $('#dnd_upload_'+options.divId)
		, listner : null
	}, options || {});
	
	// 브라우져 기능 지원여부 체크
	var testname = "filereader formdata progress".split(' '); 
	var testResult = true;
	for(var i = 0; i <= testname.length; i++){
		if(options.tests[testname[i]] === false){
			testResult = false;
		}
	}
	
	if(!options.readonly){
		options.holder.append('<strong>Click</strong>');
		
		if(testResult == true){
			options.holder.append('<strong> & </strong><strong>Drop</strong>');
		}
		
		options.holder.append('<strong> File Here</strong>');
		
		// 실제 기능
		if (options.tests.dnd) {
			options.holder.append('<div class="upload"><a href="#none"><img src="../page/images/board/btn_upload.png" alt="upload" /></a></div>');
			options.holder[0].ondragover = function(){ 
		    	$(this).addClass('hover'); 
				return false; 
			};
			options.holder[0].ondragleave = function(){
				$(this).removeClass('hover');
				return false;
			};
			options.holder[0].ondragend = function(){
		    	$(this).removeClass('hover'); 
		    	return false; 
		    };
			options.holder[0].ondrop = function(e){
		    	$(this).removeClass('hover');
		    	e.preventDefault();
		    	dndFile.readFiles(options, e.dataTransfer.files);
		  	};
		  	options.holder[0].onclick = function(){
		  		options.fileupload.find('input').click();
		  	};
		  	options.fileupload.find('input')[0].onchange = function(e){
		  		dndFile.readFiles(options, event.srcElement.files);

		  		// 사용한 첨부파일정보를 초기화 하여 동일 파일 업로드시 업로드 안되던 버그 수정
				// IE11에서는 value를 초기화 되면 change 이벤트가 발생함.
				this.value = "";
		  	};
			
		} else {
			$(options.fileupload.find('input')).attr('id','dndFileUploder').attr('name', 'dndFileUploder');
			
		  	options.fileupload.removeClass('hidden').css('text-align', 'center');
		  	$(options.fileupload.find('input')).css('width', '98px');
		  	$(options.fileupload).appendTo($(options.holder));
		  	options.holder.addClass('nocursor');
			
			options.fileupload.find('input')[0].onchange = function() {
				dndFile.readFiles(options, this.files);

				// 사용한 첨부파일정보를 초기화 하여 동일 파일 업로드시 업로드 안되던 버그 수정
				// IE11에서는 value를 초기화 되면 change 이벤트가 발생함.
				this.value = "";
			};
		}
	}

	// 첨부파일 존재시 로드 처리
	if(uxl.isNotNull(fileDataList)){
		for (var i=0; i<fileDataList.length; i++) {
			if(fileDataList[i].attachType == options.attachType){
				var $fileItem = dndFile.loadingFile(fileDataList[i], options);
				$('#'+options.targetId + '> ul').append($fileItem);
			}
		}			
	}
};

dndFile.sendFile = function(options, file){
	// 폼데이터 생성
	var formData = options.tests.formdata ? new FormData() : null;
	formData.append('file', file);
		
	var xhr = new XMLHttpRequest();
  	
	// 진행바 박스 생성
	var progressBar = $('<progress min="0" max="100" value="0"/>');
	var box = $('<div class="thumb"><div class="status"><div></div></div></div>');
	box.find('.status>div').append(progressBar);
	var liBar = $('<li>').append(box);
  	options.progress.append(liBar);

	var uploadUrl = uxl.getContextURL("/file/upload.ub?attachType=" + options.attachType);
  	xhr.open('POST', uploadUrl, 'true');
  	xhr.onreadystatechange = function(oEvent){
  		if (xhr.readyState === 4) {
			if (xhr.status === 200) { // 업로드가 정상적으로 진행된 경우		  	
		  		var result = JSON.parse(xhr.responseText).result;
		  		if(result.serviceMessage.resultStatus == 'Success'){
			  		var uploadFiles = result.dataList[0].rows;
			  		for(var i = 0 ; i < uploadFiles.length; i++){
			  			
			  			// 파일정보 생성
			  			if(options.targetId != null && options.targetId != ''){
			  				var viewFile = dndFile.setFileContent(uploadFiles[i]);

				  			viewFile += '<span class="close"><a href="#none" class="blind" onclick="javascript:dndFile.deleteFileNow(\''+uploadFiles[i].id+'\')">삭제</a></span></div>';
				  			viewFile += '<input type="hidden" name ="file_info.id" id="file_info.id" value="'+uploadFiles[i].id+'">';
				  			viewFile += '<input type="hidden" name ="file_info.delYn" id="file_info.delYn" value="'+uploadFiles[i].delYn+'">';
				  			viewFile += '</li>';
				  			$('#'+options.targetId+' > ul').append(viewFile);
			  			}
			  			
			  			// 콜백함수 호출
			  			if(uxl.isFunction(options.listner)){
				  			options.listner(uploadFiles[i]);
				  		}
			  		}
		  		}else{
		  			var message = result.serviceMessage.message;
		  			alert(message);
		  		}
			} else {
				uxl.showMessage("파일 업로드가 정상적으로 진행되지 않았습니다.");
			}
  		}
  	};

  	// 업로드 완료시
  	xhr.onload = function() {
//  		progressBar.remove();
  		liBar.remove();
  	};

  	// 진행바 표시
	xhr.upload.onprogress = function(event) {
		if (event.lengthComputable) {
			var complete = (event.loaded / event.total * 100 | 0);
	  		progressBar.attr('value', complete);
		}
	};
  	
  	xhr.send(formData);
};

dndFile.readFiles = function(options, files){
	if(options.tests.formdata){
		for (var i = 0; i < files.length; i++) {		
	  		dndFile.sendFile(options, files[i]);
		}
		
		// 업로드 파일의 정렬 기능 활성화
  		$('#'+options.targetId+' >ul').sortable({
			connectWith: "ul"
			//, axis: "x"
			, cursor : "move"
			, revert: true
			, placeholder: "ui-state-highlight"
			, beforeStop: function(event, ui){
			  	$item = ui.item;
			}
		});
		
	}else{
		var uploadUrl = uxl.getContextURL("/file/upload.ub?attachType=" + options.divId);
		var option = {
			data:{}
		  , success:function(result) {
				var uploadFile = result.getDataList(0).rows[0];
				if(options.targetId != null && options.targetId != ''){
	  				var viewFile = dndFile.setFileContent(uploadFile);

		  			viewFile += '<span class="close"><a href="#none" class="blind" onclick="javascript:dndFile.deleteFileNow(\''+uploadFile.id+'\')">삭제</a></span></div>';
		  			viewFile += '<input type="hidden" name ="file_info.id" id="file_info.id" value="'+uploadFile.id+'">';
		  			viewFile += '<input type="hidden" name ="file_info.delYn" id="file_info.delYn" value="'+uploadFile.delYn+'">';
		  			viewFile += '</li>';
		  			$('#'+options.targetId+' > ul').append(viewFile);
	  			}
	  			if(uxl.isFunction(options.listner)){
		  			options.listner(uploadFile);
		  		}
			}
		  , async:true
		};
		uxl.callSubmitFunction($('#'+options.formId), uploadUrl, option);		
	}
};

dndFile.loadingFile = function(fileInfo, options){

	var viewFile = dndFile.setFileContent(fileInfo);
	
	if(options.readonly){
		viewFile += '</div>';
	}else{
		viewFile += '<span class="close"><a href="#none" class="blind" onclick="javascript:dndFile.deleteFile(\''+fileInfo.id+'\')">삭제</a></span></div>';
	}
	viewFile += '<input type="hidden" name ="file_info.id" id="file_info.id" value="'+fileInfo.id+'">';
	viewFile += '<input type="hidden" name ="file_info.delYn" id="file_info.delYn" value="N">';
	viewFile += '</li>';
	$('#'+options.targetId+' > ul').append(viewFile);

		
	if(!options.readonly){
		$('#'+options.targetId+' >ul').sortable({
			connectWith: "ul"
			, cursor : "move"
			, revert: true
			, placeholder: "ui-state-highlight"
			, beforeStop: function(event, ui){
			  	$item = ui.item;
			}
		}); 
	}
	
};

dndFile.setFileContent = function(uploadFile){
	var fileType = uploadFile.contentType;
	var fileUrl = uxl.getContextURL('/file/download.' + uxl.CONSTANT.URL_EXTENTION + '?fileId=' + uploadFile.id);
	var viewFile = '<li fileId="'+uploadFile.id+'" title="'+uploadFile.fileName+'">';
	viewFile += '<div class="thumb" >';//onclick="location.href=\''+fileUrl+'\'" 
	viewFile += '<div class="layer"><ul><li><a href="#none" onclick="location.href=\''+fileUrl+'\'">다운로드</a></li>';//
	if(fileType.indexOf("image") != -1){
		viewFile += '<li><a href="#none" onclick="dndFile.previewFile(\''+uploadFile.id+'\', \''+uploadFile.fileName+'\')">미리보기</a></li>';
	}
	viewFile += '</ul></div>';
	
	if(fileType.indexOf("image") != -1){
		var viewUrl = uxl.getContextURL('/boardfile/thumbnail.ub?imageId='+uploadFile.id+'&wSize=106&hSize=74');
		viewFile += '<div class="img"><div><img src="'+viewUrl+'" alt="" /></div></div>';
//	}else if(fileType.indexOf("excel") != -1){
//		viewFile += '<div class="img"><img src="../page/images/board/thumb_excel.jpg" alt="" /></div>';
//	}else if(fileType.indexOf("text") != -1){
//		viewFile += '<div>TextFile</div>';
//	}else{
//		viewFile += '<div>EtcFile</div>';	
//	}
	}else{
		var extension = uploadFile.fileName.slice(uploadFile.fileName.indexOf(".")+1).toLowerCase();
		var imageUrl = uxl.getContextURL("/page/images/board/thumb_"+extension+".jpg");
		var image = new Image();
		image.src = imageUrl;
		
		if(image.width == 0 && image.height == 0){
			imageUrl = uxl.getContextURL("/page/images/board/thumb_file.jpg");
		}
		
//		do {
//			imageUrl = uxl.getContextURL("/page/images/board/thumb_"+extension+".jpg");
//			var image = new Image();
//			image.src = imageUrl;
//			if(image.width == 0 && image.height == 0){
//				imageUrl = uxl.getContextURL("/page/images/board/thumb_file.jpg");
//			}
//		} while (!image.complete);
		
		viewFile += '<div class="img"><img src="'+imageUrl+'" alt=""/></div>';
	}

	viewFile += '<div class="ellipsis file-name"><span><img src="../page/images/board/ico_file.png" alt="파일" />'+uploadFile.fileName+'</span></div>';
	return viewFile;
};

dndFile.previewFile = function(id, name){
	var viewUrl = uxl.getContextURL('/file/image.' + uxl.CONSTANT.URL_EXTENTION + '?imageId='+id);
	var fileUrl = uxl.getContextURL('/file/download.' + uxl.CONSTANT.URL_EXTENTION + '?fileId=' + id);
	var image = new Image();
	image.src = viewUrl;
	
	$('.pre-layer', $(document.body)).remove();
	
	var previewHtml = '';
	previewHtml += '<div class="pre-layer image preview" >';
	previewHtml += '	<div class="pre-layer-header">';
	previewHtml += '		<strong class="ellipsis">'+name+' 미리보기</strong><span class="close"><a href="#none" onclick="javascript:dndFile.closePreview();"><span>미리보기 닫기</span></a></span>';
	previewHtml += '	</div>';
	previewHtml += '	<div class="pre-layer-body">';
	previewHtml += '		<div class="inner">';
	previewHtml += '			<div class="img" style="text-align:center"><img src="'+image.src+'" alt="" /></div>';
	previewHtml += '		</div>';
	previewHtml += '	<div class="bottom-btn">';
	previewHtml += '		<a href="#none" onclick="location.href=\''+fileUrl+'\'"><span>다운받기</span></a>';
	previewHtml += '		<a href="#none" onclick="dndFile.closePreview();"><span>닫기</span></a>';
	previewHtml += '	</div>';
	previewHtml += '</div>';
	
	$(document.body).append(previewHtml);
	$('.ub-page.board .pre-layer.image.preview').draggable();
	
};

dndFile.closePreview = function(){
	$('.pre-layer', $(document.body)).remove();
};

dndFile.deleteFile = function(fileId){
	$('li[fileId="'+fileId+'"] > input[id="file_info.delYn"]').val('Y');
	$('li[fileId="'+fileId+'"]').css("display","none");
};

dndFile.deleteFileNow = function(fileId){
	$.ajax({
		  type:"POST"
		, url:uxl.getContextURL("/file/remove")+ '.ub?fileId='+fileId
		, data:{}
	 	, dataType: "json"
		, success:function(data){
			$('li[fileId="'+fileId+'"]').remove();
		}
		, error:function(){
			alert('File Delete Error !');
		}
	});
};
