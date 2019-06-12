/******************************************************************************
 *   BI-META FlexChart JavaScript
 *	 FlexChart 관련 Script
 *
 *   @version 1.0  2008/01/01
 *   [History] - 2008/01/01, 최초작성, by 임경철
 *
 *   @author  Copyright (c) 2008 by (주) 유비원. All Rights Reserved.
 *****************************************************************************/



var FLEXCHART = new Object();
FLEXCHART.path = "/flexChartPage.do?_dummy_parameter=_dummy_parameter";
FLEXCHART.prefix_basic_chart_name = "basicChart_";
FLEXCHART.prefix_query_id = "selectFlexCharData_";
FLEXCHART.PARAMETERKEY = new Object();
FLEXCHART.PARAMETERKEY.CONTEXT_ROOT = "CONTEXT_ROOT";
FLEXCHART.PARAMETERKEY.CHART_NAME = "CHART_NAME";
FLEXCHART.PARAMETERKEY.CHART_FILE_NAME = "CHART_FILE_NAME";
FLEXCHART.PARAMETERKEY.CHART_TYPE = "CHART_TYPE";
FLEXCHART.PARAMETERKEY.CHART_WIDTH = "CHART_WIDTH";
FLEXCHART.PARAMETERKEY.CHART_HEIGHT = "CHART_HEIGHT";
FLEXCHART.PARAMETERKEY.EFFECT = "EFFECT";
FLEXCHART.PARAMETERKEY.SERIES = "SERIES";
FLEXCHART.PARAMETERKEY.RADIUS = "RADIUS";
FLEXCHART.PARAMETERKEY.LABELFUNCTION = "LABELFUNCTION";
FLEXCHART.PARAMETERKEY.DATATIPFUNCTION = "DATATIPFUNCTION";
FLEXCHART.PARAMETERKEY.VERTICAL_SCROLL_YN = "VERTICAL_SCROLL_YN";
FLEXCHART.PARAMETERKEY.HORIZONTAL_SCROLL_YN = "HORIZONTAL_SCROLL_YN";
FLEXCHART.PARAMETERKEY.SHOWDATATIPS = "SHOWDATATIPS";
FLEXCHART.PARAMETERKEY.LABELPOSITION = "LABELPOSITION";
FLEXCHART.PARAMETERKEY.RESERVEEXPLODERADIUS = "RESERVEEXPLODERADIUS";
FLEXCHART.PARAMETERKEY.PIECOLOR = "PIECOLOR";
FLEXCHART.PARAMETERKEY.GROUPTYPE = "GROUPTYPE";
FLEXCHART.PARAMETERKEY.CALLBACK = "CALLBACK";
FLEXCHART.PARAMETERKEY.INIT_KEY = "INIT_KEY";
FLEXCHART.PARAMETERKEY.QUERY_ID = "QUERY_ID";
FLEXCHART.PARAMETERKEY.QUERY_PARAMS = "QUERY_PARAMS";
FLEXCHART.PARAMETERKEY.CHART_EXT_ATT = "CHART_EXT_ATT";
FLEXCHART.PARAMETERKEY.APP_EXT_ATT = "APP_EXT_ATT";

FLEXCHART.CHART_TYPE = new Object();
FLEXCHART.CHART_TYPE.PIE = "PIE";
FLEXCHART.CHART_TYPE.COLUMN = "COLUMN";
FLEXCHART.CHART_TYPE.LINE = "LINE";
FLEXCHART.CHART_TYPE.BAR = "BAR";


