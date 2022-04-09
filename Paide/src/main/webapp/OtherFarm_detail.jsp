<%@page import="Model.GraphDTO"%>
<%@page import="Model.SubscriptionDTO"%>
<%@page import="Model.SubscriptionDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.CommunityDAO"%>
<%@page import="Model.CommunityDTO"%>
<%@page import="Model.MemberDAO"%>
<%@page import="Model.MemberDTO"%>
<%@page import="Model.FarmDTO"%>
<%@page import="Model.FarmDAO"%>
<%@ page language="java" contentType="text/html; charset=UTf-8"
    pageEncoding="UTf-8"%>
<!doctype html>
<html lang="en">

<head>
   <title>PAI:DE | 내농장.myFarm</title>
   <meta charset="utf-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
   <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
   <!-- VENDOR CSS -->
   <link rel="stylesheet" href="assets/vendor/bootstrap/css/bootstrap.min.css">
   <link rel="stylesheet" href="assets/vendor/font-awesome/css/font-awesome.min.css">
   <link rel="stylesheet" href="assets/vendor/linearicons/style.css">
   <!-- MAIN CSS -->
   <link rel="stylesheet" href="assets/css/main.css">
   <!-- FOR DEMO PURPOSES ONLY. You should remove this in your project -->
   <link rel="stylesheet" href="assets/css/demo.css">
   <!-- GOOGLE FONTS -->
   <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700" rel="stylesheet">
   <!-- ICONS -->
   <link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
   <link rel="icon" type="image/png" sizes="96x96" href="assets/img/favicon.png">

   <!-- 댓글 -->
   <link rel="stylesheet" type="text/css" media="screen" href="assets/css/main.css">
   <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
	#profile {
		width: 20px;
		height: 20px;
		object-fit: cover;
	}
	#profileimg{
   	width: 110px;
      height: 110px;
      object-fit: cover;
   	}	
</style>

</head>

<body>
<% MemberDTO info = (MemberDTO)session.getAttribute("info"); 
	ArrayList<SubscriptionDTO> sublist = new SubscriptionDAO().sub_list(info.getM_id());
	int f_seq = Integer.parseInt(request.getParameter("seq"));
	String startday = request.getParameter("startday");
	ArrayList<FarmDTO> farmlist = new FarmDAO().myfarm(info.getM_id());
	FarmDTO fdto = new FarmDAO().selectFarm(f_seq);
	MemberDTO otherinfo = new MemberDAO().otherinfo(fdto.getF_owner_id());
	String userID = null;
	if (session.getAttribute("info") != null) {
		userID = info.getM_id();
	}
