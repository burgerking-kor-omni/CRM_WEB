	// ---------------------------------------------------------
	// VOC 클래스
	// ---------------------------------------------------------
	function VocClass() {	

		// VOC 화면 모드
		this.voc_dtl_mode = $('#TP_VOC_MODE').val();
		
		// VOC 상태
		this.voc_stat_code = $('#TP_VOC_STATUS').val();

		// 등록화면여부
		this.isRegisterMode = (this.voc_dtl_mode == "REGIST");

		// 조회전용여부
		this.viewMode = false;
		
		// 화면초기화 설정
		this.setInit();
		
		//이미지조회버튼 권한 설정, 권한자 : VOC마스터
		this.privilegeImageSearch();
		
		//임시저장버튼 제거
		this.hideTemporaryButton();
		
		//수동이메일통보버튼 감춤
		this.hideManualButton();
		
	}		
	
	//이미지조회버튼 권한 설정, 권한자 : VOC마스터
	VocClass.prototype.privilegeImageSearch = function(){
		if(AUTH_IS_PROJECT_MANAGER){
			$('button[name=btnImageSearch]').show();
		}else{
			$('button[name=btnImageSearch]').hide();
		}
	}
	
	// 임시저장버튼 제거
	VocClass.prototype.hideTemporaryButton = function(){
		$('button[name=insertBtn][title=임시저장]').remove();
	}
	
	// 수동이메일통보버튼 감춤
	VocClass.prototype.hideManualButton = function(){
		$('button[name=btnNoticeEMAIL]').remove();
	}
	
	// 화면초기화 설정
	VocClass.prototype.setInit = function (){
		 
		 this.setButton();
		 
		 this.setDate();
		 
		 this.setVocType();
		 
		 //계약관련 설정 컨트롤 숨기기
		 $('input[name=isCopyRow]').hide();

		//답변템플릿 숨김
		$('#REPLY_TEMPLATE').hide();

		// 등록/임시저장 상태에서만 즉시처리 제어함.
		if(this.voc_dtl_mode == "REGIST" || this.voc_dtl_mode == "REGISTER_TEMP"){
			//즉시처리 정보 숨기기
			 if($('#ACTInform').contents().find('#FG_VOC_AFTER').val() != "Y"){
				 this.setDirectComplete(false);
			 }else{
				 this.setDirectComplete(true);
			 }
		}else if(this.voc_dtl_mode == "RECEIPT"){
			// 접수상세화면은 조회용 모드로 설정
			this.viewMode = true;
		}else if(this.voc_dtl_mode == "PROGRESS"){
			$('#SEARCH_USER').finder();
		}else if(this.voc_dtl_mode == "VIEW"){
			this.viewMode = true;
		}
		
		// 조회모드일 경우: 이미지조회 버튼만 보임, 수정모드일 경우: 이미지 등록, 조회버튼 모두 보임
		if( this.viewMode ){
			$('#btnImageRegist').hide();
		}
	 }
	 
	// 계약유형에 따른 계약목록 항목명 설정
	VocClass.prototype.setContractLabel = function(){
		// 등록모드일 경우는 "계약"으로 기본 설정
		if(this.isRegisterMode){
			$('#TP_CONTRACT').val("01");
			$('#TP_CONTRACT').click();
		}
		
		
	}
	// 즉시처리 입력항목 조절
	VocClass.prototype.setDirectComplete = function(visibility){
		if(visibility){
			$('#layout-2_2').show();
			$('#layout-2_3').show();
			$('#layout-2_4').show();
			$('#layout-2_5').show();

			$('#SEARCH_USER').finder();
			$('#btnEssential').show();
		}else{
			$('#layout-2_2').hide();
			$('#layout-2_3').hide();
			$('#layout-2_4').hide();
			$('#layout-2_5').hide();
			$('#btnEssential').hide();
		}
	}
	
	// 날짜 필드 Validation 설정
	VocClass.prototype.setDate = function (){
		var TODAY = $('#DT_TODAY').val();
		
		// 날짜 필드 입력 제한 (오늘 날짜 이후 입력 금지)
		$('#DT_SEND_ORGAN').datepicker({maxDate: TODAY});
		$('#DT_RECV_ORGAN').datepicker({maxDate: TODAY});
		$('#DT_END').datepicker({maxDate: TODAY});
		
		// 입력필드의 수기입력 시 체크 
		$('#DT_SEND_ORGAN').change(function(){
			var ret = checkDate("DT_SEND_ORGAN", "발송일자", this.value, TODAY);
		});
		$('#DT_RECV_ORGAN').change(function(){
			var ret = checkDate("DT_RECV_ORGAN", "접수일자", this.value, TODAY);
		});
		$('#DT_END').change(function(){
			var ret = checkDate("DT_END", "처리일자", this.value, TODAY);
		});
		
		// 날짜 체크 함수
		checkDate = function(controlName, controlLabel, value, basis){
			if(value=="") {
				return;
			}
			
			// 날짜 비교
			var interval = DateUtil.getDayInterval(value, basis);

			// -일 경우, 오늘날짜보다 입력된 날짜가 큼
			if( interval < 0){
				$('input[name=' + controlName + ']').val("");		// 값을 먼저 초기화 하여야 함.
				alert(controlLabel + "는 오늘보다 이후 날짜는 입력할 수 없습니다.");
			}
		};
	}
	
	// 버튼 초기화 설정
	VocClass.prototype.setButton =  function (){
		if(this.voc_dtl_mode=="REGIST" || this.voc_dtl_mode=="REGISTER_TEMP" || this.voc_dtl_mode=="PROGRESS" ){
			// 관련자 추가 버튼 Binding
			$('#btnRelationAdd').click(function(){
				var searchUserId = $('#SEARCH_USER').val();
				var searchUserNm = $('#SEARCH_USER_DISPLAY').val();
				
				$("#RELATION_LIST").append("<option value='"+searchUserId+"'>"+searchUserNm +"(" + searchUserId + ")" +"</option>");
				
				jQuery.finder.removeItem('SEARCH_USER');
			});
			
			
			// 관련자 삭제 버튼 Binding
			$('#btnRelationDelete').click(function(){
				var selectedIndex = $("#RELATION_LIST option").index($("#RELATION_LIST option:selected"));
				
				if(selectedIndex < 0){
					alert('삭제하고자 하는 관련자를 선택하시기 바랍니다.');
					return;
				}
				
				$("#RELATION_LIST option:eq("+ selectedIndex +")").remove();

			});
		}
		
		if(this.isRegisterMode){   // 등록
			
			// 관련자 삭제 버튼 Binding
			$('#btnRelationDelete').click(function(){
				var selectedIndex = $("#RELATION_LIST option").index($("#RELATION_LIST option:selected"));
				
				if(selectedIndex < 0){
					alert('삭제하고자 하는 관련자를 선택하시기 바랍니다.');
					return;
				}
				
				$("#RELATION_LIST option:eq("+ selectedIndex +")").remove();

				});
			
	    	// VOC임시저장 처리 호출
	    	/*var option = uxl.Page.makeServiceEventOption('REGIST', {
				validator: function(data, targetForm) {
					if(uxl.validateBasicInput(targetForm) && voc.checkValidation("REGIST")) {
						return true;	
					}
					return false;
				},
				serviceStart: function(data) {
					//저장전 관련자 컨트롤에 입력된 정보를 select한다. 
					$('#RELATION_LIST option').attr("selected","selected");
				},
				message: {
					confirm: uxl.getMessage('@message.voc.process.confirm', '임시저장')
				},
				success: function(result) {
						uxl.moveLocation(uxl.getScreenURL('VOC0041') + "?ID_VOC=" +result.getResultKey() + "&TP_VOC_MODE=REGISTER_TEMP" );  // 임시저장 상세로 이동
				}
	        });
			uxl.Page.bindServiceEvent('REGIST', option);*/
			
	    	// VOC접수등록 처리 호출(USERDEFINED1) binding
			var option_userdefined1 = {
				eventTarget : 'btnReceipt',
				eventType : 'click',
				formName: 'detailForm',
				validator: function(data, targetForm) {
					if(uxl.validateBasicInput(targetForm) && voc.checkValidation("RECEIPT")) {
						return true;	
					}
					return false;
				},		
				serviceStart: function(data) {
					//저장전 관련자 컨트롤에 입력된 정보를 select한다. 
					$('#RELATION_LIST option').attr("selected","selected");
				},
				message: {
					confirm: uxl.getMessage('@message.voc.process.confirm', '접수등록')
				},
				success: function(result) {
					if( $('#FG_VOC_AFTER').val() != "Y"){  // 즉시처리아닐경우
						// 2013 - 03 - 08 (당사유선, 당사인터넷, 당사서류, 당사방문)만 문자발송 제한 :: 최초 등록일 경우 SMS발송으로 변경 현업요청
						// 코드 : C01, C02, C03, C04
						if( $('#TP_CHNN_PATH').val() == "C01" ||  $('#TP_CHNN_PATH').val() == "C02" || $('#TP_CHNN_PATH').val() == "C03" || $('#TP_CHNN_PATH').val() == "C04"){
							// 등록 SMS 발송
							var datalist = result.getDataList(0);
							var id_voc = datalist.rows[0].ID_VOC;
							var nm_emp_act = datalist.rows[0].NM_EMP_ACT;
							dispRecvCustSet("03", id_voc, nm_emp_act);
//							dispRecvCustSet("03", result.getResultKey());
						}
						uxl.moveLocation(uxl.getScreenURL('VOC0042') + "?ID_VOC=" +result.getResultKey()+ "&TP_VOC_MODE=RECEIPT" );    // 접수상세로 이동
					}else{ // 즉시처리할경우
						uxl.moveLocation(uxl.getScreenURL('VOC0042') + "?ID_VOC=" +result.getResultKey()+ "&TP_VOC_MODE=RECEIPT" );    // 접수상세로 이동
					}
					/*2013 - 03 - 08 종결 SMS 발송 안함
					else{
						dispRecvCustSet("04", result.getResultKey());
					}*/
				}
			};
			uxl.Page.bindServiceEvent('USERDEFINED1', option_userdefined1);
		}else{   // 임시저장, 접수
			if(this.voc_dtl_mode=="REGISTER_TEMP" || this.voc_dtl_mode=="RECEIPT"){
				var mode = this.voc_dtl_mode;
				// 접수버튼
				var option_userdefined1 = {
					eventTarget : 'btnReceipt',
					eventType : 'click',
					formName: 'detailForm',
					validator: function(data, targetForm) {
						if(uxl.validateBasicInput(targetForm) && voc.checkValidation("RECEIPT")) {
							return true;	
						}
						return false;
					},		
					serviceStart: function(data) {
						//저장전 관련자 컨트롤에 입력된 정보를 select한다. 
						$('#RELATION_LIST option').attr("selected","selected");
					},
					message: {
						confirm: uxl.getMessage('@message.voc.process.confirm', '접수등록')
					},
					success: function(result) {
						if(mode == "REGISTER_TEMP"){
							if( $('#FG_VOC_AFTER').val() != 'Y' ){   // 즉시처리 아닐경우
								uxl.moveLocation(uxl.getScreenURL('VOC0042') + "?ID_VOC=" +result.getResultKey()+ "&TP_VOC_MODE=RECEIPT" );    // 접수상세로 이동
							}
							/*2013 - 03 - 08 종결 SMS 발송 안함
							else{								
								dispRecvCustSet("04", result.getResultKey());
							}*/
							
						}
						/* 2013 - 03 - 08 등록 SMS 발송 최초등록시로 변경
						else if(mode == "RECEIPT"){
							dispRecvCustSet("03", result.getResultKey());
						}*/
						
					}
				};
				uxl.Page.bindServiceEvent('USERDEFINED1', option_userdefined1);
			}
			
			if(this.voc_dtl_mode=="REGISTER_TEMP" || this.voc_dtl_mode=="PROGRESS"){
				var mode = this.voc_dtl_mode;
				// 수정버튼
		    	var option = uxl.Page.makeServiceEventOption('MODIFY', {
					validator: function(data, targetForm) {
						if(uxl.validateBasicInput(targetForm) && voc.checkValidation("UPDATE")) {
							return true;
						}
						return false;
					},
					serviceStart: function(data) {
						//저장전 관련자 컨트롤에 입력된 정보를 select한다. 
						$('#RELATION_LIST option').attr("selected","selected");
						
					},
					message: {
						confirm: uxl.getMessage('@message.voc.process.confirm', '수정')
					},
					success: function(result) {
						if(mode == "REGISTER_TEMP"){
							uxl.moveLocation(uxl.getScreenURL(_SCREEN_ID) + '?ID_VOC=' + $('#ID_VOC').val() + "&TP_VOC_MODE=REGISTER_TEMP" );  // 임시저장
						}else{
							uxl.moveLocation(uxl.getScreenURL(_SCREEN_ID) + '?ID_VOC=' + $('#ID_VOC').val() + "&TP_VOC_MODE=PROGRESS" );  // 처리상세
						}
					}
		        });
				uxl.Page.bindServiceEvent('MODIFY', option);
			}
			
			if(this.voc_dtl_mode=="REGISTER_TEMP"){
				// 삭제버튼
				var option = uxl.Page.makeServiceEventOption('REMOVE', {
					validator: function(data, targetForm) {
					},
					message: {
						confirm: uxl.getMessage('@message.voc.process.confirm', '삭제')
					},
					success: function(result) {
						self.close();   
					}
		        });
				uxl.Page.bindServiceEvent('REMOVE', option);
			}
			
			if(this.voc_dtl_mode=="PROGRESS"){
				// 결재상신 버튼
				$("#btnApprove").click(function(){
					var ID_VOC = $("#ID_VOC").val();
					var data={
							 ID_VOC :  ID_VOC
					};
					alert("[TODO]결재 연계 작업 이후");
					//heungkuk.fnApprovePop('',data);
				});
				
				// 처리완료 버튼
				var option = uxl.Page.makeServiceEventOption('COMPLETE', {
					validator: function(data, targetForm) {
						var Assist = true;
						//처리완료 버튼 클릭시 업무협조중이면 처리완료가 안되게 하는 부분
				 		uxl.ajaxQuery('SVCBCO0011'
				 		              , { 
				 		                  ID_VOC : $('#ID_VOC').val()
										}
									  , function(result) {
											var dataList = result.getDataList('VocActivity.getListAssist');
											var rows = dataList.rows;
											for(var i in rows){
												var checkAssist = rows[i].TP_VOC_ACT_STATUS;
												
												//01 : 요청중, 02 : 접수, 03 : 처리중
												if(checkAssist == '01' || checkAssist == '02' || checkAssist == '03' ){
													//업무협조 상태가 요청중,접수,처리중일 경우 처리완료 불가이므로, false를 반환함. 
													Assist = false;
													break;
												}
											}
										}
									  , false);
				 		//업무협조 상태가 요청중,접수,처리중이 아닐경우(true일 경우) validation 체크를 한다.
				 		if(Assist){
				 			if(uxl.validateBasicInput(targetForm) && voc.checkValidation("UPDATE")) {
								return true;
							}
							return false;
				 		}
				 		else{
				 			uxl.showMessage('업무협조 요청완료 후 처리완료가 가능합니다.');
				 			return false;
				 		}
					},
					serviceStart: function(data) {
						//저장전 관련자 컨트롤에 입력된 정보를 select한다. 
						$('#RELATION_LIST option').attr("selected","selected");
						
					},
					message: {
						confirm: uxl.getMessage('@message.voc.process.confirm', '완료')
					},
					success: function(result) {
						//2013 - 03 - 08 종결 SMS 발송 안함
						//dispRecvCustSet("04", result.getResultKey());
					}
		        });
				uxl.Page.bindServiceEvent('COMPLETE', option);
			}
			// 취하버튼
			
			// 이관요청버튼
			if(this.voc_dtl_mode=="RECEIPT" || this.voc_dtl_mode=="PROGRESS"){
				$("#btnTransfer").click(function(){
					var ID_VOC = $("#ID_VOC").val();
					var data={
							 ID_VOC :  ID_VOC
							,TP_VOC_ACT : 'TRANSFER'
							,TP_BIZ_REQ : 'T12'
							,TP_VOC_ACT_STATUS : '01'
							,TP_VOC_MODE : 'CALL'
					};
					heungkuk.fnTransferReqPop('',data);
					
				});
				
				// VOC처리이력 조회 버튼
				$("#btnHistory").click(function(){
					var ID_VOC = $("#ID_VOC").val();
					var data={
							 ID_VOC :  ID_VOC
					};
					heungkuk.fnViewHistoryPop('',data);
					
				});
			}
			
			
			if(this.voc_dtl_mode == "VIEW"){
				// VOC처리이력 조회 버튼
				$("#btnHistory").click(function(){
					var ID_VOC = $("#ID_VOC").val();
					var data={
							 ID_VOC :  ID_VOC
						};
					heungkuk.fnViewHistoryPop('',data);
				});
			}
		}
		
		
		// 계약유형 선택 Radio 버튼
		this.changeContractType = $('input[name=TP_CONTRACT]').click(function() {
			//현재 계약갯수 체크
			var i = 0;
			$('input[name=NO_CONTRACT]').each(function(idx){
				i = idx ;
			});

			//라디오버튼 클릭시 클릭된값과 기존값이 같지 않을때만 삭제로직을 탄다.
			if(this.value != $('#TP_CONTRACT_PREV').val()){
				//계약이 하나라도 있을경우
				if(i != 0){
					if(confirm("계약구분 변경시 계약이 삭제됩니다. 계속하시겠습니까?")){
						//계약삭제
						$("input:radio[name=NO_CONTRACT]").each(function(idx){
							if(idx > 0){
								$('input:radio[name=NO_CONTRACT]').click();
								var selectRow =  $("input:radio[name=NO_CONTRACT]:checked").parent();
								var selectContractNo = $('#ID_CONTRACT', selectRow).val();
								
								contract.remove(selectContractNo);
							}
						});
						
						
						//계약구분에 따른 label 설정
						if(this.value == '02'){
							$('#lblCONTRACT_NO nobr').text('사고번호');
							$('#lblCONTRACT_DT nobr').text('사고일');
							$('#lblCONTRACT_CUST nobr').text('계약자');
							$('#lblCOLLECT nobr').text('취급지점');
							$('#lblMANAGING nobr').text('보상팀');
							$('#lblMANAGE_TEAM nobr').text('보상팀');
							$('#lblMANAGE_EMP nobr').text('담당자');
						}else {
							$('#lblCONTRACT_NO nobr').text('계약번호');
							$('#lblCONTRACT_DT nobr').text('계약일');
							$('#lblCONTRACT_CUST nobr').text('계약자');
							$('#lblCOLLECT nobr').text('모집지점');
							$('#lblMANAGING nobr').text('수금지점');
							$('#lblMANAGE_TEAM nobr').text('수금지점');
							$('#lblMANAGE_EMP nobr').text('취급자');
						}
						
						//계약구분에 따른 버튼 설정
						if(this.value =="03" || this.value=="04"){
							
							if(confirm("[계약없음]으로 추가하시겠습니까?")){
								$("#btnSearchContract").click();
								$("#btnSearchContract").hide()
								$("#btnDeleteContract").hide();
							}else{
								$("#TP_CONTRACT").val("01");
								$("#TP_CONTRACT").click();
								$("#btnSearchContract").show();
								$("#btnDeleteContract").show();
							}
						}else{
							$("#btnSearchContract").show();
							$("#btnDeleteContract").show();
						}
						
						//라디오버튼 클릭시 클릭된 값을 기존값변수에 셋팅
						$('#TP_CONTRACT_PREV').val(this.value);
						
					}
					else{
						//취소시 라디오버튼 클릭전으로 돌아감
						var idx = $('#TP_CONTRACT_PREV').val().substr(1,2);
						
						$('input[type=radio][name=TP_CONTRACT]')[idx-1].checked=true;
					} // TODO : if(confirm("계약구분 변경시 계약이 삭제됩니다. 계속하시겠습니까?")){ 가 시작
					
				}
				else{
					//계약구분에 따른 label 설정
					if(this.value == '02'){
						$('#lblCONTRACT_NO nobr').text('사고번호');
						$('#lblCONTRACT_DT nobr').text('사고일');
						$('#lblCONTRACT_CUST nobr').text('계약자');
						$('#lblCOLLECT nobr').text('취급지점');
						$('#lblMANAGING nobr').text('보상팀');
						$('#lblMANAGE_TEAM nobr').text('보상팀');
						$('#lblMANAGE_EMP nobr').text('담당자');
					}else {
						$('#lblCONTRACT_NO nobr').text('계약번호');
						$('#lblCONTRACT_DT nobr').text('계약일');
						$('#lblCONTRACT_CUST nobr').text('계약자');
						$('#lblCOLLECT nobr').text('모집지점');
						$('#lblMANAGING nobr').text('수금지점');
						$('#lblMANAGE_TEAM nobr').text('수금지점');
						$('#lblMANAGE_EMP nobr').text('취급자');
					}
					
					//계약구분에 따른 버튼 설정
					if(this.value =="03" || this.value=="04"){
						
						if(confirm("[계약없음]으로 추가하시겠습니까?")){
							$("#btnSearchContract").click();
							$("#btnSearchContract").hide()
							$("#btnDeleteContract").hide();
						}else{
							$("#TP_CONTRACT").val("01");
							$("#TP_CONTRACT").click();
							$("#btnSearchContract").show();
							$("#btnDeleteContract").show();
						}
					}else{
						$("#btnSearchContract").show();
						$("#btnDeleteContract").show();
					}
					
					//라디오버튼 클릭시 클릭된 값을 기존값변수에 셋팅
					$('#TP_CONTRACT_PREV').val(this.value);
				} // TODO : if(i != 0){ 가 시작 
				
			}

		});
		
		// 즉시처리 버튼
		this.completButton = $('#ACTInform').contents().find('#FG_VOC_AFTER').click(function(){
			if($('#ACTInform').contents().find('#FG_VOC_AFTER').checked) {
				$('#ACTInform').contents().find('#FG_VOC_AFTER').value = "Y";
			}else{
				$('#ACTInform').contents().find('#FG_VOC_AFTER').value = "N";
			}
			voc.setDirectComplete($('#ACTInform').contents().find('#FG_VOC_AFTER').checked);
		});
		
		// 계약자의 상담이력 조회 버튼
		this.viewCallHistory = $('#btnSearchCallHistory').click(function(){
			alert('[TODO]상담이력 연계 작업 이후');
			return;
			var selectCust = "";
			heungkuk.fnCounselListPop()
		});
		
		// 새로고침 버튼 클릭
		this.refreshWindow = $('#btnRefresh').click(function(){
			uxl.reload();
		});
		
		// 이메일 콤보 
		this.changeEmail = $('#TP_EMAIL').change(function(){
			//콤보값 텍스트
		    var EMAIL = $("#TP_EMAIL option:selected").val();
		     
		    //이메일주소부분에 값 셋팅
		    $("#DS_EMAIL_DOMAIN").val(EMAIL);
		  
		    //콤보값 변경에 따라 이메일주소부분 속성 변경
		    if($('#TP_EMAIL').val() == ''){
		    	$("#DS_EMAIL_DOMAIN").attr('readOnly', false);
		    }
		    else{
		    	$("#DS_EMAIL_DOMAIN").attr('readOnly', true);
		    }
		});
		
		// 우편번호 검색
		this.searchZip1 = $('#btnSearchZip1').click(function(){
			heungkuk.fnPostListPop("1");
		});
		
		this.searchZip2 = $('#btnSearchZip2').click(function(){
			heungkuk.fnPostListPop("2");
		});
		
		this.searchZip3 = $('#btnSearchZip3').click(function(){
			heungkuk.fnPostListPop("3");
	    });
		
		// 계약 조회 버튼 
		this.searchContract = $('#btnSearchContract').click(function() {
			var contract_type = $("input[name='TP_CONTRACT']:checked").val();
			var regident_id = $('#searchCondition').val();
			
			if(util.isNotEmpty(contract_type)){
				
				if(contract_type=="03"){
					// 입력된 계약이 있는지 체크
					if($("#ID_CONTRACT:visible").size()>0){
						alert("입력된 계약이 있습니다. [계약없음]으로 입력하시려면 기존의 계약을 삭제하신 후 입력하시기 바랍니다.");
						return;
					}
					
					// 대출일 경우, 계약없음으로 입력
					var contractParam = {
							NO_CONTRACT			: DummyContract.NO_CONTRACT, 
							ID_CONTRACT			: DummyContract.NO_CONTRACT,
							TP_CONTRACT			: DummyContract.TP_CONTRACT,
							NM_CONTRACT			: DummyContract.NO_CONTRACT,
							NM_PRODUCT			: DummyContract.NM_PRODUCT,
							DT_CONTRACT			: DummyContract.ETC, 
							NM_CUST_CONTRACT	: DummyContract.ETC,
							NM_DEPT_COLLECT		: DummyContract.ETC,
							NM_EMP_COLLECT		: DummyContract.ETC,
							NM_DEPT_COMP		: DummyContract.ETC,
							NM_EMP_COMP			: DummyContract.ETC,
							CONTRACT_PARAM    : DummyContract.param
						};
						
						contract.add(contractParam, DummyCustomer.param);
				}else if(contract_type=="04"){
				
					// 입력된 계약이 있는지 체크
					if($("#ID_CONTRACT:visible").size()>0){
						alert("입력된 계약이 있습니다. [계약없음]으로 입력하시려면 기존의 계약을 삭제하신 후 입력하시기 바랍니다.");
						return;
					}
					
					// 기타일 경우, 계약없음으로 입력
					var contractParam = {
							NO_CONTRACT			: DummyContractSecond.NO_CONTRACT, 
							ID_CONTRACT			: DummyContractSecond.NO_CONTRACT,
							TP_CONTRACT			: DummyContractSecond.TP_CONTRACT,
							NM_CONTRACT			: DummyContractSecond.NO_CONTRACT,
							NM_PRODUCT			: DummyContractSecond.NM_PRODUCT,
							DT_CONTRACT			: DummyContractSecond.ETC, 
							NM_CUST_CONTRACT	: DummyContractSecond.ETC,
							NM_DEPT_COLLECT		: DummyContractSecond.ETC,
							NM_EMP_COLLECT		: DummyContractSecond.ETC,
							NM_DEPT_COMP		: DummyContractSecond.ETC,
							NM_EMP_COMP			: DummyContractSecond.ETC,
							CONTRACT_PARAM    : DummyContractSecond.param
					};
					
					contract.add(contractParam, DummyCustomer.param);
				}else if(contract_type == "01" || contract_type == "02"){
					if($('input[name="ID_CONTRACT"][value="NO"]').size()>0){
						alert("입력된 [계약없음]을 삭제하신 후, 입력하시기 바랍니다.");
						return;
					}
					
					if(contract_type == "01"){
						//계약 검색 팝업 호출
						heungkuk.fnContractListPop();
					}else if(contract_type == "02"){
						//보상 검색 팝업 호출
						heungkuk.fnRewardListPop();
					}						
				}else{
					alert('검색할 계약구분을 선택하시기 바랍니다.');
					return;
				}
			}else{
				alert('검색할 계약구분을 선택하시기 바랍니다.');
				return;
			}
				
		});
		
		// 계약 삭제 버튼
		this.deleteContract = $('#btnDeleteContract').click(function(){
			var selectRow =  $("input:radio[name=NO_CONTRACT]:checked").parent();
			var selectContractNo = $('#ID_CONTRACT', selectRow).val();
			
			
			if(util.isUndefined(selectContractNo)){
				alert('삭제하고자 하는 계약을 선택하시기 바랍니다.');
				return;
			}else{
				contract.remove(selectContractNo);
			}
		});
		
		// 이미지 등록 버튼
		this.imageRegist = $('#btnImageRegist').click(function(){
			var voc_mode 		= $('#TP_VOC_MODE').val();
			var DOC_KEY 		= "";
			var DOC_CLS_CD  	= "";
			var DOC_TYPE_CD	= "";
			var WORK_TYPE 	= "";
			var data				= "";
			
			//변수 셋팅
			if(voc_mode == "REGIST"){
				DOC_KEY			= "1000000215";
				WORK_TYPE		= "SCAN";
				
				data ={
						DOC_KEY			: DOC_KEY,
						WORK_TYPE		: WORK_TYPE
				};
				
			}
			else{
				DOC_KEY			= $('#ID_VOC').val();
				WORK_TYPE		= "DOCVIEW";
				DOC_CLS_CD  	= "001";
				DOC_TYPE_CD	= "001";
			
				data ={
						DOC_KEY			: DOC_KEY,
						DOC_CLS_CD		: DOC_CLS_CD,
						DOC_TYPE_CD	: DOC_TYPE_CD,
						WORK_TYPE		: WORK_TYPE
				};
				
			}
			
			heungkuk.fnImageSystemPop('',data);
			
		});
		
		// 이미지 등록 버튼
		this.imageRegist = $('#btnImageRegist').click(function(){
			var DOC_KEY 		= "";
			var WORK_TYPE 	= "";
			var data				= "";
			
			DOC_KEY			= $('#ID_VOC').val();
			WORK_TYPE		= "SCAN";
			
			data ={
					DOC_KEY			: DOC_KEY,
					WORK_TYPE		: WORK_TYPE
			};
			
			heungkuk.fnImageSystemPop('',data);
			
		});
		
		// 이미지 조회 버튼
		this.imageRegist = $('#btnImageSearch').click(function(){
			var DOC_KEY 		= "";
			var DOC_CLS_CD  	= "";
			var DOC_TYPE_CD	= "";
			var WORK_TYPE 	= "";
			var data				= "";

			DOC_KEY			= $('#ID_VOC').val();
			WORK_TYPE		= "DOCVIEW";
			DOC_CLS_CD  	= "001";
			DOC_TYPE_CD	= "001";
		
			data ={
					DOC_KEY			: DOC_KEY,
					DOC_CLS_CD		: DOC_CLS_CD,
					DOC_TYPE_CD	: DOC_TYPE_CD,
					WORK_TYPE		: WORK_TYPE
			};
			
			heungkuk.fnImageSystemPop('',data);
			
		});
		
		// 통합 고객 확인 버튼
		this.searchCustomer = $('#btnSearchCust').click(function(){
			heungkuk.fnCustomerSearchPop();
		});
		
		// 녹취듣기 팝업 호출 버튼
		this.searchCallHistory = $('#btnCTIRecord').click(function(){
			/*  TODO : 사번 안넘기기로 함(허융부장). 2012-07-23. 
			var loginId = $('#loginId').val();
			var data={
					userid :  loginId
			};
			*/
			heungkuk.fnCTIRecordPop();
			
		});
		
		// 소송조회 팝업 호출 버튼
		this.searchLawsuit = $('#btnSearchLawsuit').click(function(){
			if($('#ID_CUST').val() == ""){
	    		uxl.showMessage('선택된 신청인이 없습니다. 통합고객확인 버튼을 클릭하여 해당 고객을 검색한 후 선택하시기 바랍니다.');
	    	}
			else{
				heungkuk.fnLwsSearchCallPop();
			}
			
		});
		
		// 계약자의 VOC이력 조회 버튼
		this.viewVocHistoryByContract = $('#btnSearchHistoryContract').click(function(){
			var selectRow =  $("input:radio[name=NO_CONTRACT]:checked").parent();
			
			if($("input:radio[name=NO_CONTRACT]:checked").length == 0){
				alert('선택된 계약이 없습니다. ');
				return;
			}
			
			var ID_CUST = $.trim($('#CONTRACT_REGIDENT',selectRow).val());

			if(uxl.isEmpty(ID_CUST)){
				alert('계약자가 없거나 계약없음을 선택하셨습니다.');
				return;
			}
			var data = {
					ID_CUST : ID_CUST
				}
			heungkuk.fnCustListPop('',data);
		});
		
		// 신청자의 VOC이력 조회 버튼
		this.viewVocHistoryByRequest = $('#btnSearchHistoryRequest').click(function(){
			var ID_CUST = $.trim($('#ID_CUST').val());
			var ID_CUST_REGIDENT = '';
			var NM_CUST = '';
			if(uxl.isEmpty(ID_CUST)){
				ID_CUST_REGIDENT = $.trim($('#ID_CUST_REGIDENT').val());
				if(uxl.isEmpty(ID_CUST_REGIDENT)){
					NM_CUST = $.trim($('#NM_CUST').val()) || $.trim($('input[name=NM_CUST]').attr('value'));
					if(uxl.isEmpty(NM_CUST)){
						alert('신청인 정보가 없습니다. 신청인의 이름, 주민등록번호, 통합고객확인등으로 신청인 정보를 입력해주세요 .');
						return;
					}
				}
			}
			
			var data = {
				ID_CUST : ID_CUST,
				ID_CUST_REGIDENT : ID_CUST_REGIDENT,
				NM_CUST : NM_CUST
			}
			heungkuk.fnCustListPop('',data);
		});
		
    }

	// 화면의 컨트롤을 읽기전용 모드로 전환
	VocClass.prototype.vocReadOnlyMode = function() {
		// Combo Box : 읽기모드
		this.setReadOnly($('#TP_VOC_KIND'));
		this.setReadOnly($('#TP_CHNN_PATH'));
		this.setReadOnly($('#TP_SURROGATE'));
		this.setReadOnly($('#TP_VOC_ORGAN'));
		this.setReadOnly($('#FG_VOC_ORGAN_FILE'));
		this.setReadOnly($('#FG_RSLT_ORGAN_FILE'));
		this.setReadOnly($('#TP_RECV_ORGAN'));
		
		// 멀티 텍스트박스 읽기 모드
		var controls = document.getElementsByTagName('textarea');
		for(var i=0; i<controls.length; i++) {
			controls[i].readOnly = true;
			fitTextareaSize(controls[i]);
		}
		
		// 인풋박스 읽기모드
		$('input[type=text]')
			.addClass('ui-state-disabled')
			.attr('readOnly', 'readOnly');
		
		// 체크박스 읽기모드
		$('input[type=checkbox]')
			.attr('disabled', true);
		
		// 버튼 제어
		$("#btnSearchCust").remove();
		$("#btnSearchLawsuit").remove();
		$("#btnSearchZip1").remove();
		$("#btnSearchZip2").remove();
		$("#btnSearchZip3").remove();
		$("#DT_LAWSUIT").datepicker().datepicker("disable");
		$("#DT_SEND_ORGAN").datepicker().datepicker("disable");
		$("#DT_RECV_ORGAN").datepicker().datepicker("disable");
		$("#DT_LIMIT_ORGAN").datepicker().datepicker("disable");
		$("#DT_RETURN_ORGAN").datepicker().datepicker("disable");
		
		// 계약관련 컨트롤 읽기모드
		contract.disableInput();
	}
	
	VocClass.prototype.setReadOnly = function(target) {
		$(target)
			.before('<input type="hidden" name="' + target.id + '" id="' + target.id + '" value="' + target.value + '"/>')
			.replaceWith('<input type="text" style="width:' + ($(target).width() + 4) + 'px" class="ui-state-disabled" name="VIEW_' + target.id + '" id="VIEW_' + target.id + '" value="' + $('option:selected', target).text() + '"/>');
	}
	
	// 업무적인 Validation 체크
	VocClass.prototype.checkValidation = function(eventType){
		
		// 1. 계약 입력여부 체크
		var selectContract = $('input[name=ID_CONTRACT]', this.$this).filter('[value!=]');
		
		
		if(selectContract.size()==0){
			alert('계약정보는 필수입력입니다.\n계약이 없을 경우 [기타]로 하여 [계약없음]으로 추가하여 주시기 바랍니다.');
			$("#TP_CONTRACT").focus();
			return false;
		}
		
		// 2. VOC유형 입력 체크
		var selectContractSize = $('input[name=ID_CONTRACT]', this.$this).filter('[value!=]').size();
		var selectClass = $('input[name=ID_VOC_CLASS_CD]', this.$this).filter('[value!=]').size();
		var selectContractNo = selectContract.val();
		var selectRow = contract.getContractRows(selectContractNo);
		
		//추가된 계약정보보다 유형이 적게 입력되어 있을경우
		if(selectContractSize > selectClass){
			alert("VOC유형은 필수입력입니다.");
			$("#NM_VOC_CLASS_CD", selectRow).focus();
			return false;
		}			
		
		// 3. 처리완료일 때 발생원인, 처리유형 validation check!
		if( this.voc_dtl_mode == "PROGRESS" && eventType == "UPDATE"){
			// 발생원인
			if($('#TP_VOC_REASON').val() == ''){
				alert("발생원인은 필수입력입니다.");
				$('#ACTInform').contents().find('#TP_VOC_REASON').focus();
				return false;
			}
			
			// 처리유형
			if($('#TP_ACT_RSLT').val() == ''){
				alert("처리유형은 필수입력입니다.");
				$('#ACTInform').contents().find('#TP_ACT_RSLT').focus();
				return false;
			}
			
			// 답변내용
			if($('#DS_ACT_RSLT').val() == ''){
				alert("답변내용은 필수입력입니다.");
				$('#ACTInform').contents().find('#DS_ACT_RSLT').focus();
				return false;
			}
		}
		
		// 4. 즉시처리 여부 체크
		if($('#ACTInform').contents().find('#FG_VOC_AFTER').attr("checked")){
			//임시저장일 경우 false
			if(eventType == "REGIST"){
				alert("즉시처리는 임시저장을 할 수 없습니다.");
				return false;
			}
			
			//수정일 경우 false
			if(eventType == "UPDATE"){
				alert("즉시처리는 수정을 할 수 없습니다.");
				return false;
			}
			
			//접수일 경우, 즉시처리를 위한 Validation Check
			if(eventType == "RECEIPT"){
				// 처리일시
				if($('#DT_END').val() == ""){
					alert("처리일시는 필수입력입니다.");
					$('#ACTInform').contents().find('#DT_END').focus();
					return false;
				}
				// 발생원인
				if($('#TP_VOC_REASON').val() == ""){
					alert("발생원인은 필수입력입니다.");
					$('#ACTInform').contents().find('#TP_VOC_REASON').focus();
					return false;
				}
				
				// 처리유형
				if($('#TP_ACT_RSLT').val() == ""){
					alert("처리유형은 필수입력입니다.");
					$('ACTInform').contents().find('#TP_ACT_RSLT').focus();
					return false;
				}
				
				// 답변내용
				if($('#DS_ACT_RSLT').val() == ""){
					alert("답변내용은 필수입력입니다.");
					$('ACTInform').contents().find('#DS_ACT_RSLT').focus();
					return false;
				}
			}
		}
		
		// 5. 입력 포맷 체크
		var email_id 			= $("#DS_EMAIL_ID").val();
		var email_domain	= $("#DS_EMAIL_DOMAIN").val();
		if(!util.isEmpty(email_id) || !util.isEmpty(email_domain)){
			if(util.isEmpty(email_id)){
				alert("이메일 아이디를 입력하시기 바랍니다.");
				$("#DS_EMAIL_ID").focus();
				return false;
			}
			if(util.isEmpty(email_domain)){
				alert("이메일의 도메인주소를 입력하시기 바랍니다.");
				$("#DS_EMAIL_DOMAIN").focus();
				return false;
			}
			
			if(!uxl.isEmail(email_id + '@' + email_domain)){
				alert('올바른 이메일주소를 입력하시기 바랍니다.');
				$("#DS_EMAIL_ID").focus();
				return false;
			}
		}
		return true;
	}
	
	// VOC유형에 따른 처리
	VocClass.prototype.setVocType =  function (){
		var thisRef = this;
		var vocPath = $('#TP_CHNN_PATH');
		
		// 유형변경 Event
		vocPath.change(function(event) {
			var prev_selected = $(this).data('prev_selected') || this.value;
			
			thisRef.toggleExternal(this.value);
			
			// 이전 선택된 값 보관
			$(this).data('prev_selected', this.value);
		})
		.change();
		
	}
	
	// 대외민원정보 Toggle
	VocClass.prototype.toggleExternal = function (value) {
		
		// 대외일 경우, 대외민원정보 Layer 보여주기
		if(value=="E01" || value=="E02"){
			$('#layout-8').show();
			$('#layout-9').show();
		}else{
			$('#layout-8').hide();
			$('#layout-9').hide();
		}
	}
	
	// 고객없음 - 고객
	var DummyCustomer = {};
	DummyCustomer.id_cust = '고객없음';
	DummyCustomer.nm_cust = '고객없음';
	DummyCustomer.param = 'ID_CUST' + '@' + DummyCustomer.id_cust + '^'
						+ 'NM_CUST' + '@' + DummyCustomer.nm_cust;
	
	// 계약없음 - 대출
	var DummyContract = {};
	DummyContract.ID_CONTRACT = 'NO';
	DummyContract.NO_CONTRACT = 'NO';
	DummyContract.TP_CONTRACT = '03';
	DummyContract.NM_CONTRACT = '계약없음';
	DummyContract.NM_PRODUCT = '계약없음';
	DummyContract.ETC = '-';
	DummyContract.param = 'ID_CONTRACT' + '@' + DummyContract.ID_CONTRACT + '^'
						+ 'NO_CONTRACT' + '@' + DummyContract.NO_CONTRACT + '^'
						+ 'TP_CONTRACT' + '@' + DummyContract.TP_CONTRACT + '^'
						+ 'NM_CONTRACT' + '@' + DummyContract.NM_CONTRACT + '^'
						+ 'NM_PRODUCT' + '@' + DummyContract.NM_PRODUCT + '^'
						+ 'DT_CONTRACT' + '@' + DummyContract.ETC + '^'
						+ 'NM_CUST_CONTRACT' + '@' + DummyContract.ETC + '^'
						+ 'NM_DEPT_COLLECT' + '@' + DummyContract.ETC + '^'
						+ 'NM_EMP_COLLECT' + '@' + DummyContract.ETC + '^'
						+ 'NM_DEPT_COMP' + '@' + DummyContract.ETC + '^'
						+ 'NM_EMP_COMP' + '@' + DummyContract.ETC;
	
	// 계약없음 - 기타
	var DummyContractSecond = {};
	DummyContractSecond.ID_CONTRACT = 'NO';
	DummyContractSecond.NO_CONTRACT = 'NO';
	DummyContractSecond.TP_CONTRACT = '04';
	DummyContractSecond.NM_CONTRACT = '계약없음';
	DummyContractSecond.NM_PRODUCT = '계약없음';
	DummyContractSecond.ETC = '-';
	DummyContractSecond.param = 'ID_CONTRACT' + '@' + DummyContractSecond.ID_CONTRACT + '^'
						+ 'NO_CONTRACT' + '@' + DummyContractSecond.NO_CONTRACT + '^'
						+ 'TP_CONTRACT' + '@' + DummyContractSecond.TP_CONTRACT + '^'
						+ 'NM_CONTRACT' + '@' + DummyContractSecond.NM_CONTRACT + '^'
						+ 'NM_PRODUCT' + '@' + DummyContractSecond.NM_PRODUCT + '^'
						+ 'DT_CONTRACT' + '@' + DummyContractSecond.ETC + '^'
						+ 'NM_CUST_CONTRACT' + '@' + DummyContractSecond.ETC + '^'
						+ 'NM_DEPT_COLLECT' + '@' + DummyContractSecond.ETC + '^'
						+ 'NM_EMP_COLLECT' + '@' + DummyContractSecond.ETC + '^'
						+ 'NM_DEPT_COMP' + '@' + DummyContractSecond.ETC + '^'
						+ 'NM_EMP_COMP' + '@' + DummyContractSecond.ETC;
   
	// 계약
	function VocContract(layout) {
		var thisRef = this;
		var $this = $('#' + layout);
		this.$this = $this;
		this.table = $('>table', $this);
		this.layout_id = layout;
		this.layout = $this;
		this.copyRows = $('>table>tbody>tr', $this).has('input[name=isCopyRow]').hide();
		this.searchRow = $('>tbody>tr:first', $this);
		this.noContractRow = $('>tbody>tr', $this).has('label[name=NM_CONTRACT]');
		this.changed = false;
		this.complaintTargetRow = null;
		this.canSearch = true;
			
				
		// 계약검색 조건입력 필드 엔터 이벤트 	
		this.contractSearchInputs = $('#searchCondition', $this)
		.bind('keypress', function(event) {
			if (event.which == '13') {
				thisRef.contractSearchButton.click();
			}
			return allowOnly('0..9|-');
		});

		if(!voc.isRegisterMode){
			// 검색결과 TR을 없앤다. (상세조회 시 계약검색 결과)
			this.resultrow = $('>table>tbody>tr', $this).has($('.no_value')).remove();
			
			// 검색된 계약정보가 있는지 확인
			if(this.resultrow.html() == null){
				// 첫번째 계약 확인 후 계약유형 설정
				var param = $("#CONTRACT_PARAM", $("input[name=NO_CONTRACT]:visible:first").parent()).val();
				var firstContract = this.makeContractFromParam(param);
				var firstTPContract =firstContract["TP_CONTRACT"];
				$("input[name='TP_CONTRACT'][value='"+firstTPContract+"']").attr("checked","checked");
				
				// 계약의 유형검색 관련 Control의 이벤트 바인딩
				$("input[name=NM_VOC_CLASS_CD]").each(function(index){
					var contractTr = $('>table>tbody>tr', $("#" + layout)).has($(this));		// 해당 TR
					
					//Hidden Row이면 Return
					if(contractTr.css("display") == "none") return;
					
					var ClassName = $('#NM_VOC_CLASS_CD', contractTr);					// VOC유형명 
					var ClassId = $('#ID_VOC_CLASS_CD', contractTr);							// VOC유형코드
					var ClassSearch = $('#btnVocClassSearch', contractTr);					// VOC유형검색버튼
					
					// 추가된 계약의 VOC유형검색(자동완성) 기능 바인딩
					var option = {
						itemExtractor: function(row) {
			    			return {
			    				label: row.LABEL,
			    				value: '[' + row.VALUE + ']' + row.NM_VOC_CLASS_CD,
			    				id: row.VALUE
			    			};
			    		},
			    		select: function(event, ui) {
			    			ClassName.val(ui.item.label);
			    			ClassId.val(ui.item.id);
			    		}
					};
					uxl.autocomplete(ClassName,'SVCBCO0009', null, option);
					
					//VOC유형명 컨트롤의 더블클릭 이벤트 바인딩
					ClassName.dblclick(function(){
						ClassName.val("");
						ClassId.val("");
					});
					
					// 추가된 계약의 VOC유형검색(검색팝업호출) 기능 바인딩
					ClassSearch.click(function(){
						var handler = function(data){
							if(data != null && data != -1 && data != 0) {
								ClassId.val(data.ID_VOC_CLASS_CD);
								ClassName.val("[" + data.ID_VOC_CLASS_CD + "]" + data.NM_VOC_CLASS_CD);
							}
						};
						heungkuk.fnTypeSearchPop(handler);
					});
				});
				
			}else{
				alert("Contract is null");
			}
			
		}
		

	}

	// 계약정보 객체
	VocContract.prototype.makeContractFromParam = function(contractParam) {
		contractParam = contractParam || '';
		var contractParams = contractParam.split("^");
		var contract = {
			ID_CONTRACT			: this.getVal(contractParams, 'ID_CONTRACT'),	
			TP_CONTRACT			: this.getVal(contractParams, 'TP_CONTRACT'),
			NO_CONTRACT			: this.getVal(contractParams, 'NO_CONTRACT'), 
			NM_CONTRACT			: this.getVal(contractParams, 'NM_CONTRACT'),
			NM_PRODUCT			: this.getVal(contractParams, 'NM_PRODUCT'),
			DT_CONTRACT			: this.getVal(contractParams, 'DT_CONTRACT'), 
			NM_CUST_CONTRACT	: this.getVal(contractParams, 'NM_CUST_CONTRACT'),
			NM_DEPT_COLLECT		: this.getVal(contractParams, 'NM_DEPT_COLLECT'),
			NM_EMP_COLLECT		: this.getVal(contractParams, 'NM_EMP_COLLECT'),
			NM_DEPT_COMP		: this.getVal(contractParams, 'NM_DEPT_COMP'),
			NM_EMP_COMP			: this.getVal(contractParams, 'NM_EMP_COMP'),
			CONTRACT_PARAM    : contractParams
		};
		return contract;
	}

	
	// 계약 파라미터 정보로 부터 필요한 값을 추출
	VocContract.prototype.getVal = function (params, field) {
		var rtnval = '';
		for(var i=0; i<params.length; i++) {
			var pair = params[i].split("@");
			if(pair[0] == field) {
				rtnval = pair[1];
				rtnval = rtnval.replace(new RegExp('\null'),''); //replace(rtnval, 'null', '');
				break;
			}
		}
		return rtnval;
	}
	
	// 계약 검색 팝업 호출
	VocContract.prototype.openSearch = function(contract_type, regident_id) {
		
			var url = '/kvoc/contract.do?method=getList';
			url += '&searchCONTRACT_TYPE=' + contract_type;
			url += '&searchREGIDENT_ID=' + regident_id;
			
			this.pop = popUpOpenWindow(url, 'contractGetList', 750, 575);
	}
	
	
	// 계약 추가
	VocContract.prototype.add = function(newContract, isSetted) {
		var thisRef = this;
		var newRow = this.copyRows.clone().hide();
		var ContractInfo = $('#CONTRACT_PARAM', newRow);
		var ClassName = $('#NM_VOC_CLASS_CD', newRow);
		var ClassId	   = $('#ID_VOC_CLASS_CD', newRow);	
		var ClassSearch = $('#btnVocClassSearch', newRow);
		var ContractOrder = $('#NO_CONTRACT', newRow);
		// 추가하기 위한 계약과 동일한 계약이 리스트에 존재하는지 확인
		if(this.hasContract(newContract["NO_CONTRACT"])){
			alert("추가하고자 하는 계약이 이미 존재합니다.");
			newRow.remove();
			return;
		}
		
		// 추가된 계약의 VOC유형검색(자동완성) 기능 바인딩
		var option = {
			itemExtractor: function(row) {
    			return {
    				label: row.LABEL,
    				value: '[' + row.VALUE + ']' + row.NM_VOC_CLASS_CD,
    				id: row.VALUE
    			};
    		},
    		select: function(event, ui) {
    			ClassName.val(ui.item.label);
    			ClassId.val(ui.item.id);
    		}
		}
		uxl.autocomplete(ClassName,'SVCBCO0009', null, option);
		
		//VOC유형명 컨트롤의 더블클릭 이벤트 바인딩
		ClassName.dblclick(function(){
			ClassName.val("");
			ClassId.val("");
		});
		
		// 추가된 계약의 VOC유형검색(검색팝업호출) 기능 바인딩
		this.SearchClass = ClassSearch.click(function(){
			var ClassName1 = $('#NM_VOC_CLASS_CD', newRow);
			var ClassId1 		= $('#ID_VOC_CLASS_CD', newRow);
			var handler = function(data){
				if(data != null && data != -1 && data != 0) {
					ClassId1.val(data.ID_VOC_CLASS_CD);
					ClassName1.val("[" + data.ID_VOC_CLASS_CD + "]" + data.NM_VOC_CLASS_CD);
				}
			};
			heungkuk.fnTypeSearchPop(handler);
		});
		
		// 조회된 계약정보 설정
		ContractInfo.val(newContract["CONTRACT_PARAM"]);
		
		this.setLabel(newRow, newContract);
		newRow.show();
		this.table.append(newRow);
		
		// 값 초기화
		ContractOrder.attr("checked","");
		ClassId.val("");
		ClassName.val("");
		
	}
	
	// 계약 목록의 값을 설정한다.
	VocContract.prototype.setLabel = function(newRow, newContract) {
		var thisRef = this;
		
		$('label', newRow).each(function() {
			var labelname = $(this).attr('name');
			if(util.isNotEmpty(labelname)) {
				fieldvalue = newContract[labelname];
				
				if(util.isUndefined(fieldvalue)) fieldvalue = "";
				
				//계약번호를 Radio버튼의 값으로 설정
				if(labelname=="NM_CONTRACT"){
					$("#ID_CONTRACT", newRow).val(fieldvalue);
				}
				
				//계약자ID를 HIDDEN 값으로 설정
				if(labelname=="LB_ID_CUST"){
					$("#CONTRACT_REGIDENT", newRow).val(fieldvalue);
					fieldvalue ="";
				}
				
				this.title = fieldvalue;
				this.innerHTML = '<nobr>' + fieldvalue + '</nobr>';
			}
		});
	}
	
	// 계약 정보가 존재하는지 확인
	VocContract.prototype.hasContract = function(NO_CONTRACT) {
		if(NO_CONTRACT) {
			return $('input[name=ID_CONTRACT]', this.$this).filter('[value=' + NO_CONTRACT + ']').size() != 0;
		}
		else {
			return $('input[name=ID_CONTRACT]', this.$this).size() != 0;
		}
	}
	
	// 계약 삭제
	VocContract.prototype.remove = function(NO_CONTRACT) {
		this.getContractRows(NO_CONTRACT).remove();

		if(this.hasContract() == false) {
			/*
			// 계약 입력 알림 행 보이기
			this.noContractRow.show();
			// [계약없음] 버튼 보이기
			this.noContractButton.show();
			if(this.canSearch) {
				this.setSearch();
			}
			*/
		}
	}
	
	// 해당 계약의 ROW를 반환한다.
	VocContract.prototype.getContractRows = function(target) {
		if(util.isString(target)) {
			target = $('input[name=ID_CONTRACT]', this.$this).filter('[value=' + target + ']');
		}
		var targetRow = $('>table>tbody>tr', this.$this).has(target);
		
		return targetRow.add(targetRow.next());
		/*
		if(targetRow.has('input[name=ID_CONTRACT]').size() == 1) {
			return targetRow.add(targetRow.next());
		}
		else {
			return targetRow.add(targetRow.prev());
		}
		*/
	}
	
	// 계약정보의 입력 기능 제거
	VocContract.prototype.disableInput = function(){
		//
		//
		//1. 검색 기능 비활성화
		$("#searchCondition").remove();
		$("input[name=TP_CONTRACT]").attr("disabled","true");
		$("#btnSearchContract").remove();
		$("#btnDeleteContract").remove();
		
		//2. 계약의 유형검색기능 비활성화
		$("input[name=NM_VOC_CLASS_CD]").unbind('dblclick');
		$("*[name=btnVocClassSearch]").remove();
		
	}
	