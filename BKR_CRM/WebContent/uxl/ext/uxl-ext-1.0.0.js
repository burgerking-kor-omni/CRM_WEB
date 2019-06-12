(function($, uxl) {
	
	/**
	 * @class 탭 위젯 클래스<br/>
	 * 
	 * @see uxl-ext-1.0.0.js
	 */
	uxl.ext = {}; 

	/**
	 * AJAX Page 로딩시 SWFUpload 첨부파일이 존재할 경우
	 * Flash 자체의 객체 이벤트 처리시 오류가 발생함. (ie 8에서 발생)
	 * 
	 * Page 로딩 호출전에 SWFUpload의 Instance를 Destroy 하고,
	 * 페이지를 호출할 것. 
	 */
	uxl.ext.UploadDestroy = function(id){
		
		if(SWFUpload){
			// find instance
			for(var i=0; i<SWFUpload.movieCount; i++){
				var inst = SWFUpload.instances['SWFUpload_'+i];
				if(uxl.isNotNull(inst)){
					if(inst.settings.upload_id == id){
						inst.destroy();
						break;
					}
				}
			}
		}
		
	};
	
	uxl.ext.UploadDestroyAll = function(){
		
		if(SWFUpload){
			// find instance
			for(var i=0; i<SWFUpload.movieCount; i++){
				var inst = SWFUpload.instances['SWFUpload_'+i];
				if(uxl.isNotNull(inst)){
					inst.destroy();
				}
			}
		}
		
	};
	
	uxl.ext.Upload = function(id, options){
		
		var uploadOption = {
					 		  file_size_limit : 1024 * 100	// 100MB
							, allowFileType : "*.*"
							, file_upload_limit : 10
							, file_queue_limit : 10
							, uploadSuccessAfter : function(){}
							, removeAfter : function(){}
							, readOnly : false
		};
		
		options = $.extend(uploadOption, options);
		
		var settings = {
				 upload_id : id
			   , flash_url : uxl.getContextURL("/uxl/ext/swfupload/swfupload.swf")
			   , upload_url : uxl.getContextURL("/file/upload.")+ uxl.CONSTANT.URL_EXTENTION+'?attachType='+id
			   , file_size_limit : options.file_size_limit
			   , file_types : uxl.isEmpty(options.allowFileType)?'*.*':options.allowFileType
			   , file_types_description : uxl.isEmpty(options.allowFileType)?'All files':options.allowFileType
			   , file_upload_limit : options.file_upload_limit
			   , file_queue_limit : options.file_queue_limit
			   , custom_settings : {
		 			  progressTarget : 'uploadProgress_'+id
		 			, uploadedTarget : 'uploadedFiles_'+id
		 			, uploadSuccessAfter : options.uploadSuccessAfter
		 			, removeAfter : options.removeAfter
		 		 }
		       , debug: false
		       // Button settings
       		   , button_width: '69'
		 	   , button_height: '19'
		 	   , button_image_url : uxl.getContextURL("/uxl/ext/swfupload/img/upload.jpg")
		 	   , button_placeholder_id: 'btnUpload_'+id
		 	   , button_cursor: SWFUpload.CURSOR.HAND
		 	    // The event handler functions are defined in handlers.js
		 	   , file_queued_handler : fileQueued
		 	   , file_queue_error_handler : fileQueueError
		 	   , file_dialog_complete_handler : fileDialogComplete
		 	   , upload_start_handler : uploadStart
		 	   , upload_progress_handler : uploadProgress
		 	   , upload_error_handler : uploadError
		 	   , upload_success_handler : uploadSuccess
		 	   , upload_complete_handler : uploadComplete
		 	   , queue_complete_handler : queueComplete
		};
		
		if(options.file_upload_limit < 1){
			settings.button_disabled = true;
		}
		
		if(options.readOnly){
			settings.button_disabled = true;
		}
		
		this.id = id;
		this.options = options;
		
		this.SWFUpload = new SWFUpload(settings);
		
		if(settings.button_disabled){
			$('#'+this.SWFUpload.movieName).parent('.attachFile').css('padding-left','0');
			$('#'+this.SWFUpload.movieName).remove();
		}

		// 첨부파일 존재시 로드 처리
		if(uxl.isNotNull(fileDataList)){
			for (var i=0; i<fileDataList.length; i++) {
				if(fileDataList[i].attachType == this.id){
					// file handler bind
					var $fileItem = makeFileItem(fileDataList[i], this.options.readOnly, function() {
						this.SWFUpload.setButtonDisabled(false);
						this.SWFUpload.setFileUploadLimit(this.SWFUpload.settings.file_upload_limit + 1);
						
						if(!uxl.isBlank(this.SWFUpload.customSettings.removeAfter)){
							setTimeout(this.SWFUpload.customSettings.removeAfter+"();",100);
						}
					});
					
					// file handler append
					var target = this.SWFUpload.settings.custom_settings.uploadedTarget; 
					$('#'+target).append($fileItem.show());
				}
			}			
		}
		
		
		
	};
	
})(jQuery, uxl);