%>
   <!-- WRAPPER -->
   <div id="wrapper">
      <!-- NAVBAR -->
      <nav class="navbar navbar-default navbar-fixed-top">
         <div class="brand">
             <a href="index.html"><img src="assets/img/pidelogoSmall.png" alt="piede Logo"
                     class="img-responsive logo"></a>
         </div>
         <div class="container-fluid">
             <div class="navbar-btn">
                 <button type="button" class="btn-toggle-fullwidth"><i
                         class="lnr lnr-arrow-left-circle"></i></button>
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
                      <% if(info != null){%>
                     <li class="dropdown">
                         <a href="#" class="dropdown-toggle" data-toggle="dropdown"><img src="assets/img/<%= info.getM_profile() %>"
                                 class="img-circle" alt="Avatar" id="profile"> <span> <%= info.getM_name() %> </span> <i
                                 class="icon-submenu lnr lnr-chevron-down"></i></a>
                         <ul class="dropdown-menu">
                             <li><a href="myFarm.jsp?seq=<%=farmlist.get(0).getF_seq()%>"><i class="lnr lnr-leaf"></i> <span>내 농장</span></a></li>
                             <li><a href="updateMember.jsp"><i class="lnr lnr-cog"></i> <span>회원정보수정</span></a></li>
                             <li><a href="LogoutServiceCon.do"><i class="lnr lnr-exit"></i> <span>로그아웃</span></a></li>
                         </ul>
                     </li>
                     <li class="dropdown">
                         <a href="#" class="dropdown-toggle icon-menu" data-toggle="dropdown">
                             <i class="lnr lnr-bubble"></i>
                             <span class="badge bg-danger">
                         <%
                        MemberDAO dao = new MemberDAO();
                    	MemberDTO dto = new MemberDTO(); 
                    	dao.updatecomment(info.getM_id());
                     	dao.updatefcomment(info.getM_id());
                        int totalalam = dao.commentalam(info.getM_id()) + dao.fcommentalam(info.getM_id());
                        %>
                        <%=totalalam %>
                        </span>
                     </a>
                     <ul class="dropdown-menu notifications">
                       <% CommunityDTO codto = new CommunityDTO();
                     	CommunityDAO codao = new CommunityDAO(); 
                     	ArrayList<CommunityDTO> cmtlist = new ArrayList<CommunityDTO>();
                     	ArrayList<CommunityDTO> fcmtlist = new ArrayList<CommunityDTO>();
                     	
                     	cmtlist = codao.newcomment(info.getM_id(), dao.commentalam(info.getM_id()));
                     	fcmtlist = codao.newfcomment(info.getM_id(), dao.fcommentalam(info.getM_id()));
                     	
                     	for(int i = 0; i < cmtlist.size(); i++){
                     	
                     	%><li><a href="#" class="notification-item"><span class="dot bg-warning"></span>회원님의 글 <%=cmtlist.get(i).getArticle_title() %>에 <%=cmtlist.get(i).getM_id() %>님이 댓글을 작성하였습니다 </a></li>
                              <%} %>
                        <%for(int i = 0; i< fcmtlist.size(); i++){
                     	%>
                     	<li><a href="#" class="notification-item"><span class="dot bg-warning"></span>회원님의 농장에<%=fcmtlist.get(i).getM_id()%>님이 댓글을 작성하였습니다 </a></li>
                     	<%} %>
                        <li><a href="SeenotificationService.do" class="more">See all notifications</a></li>
                     </ul>
                  </li>
                     <!-- 이웃목록
                     추가할 기능
                        1. 구독(이웃추가)을 눌렀을 때, 자동으로 class="dropdown-menu notifications으로 들어가고,
                        2.  class="dropdown-menu notifications에 있는 다른 농장의 수 만큼 자동으로 class="badge rounded-pill bg-success"에서 count가 들어가야 함.
                        3. 구독을 다시 한 번 눌렀을 때, 구독이 취소되고, 자동으로 class="badge rounded-pill bg-success"에서 카운트가 내려가고, class="dropdown-menu notifications"에서 목록이 빠져야 함. -->
                     <li class="dropdown">
                         <a href="#" class="dropdown-toggle icon-menu" data-toggle="dropdown">
                             <i class="lnr lnr-users"></i>
                                                             <!-- 변경 5 =  이웃의 수 만큼 count가 되어야 함. -->
                             <span class="badge rounded-pill bg-success"></span>
                         </a>
                         <!-- ? 대매니 : m_id가 아니라 subscriptioned_id (이웃의 아이디)가  들어가야하는 거 아닌가요? 
                          사용자의 이웃의 수 만큼 li 반복 되어야합니다  -->
                         <!-- "m_id"의 코드가 들어가고, 클릭 시, 해당 회원의 농장화면으로 넘어감. -->

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
      <a name ="top">맨위</a>
      <div id="sidebar-nav" class="sidebar">
         <div class="sidebar-scroll">
            <nav>
               <ul class="nav">
                  <li><a href="index.html" class=""><i class="lnr lnr-home"></i> <span>Home</span></a></li>
                  <li><a href="commu_D.html" class=""><i class="lnr lnr-list"></i> <span>농산물 직거래</span></a></li>
                  <li><a href="commu_E.html" class=""><i class="lnr lnr-list"></i> <span>체험농장</span></a></li>
                  <li><a href="commu_W.html" class=""><i class="lnr lnr-list"></i> <span>농촌일자리</span></a></li>
                  <li><a href="commu_F.html" class=""><i class="lnr lnr-list"></i> <span>자유게시판</span></a></li>

                  <!-- 로그아웃시 삭제2 start -->
                  <% if(info != null){%>
                  <li>
                     <a href="#subPages" data-toggle="collapse" class="collapsed"><i class="lnr lnr-user"></i>
                        <span><%= info.getM_name() %></span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
                     <div id="subPages" class="collapse ">
                        <ul class="nav">
                           <li><a href="myFarm.jsp?seq=<%=farmlist.get(0).getF_seq()%>" class=""><i class="lnr lnr-leaf"></i>내 농장</a></li>
                           <li><a href="farmSelect.jsp" class=""><i class="lnr lnr-magnifier"></i>농장검색</a></li>
                           <li><a href="commuWrite.jsp" class=""><i class="lnr lnr-pencil"></i>글쓰기</a></li>
                        </ul>
                     </div>
                      <%} %>
                  </li>
                  <!-- 로그아웃시 삭제2 end -->
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
               <div class="panel panel-profile">
                  <div class="clearfix">
                     <!-- LEFT COLUMN -->
                     <div class="profile-left">
                        <!-- PROFILE HEADER -->
                        <div class="profile-header">
                           <div class="overlay"></div>
                           <div class="profile-main">
                              <img src="assets/img/<%=otherinfo.getM_profile() %>" id="profileimg" class="img-circle" alt="Avatar">
                              <!-- 선택한 농장의 이름변수 ㄱ -->
                              <h3 class="name"><%=otherinfo.getM_name() %></h3>
                           </div>
                        </div>
                        <!-- END PROFILE HEADER -->
                        <!-- PROFILE DETAIL -->
                        <div class="profile-detail">
                           <div class="profile-info">
                              <!-- 변경 선택한 농장의 정보로 변경 -->
                              <!-- 선택한 농장의 이름  -->
                              <% FarmDTO Farminfo = new FarmDAO().myFarm(f_seq); %>
                              <h4 class="heading"><%=fdto.getF_name() %></h4>
                              <ul class="list-unstyled list-justify">
                                 <li>농장지역 <span><%=fdto.getF_region() %></span></li>
                                 <li>재배작목 <span><%=fdto.getF_crops() %></span></li>
                                 <%if("P".equals(Farminfo.getF_facility())){ %>
                                 <li>재배시설 <span>비닐온실</span></li>
                                 <%}else if("G".equals(Farminfo.getF_facility())){ %>
                                 <li>재배시설 <span>유리온실</span></li>
                                 <%}; %>
                              </ul>
                              <br>

                     
                              <br>
                              <center>
                                 <!-- 자세히 보기 클릭시 현재 선택한 농장정보 페이지(차트,테이블 있는 곳)로 이동  -->
                                 <a href="OtherFarm.jsp?seq=<%=f_seq%>"> <button type="button" class="btn btn-primary">농장홈화면</button></a>
                              </center>
                           </div>
                           <!-- current_date끝 -->
                        </div>
                        <!-- END PROFILE DETAIL -->
                     </div>
                     <!-- END LEFT COLUMN -->
                     <!-- RIGHT COLUMN -->
                     <div class="profile-right">
                        <h4 class="heading">날짜선택</h4>
                        <!-- 변경 입력 : 조회하고싶은 날짜 선택  -->
                        <form action="OtherFarm_detail.jsp" method="get">
                           <div class="input-group">
							<%if(startday.equals("TO_CHAR(SYSDATE, 'YYYY-MM-DD')")){ %>
                              <input type="date" name="startday" id='currentDate'/>
                              <%}else{ %>
                              <input type="date" name="startday" value="<%=startday %>"/>
                              <%} %>
							  <input type="hidden" name="seq" value="<%= f_seq %>">
                              <input type="submit" value="선택" class="btn btn-primary"/>
                           </div>
                        </form>
                        <br>
                        <!-- 선택한 농장의 정보테이블  -->
                        <%  ArrayList<GraphDTO> temp = new FarmDAO().temp_HL(f_seq, startday);
                         	ArrayList<GraphDTO> humi = new FarmDAO().humi_HL(f_seq, startday);
                         	ArrayList<GraphDTO> soil = new FarmDAO().soil_HL(f_seq, startday);
                         	ArrayList<GraphDTO> insol = new FarmDAO().insol_HL(f_seq, startday);
                        %>
                        <table class="table table-bordered">
                           <thead>
                              <tr>
                                 <th>구분</th>
                                 <th>현재</th>
                                 <th>최고</th>
                                 <th>최고시간</th>
                                 <th>최저</th>
                                 <th>최저시간</th>
                              </tr>
                           </thead>
                           <tbody>
                              <tr>
                              <%if (temp.size()!=0){ %>
                                 <td>온도</td>
                                 <td><%=temp.get(0).getEnv_HL() %>°C</td>
                                 <td><%=temp.get(0).getTime() %></td>
                                 <td><%=temp.get(1).getEnv_HL() %>°C</td>
                                 <td><%=temp.get(1).getTime() %></td>
                                <%}else{ %>
                                 <td>온도</td>
                                 <td>없음</td>
                                 <td>없음</td>
                                 <td>없음</td>
                                 <td>없음</td>
                                 <%} %>
                              </tr>
                              <tr>
                                 <%if (humi.size()!=0){ %>
                                 <td>습도</td>
                                 <td><%=humi.get(0).getEnv_HL() %>%</td>
                                 <td><%=humi.get(0).getTime() %></td>
                                 <td><%=humi.get(1).getEnv_HL() %>%</td>
                                 <td><%=humi.get(1).getTime() %></td>
                                <%}else{ %>
                                 <td>습도</td>
                                 <td>없음</td>
                                 <td>없음</td>
                                 <td>없음</td>
                                 <td>없음</td>
                                 <%} %>
                              </tr>
                              <tr>
                                 <%if (insol.size()!=0){ %>
                                 <td>일사량</td>
                                 <td><%=insol.get(0).getEnv_HL() %>kWh/㎡</td>
                                 <td><%=insol.get(0).getTime() %></td>
                                 <td><%=insol.get(1).getEnv_HL() %>kWh/㎡</td>
                                 <td><%=insol.get(1).getTime() %></td>
                                <%}else{ %>
                                 <td>일사량</td>
                                 <td>없음</td>
                                 <td>없음</td>
                                 <td>없음</td>
                                 <td>없음</td>
                                 <%} %>
                              </tr>
                              <tr>
                                <%if (soil.size()!=0){ %>
                                 <td>토양습도</td>
                                 <td><%=soil.get(0).getEnv_HL() %>%</td>
                                 <td><%=soil.get(0).getTime() %></td>
                                 <td><%=soil.get(1).getEnv_HL() %>%</td>
                                 <td><%=soil.get(1).getTime() %></td>
                                <%}else{ %>
                                 <td>토양습도</td>
                                 <td>없음</td>
                                 <td>없음</td>
                                 <td>없음</td>
                                 <td>없음</td>
                                 <%} %>
                              </tr>
                           </tbody>
                        </table>
                        <center>
                           <!-- 농장하루평균차트 -->
                           <a href="ChartDay.jsp?seq=<%=f_seq%>&startday=TO_CHAR(SYSDATE, 'YYYY-MM-DD')"> <button type="submit" class="btn btn-primary btn-lg"><i class="lnr lnr-chevron-left-circle"></i>&nbsp;&nbsp;일일차트&nbsp;&nbsp;<i class="bi bi-graph-up-arrow"></i></button></a>
                           <!-- 농장평균차트 -->
                           <a href="ChartAvg.jsp?seq=<%=f_seq%>&startday=TO_CHAR(SYSDATE, 'YYYY-MM-DD')"> <button type="submit" class="btn btn-primary btn-lg">평균차트&nbsp;&nbsp;<i class="bi bi-bar-chart-line"></i>&nbsp;&nbsp;<i class="lnr lnr-chevron-right-circle"></i></button></a>
                        </center>
                        <br>                        
   <%
 		CommunityDAO cmt = new CommunityDAO();
 		ArrayList<CommunityDTO> cmtList = cmt.getFcmtList(f_seq);
 	%>
                        <div class="panel panel-scrolling">
                           <div class="panel-heading">
                              <h3 class="panel-title">댓글</h3>
                              <div class="right">
                                 <button type="button" class="btn-toggle-collapse"><i
                                       class="lnr lnr-chevron-up"></i></button>
                              </div>
                           </div>
                           <div class="panel-body">
                           <%
	if(cmtList.size() != 0){
 	%>
                              <ul class="list-unstyled activity-list">
                              <%for(int i = 0; i<cmtList.size(); i++){ 
                              		MemberDTO otherprofile = new MemberDAO().otherinfo(cmtList.get(i).getM_id());%>
                                <li>
                                   <img src="assets/img/<%=otherprofile.getM_profile() %>" alt="Avatar" class="img-circle pull-left avatar">
                                   <p>
								<a style="font-size : 18px; font-weight:bolder;" href="#" id="cmt_writer<%= cmtList.get(i).getCmt_seq() %>"><%= cmtList.get(i).getM_id() %>&nbsp;&nbsp;</a> 
								
								<span  style="font-size : 16px" id="cmt_content<%= cmtList.get(i).getCmt_seq() %>"> <%= cmtList.get(i).getCmt_content() %></span>
								<span class="timestamp" id="cmt_date<%=cmtList.get(i).getCmt_seq() %>"><%= cmtList.get(i).getCmt_date() %></span> 
									
								<div style ="text-align: right; padding-right: 5%;">
									<span id="likeNum<%= cmtList.get(i).getCmt_seq() %>"><%= cmtList.get(i).getCmt_like() %></span> 
									<span> 
									<!-- 로그인한 회원이 해당 댓글에 좋아요를 누르지 않은 경우 기본적으로 좋아요 버튼 --> 
										<% if(cmt.isLike(cmtList.get(i).getCmt_seq(), userID) == 0){ %>
										<button class="heartbtn" id="like<%= cmtList.get(i).getCmt_seq() %>" onClick="likes(<%= cmtList.get(i).getCmt_seq() %>)"><img id="heart" src="img/heart.png"></button> 
										<%} else{ %> <!-- 로그인한 회원이 해당 댓글을 좋아요 누른 경우 기본적으로 좋아요 취소 버튼 -->
										<button class="heartbtn" id="dislike<%= cmtList.get(i).getCmt_seq() %>" onClick="dislikes(<%= cmtList.get(i).getCmt_seq() %>)"><img id="heart" src="img/heartfull.png"></button>
										<%} %> <!-- 댓글의 작성자만 수정/삭제 가능하도록 조건문 추가 --> 
										<% if(userID.equals(cmtList.get(i).getM_id())) {%>
										<button class="btn btn-default" id="cmt_edit<%= cmtList.get(i).getCmt_seq() %>" onClick="cmtEdit(<%= cmtList.get(i).getCmt_seq() %>)" style="font-size : 13px">수정</button>
										<button class="btn btn-default" id="cmt_delete<%= cmtList.get(i).getCmt_seq() %>" onClick="cmtDelete(<%= cmtList.get(i).getCmt_seq() %>)" style="font-size : 13px">삭제</button> 
								</div>
										<%} %>
								</span>
								</p>
                                 </li>
                                 <%}
                              }%>
                              </ul>
                           </div>
                        </div>
                        <!-- END 댓글 -->
                        <%
							if(info != null){
						%>
						<form action="WriteFCmtService.do?t_farm_seq=<%=f_seq%>" method="post">
							<div class="input-group">
								<input type="hidden" name="fcmtWriter" placeholder="<%=userID%>" value="<%=userID%>"> 
								<input class="form-control" name="fcmtContent" placeholder="댓글을 입력해주세요" type="text">
								<span class="input-group-btn">
									<button class="btn btn-primary" type="submit">작성</button>
								</span>
						</form> <!-- 작성btton 클릭시 =>  댓글 테이블 t_comment --><%} %>
                     </div>
                     <!-- 댓글달기 end -->
                  </div>
                  <!-- END RIGHT COLUMN -->
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
   </footer>
   </div>

   <!-- END WRAPPER -->
   <!-- Javascript -->

   <!-- 현재날짜 기본값으로 세팅하는 js -->
   <script>
      document.getElementById('currentDate').value = new Date().toISOString().substring(0, 10);
    </script>
    <!-- 현재날짜 기본값으로 세팅하는 js 끝.-->
    
   <script src="assets/vendor/jquery/jquery.min.js"></script>
   <script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
   <script src="assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
   <script src="assets/scripts/klorofil-common.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>

</body>

</html>