<%@page import="Model.SubscriptionDTO"%>
<%@page import="Model.SubscriptionDAO"%>
<%@page import="Model.CommunityDAO"%>
<%@page import="Model.CommunityDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.MemberDAO"%>
<%@page import="Model.MemberDTO"%>
<%@page import="Model.FarmDTO"%>
<%@page import="Model.FarmDAO"%>
<%@ page language="java" contentType="text/html; charset=UTf-8" pageEncoding="UTf-8"%>
<!doctype html>
<html lang="en">

<head>
<title>PAI:DE | commu_E.체험농장</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<!-- VENDOR CSS -->
<link rel="stylesheet" href="assets/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/vendor/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="assets/vendor/linearicons/style.css">
<link rel="stylesheet" href="assets/vendor/chartist/css/chartist-custom.css">
<!-- MAIN CSS -->
<link rel="stylesheet" href="assets/css/main.css">
<link rel="stylesheet" href="assets/css/style.css">
<script src="https://kit.fontawesome.com/51db22a717.js" crossorigin="anonymous"></script>
<!-- FOR DEMO PURPOSES ONLY. You should remove this in your project -->
<link rel="stylesheet" href="assets/css/demo.css">
<!-- GOOGLE FONTS -->
<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700" rel="stylesheet">
<!-- ICONS -->
<link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
<link rel="icon" type="image/png" sizes="96x96" href="assets/img/favicon.png">
<style>
	#profile {
		width: 20px;
		height: 20px;
		object-fit: cover;
	}
</style>
</head>