/* 
	Flex 기본 Chart 객체 
	@param name 차트명
	@param type 차트유형
				FLEXCHART.CHART_TYPE.PIE|FLEXCHART.CHART_TYPE.COLUMN|FLEXCHART.CHART_TYPE.LINE|FLEXCHART.CHART_TYPE.BAR
	@param target 차트생성대상 (차트를 보여줄 Iframe 이름)
*/
function FlexChart (name, type, target) {
	var CHART_URL = _CONTEXT_ROOT + FLEXCHART.path;
	var CHART_NAME = name;
	var CHART_FILE_NAME = FLEXCHART.prefix_basic_chart_name + type;
	var CHART_TYPE = type;
	var CHART_TARGET = document.getElementById(target);
	var CHART_WIDTH = CHART_TARGET.width;
	if(CHART_WIDTH == null || CHART_WIDTH == '') {
		CHART_WIDTH = CHART_TARGET.clientWidth
	}
	var CHART_HEIGHT = CHART_TARGET.height;
	if(CHART_HEIGHT == null || CHART_HEIGHT == '') {
		CHART_HEIGHT = CHART_TARGET.clientHeight
	}
	
	var EFFECT = '1';
	
	var QUERY_ID = FLEXCHART.prefix_query_id + name;
	var QUERY_PARAMS = '';
	
	var SERIES = '';
	
	var RADIUS = '3';
	var LABELFUNCTION = 'default';
	var DATATIPFUNCTION = 'default';
	var SHOWDATATIPS  = 'true';
	var RESERVEEXPLODERADIUS  = '0';
	var LABELPOSITION  = 'insideWithCallout';
	var PIECOLOR = '';
	var VERTICAL_SCROLL_YN='auto';
	var HORIZONTAL_SCROLL_YN='auto';
	
	var GROUPTYPE = 'clustered'
	
	var CALLBACK = '';
	var INIT_KEY = '';
	
	var APP_EXT_ATT = '';
	
	var CHART_EXT_ATT = '';
	
	// ------------------------
	// 기본 차트외에 별도 작성한 차트파일을 호출할 경우 파일명 설정
	this.setFileName = function (filename) {
		CHART_FILE_NAME = filename;
	};
	// ------------------------
	// 차트 넓이 : 별도 설정이 없을 경우 타겟 Ifrmae 넓이
	this.setWidth = function (width) {
		CHART_WIDTH = width;
	};
	// ------------------------
	// 차트 높이 : 별도 설정이 없을 경우 타겟 Ifrmae 높이
	this.setHeigth = function (height) {
		CHART_HEIGHT = height;
	};
	// 차트 백그라운드 색상 : 별도 설정이 없을 경우 white
	this.setBackgroundColor = function (color) {
		addAppExtAttribute("backgroundColor", color.replace('#', ''));
	};
	// 차트 보더 : 별도 설정이 없을 경우 보더 없음
	this.setBorder = function (color) {
		addAppExtAttribute("borderStyle", "solid");
		addAppExtAttribute("borderColor", color.replace('#', ''));
	};
	// ------------------------
	// 이펙트 비활성화 : 별도 설정이 없을 경우 Effect 활성
	this.setEffectDisable = function () {
		EFFECT = 0;
	};
	// ------------------------
	// 쿼리 ID : 별도 설정이 없을 경우 'selectFlexCharData_' + CHART_NAME
	this.setQueryId = function (queryid) {
		QUERY_ID = queryid;
	};
	// ------------------------
	// 쿼리에 사용될 조건 파라미터 설정
	this.setQueryParams = function (queryparams) {
		QUERY_PARAMS = queryparams;
	} ;
	/* -------------------------
		차트에 사용될 Series 설정
		@param		field_id		매핑될 필드명
		@param		field_name		차트에 표현될 이름
		@param		field_color		칼라(별도 설정이 없을 경우 차트 기본값)
		@param		series_type		시리즈유형(별도 설정이 없을 경우 차트유형에 따라 자동 설정)
									FLEXCHART.CHART_TYPE.COLUMN|FLEXCHART.CHART_TYPE.LINE|FLEXCHART.CHART_TYPE.BAR
		@param		lineweigth		라인시리즈 선 두께 : 라인 시리즈일 경우에만 설정(별도 설정이 없을 경우 3)
		@param		lineform		라인시리즈 선 유형 : 라인 시리즈일 경우에만 설정(별도 설정이 없을 경우 curve)
									segment|curve|horizontal|reverseStep|step|vertical
	*/
	this.addSeries = function (field_id, field_name, field_color, series_type, lineweigth, lineform) {
		if(field_id == null || field_id == '') {
			field_id = 'VALUE_FIELD';
		}
		if(field_name == null) {
			field_name = '';
		}
		if(field_color == null) {
			field_color = '';
		}
		if(field_color != '') {
			field_color = '0x' + field_color.replace('#', '')
		}
		if(series_type == null || series_type == '') {
			series_type = CHART_TYPE;
		}
		var val = field_id + "^" + field_name + "^" + field_color + "^" + series_type;
		
		if(series_type == FLEXCHART.CHART_TYPE.LINE) {
			if(lineweigth == null || lineweigth == '') {
				lineweigth = '3';
			}
			if(lineform == null || lineform == '') {
				lineform = 'curve';
			}
			val += "^" + lineweigth + "^" + lineform;
		}
		if(SERIES == '') {
			SERIES = val;
		}
		else {
			SERIES += ';' + val;
		}
	};
	// ------------------------
	// 차트 단위 추가 속성 설정
	this.addChartExtAttribute = function (attname, attval) {		
		var val = attname + "^" + attval;
		if(CHART_EXT_ATT == '') {
			CHART_EXT_ATT = val;
		}
		else {
			CHART_EXT_ATT += ';' + val;
		}
	};
	// ------------------------
	// 파이 차트 일 경우 중심부 비율 (0 ~ 9  값이 클 수록 중심부 빈 공간이 커진다) : 별도 설정이 없을 경우 기본값 3
	this.setRadius = function (radius) {
		RADIUS = radius;
	};
	// ------------------------
	// 파이 차트 라벨 정보 : default/nameAndPercent/nameAndValue/nameOnly/percentOnly/valueOnly
	this.setLabelFunction = function (labelFunction) {
		LABELFUNCTION = labelFunction;
	};
	
	// 파이 차트 라벨 정보 : default/nameAndPercent/nameAndValue/nameOnly/percentOnly/valueOnly
	// 파이 차크인 경우 :default/nameAndPercent/nameAndValue/nameOnly/percentOnly/valueOnly
	// 파이 차트가 아닌경우 :default/nameAndValue/nameOnly/valueOnly
	this.setDataTipFunction = function (dataTipFunction) {
		DATATIPFUNCTION = dataTipFunction;
	};
	
	// ------------------------
	// 파이 차트 라벨 정보 : true/false
	this.setShowDataTips = function (showDataTips) {
		SHOWDATATIPS = showDataTips;
	};
	
	// ------------------------
	// vertical scroll : on/off
	this.setVerticalScrollYN = function (vsYN) {
		VERTICAL_SCROLL_YN = vsYN;
	}
	;
	
	// ------------------------
	// horizontal scroll : on/off
	this.setHorizontalScrollYN = function (hsYN) {
		HORIZONTAL_SCROLL_YN = hsYN;
	};
	
	
	// ------------------------
	// 파이 차트  : 0-1
	this.setReserveExplodeRadius = function (reserveExplodeRadius) {
		RESERVEEXPLODERADIUS = reserveExplodeRadius;
	};
	
	// ------------------------
	// 파이 차트  : inside/insideWithCallout/callout
	this.setLabelPosition = function (labelPosition) {
		LABELPOSITION = labelPosition;
	};
	// ------------------------
	// 파이 차트 색상 설정
	this.addPieColorSet = function (code, color) {
		var val = code + "^" + '0x' + color.replace('#', '');
		if(PIECOLOR == '') {
			PIECOLOR = val;
		}
		else {
			PIECOLOR += ';' + val;
		}
	};
	// ------------------------
	// 바/컬럼차트 그룹핑 유형 : 별도 설정이 없을 경우 clustered
	// clustered|overlaid|stacked|100%
	this.setGroupType = function (grouptype) {
		if(grouptype == null || grouptype == '') {
			grouptype = "clustered";
		}
		GROUPTYPE = grouptype.replace('%', '');
	};
	// ------------------------
	// 차트 클릭시 호출될 javascript CallBack Function Name
	this.setCallback = function (callback) {
		CALLBACK = callback;
	};
	// ------------------------
	// 최초 로딩시 선택값 설정
	this.setInitkey = function (initkey) {
		INIT_KEY = initkey;
	};
	
	// ------------------------
	// 차트 생성
	this.generate = function() {
		// 차트명
		CHART_URL += makeUrlParamString(FLEXCHART.PARAMETERKEY.CHART_NAME, CHART_NAME);
		// 차트유형
		CHART_URL += makeUrlParamString(FLEXCHART.PARAMETERKEY.CHART_TYPE, CHART_TYPE);
		// 차트 파일명
		CHART_URL += makeUrlParamString(FLEXCHART.PARAMETERKEY.CHART_FILE_NAME, CHART_FILE_NAME);
		// 차트 넓이
		CHART_URL += makeUrlParamString(FLEXCHART.PARAMETERKEY.CHART_WIDTH, CHART_WIDTH);
		// 차트 높이
		CHART_URL += makeUrlParamString(FLEXCHART.PARAMETERKEY.CHART_HEIGHT, CHART_HEIGHT);
		// 차트 Effect
		CHART_URL += makeUrlParamString(FLEXCHART.PARAMETERKEY.EFFECT, EFFECT);
		
		// 차트 Vertical scroll yn
		CHART_URL += makeUrlParamString(FLEXCHART.PARAMETERKEY.VERTICAL_SCROLL_YN, VERTICAL_SCROLL_YN);
		
		// 차트 Horizontal scroll yn
		CHART_URL += makeUrlParamString(FLEXCHART.PARAMETERKEY.HORIZONTAL_SCROLL_YN, HORIZONTAL_SCROLL_YN);
		
		// 쿼리 ID
		CHART_URL += makeUrlParamString(FLEXCHART.PARAMETERKEY.QUERY_ID, QUERY_ID);
		
		// 쿼리에 사용될 조건 파라미터
		CHART_URL += QUERY_PARAMS;
		
		
		if(typeof(FLEXCHART.PARAMETERKEY.DATATIPFUNCTION)!='undefined'
		  && FLEXCHART.PARAMETERKEY.DATATIPFUNCTION!="") {
		  	CHART_URL += makeUrlParamString(FLEXCHART.PARAMETERKEY.DATATIPFUNCTION, DATATIPFUNCTION);
		  }
		  
		
		// 파이 차트 radius, labelFunction, color set
		if(CHART_TYPE == FLEXCHART.CHART_TYPE.PIE) {
			CHART_URL += makeUrlParamString(FLEXCHART.PARAMETERKEY.RADIUS, RADIUS);
			CHART_URL += makeUrlParamString(FLEXCHART.PARAMETERKEY.LABELFUNCTION, LABELFUNCTION);
			CHART_URL += makeUrlParamString(FLEXCHART.PARAMETERKEY.SHOWDATATIPS, SHOWDATATIPS);
			CHART_URL += makeUrlParamString(FLEXCHART.PARAMETERKEY.RESERVEEXPLODERADIUS, RESERVEEXPLODERADIUS);
			CHART_URL += makeUrlParamString(FLEXCHART.PARAMETERKEY.LABELPOSITION, LABELPOSITION);
			CHART_URL += makeUrlParamString(FLEXCHART.PARAMETERKEY.PIECOLOR, PIECOLOR);
		}
		else {
			if(typeof(FLEXCHART.PARAMETERKEY.SHOWDATATIPS)!='undefined'
			  && FLEXCHART.PARAMETERKEY.SHOWDATATIPS!="") {
			  	CHART_URL += makeUrlParamString(FLEXCHART.PARAMETERKEY.SHOWDATATIPS, SHOWDATATIPS);
		  	}
			if(SERIES == null || SERIES == '') {
				this.addSeries();
			}
		}
		
		// 바/컬럼 차트 그룹핑 유형 설정
		if(CHART_TYPE == FLEXCHART.CHART_TYPE.BAR || CHART_TYPE == FLEXCHART.CHART_TYPE.COLUMN) {
			CHART_URL += makeUrlParamString(FLEXCHART.PARAMETERKEY.GROUPTYPE, GROUPTYPE);
		}
		
		// 차트 Series 
		CHART_URL += makeUrlParamString(FLEXCHART.PARAMETERKEY.SERIES, SERIES);
		
		// 차트 Application 단위 추가 속성
		CHART_URL += makeUrlParamString(FLEXCHART.PARAMETERKEY.APP_EXT_ATT, APP_EXT_ATT);
		
		// 차트 추가 속성
		CHART_URL += makeUrlParamString(FLEXCHART.PARAMETERKEY.CHART_EXT_ATT, CHART_EXT_ATT);
		
		// Callback Script
		CHART_URL += makeUrlParamString(FLEXCHART.PARAMETERKEY.CALLBACK, CALLBACK);
		// 최초 로딩시 선택값
		CHART_URL += makeUrlParamString(FLEXCHART.PARAMETERKEY.INIT_KEY, INIT_KEY);
		
		// 어플리케이션 컨텍스트 루트
		CHART_URL += makeUrlParamString(FLEXCHART.PARAMETERKEY.CONTEXT_ROOT, _CONTEXT_ROOT);
		
		CHART_TARGET.src = CHART_URL;
	};
	
	function makeUrlParamString(key, value) {
		return "&" + encodeURIComponent(key) + '=' + encodeURIComponent(value);
	}
	function addAppExtAttribute (attname, attval) {		
		var val = attname + "^" + attval;
		if(APP_EXT_ATT == '') {
			APP_EXT_ATT = val;
		}
		else {
			APP_EXT_ATT += ';' + val;
		}
	}
}

