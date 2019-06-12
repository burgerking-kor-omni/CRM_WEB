/** 
 * @author (주)유비원 Framework Team
 * @version 1.2.0
 * 
 * Release Note
 * 
 * 1.2.0 : 
 *  - 핸들링 메세지를 설정값에 따라 보여질 수 있도록 fileQueueError / fileUploadError 메세지 정보 수정
 * 
 * 1.1.0 : 2015-11-12
 * 	- SWFUpload의 인코딩이 UTF-8로 고정되어 인코딩이 다른서버에서의 사용시 파일이 깨지는 현상에 대한 수정 처리
 *  - 업로드 성공 콜백 / 파일 삭제시 콜백 기능 보완 처리
 *         
 * 1.0.0 : 2014-12-17
 *  - Service 에러메시지 처리 로직 추가 - 체크 메세지 표출 기능 추가 (black/white list 관련 기능 수정)
 */
// file queued handler
function fileQueued(file) {
	try {
		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setStatus('wait...');
	}
	catch (ex) {
		uxl.error(ex);
	}
}
// file queue error handler
function fileQueueError(file, errorCode, message) {
	try {
		
		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setError();
		
		switch (errorCode) {
		case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
			progress.setStatus('파일 건당 크기 제한은 '+(this.settings.file_size_limit / 1024)+'MB 입니다.');
			break;
		case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
			progress.setStatus('Cannot upload Zero Byte files.');
			break;
		case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
			progress.setStatus('유효하지 않은 확장자 입니다.');
			break;
		case SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED:
			progress.setStatus('한번에 올릴 수 있는 파일 갯수 제한은 '+this.settings.file_queue_limit+'개 입니다.');	
			break;
		default:
			if(file !== null) {
				progress.setStatus('Unhandled Error');
			}
			break;
		}
	}
	catch (ex) {
		uxl.error(ex);
    }
	
	var progressTarget = this.customSettings.progressTarget;
	setTimeout(function () {
		$('#' + progressTarget).hide('fast');
	}, 3000);
}
// file dialog complete handler
function fileDialogComplete(numFilesSelected, numFilesQueued) {
	if (numFilesSelected > 0) {
		$('#' + this.customSettings.progressTarget).show('fast');
	}
	
	try {
		this.startUpload();
	}
	catch (ex)  {
		uxl.error(ex);
	}
}
// upload start handler
function uploadStart(file) {
	try {
		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setStatus('Uploading...');
	}
	catch (ex) {
		uxl.error(ex);
    }
	return true;
}
// upload progress handler
function uploadProgress(file, bytesLoaded, bytesTotal) {
	try {
		var percent = Math.ceil((bytesLoaded / bytesTotal) * 100);
		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setProgress(percent);
		progress.setStatus('Uploading...');
	}
	catch (ex) {
		uxl.error(ex);
	}
}
//upload success handler
function uploadSuccess(file, serverData) {
	try {
		var jsonData = uxl.str2Json(serverData);
		var result = new uxl.Result(jsonData);
		
		if(result.isSuccess()){
			var progress = new FileProgress(file, this.customSettings.progressTarget);
			progress.setComplete();
			progress.setStatus('Complete.');

			var fileInfo = result.getDataList('file_info');
			this.addFileLink(fileInfo);

			/* 1.1.0 - 성공 콜백 함수 기능 보완 처리 */
			var callback = this.customSettings.uploadSuccessAfter;
			if(uxl.isNotNull(callback) && uxl.isFunction(callback)){
				if(fileInfo.rowCount > 0){
					var row = fileInfo.rows[0];
					callback.call(this, row);
				}
			}
		}else{
			var progress = new FileProgress(file, this.customSettings.progressTarget);
			progress.setError();
			progress.setStatus(result.getMessage());
			
			alert(result.getMessage());
		}
	}
	catch (ex) {
		uxl.error(ex);
	}
}
// upload error handler
function uploadError(file, errorCode, message) {
	try {
		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setError();
		
		switch (errorCode) {
		case SWFUpload.UPLOAD_ERROR.HTTP_ERROR:
			progress.setStatus('Upload Error: ' + message);
			//progress.setStatus('파일 건당 크기 제한은 10MB 입니다.');
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_FAILED:
			progress.setStatus('Upload Failed.');
			break;
		case SWFUpload.UPLOAD_ERROR.IO_ERROR:
			progress.setStatus('Server (IO) Error');
			break;
		case SWFUpload.UPLOAD_ERROR.SECURITY_ERROR:
			progress.setStatus('Security Error');
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
			progress.setStatus('최대 '+this.settings.file_upload_limit+'개까지만 업로드가 가능합니다.');
			break;
		case SWFUpload.UPLOAD_ERROR.FILE_VALIDATION_FAILED:
			progress.setStatus('Failed Validation.  Upload skipped.');
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
			progress.setStatus('Stopped');
			break;
		default:
			progress.setStatus('Unhandled Error: ' + errorCode);
			break;
		}
	}
	catch (ex) {
		uxl.error(ex);
	}

	var progressTarget = this.customSettings.progressTarget;
	setTimeout(function () {
		$('#' + progressTarget).hide('fast');
	}, 3000);
}
// upload complete handler
function uploadComplete(file) {
	if (this.getStats().files_queued == 0) {
		var progressTarget = this.customSettings.progressTarget;
		setTimeout(function () {
			$('#' + progressTarget).hide('fast');
		}, 2000);
	}
}
// queue complete handler
function queueComplete(numFilesUploaded) {
}