<body>
<% MemberDTO info = (MemberDTO)session.getAttribute("info");
%>
	<!-- WRAPPER -->
	<div id="wrapper">
		<!-- NAVBAR -->
		<nav class="navbar navbar-default navbar-fixed-top">
			<div class="brand">
			<a href="index.jsp"><img src="assets/img/paidelogo.jpg" alt="piede Logo" style="width: 100%; height: 45px;"
                  class="img-responsive logo"></a>
			</div>
			<div class="container-fluid">
				<div class="navbar-btn">
					<button type="button" class="btn-toggle-fullwidth">
						<i class="lnr lnr-arrow-left-circle"></i>
					</button>
				</div>
			<form action="commu_All.jsp" class="navbar-form navbar-left" method="post">
               <div class="input-group">
                  <table>
                     <tr>
                        <td>
                           <select class="form-control" name="searchField">
                              <option value="0">선택</option>
                              <option value="article_title">제목</option>
                              <option value="m_id">작성자</option>
                           </select>  
                        </td>
                        <td>
                           <input type="text" class="form-control" placeholder="검색" name="searchText" maxlength="100">
                        </td>
                        <td>
                           <button type="submit" class="btn btn-primary">Go</button>
                        </td>
                     </tr>
                  </table>
               </div>
            </form>

				<div id="navbar-menu">
					<ul class="nav navbar-nav navbar-right">

						<!-- 로그아웃시 삭제1 start-->
						 <% if(info != null){
						 ArrayList<SubscriptionDTO> sublist = new SubscriptionDAO().sub_list(info.getM_id());
						 ArrayList<FarmDTO> farmlist = new FarmDAO().myfarm(info.getM_id());%>
						<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><img src="assets/img/<%= info.getM_profile() %>" id="profile" class="img-circle" alt="Avatar"> <span> <%= info.getM_name() %> </span> <i class="icon-submenu lnr lnr-chevron-down"></i></a>
							<ul class="dropdown-menu">
							<%if(farmlist.size()>0){ %>
								<li><a href="myFarm.jsp"><i class="lnr lnr-leaf"></i> <span>내 농장</span></a></li>
								<%} %>
								<li><a href="updateMember.jsp"><i class="lnr lnr-cog"></i> <span>회원정보수정</span></a></li>
								<li><a href="LogoutServiceCon.do"><i class="lnr lnr-exit"></i> <span>로그아웃</span></a></li>
							</ul></li>
						<li class="dropdown"><a href="#" class="dropdown-toggle icon-menu" data-toggle="dropdown"> <i class="lnr lnr-bubble"></i> <span class="badge bg-danger">
						 <%
                        MemberDAO mdao = new MemberDAO();
                    	MemberDTO mdto = new MemberDTO(); 
                    	mdao.updatecomment(info.getM_id());
                     	mdao.updatefcomment(info.getM_id());
                        int totalalam = mdao.commentalam(info.getM_id()) + mdao.fcommentalam(info.getM_id());
                        %>
                        <%=totalalam %>
						</span>
						</a>
							<ul class="dropdown-menu notifications">
								 <% CommunityDTO codto = new CommunityDTO();
                     	CommunityDAO codao = new CommunityDAO(); 
                     	ArrayList<CommunityDTO> cmtlist = new ArrayList<CommunityDTO>();
                     	ArrayList<CommunityDTO> fcmtlist = new ArrayList<CommunityDTO>();
                     	
                     	cmtlist = codao.newcomment(info.getM_id(), mdao.commentalam(info.getM_id()));
                     	fcmtlist = codao.newfcomment(info.getM_id(), mdao.fcommentalam(info.getM_id()));
                     	
                     	for(int i = 0; i < cmtlist.size(); i++){
                     	
                     	%><li><a href="#" class="notification-item"><span class="dot bg-warning"></span>회원님의 글 <%=cmtlist.get(i).getArticle_title() %>에 <%=cmtlist.get(i).getM_id() %>님이 댓글을 작성하였습니다 </a></li>
                              <%} %>
                        <%for(int i = 0; i< fcmtlist.size(); i++){
                     	%>
                     	<li><a href="#" class="notification-item"><span class="dot bg-warning"></span>회원님의 농장에<%=fcmtlist.get(i).getM_id()%>님이 댓글을 작성하였습니다 </a></li>
                     	<%} %>
								<li><a href="SeenotificationService.do" class="more">See all notifications</a></li>
							</ul></li>
						<!-- 이웃목록
                     추가할 기능
                        1. 구독(이웃추가)을 눌렀을 때, 자동으로 class="dropdown-menu notifications으로 들어가고,
                        2.  class="dropdown-menu notifications에 있는 다른 농장의 수 만큼 자동으로 class="badge rounded-pill bg-success"에서 count가 들어가야 함.
                        3. 구독을 다시 한 번 눌렀을 때, 구독이 취소되고, 자동으로 class="badge rounded-pill bg-success"에서 카운트가 내려가고, class="dropdown-menu notifications"에서 목록이 빠져야 함. -->
						<li class="dropdown"><a href="#" class="dropdown-toggle icon-menu" data-toggle="dropdown"> <i class="lnr lnr-users"></i> <!-- 변경 5 =  이웃의 수 만큼 count가 되어야 함. --> <span class="badge rounded-pill bg-success"></span>
						</a> <!-- ? 대매니 : m_id가 아니라 subscriptioned_id (이웃의 아이디)가  들어가야하는 거 아닌가요? 
                          사용자의 이웃의 수 만큼 li 반복 되어야합니다  --> <!-- "m_id"의 코드가 들어가고, 클릭 시, 해당 회원의 농장화면으로 넘어감. -->

							<ul id='neighbor' class="dropdown-menu notifications">
								<%if(sublist.size() == 0){ %>
                        		<li><a><span
                           			class="lnr lnr-user"></span> 이웃 목록이 없습니다 </a></li>
                       			<%}else {%>
                         			<% for(int i = 0; i<sublist.size(); i++){ %>
                        		<li><a href="OtherFarm.jsp?seq=<%=sublist.get(i).getSubscriptioned_id()%>" class="notification-item"><span
                               		class="lnr lnr-user"></span>&nbsp;<%=sublist.get(i).getF_name() %></a></li>
                            		<%} 
                         		};%>
							</ul>
							<% }else{%>
		                     <div class="navbar-btn navbar-btn-right"> 
		                     <a class="btn btn-primary" href="page-login.jsp"  ><i class="lnr lnr-leaf"></i> <span> 로그인</span></a>
		                     </div>
		                     <%} %>
						</li>
						<!-- 로그아웃시 삭제1 end-->

						<!-- 로그아웃시 추가 start : 로그인버튼 -->
						<!-- <div class="navbar-btn navbar-btn-right"> 
               <a class="btn btn-primary" href="page-login.html"  ><i class="lnr lnr-leaf"></i> <span> 로그인</span></a>
               </div>  -->
						<!--로그아웃시 추가 end-->

					</ul>
				</div>
			</div>
		</nav>

		<!-- END NAVBAR -->
		<!-- LEFT SIDEBAR -->
		<div id="sidebar-nav" class="sidebar">
			<div class="sidebar-scroll">
				<nav>
					<ul class="nav">
						<li><a href="index.jsp" class=""><i class="lnr lnr-home"></i> <span>Home</span></a></li>
						<li><a href="commu_D.jsp" class=""><i class="lnr lnr-list"></i> <span>농산물 직거래</span></a></li>
						<li><a href="commu_E.jsp" class="active"><i class="lnr lnr-list"></i> <span>체험농장</span></a></li>
						<li><a href="commu_W.jsp" class=""><i class="lnr lnr-list"></i> <span>농촌일자리</span></a></li>
						<li><a href="commu_F.jsp" class=""><i class="lnr lnr-list"></i> <span>자유게시판</span></a></li>
						<% if(info != null){
						ArrayList<FarmDTO> farmlist = new FarmDAO().myfarm(info.getM_id());%>
						<li>
						<a href="#subPages" data-toggle="collapse" class="collapsed"><i class="lnr lnr-user"></i> 
						<span><%= info.getM_name() %></span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="subPages" class="collapse ">
								<ul class="nav">
								<%if(farmlist.size()>0){ %>
									<li><a href="myFarm.jsp" class=""><i class="lnr lnr-leaf"></i>내 농장</a></li>
									<%} %>
									<li><a href="farmSelect.jsp" class=""><i class="lnr lnr-magnifier"></i>농장검색</a></li>
									<li><a href="commuWrite.jsp" class=""><i class="lnr lnr-pencil"></i>글쓰기</a></li>
								</ul>
							</div>
							<%} %>
						</li>
					</ul>
				</nav>
			</div>
		</div>
		<!-- END LEFT SIDEBAR -->
		<!-- MAIN -->
		<div class="main">
			<!-- MAIN CONTENT -->
			<div class="main-content">
				<div class="container-fluid">
					<h5 class="page-title">
						<i class="lnr lnr-home"></i> HOME <i class="lnr lnr-chevron-right"></i><strong>체험농장</strong>
					</h5>
					<div id="toastr-demo" class="panel">
						<div class="panel-body">
							<div class="container-fluid">
								<div class="row">
									<div class="col-md-12">
										<h3>체험농장 게시판입니다.</h3>
										<!-- 출처: https://webdir.tistory.com/487 [WEBDIR] -->
										<!-- <div class="thumbnail-wrapper"> 
                                 <img id = "boardimg" alt="Bootstrap Image Preview" src="assets/img/게시판1.jpg" max-width="100%" height="auto"/> 
                              </div> -->
										<div class="thumbnail-wrapper">
											<div class="thumbnail">
												<img id="boardimg" alt="Bootstrap Image Preview" src="assets/img/board2.jpg" />
											</div>
										</div>
									</div>
								</div>
								<%
		String userID = null;
		if(session.getAttribute("useID") != null){
			userID = (String)session.getAttribute("userID");
		};
		
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		
		//String category = null;
		//if(request.getParameter("category") != null){
		//	category = request.getParameter("article_category");
		//}
		
		String category = "E";
	
		ArrayList<CommunityDTO> list = new CommunityDAO().getList(pageNumber, category);
		CommunityDAO dao = new CommunityDAO();
	%>



								<!-- 변경           article_seq  게시글의 개수  -->
								<div style="text-align: center;">
									총 <strong class="text-success"><%= dao.getNext2(category) - 1 %></strong>개의 게시글이 있습니다.
								</div>
								<br>
								<div class="row">
									<div class="col-md-12">
										<table class="table table-bordered table-hover" style="text-align: center;">
											<thead>
												<tr>
													<th>번호</th>
													<th>제목</th>
													<th>작성자</th>
													<th>작성일</th>
													<th>첨부파일</th>
												</tr>
											</thead>
											<tbody>
												<!-- 변경 <tr>
                                       <td>article_seq</td>
                                       <td><a href="#">article_title</a></td>
                                       <td>m_id</td>
                                       <td>article_date</td>
                                       <td>첨부파일유무</td>
                                    </tr> -->
												<% for(int i = 0; i < list.size(); i++){ %>
												<tr>
													<td><%= (pageNumber - 1) * 10 + i + 1 %></td>
													<!-- 선택한 제목(article_title)을 가지고 게시글페이지로이동 -->
													<td><a href="boardSelect.jsp?article_seq=<%= list.get(i).getArticle_seq()%>"><%= list.get(i).getArticle_title().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
													<!-- m_id -->
													<td><%=list.get(i).getM_id()%></td>
													<td><%=list.get(i).getArticle_date()%></td>
													<td><i class="lnr lnr-link"></i></td>
												</tr>
												<%} %>
											</tbody>
										</table>
									</div>
								</div>
							</div>
							<!--  페이지 넘기기 START-->
							<div class="row">
								<div class="col" style="text-align: center;">
									<ul class="pagination">
									<% 
										if(pageNumber != 1){
									%>
										<li class="page-item"><a class="page-link" href="commu_E.jsp?pageNumber=<%= pageNumber - 1 %>"><i class="lnr lnr-chevron-left">이전</i></a></li>
									<%
										} if(dao.getNext2(category) - 1 - (pageNumber - 1) * 10 > 10){
									%>	
										<li class="page-item"><a class="page-link" href="commu_E.jsp?pageNumber=<%= pageNumber + 1 %>">다음<i class="lnr lnr-chevron-right"></i></a></li>
									<%
										}
									%>
									</ul>
								</div>
							</div>
							<!--  페이지 넘기기 END-->

						</div>
					</div>
				</div>
			</div>
			<!-- END MAIN CONTENT -->
		</div>
		<!-- END MAIN -->
		<div class="clearfix"></div>
		<footer>
			<div class="copyright-wrap">
				<span> Copyright © PAIDE Corp. All Rights Reserved.</span>
			</div>
		</footer>
	</div>
	<!-- END WRAPPER -->
	<!-- Javascript -->
	<script src="assets/vendor/jquery/jquery.min.js"></script>
	<script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
	<script src="assets/vendor/jquery.easy-pie-chart/jquery.easypiechart.min.js"></script>
	<script src="assets/vendor/chartist/js/chartist.min.js"></script>
	<script src="assets/scripts/klorofil-common.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	<script>
      $(function () {
         var data, options;

         // headline charts
         data = {
            labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            series: [
               [23, 29, 24, 40, 25, 24, 35],
               [14, 25, 18, 34, 29, 38, 44],
            ]
         };

         options = {
            height: 300,
            showArea: true,
            showLine: false,
            showPoint: false,
            fullWidth: true,
            axisX: {
               showGrid: false
            },
            lineSmooth: false,
         };

         new Chartist.Line('#headline-chart', data, options);


         // visits trend charts
         data = {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            series: [{
               name: 'series-real',
               data: [200, 380, 350, 320, 410, 450, 570, 400, 555, 620, 750, 900],
            }, {
               name: 'series-projection',
               data: [240, 350, 360, 380, 400, 450, 480, 523, 555, 600, 700, 800],
            }]
         };

         options = {
            fullWidth: true,
            lineSmooth: false,
            height: "270px",
            low: 0,
            high: 'auto',
            series: {
               'series-projection': {
                  showArea: true,
                  showPoint: false,
                  showLine: false
               },
            },
            axisX: {
               showGrid: false,

            },
            axisY: {
               showGrid: false,
               onlyInteger: true,
               offset: 0,
            },
            chartPadding: {
               left: 20,
               right: 20
            }
         };

         new Chartist.Line('#visits-trends-chart', data, options);


         // visits chart
         data = {
            labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            series: [
               [6384, 6342, 5437, 2764, 3958, 5068, 7654]
            ]
         };

         options = {
            height: 300,
            axisX: {
               showGrid: false
            },
         };

         new Chartist.Bar('#visits-chart', data, options);


         // real-time pie chart
         var sysLoad = $('#system-load').easyPieChart({
            size: 130,
            barColor: function (percent) {
               return "rgb(" + Math.round(200 * percent / 100) + ", " + Math.round(200 * (1.1 - percent / 100)) + ", 0)";
            },
            trackColor: 'rgba(245, 245, 245, 0.8)',
            scaleColor: false,
            lineWidth: 5,
            lineCap: "square",
            animate: 800
         });

         var updateInterval = 3000; // in milliseconds

         setInterval(function () {
            var randomVal;
            randomVal = getRandomInt(0, 100);

            sysLoad.data('easyPieChart').update(randomVal);
            sysLoad.find('.percent').text(randomVal);
         }, updateInterval);

         function getRandomInt(min, max) {
            return Math.floor(Math.random() * (max - min + 1)) + min;
         }

      });
   //끝
   </script>
</body>

</html>