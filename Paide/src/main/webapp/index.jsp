<%@page import="Model.SubscriptionDTO"%>
<%@page import="Model.SubscriptionDAO"%>
<%@page import="Model.FarmDTO"%>
<%@page import="java.lang.ProcessHandle.Info"%>
<%@page import="Model.FarmDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.CommunityDAO"%>
<%@page import="Model.CommunityDTO"%>
<%@page import="Model.MemberDAO"%>
<%@page import="Model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTf-8"
    pageEncoding="UTf-8"%>
    
<!doctype html>
<html lang="en">

<head>
   <title> PAI:DE | index.메인</title>
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
   <link rel="stylesheet" href="assets/css/style copy.css">

   <script src="https://kit.fontawesome.com/51db22a717.js" crossorigin="anonymous"></script>

   <!-- FOR DEMO PURPOSES ONLY. You should remove this in your project -->
   <link rel="stylesheet" href="assets/css/demo.css">

   <!-- GOOGLE FONTS -->
   <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700" rel="stylesheet">
   <link rel="preconnect" href="https://fonts.googleapis.com">
   <link rel="preconnect" href="https://fonts.gstatic.com" 교차 출처>
   <link href="https: //fonts.googleapis.com/css2? family= 노토+산스+KR:wght@400;500;700;900 & display=swap"
      rel="stylesheet">

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
               <button type="button" class="btn-toggle-fullwidth"><i class="lnr lnr-arrow-left-circle"></i></button>
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
                   ArrayList<FarmDTO> farmlist = new FarmDAO().myfarm(info.getM_id());
                   ArrayList<SubscriptionDTO> sublist = new SubscriptionDAO().sub_list(info.getM_id());%>
                  <li class="dropdown">
                     <a href="#" class="dropdown-toggle" data-toggle="dropdown"><img src="assets/img/<%= info.getM_profile() %>"
                           class="img-circle" alt="Avatar" id="profile"> <%= info.getM_name() %> 
                            <i class="icon-submenu lnr lnr-chevron-down"></i></a>
                     <ul class="dropdown-menu">
                     <% if(farmlist.size()>0){ %>
                        <li><a href="myFarm.jsp?seq=<%=farmlist.get(0).getF_seq()%>"><i class="lnr lnr-leaf"></i> <span>내 농장</span></a></li>
                        <%} %>
                        <li><a href="updateMember.jsp"><i class="lnr lnr-cog"></i> <span>회원정보수정</span></a></li>
                        <li><a href="LogoutServiceCon.do"><i class="lnr lnr-exit"></i> <span>로그아웃</span></a></li>
                     </ul>
                  </li>
                  <li class="dropdown">
                     <a href="#" class="dropdown-toggle icon-menu" data-toggle="dropdown">
                        <i class="lnr lnr-bubble"></i>
                        <span class="badge bg-danger">
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
                  <li><a href="index.jsp" class="active"><i class="lnr lnr-home"></i> <span>Home</span></a></li>
                  <li><a href="commu_D.jsp" class=""><i class="lnr lnr-list"></i> <span>농산물 직거래</span></a></li>
                  <li><a href="commu_E.jsp" class=""><i class="lnr lnr-list"></i> <span>체험농장</span></a></li>
                  <li><a href="commu_W.jsp" class=""><i class="lnr lnr-list"></i> <span>농촌일자리</span></a></li>
                  <li><a href="commu_F.jsp" class=""><i class="lnr lnr-list"></i> <span>자유게시판</span></a></li>

                  <!-- 로그아웃시 삭제2 start -->
                  <% if(info != null){
                  ArrayList<FarmDTO> farmlist = new FarmDAO().myfarm(info.getM_id());%>
                  <li>
                     <a href="#subPages" data-toggle="collapse" class="collapsed"><i class="lnr lnr-user"></i>
                        <span><%= info.getM_name() %></span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
                     <div id="subPages" class="collapse ">
                        <ul class="nav">
                        <%if(farmlist.size()>0){ %>
                         <li><a href="myFarm.jsp?seq=<%=farmlist.get(0).getF_seq()%>"><i class="lnr lnr-leaf"></i> <span>내 농장</span></a></li>
                        <%}%>
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
               <div class="panel panel-headline">
                  <div class="wrap">
                     <div class="intro_bg">
                        <div class="header">
                           <div class="intro_text">
                              <h1 style="font-weight: 600;"> 농업은 식량과 관련된 문제이기 때문에, </h1>
                              <h1 style="font-weight: 600;"> 누구나 습득할 수 있는 보편적인 지식이 되어야 합니다 </h1>
                              <br>
                              <br>
                              <h4 style="font-weight: 400;"> 농사를 짓는 과정에서 상이한 농가시설환경의 정보 불균형을 해소하기 위해 </h4>
                              <h4 style="font-weight: 400;"> 데이터의 축척하여 수치화된 객관적인 데이터를 기반으로 </h4>
                              <h4 style="font-weight: 400;"> 농민들의 효율적인 농가운영을 가능하게 합니다. </h4>
                              <h1 style="font-size: 55px; text-align: center; padding-top: 150px;">what&nbsp;?</h1>
                           </div>
                        </div>
                     </div>
                     <!-- amount 시작 -->
                     <ul class="amount">
                        <li>
                           <div>
                              <div class="content1"> 가이드 시스템 </div>
                              <div> 환경 알람시스템 </div>
                           </div>
                        </li>
                        <li>
                           <div>
                              <div class="content1"> 데이터 수집</div>
                              <div> 사용자 맞춤화 데이터</div>
                           </div>
                        </li>
                        <li>
                           <div>
                              <div class="content1"> 객관적데이터 </div>
                              <div> 생산량 극대화</div>
                           </div>
                        </li>
                        <li>
                           <div>
                              <div class="content1"> 농업 지식의 공유 </div>
                              <div> 보편적 지식획득 </div>
                           </div>
                        </li>
                     </ul>
                     <!-- amount 끝 -->
                     <!-- 솔루션 -->
                     <div class="main_text0">
                        <h1 style="font-size: 45px;">HOW&nbsp;?</h1>
                        <ul class="icons">
                           <li>
                              <div class="icons_img">
                                 <img style="width: 100px; height:100px;"
                                    src="assets/img/데이터 시각화.png" alt="">
                              </div>
                              <div class="content1"> 농장데이터시각화</div>
                              <div> 수집된 데이터를 일일차트, 평균차트 <br>각각의 데이터에 적합한 그래프로 
                                 시각화하여 제공합니다. </div>
                           </li>
                           <li>
                              <div class="icons_img">
                                 <img style="width: 100px; height:100px;"
                                    src="assets/img/데이터공유.png"
                                    alt="데이터 시각화">
                              </div>
                              <div class="content1"> 데이터공유 </div>
                              <div>자신 농장과 비슷한 조건의 농장을   
                                 <br>검색할 수 있으며 게시판, 농장페이지에서 
                                 <br>댓글로 의견을 교환할 수 있습니다.

                                   </div>
                           </li>
                           <li>
                              <div class="icons_img">
                                 <img style="width: 100px; height:100px;"
                                    src="assets/img/센서데이터.png" alt="센서데이터">
                              </div>
                              <div class="content1"> 센서데이터 </div>
                              <div>센서로 온습도, 이산화탄소, 계도 등을 측정하여 <br>
                                 온실 내 특이사항 발생시 LED점등으로 경고, <br>
                                  LCD를 통한 실시간 데이터 값 확인 가능합니다. </div>
                           </li>
                        </ul>
                     </div>
                     <!-- 솔루션 끝  -->
                     <h1 style="font-size: 45px; text-align: center;">Who&nbsp;?</h1>
                     <div class="content1" style="margin-top: -30px; text-align: center;">이와 같은 솔루션을 농업 플랫폼인 '파이데'로 제공합니다.</div>
                     <div class="row" ">
                        <div class="col-md-6" style="text-align: right; ">
                           <img style="border-radius: 50px;"
                              src="assets/img/paidelogo.jpg" alt="파이데로고">
                        </div>
                        <div class="col-md-6">
                           <!-- <h2>도전 오전 </h2> -->
                           <div style="background-color: #3f7647; border-radius: 50px; height: 100px; width: 300px;">
                              <p style="color: #fff; text-align: center;   font-size: 20px; font-weight: 700; padding-top: 2%;"> our
                                 <br> Plant Guide
                              <h4 style="color: #fff; text-align: center; font-size: 15px;">:&nbsp;&nbsp;농업인의 가이드</h4> 
                           </div>
                        </div>
                     </div>
                  </div>
                  <!-- 설치 설명  1 -->
                  <div class="row" style="margin-top: 10%;">
                     <div class="col-md-4">
                        
                        <img style="width:100%; text-align: center;" src="assets/img/설치1.png" alt="설치사진1"
                           class="img-responsive">
                           <h2 calss="step">
                              step.1
                           </h2>
                        <p >
                           농장의 중앙부 상단에 
                        <br>데이터수집기를 달아주세요.
                        
                        </p>
                     </div>
                     <div class="col-md-4">
                        <img style="width:100%; text-align: center;" src="assets/img/설치2.png" alt="설치사진2"
                           class="img-responsive">
                           <h2 calss="step">
                              step.2
                           </h2>
                        <p>
                           토양습도센서를 토양에 꼽아주세요
                        </p>
                     </div>
                     <div class="col-md-4">
                        <img style="width:100%; text-align: center;" src="assets/img/설치3.png" alt="설치사진3"
                           class="img-responsive">
                           <h2 calss="step">
                              step.3
                           </h2>
                        <p>
                           데이터 수집기내부의 연결선상태를 
                           <br>확인후 전원을 켜주세요
                        </p>
                     </div>
                  </div>
                  <!-- 설치설명1 끝 -->
                  <!-- 설치완료 -->
                  <div class="row" style="margin-top: 3%; text-align: right; padding: 2%; " >
                     <div class="col-md-6" >
                        <img style="width:100%; padding-left: 25%;" src="assets/img/수집기.jpg" alt="수집기"
                           class="img-responsive">
                           
                     </div>
                     <div class="col-md-6" id="right" >
                        <img style="width:100%; padding-right: 25%;" src="assets/img/LCD확인.png" alt="LCD확인"
                           class="img-responsive">
                           <h2 calss="step" >설치완료</h2>
                        <p>
                           수집기의 데이터는  파이데의 내농장 페이지에서 조회 가능하며,<br>
                           수신기의 LCD와 LED의 상태알림으로 현장에서도 <br> 직관적으로 농장의 상태를 확인 할 수 있습니다.
                        </p>
                        <p style="padding-left : 25%;">
                           <a class="btn btn-primary btn-large" href="page-join.jsp" > JOIN US &nbsp;<i class="lnr lnr-leaf"></i> </a>
                        </p>
                     </div>
                  </div>
                  <div class="row" style="padding-left: 3%;">
                     <div class="col-md-12" >
                        <p style="text-align: center;">
                           <br><br><br><br><br><br><br>
                           <a class="btn" href="#"> 맨위로 </a>
                           <br>
                        </p>
                        <address>
                            <br><strong>PAI:DE, Inc.</strong><br /> address : 광주광역시 동구 예술길 31-15 3, 4, 7층<br />  tel : (062) 123-1234
                        </address>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- END MAIN CONTENT -->
      <!-- END MAIN -->
    
         <div class="clearfix"></div>
         <footer>
            <div class="container-fluid">
               <div class="copyright-wrap">
                  <span>Copyright © PAIDE Corp. All Rights Reserved.</span>
               </div>
            </div>
         </footer>
      </div>
      <!-- END WRAPPER -->

      <!-- END WRAPPER -->
      <!-- Javascript -->
      <script src="assets/vendor/jquery/jquery.min.js"></script>
      <script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
      <script src="assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
      <script src="assets/vendor/jquery.easy-pie-chart/jquery.easypiechart.min.js"></script>
      <script src="assets/vendor/chartist/js/chartist.min.js"></script>
      <script src="assets/scripts/klorofil-common.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
     
</body>

</html>