function FileProgress(file, targetID) {
	file = file || {
		id : '_',
		name : ''};
	this.fileProgressID = file.id;
	this.height = 0;

	this.fileProgressWrapper = document.getElementById(this.fileProgressID);
	if (!this.fileProgressWrapper) {
		this.fileProgressWrapper = document.createElement('div');
		this.fileProgressWrapper.className = 'progressWrapper';
		this.fileProgressWrapper.id = this.fileProgressID;

		this.fileProgressElement = document.createElement('div');
		this.fileProgressElement.className = 'progressContainer';

		var progressCancel = document.createElement('a');
		progressCancel.className = 'progressCancel';
		progressCancel.href = '#';
		progressCancel.style.visibility = 'hidden';

		var progressText = document.createElement('div');
		progressText.className = 'progressName';
		progressText.appendChild(document.createTextNode(file.name));

		var progressBar = document.createElement('div');
		progressBar.className = 'progressBarInProgress';

		var progressStatus = document.createElement('div');
		progressStatus.className = 'progressBarStatus';
		progressStatus.innerHTML = '&nbsp;';

		this.fileProgressElement.appendChild(progressCancel);
		this.fileProgressElement.appendChild(progressText);
		this.fileProgressElement.appendChild(progressStatus);
		this.fileProgressElement.appendChild(progressBar);
		this.fileProgressWrapper.appendChild(this.fileProgressElement);
		document.getElementById(targetID).appendChild(this.fileProgressWrapper);
	} else {
		this.fileProgressElement = this.fileProgressWrapper.firstChild;
		this.reset();
	}
	this.height = this.fileProgressWrapper.offsetHeight;
}
FileProgress.prototype.reset = function () {
	this.fileProgressElement.className = 'progressContainer';

	this.fileProgressElement.childNodes[2].innerHTML = '&nbsp;';
	this.fileProgressElement.childNodes[2].className = 'progressBarStatus';
	
	this.fileProgressElement.childNodes[3].className = 'progressBarInProgress';
	this.fileProgressElement.childNodes[3].style.width = '0%';

	$(this.fileProgressElement).show('fast');
};
FileProgress.prototype.setProgress = function (percentage) {
	this.fileProgressElement.className = 'progressContainer progress_green';
	this.fileProgressElement.childNodes[3].className = 'progressBarInProgress';
	this.fileProgressElement.childNodes[3].style.width = percentage + '%';
	
	$(this.fileProgressElement).show('fast');
};
FileProgress.prototype.setComplete = function () {
	this.fileProgressElement.className = 'progressContainer progress_blue';
	this.fileProgressElement.childNodes[3].className = 'progressBarComplete';
	this.fileProgressElement.childNodes[3].style.width = '';
	
	var completeElement = this.fileProgressElement;
	setTimeout(function () {
		$(completeElement).hide('fast');
	}, 1000);
};
// 파일 사이즈 제한시 에러구문 보여주는 시간 설정
FileProgress.prototype.setError = function () {
	this.fileProgressElement.className = 'progressContainer progress_red';
	this.fileProgressElement.childNodes[3].className = 'progressBarError';
	this.fileProgressElement.childNodes[3].style.width = '';

	var completeElement = this.fileProgressElement;
	setTimeout(function () {
		$(completeElement).hide('fast');
	}, 3000);
};
FileProgress.prototype.setStatus = function (status) {
	this.fileProgressElement.childNodes[2].innerHTML = status;
};

