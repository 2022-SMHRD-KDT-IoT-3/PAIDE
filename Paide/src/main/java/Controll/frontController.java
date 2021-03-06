package Controll;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Inter.Command;
import Service.AddFarmService;
import Service.AddSubscriptionService;
import Service.CheckFarmNameService;
import Service.CheckIDService;
import Service.CheckInfoService;
import Service.DeleteArticleService;
import Service.DeleteCmtService;
import Service.DeleteFCmtService;
import Service.DeleteFarmService;
import Service.DeleteSubscriptionService;
import Service.EditFarmService;
import Service.FcmtLikeMupdateService;
import Service.FcmtLikeUpdateService;
import Service.IDSendMailService;
import Service.JoinService;
import Service.LikeMupdateService;
import Service.LikeUpdateService;
import Service.LoginService;
import Service.LogoutServiceCon;
import Service.PWSendMailService;
import Service.SearchFarmlistService;
import Service.SearchIDService;
import Service.SearchPWService;
import Service.SeenotificationService;
import Service.UpdateArticleService;
import Service.UpdateCmtService;
import Service.UpdateFarmService;
import Service.UpdateFcmtService;
import Service.UpdateLevel;
import Service.UpdateMemberService;
import Service.UpdateProfileService;
import Service.WriteArticleService;
import Service.WriteCmtService;
import Service.WriteFCmtService;

@WebServlet("*.do")
public class frontController extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println("[FrontController]");
		String nextpage = "";
		Command com = null;

		// 어떤 기능을 수행하는 문자열인지 판단
		String uri = request.getRequestURI();
		System.out.println(uri);

		String path = request.getContextPath();
		System.out.println(path);

		String command = uri.substring(path.length() + 1);
		System.out.println(command);

		if (command.equals("DeleteArticleService.do")) {
			com = new DeleteArticleService();
			nextpage = com.execute(request, response);

		} else if (command.equals("LikeUpdateService.do")) {
			com = new LikeUpdateService();
			nextpage = com.execute(request, response);

		} else if (command.equals("WriteArticleService.do")) {
			com = new WriteArticleService();
			nextpage = com.execute(request, response);

		} else if (command.equals("WriteCmtService.do")) {
			com = new WriteCmtService();
			nextpage = com.execute(request, response);

		} else if (command.equals("UpdateArticleService.do")) {
			com = new UpdateArticleService();
			nextpage = com.execute(request, response);

		} else if (command.equals("CheckFarmNameService.do")) {
			com = new CheckFarmNameService();
			nextpage = com.execute(request, response);

		} else if (command.equals("CheckIDService.do")) {
			com = new CheckIDService();

			nextpage = com.execute(request, response);
		} else if (command.equals("CheckInfoService.do")) {
			com = new CheckInfoService();
			nextpage = com.execute(request, response);

		} else if (command.equals("DeleteCmtService.do")) {
			com = new DeleteCmtService();
			nextpage = com.execute(request, response);

		} else if (command.equals("IDSendMailService.do")) {
			com = new IDSendMailService();
			nextpage = com.execute(request, response);

		} else if (command.equals("JoinService.do")) {
			com = new JoinService();
			nextpage = com.execute(request, response);

		} else if (command.equals("LoginService.do")) {
			com = new LoginService();
			nextpage = com.execute(request, response);

		} else if (command.equals("SearchFarmlistService.do")) {
			com = new SearchFarmlistService();
			nextpage = com.execute(request, response);

		} else if (command.equals("SearchIDService.do")) {
			com = new SearchIDService();
			nextpage = com.execute(request, response);

		} else if (command.equals("SearchPWService.do")) {
			com = new SearchPWService();
			nextpage = com.execute(request, response);

		} else if (command.equals("UpdateLevel.do")) {
			com = new UpdateLevel();
			nextpage = com.execute(request, response);

		} else if (command.equals("UpdateMemberService.do")) {
			com = new UpdateMemberService();
			nextpage = com.execute(request, response);

		} else if (command.equals("PWSendMailService.do")) {
			com = new PWSendMailService();
			nextpage = com.execute(request, response);
			
		} else if (command.equals("LogoutServiceCon.do")) {
			com = new LogoutServiceCon();
			nextpage = com.execute(request, response);
			
		} else if (command.equals("AddFarmService.do")) {
			com = new AddFarmService();
			nextpage = com.execute(request, response);
			
		} else if (command.equals("UpdateFarmService.do")) {
			com = new UpdateFarmService();
			nextpage = com.execute(request, response);
			
		} else if (command.equals("DeleteFarmService.do")) {
			com = new DeleteFarmService();
			nextpage = com.execute(request, response);
			
		} else if (command.equals("LikeMupdateService.do")) {
			com = new LikeMupdateService();
			nextpage = com.execute(request, response);
			
		} else if (command.equals("UpdateCmtService.do")) {
			com = new UpdateCmtService();
			nextpage = com.execute(request, response);
			
		} else if(command.equals("EditFarmService.do")) {
			com = new EditFarmService();
			nextpage = com.execute(request, response);
			
		} else if(command.equals("SeenotificationService.do")) {
			com = new SeenotificationService();
			nextpage = com.execute(request, response);
			
		} else if (command.equals("WriteFCmtService.do")) {
			com = new WriteFCmtService();
			nextpage = com.execute(request, response);
		} else if (command.equals("AddSubscriptionService.do")) {
			com = new AddSubscriptionService();
			nextpage = com.execute(request, response);
		} else if (command.equals("DeleteSubscriptionService.do")) {
			com = new DeleteSubscriptionService();
			nextpage = com.execute(request, response);
		} else if (command.equals("UpdateProfileService.do")) {
			com = new UpdateProfileService();
			nextpage = com.execute(request, response);
		}else if(command.equals("FcmtLikeUpdateService.do")) {
			com = new FcmtLikeUpdateService();
			nextpage = com.execute(request, response);
		} else if(command.equals("FcmtLikeMupdateService.do")) {
			com = new FcmtLikeMupdateService();
			nextpage = com.execute(request, response);
		} else if(command.equals("DeleteFCmtService.do")) {
			com = new DeleteFCmtService();
			nextpage = com.execute(request, response);
			
		} else if(command.equals("UpdateFcmtService.do")) {
			com = new UpdateFcmtService();
			nextpage = com.execute(request, response);
		}
		

		// else if 마지막줄
		if (nextpage != null) {
			response.sendRedirect(nextpage);
		}

	}

}
