/*! 
 * Copyright (c) 2014 UBONE (http://www.ubqone.com)
 * 
 * File : uxl-ext-1.2.0.js
 * Version 1.2.0
 * Release List
 * 
 * 1.2.0 - 2017-04-14 : 
 *       1) Unique Id 체크 로직 추가
 *       2) 첨부파일 컨트롤의 attach_type 속성으로 처리하도록 변경, 설정이 안되어 있으면 id로 기존과 동일하게 처리
 *       3) 메타 첨부파일 템플릿 변경
 *				<div class="ub-control temp" style="border:2px solid gray;width:100%;height:80px;text-align:center;"><h3 style="padding-top:30px;padding-left:10px;padding-right:10px;">Attach File Control</h3></div>
 *				<span id="@id@" data-attach-type="@attach_type@" class="ub-control attachFile">
 *				   	<div class="filefieldset" id='uploadedFiles_@id@' ></div>
 *				   	<div class="filefieldset" id='uploadProgress_@id@' style="display:none;">
 *				   		<span class="legend">Uploading...</span>
 *				   	</div>
 *					<span id='btnUpload_@id@'></span> 
 *				</span>
 *                  
 * 1.1.0 - 2015-11-13 : SWFUpload 이벤트 바인딩 removeAfter / uploadSuccessAfter 옵션 Function Base로 사용할 수 있도록 변경
 */
(function($, uxl) {
	
	/**
	 * @class 탭 위젯 클래스<br/>
	 * @see uxl-ext-1.1.0.js
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
	
	/**
	 * SWFUpload 생성 함수
	 * @param id
	 * @param options
	 * 		- file_size_limit    : 업로드 사이즈 (단위 : KB)
	 * 		- allowFileType      : 업로드 파일 확장자 설정
	 *      - file_upload_limit  : 파일업로드 제한 건수
	 *      - file_queue_limit   : 동시업로드 제한 건수
	 *      - uploadSuccessAfter : 파일업로드 성공후 콜백함수 (this : SWFUpload Instance, f : FileInfo)
	 *      - removeAfter		 : 파일항목 삭제시 콜백함수   (this : SWFUpload Instance, f : FileInfo)
	 *      - readOnly           : 읽기전용 여부 (true/false)
	 */
	uxl.ext.Upload = function(id, options){
		
		var uploadOption = {
					 		  file_size_limit : 1024 * 100	// 100MB
							, allowFileType : "*.*"
							, file_upload_limit : 10
							, file_queue_limit : 10
							, uploadSuccessAfter : null
							, removeAfter : null
							, readOnly : false
		};
		
		options = $.extend(uploadOption, options);
		
		// 컨트롤의 data-attach-type 속성이 존재하면 해당 값으로 설정하고, 존재하지 않으면 id 값으로 attach-type으로 설정한다.
		this.attachType = $('.ub-control.attachFile[id='+id+']').attr('data-attach-type');
		if(uxl.isEmpty(this.attachType)){
			this.attachType = id;
		}
		
		var settings = {
				 upload_id : id
			   , flash_url : uxl.getContextURL("/uxl/ext/swfupload/swfupload.swf")
			   , upload_url : uxl.getContextURL("/file/upload.")+ uxl.CONSTANT.URL_EXTENTION+'?attachType='+this.attachType
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
		
		// 첨부파일의 객체 중복은 업로드 버튼이름으로 체크한다.
		if(!uxl.isUniqueId(settings.button_placeholder_id)){
			alert('첨부파일 객체의 ID가 중복되었습니다. 확인후 조정해주세요. :: '+id);
			return;
		}
		
		if(options.file_upload_limit < 1){
			settings.button_disabled = true;
		}
		
		if(options.readOnly){
			settings.button_disabled = true;
		}
		
		this.id = id;
		this.options = options;
		
		this.SWFUpload = new SWFUpload(settings);
		
		swf = this.SWFUpload;
		
		if(settings.button_disabled){
			$('#'+swf.movieName).parent('.attachFile').css('padding-left','0');
			$('#'+swf.movieName).remove();
		}

		// 첨부파일 존재시 로드 처리
		if(uxl.isNotNull(fileDataList)){
			for (var i=0; i<fileDataList.length; i++) {
				var row = fileDataList[i];
				if(row.attachType == this.attachType){
					// file handler bind
					var $fileItem = makeFileItem(row, this.options.readOnly, function() {
						swf.setButtonDisabled(false);
						swf.setFileUploadLimit(swf.settings.file_upload_limit + 1);
						
						/* 1.1.0 함수호출 유형 변경처리 */
						var callback = swf.customSettings.removeAfter;
						if(uxl.isNotNull(callback) && uxl.isFunction(callback)){
							callback.call(swf, row);
						}
					});
					
					// file handler append
					var target = swf.settings.custom_settings.uploadedTarget; 
					$('#'+target).append($fileItem.show());
				}
			}			
		}
	};
	
})(jQuery, uxl);