/**
 * Upload 버튼을 클릭시 파일연결 정보를 생성하는 함수 (신규파일)
 */
SWFUpload.prototype.addFileLink = function (fileDataList) {	
	for (var i=0; i<fileDataList.rowCount; i++) {
		var swf = this;
		var row = fileDataList.rows[i];
		var $fileItem = makeFileItem(row, false, function() {
		
			/* 신규파일은 삭제시 서버로 파일정보를 삭제요청 */
			$.ajax({
				url : uxl.getContextURL('/file/remove.' + uxl.CONSTANT.URL_EXTENTION),
				data : { fileId : row.id }
			});
//TODO Non-Flash와 Flash 사용시의 오류 체크 확인 필요
//			swf.setFileUploadLimit(swf.settings.file_upload_limit + 1);
			
			/* 1.1.0 함수호출 유형 변경 처리 */
			var callback = swf.customSettings.removeAfter;
			if(uxl.isNotNull(callback) && uxl.isFunction(callback)){
				callback.call(swf, row);
			}
		});		
		$('#' + this.customSettings.uploadedTarget).append($fileItem);
		
		setTimeout(function () {
			$fileItem.show('fast');
		}, 1000);
	}
};

/**
 * 상세화면에서의 파일정보를 가져와서 로드할때 사용하는 함수
 */
function addFileLink(uploadedTarget, fileDataList, readOnly, swf) {
	if(fileDataList == null || fileDataList.rowCount == 0) {
		return;
	}
	
	for (var i=0; i<fileDataList.rowCount; i++) {
		var $fileItem = makeFileItem(fileDataList.rows[i], readOnly, function() {
			swf.setButtonDisabled(false);

//TODO Non-Flash와 Flash 사용시의 오류 체크 확인 필요
//			swf.setFileUploadLimit(swf.settings.file_upload_limit + 1);
			
			/* 1.1.0 함수호출 유형 변경 처리 */
			var callback = swf.customSettings.removeAfter;
			if(uxl.isNotNull(callback) && uxl.isFunction(callback)){
				callback.call(swf, row);
			}
		});
		$('#' + uploadedTarget).append($fileItem.show());
	}
};
function makeFileItem(fileInfo, readOnly, removeFunction) {
	
	// 1.1.0 : 파일인코딩 오류에 대한 처리
	fileInfo.fileName = decodeURIComponent(fileInfo.fileName);
	
	var fileUrl = uxl.getContextURL('/file/download.' + uxl.CONSTANT.URL_EXTENTION + '?fileId=' + fileInfo.id);
	var $fileItem = $('<div></div>', {
		'id' : 'file_' + fileInfo.id,
		'style' : 'display: none;'
	})
	.append('<img src="' + uxl.getContextURL('/uxl/ext/swfupload/img/icon_file.gif') + '"/>')
	.append(
		$('<a></a>', {
			'class' :  'file_link',
			'onmouseover' : 'window.status="";return true',
			'onmouseout' : 'window.status="";return true',
			'onClick' : 'location.href="'+ fileUrl +'"'
		})
		.append($('<span></span>').text(function() {
			var size = fileInfo.fileSize / 1024;
			if(size > 1024) {
				return fileInfo.fileName + '(' + (size / 1024).toFixed(1) + 'MB)';
			}
			else {
				return fileInfo.fileName + '(' + size.toFixed(1) + 'KB)';
			}
		}))
	)
	.append('<input type="hidden" name="file_info.id"    id="file_info.id"      value="' + fileInfo.id + '" />')
	.append('<input type="hidden" name="file_info.delYn" id="file_info.delYn" 	value="N" />')
	.append(function() {
		if(readOnly == false) {
			return $('<label id="removeThis" title="click to remove this file [' + fileInfo.fileName + ']" style="display:inline-block;"><span class="ui-icon ui-icon-close" style="cursor:pointer"/></label>')
				.click(function() {
//					$('#file_' + fileInfo.id).remove();
					
					// v1.1.0 수정사항
					var filePanel = $('#file_' + fileInfo.id); 
					filePanel.hide();
					$('input[id="file_info.delYn"]', filePanel).val("Y");
					
					removeFunction();
				})
				.hover(function(event) {
					$('span', this).toggleClass('ui-icon-closethick');
				});
		}
		return ;
	});
	return $fileItem;
};