// ==============================================================
// 차트 예제
// ==============================================================
// 파이 차트
function genSamplePieChart() {
	// 기본 차트 생성자
	// param 1 : 차트명 
	// param 2 : 차트타입 (파이차트:FLEXCHART.CHART_TYPE.PIE)
	// param 3 : 차트를 보여줄 Iframe 명
	var chart = new FlexChart('PieSample', FLEXCHART.CHART_TYPE.PIE, 'targetIframName');
	
	// 쿼리 실행시 사용할 조건값 파라미터 설정 : 추가 쿼리 조건 파라미터가 없을 경우 생략
	chart.setQueryParams('&serch_NM=name&serch_CODE=name');
	
	// 차트 중심부 설정(0 ~ 9) : 기본값(3)을 사용 할 경우 생략
	chart.setRadius("0");
	
	// 차트 라벨 설정(default/nameAndPercent/nameAndValue/nameOnly/percentOnly/valueOnly) : 기본값(default)을 사용 할 경우 생략
	chart.setLabelFunction("nameOnly");
	
	// 파이 차트 색상 셋 설정 : 차트 기본 색상을 사용 할경 우 생략
	// 키값, 색상값 
	chart.addPieColorSet('01', '#55AA33');
	chart.addPieColorSet('02', '#333333');
	
	// 차트배경색 설정 : 차트 기본 색상(white)을 사용 할 경우 생략
	chart.setBackgroundColor("#FFFFFF");
	// 차트보더 설정 : 보더를 그리지 않을 경우 생략
	chart.setBorder("#000000");
	
	// 범례 view
	chart.addChartExtAttribute("legendVisible", "false");
	
	// 기타 차트 단위 추가 속성 설정
	// 예)차트 왼쪽 마진
	chart.addChartExtAttribute("paddingLeft", "100");
	
	// 차트 콜백 함수 설정 : 콜백 함수 기능이 필요 없을 경우 생략
	chart.setCallback('test');
	
	// 최초 로딩시 선택값 설정 : 선택된 값 표현이 필요 없을 경우 혹은 최초 선택값이 없을 경우 생략
	chart.setInitkey('01');
	
	// 차트 생성
	chart.generate();
}
// 바 차트(가로막대 차트)
function genSampleBarChart() {
	// 기본 차트 생성자
	// param 1 : 차트명 
	// param 2 : 차트타입 (컬럼차트 : FLEXCHART.CHART_TYPE.BAR )
	// param 3 : 차트를 보여줄 Iframe 명
	var chart = new FlexChart('Sample', FLEXCHART.CHART_TYPE.BAR, 'targetIframName');
	
	// 쿼리 실행시 사용할 조건값 파라미터 설정 : 추가 쿼리 조건 파라미터가 없을 경우 생략
	chart.setQueryParams('&serch_NM=name&serch_CODE=name');
	
	// 차트 시리즈 설정
	// 컬럼차트의 컬럼 시리즈 설정	// 
	// param 1 : 매핑될 Data 필드명 
	// param 2 : 화면에 표시될 Display Name
	chart.addSeries("VALUE_FIELD1", "칭찬");
	chart.addSeries("VALUE_FIELD2", "불만");
	chart.addSeries("VALUE_FIELD3", "문의");
	
	// 차트배경색 설정 : 차트 기본 색상(white)을 사용 할 경우 생략
	chart.setBackgroundColor("#FFFFFF");
	// 차트보더 설정 : 보더를 그리지 않을 경우 생략
	chart.setBorder("#000000");
	
	// 차트 단위 추가 속성 설정
	// 예)차트 왼쪽 마진
	chart.addChartExtAttribute("paddingLeft", "100");
	
	// 바/컬럼차트 그룹핑 유형 : 별도 설정이 없을 경우 clustered
	// clustered|overlaid|stacked|100%
	chart.setGroupType("100%");
	
	// 차트 콜백 함수 설정 : 콜백 함수 기능이 필요 없을 경우 생략 가능
	chart.setCallback('test');
	
	// 차트 생성
	chart.generate();
}
// 컬럼차트
function genSampleColumnChart() {
	// 기본 차트 생성자
	// param 1 : 차트명 
	// param 2 : 차트타입 (컬럼차트 : FLEXCHART.CHART_TYPE.COLUMN )
	// param 3 : 차트를 보여줄 Iframe 명
	var chart = new FlexChart('Sample', FLEXCHART.CHART_TYPE.COLUMN, 'targetIframName');
	
	// 쿼리 실행시 사용할 조건값 파라미터 설정
	chart.setQueryParams('&serch_NM=name&serch_CODE=name');
	
	// 차트 시리즈 설정
	// 컬럼차트의 컬럼 시리즈 설정	// 
	// param 1 : 매핑될 Data 필드명 
	// param 2 : 화면에 표시될 Display Name
	chart.addSeries("VALUE_FIELD1", "칭찬");
	chart.addSeries("VALUE_FIELD2", "불만");
	chart.addSeries("VALUE_FIELD3", "문의");
	// param 3 : 시리즈 색상을 직접 지정할 경우
	chart.addSeries("VALUE_FIELD4", "제안", "#0000FF");
	// param 4 : 컬럼 차트에서 라인 시리즈를 사용 할 경우
	chart.addSeries("VALUE_FIELD5", "평균", "#FF0000", "LINE");
	// param 5 : 라인 시리즈를 사용 할 경우 선 두께를 직접 지정할 경우(별도 설정이 없을 경우 3)
	chart.addSeries("VALUE_FIELD5", "평균", "#FF0000", "LINE", "3");
	// param 6 : 라인 시리즈를 사용 할 경우 선 모양을 직접 지정할 경우(별도 설정이 없을 경우 curve)
	// segment|curve|horizontal|reverseStep|step|vertical
	chart.addSeries("VALUE_FIELD5", "평균", "#FF0000", "LINE", "3", "segment");
	
	// 차트배경색 설정 : 차트 기본 색상(white)을 사용 할 경우 생략
	chart.setBackgroundColor("#FFFFFF");
	// 차트보더 설정 : 보더를 그리지 않을 경우 생략
	chart.setBorder("#000000");
	
	// 차트 단위 추가 속성 설정
	// 예)차트 왼쪽 마진
	chart.addChartExtAttribute("paddingLeft", "100");
	
	// 바/컬럼차트 그룹핑 유형 : 별도 설정이 없을 경우 clustered
	// clustered|overlaid|stacked|100%
	chart.setGroupType("stacked");
	
	// 차트 콜백 함수 설정 : 콜백 함수 기능이 필요 없을 경우 생략 가능
	chart.setCallback('test');
	
	// 차트 생성
	chart.generate();
}
// 라인차트
function genSampleLineChart() {
	// 기본 차트 생성자
	// param 1 : 차트명 
	// param 2 : 차트타입 (컬럼차트 : FLEXCHART.CHART_TYPE.LINE )
	// param 3 : 차트를 보여줄 Iframe 명
	var chart = new FlexChart('Sample', FLEXCHART.CHART_TYPE.LINE, 'targetIframName');
	
	// 차트 이펙트 비활성화 : 별도 설정이 없을 경우 이페트 활성 기본
	chart.setEffectDisable();
	
	// 쿼리 실행시 사용할 조건값 파라미터 설정
	chart.setQueryParams('&serch_NM=name&serch_CODE=name');
	
	// 차트 시리즈 설정
	// 라인차트의 라인 시리즈 설정	// 
	// param 1 : 매핑될 Data 필드명 
	// param 2 : 화면에 표시될 Display Name
	chart.addSeries("VALUE_FIELD1", "칭찬");
	chart.addSeries("VALUE_FIELD2", "불만");
	chart.addSeries("VALUE_FIELD3", "문의");
	// param 3 : 시리즈 색상을 직접 지정할 경우
	chart.addSeries("VALUE_FIELD4", "제안", "81E2B5");
	// param 4 : 시리즈 유형 설정(라인 차트일 경우 별도 지정이 없거나 빈 값일 경우 라인 시리즈 생성)
	chart.addSeries("VALUE_FIELD5", "평균", "FF0000", "");
	// param 5 : 라인 시리즈를 사용 할 경우 선 두께를 직접 지정할 경우(별도 설정이 없을 경우 3)
	chart.addSeries("VALUE_FIELD5", "평균", "FF0000", "", "3");
	// param 6 : 라인 시리즈를 사용 할 경우 선 모양을 직접 지정할 경우(별도 설정이 없을 경우 curve)
	// segment|curve|horizontal|reverseStep|step|vertical
	chart.addSeries("VALUE_FIELD5", "평균", "FF0000", "", "", "segment");
	
	// 차트배경색 설정 : 차트 기본 색상(white)을 사용 할 경우 생략
	chart.setBackgroundColor("#FFFFFF");
	// 차트보더 설정 : 보더를 그리지 않을 경우 생략
	chart.setBorder("#000000");
	
	// 차트 단위 추가 속성 설정
	// 예)차트 왼쪽 마진
	chart.addChartExtAttribute("paddingLeft", "100");
	
	// 차트 단위 추가 속성 설정
	// 예)차트 왼쪽 마진
	chart.addChartExtAttribute("paddingLeft", "100");
	
	// 차트 콜백 함수 설정 : 콜백 함수 기능이 필요 없을 경우 생략 가능
	chart.setCallback('test');
	
	// 차트 생성
	chart.generate();
}

function test(key) {
	alert(key);
}