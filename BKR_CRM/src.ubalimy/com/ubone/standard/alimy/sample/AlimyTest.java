package com.ubone.standard.alimy.sample;

import java.net.ConnectException;

import com.ubone.alimy.domain.AlimDto;
import com.ubone.alimy.sender.AlimyMessageSender;

/** 
 * <pre>
 *  파 일 명 : AlimyTest.java
 *  설    명 : 알리미 전송 테스트
 *  작 성 자 : 강영운
 *  작 성 일 : 2016.04.20
 *  버    전 : 1.0
 *  수정이력 : 
 *  기타사항 : 
 * </pre>
 * @author Copyrights 2013 by ㈜ 유비원. All right reserved.
 */
public class AlimyTest{
	
	public static void main(String[] args) {
		
		String loginToken = "6112d502-2884-47e4-9606-8aec53e684b8";
		String serverIp   = "localhost";
		String serverPort = "1234";

		System.out.println("전송 시작 1");
		{
			AlimDto dto = new AlimDto("MSG01", "테스트 제목입니다 22 .asdfasfdasfsafasfasfasdfasfdasfd", "테스트 내용입니다1.", "http://www.naver.com", serverIp, serverPort, loginToken);
			AlimyMessageSender sender = new AlimyMessageSender(dto);
			sender.setUncaughtExceptionHandler(new Thread.UncaughtExceptionHandler() {
				@Override
				public void uncaughtException(Thread t, Throwable e) {
					if(e.getCause() instanceof ConnectException){
						System.out.println("Connection 1 접속 오류 입니다.");
					}
				}
			});
			sender.start();
		}
//
//		System.out.println("전송 시작 2");
//		{
//			AlimDto dto = new AlimDto("MSG01", "테스트 제목입니다2.asfdasffadsfasfasdfasdfdsfadsffsfdasd", "테스트 내용입니다2.", "", serverIp, serverPort, loginToken);
//			AlimyMessageSender sender2 = new AlimyMessageSender(dto);
//			sender2.setUncaughtExceptionHandler(new Thread.UncaughtExceptionHandler() {
//				@Override
//				public void uncaughtException(Thread t, Throwable e) {
//					if(e.getCause() instanceof ConnectException){
//						System.out.println("Connection 2 접속 오류 입니다.");
//					}
//				}
//			});
//			sender2.start();
//		}
//
//		System.out.println("전송 시작 3");
//		{
//			AlimDto dto = new AlimDto("MSG01", "테스트 제목입니다2.asfdasffadsfasfasdfasdfdsfadsffsfdasd", "테스트 내용입니다2.", "", serverIp, serverPort, loginToken);
//			AlimyMessageSender sender3 = new AlimyMessageSender(dto);
//			sender3.setUncaughtExceptionHandler(new Thread.UncaughtExceptionHandler() {
//				@Override
//				public void uncaughtException(Thread t, Throwable e) {
//					if(e.getCause() instanceof ConnectException){
//						System.out.println("Connection 3 접속 오류 입니다.");
//					}
//				}
//			});
//			sender3.start();
//		}
//
//		System.out.println("전송 시작 4");
//		{
//			AlimDto dto = new AlimDto("MSG01", "테스트 제목입니다2.asfdasffadsfasfasdfasdfdsfadsffsfdasd", "테스트 내용입니다2.", "", serverIp, serverPort, loginToken);
//			AlimyMessageSender sender4 = new AlimyMessageSender(dto);
//			sender4.setUncaughtExceptionHandler(new Thread.UncaughtExceptionHandler() {
//				@Override
//				public void uncaughtException(Thread t, Throwable e) {
//					if(e.getCause() instanceof ConnectException){
//						System.out.println("Connection 4 접속 오류 입니다.");
//					}
//				}
//			});
//			sender4.start();
//		}
//
//		System.out.println("전송 시작 5");
//		{
//			AlimDto dto = new AlimDto("MSG01", "테스트 제목입니다2.asfdasffadsfasfasdfasdfdsfadsffsfdasd", "테스트 내용입니다2.", "", serverIp, serverPort, loginToken);
//			AlimyMessageSender sender5 = new AlimyMessageSender(dto);
//			sender5.setUncaughtExceptionHandler(new Thread.UncaughtExceptionHandler() {
//				@Override
//				public void uncaughtException(Thread t, Throwable e) {
//					if(e.getCause() instanceof ConnectException){
//						System.out.println("Connection 5 접속 오류 입니다.");
//					}
//				}
//			});
//			sender5.start();
//		}

		System.out.println("전송 종료");
		System.out.println("------------------- 결과는 스레드의 완료 시간에 따라 다르게 나타 날수 있음.");
	}
}
