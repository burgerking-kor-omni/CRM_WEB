/**
 * iFrame Print Module
 * 
 * How to : window.print(iFrame객체)
 */
window.print2 = window.print;
window.print = printFrame;

function printFrame(frame, onfinish){
	if(!frame) frame = window;
	
	function execOnFinish(){
		switch(typeof(onfinish)){
			case "string" : execScript(onfinish); break;
			case "function" : onfinish();
		}
		if(focused && !focused.disabled) focused.focus();
	}
	
	if(frame.document.readyState !== "complete" && !confirm("아직 인쇄를 완료하지 못했습니다. 계속해서 인쇄를 진행하시겠습니까?")){
		execOnFinish();
		return;
	}
	
	// IE5
	if(window.print2){
		var focused = document.activeElement;
		frame.focus();
		if(frame.print2){
			frame.print2();
		}else{
			frame.print();
		}
		execOnFinish();
		return;
	}
	
	var eventScope = printGetEventScope(frame);
	var focused = document.activeElement;
	
	window.printHelper = function(){
		execScript("on error resume next: printWB.ExecWB 6, 1", "VBScript");
		printFireEvent(frame, eventScope, "onafterprint");
		printWB.outerHTML = "";
		execOnFinish();
		window.printHelper = null;
	}
	
	document.body.insertAdjacentHTML("beforeEnd", "<object id=\"printWB\" width=0 height=0 classid=\"clsid:8856F961-340A-11D0-A96B-00C04FD705A2\">");
	
	printFireEvent(frame, eventScope, "onbeforeprint");
	frame.focus();
	window.printHelper = printHelper;
	setTimeout("window.printHelper()", 0);
}

function printFireEvent(frame, obj, name){
	var handler = obj[name];
	switch(typeof(handler)){
		case "string" : frame.execScript(handler); break;
		case "function" : handler();
	}
}

function printGetEventScope(frame){
	var frameset = frame.document.all.tags("FRAMESET");
	if(frameset.length) return frameset[0];
	return frame.document.body;
}