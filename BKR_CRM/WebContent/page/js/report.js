	// ---------------------------------------------------------
	// VOC 클래스
	// ---------------------------------------------------------
	function VocReport() {	

	}
		
	/*
	 * paging 갯수
	 * pageId : 클릭시 연결한 페이지 ID
	 * target : 화면을 보여줄 target
	 * pageNum : 페이지 num
	 * onType : select 
	 * 
	 * */ 
	VocReport.prototype.pageAdd = function(pageId, target, pageNum, onType){
		
		var strPage = "";
		if(onType){
			strPage = "<li class='num on' onclick=\"fnPagenum(this,'" + pageId + "');\"><a href='#"+target+"'><span>"+pageNum+"</span></a></li>";
		}else{
			strPage = "<li class='num' onclick=\"fnPagenum(this,'" + pageId + "');\"><a href='#"+target+"'><span>"+pageNum+"</span></a></li>";
		}
		
		$('#pagenum').append(strPage);
	};
	
	/*
	 * parameter setting
	 * type : 리포트 주기 
	 *       Y : 연, M : 월, W : 주, D : 일 
	 * 
	 * */ 
	VocReport.prototype.getSelect = function(type){
		var cd_comp 		= this.getComp();
		var page_num 		= $('#pagenum .on').find('span').text();
		var report_period 	= this.getPeriod(type);
		var month			= this.getMonth();
		var date			= this.getDate();
		var data 			= "";
		
		if( type == "Y"){
			data = { CD_YEAR : report_period, CD_R_COMP : cd_comp, PAGE_NUM : page_num};
		}else if( type == "M"){
			data = { CD_MONTH : report_period+month, CD_R_COMP : cd_comp, PAGE_NUM : page_num};
		}else if( type == "W"){
			var cd_week = $('#weekCombo option:selected').val();
			data = { CD_YEAR_WEEK : cd_week, CD_R_COMP : cd_comp, PAGE_NUM : page_num};
		}else{
			data = { CD_DT : report_period+month+date, CD_R_COMP : cd_comp, PAGE_NUM : page_num};
		}
		
		return data;
	};
	
	// parameter로 넘어온 회사 셋팅
	VocReport.prototype.setComp = function(cdComp){

		// 회사 셋팅
		if( "001" == cdComp){
			$('#tab_spc').addClass("on");
		}else if( "101" == cdComp){
			$('#tab_sl').addClass("on");
			$('#tab_spc').hide();
			$('#tab_pc').hide();
			$('#tab_br').hide();
			$('#tab_hp').hide();
			$('#tab_pos').hide();
		}else if( "201" == cdComp){
			$('#tab_pc').addClass("on");
			$('#tab_spc').hide();
			$('#tab_sl').hide();
			$('#tab_br').hide();
			$('#tab_hp').hide();
			$('#tab_pos').hide();
		}else if( "301" == cdComp ){
			$('#tab_br').addClass("on");
			$('#tab_spc').hide();
			$('#tab_pc').hide();
			$('#tab_sl').hide();
			$('#tab_hp').hide();
			$('#tab_pos').hide();
		}else if( "401" == cdComp){
			$('#tab_hp').addClass("on");
			$('#tab_spc').hide();
			$('#tab_pc').hide();
			$('#tab_br').hide();
			$('#tab_sl').hide();
			$('#tab_pos').hide();
		}else{
			$('#tab_pos').addClass("on");
			$('#tab_spc').hide();
			$('#tab_pc').hide();
			$('#tab_br').hide();
			$('#tab_hp').hide();
			$('#tab_sl').hide();
		}
	};
	
	// 선택된 회사 찾기
	VocReport.prototype.getComp = function(){
		var comp = $('#tabs_comp ul').find('.on').attr('id');
		var cd_comp_1 = "";
		
		if( "tab_spc" == comp){
			cd_comp_1 = "001";	
		}else if("tab_sl" == comp){
			cd_comp_1 = "101";
		}else if("tab_pc" == comp){
			cd_comp_1 = "201";
		}else if("tab_br" == comp){
			cd_comp_1 = "301";
		}else if("tab_hp" == comp){
			cd_comp_1 = "401";
		}else{
			cd_comp_1 = "501";
		}
		
		return cd_comp_1;
	};
	
	// 선택한 연도 찾기 
	VocReport.prototype.getPeriod = function(type){
		var period = $('#yearCombo option:selected').val();
		
		return period;
	};
	
	// 선택한 월 찾기 
	VocReport.prototype.getMonth = function(){
		var period = $('#monthCombo option:selected').val();
		
		return period;
	};
	
	// 선택한 주차 찾기 
	VocReport.prototype.getWeek = function(){
		var period = $('#weekCombo option:selected').val();
		
		return period;
	};
	
	// 선택한 일 찾기 
	VocReport.prototype.getDate = function(){
		var period = $('#dateCombo option:selected').val();
		
		return period;
	};
	
	// 연도 콤보 만들기
	VocReport.prototype.fnCreateYear = function(result){
		var combo    = result.getDataList("yearReport.getYear");
		var year_cnt = combo.rowCount;
		var strHtml = "";
		
		for(var i=0; i<year_cnt; i++){
			strHtml += "<option value='"+ combo.rows[i].CODE+"'>" + combo.rows[i].CODE_NAME + "</option>";
		}
		
		$("#yearCombo").append(strHtml);
	};
	
	// 월 콤보 만들기
	VocReport.prototype.fnCreateMonth = function(result){
		
		this.fnCreateYear(result);
		
		var combo    = result.getDataList("yearReport.getMonth");
		var month_cnt = combo.rowCount;
		var strHtml = "";
		
		for(var i=0; i<month_cnt; i++){
			strHtml += "<option value='"+ combo.rows[i].CODE+"'>" + combo.rows[i].CODE_NAME + "</option>";
		}
		
		$("#monthCombo").html(strHtml);
		
	};
	
	// 주차 콤보 만들기
	VocReport.prototype.fnCreateWeek = function(result){
		
		var combo    = result.getDataList("yearReport.getWeek");
		var week_cnt = combo.rowCount;
		var strHtml = "";
		
		for(var i=0; i<week_cnt; i++){
			strHtml += "<option value='"+ combo.rows[i].CODE+"'>" + combo.rows[i].CODE_NAME + "</option>";
		}
		
		$("#weekCombo").html(strHtml);
	};
	
	// 날짜 콤보 만들기
	VocReport.prototype.fnCreateDate = function(result){
		
		var combo    = result.getDataList("yearReport.getDate");
		var date_cnt = combo.rowCount;
		var strHtml = "";
		
		for(var i=0; i<date_cnt; i++){
			strHtml += "<option value='"+ combo.rows[i].CODE+"'>" + combo.rows[i].CODE_NAME + "</option>";
		}
		
		$("#dateCombo").html(strHtml);
	};	
	
	
	