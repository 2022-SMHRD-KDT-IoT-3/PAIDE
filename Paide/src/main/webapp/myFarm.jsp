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
   <link rel="stylesheet" type="text/css" media="screen">
   <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
   <script src="https://kit.fontawesome.com/def66b134a.js" crossorigin="anonymous"></script>

   /* 댓글 */
   <style>
      #form-commentInfo {
         width: 100%;
      }

      #comment-count {
         margin-bottom: 10px;
      }

      #comment-input {
         width: 50%;
         height: 3.3em;
      }

      #submit {
         background-color: #3f7647;
         width: 5.5em;
         height: 3.3em;
         ;
         font-size: 15px;
         font-weight: bold;
         color: aliceblue;
      }

      #voteUp,
      #voteDown {
         width: 3.5em;
         height: 1.9em;
         background-color: aqua;
      }

      #comments {
         margin-top: 10px;
      }

      .eachComment {
         width: 50%;
         margin: 10px;
         padding: 0.5em;
         border-bottom: 1px solid #c1bcba;
      }

      .eachComment .name {
         font-size: 1.5em;
         font-weight: bold;
         margin-bottom: 0.3em;
         display: flex;
         justify-content: space-between;
      }

      .eachComment .inputValue {
         font-size: 1.2em;
         font-style: italic;
      }

      .eachComment .time {
         font-size: 0.7em;
         color: #c1bcba;
         font-style: oblique;
         margin-top: 0.5em;
         margin-bottom: 0.5em;
      }

      .eachComment .voteDiv {
         display: flex;
         justify-content: flex-end;
      }

      .eachComment .deleteComment {
         background-color: red;
         color: aliceblue;
      }
   </style>

</head>

<body>
	<% 
      	MemberDTO info = (MemberDTO)session.getAttribute("info");
	ArrayList<String> farmlist = new FarmDAO().myfarm(info.getM_id());  
	
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
            <a href="index.jsp"><img src="assets/img/pidelogoSmall.png" alt="piede Logo"
                  class="img-responsive logo"></a>
         </div>
         <div class="container-fluid">
            <div class="navbar-btn">
               <button type="button" class="btn-toggle-fullwidth"><i class="lnr lnr-arrow-left-circle"></i></button>
            </div>
            <form class="navbar-form navbar-left" method="post" name="search" action="SearchArticleService.do">
               <div class="input-group">
                  <table>
                     <tr>
                        <td>
                           <select class="form-control" name="searchField">
                              <option value="0">선택</option>
                              <option value="article_title">제목</option>
                              <option value="writer">작성자</option>
                           </select>
                        </td>
                        <td>
                           <input type="text" class="form-control" placeholder="Search dashboard..." name="searchText"
                              maxlength="100">
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
                     <a href="#" class="dropdown-toggle" data-toggle="dropdown"><img src="assets/img/user.png"
                           class="img-circle" alt="Avatar"> <span> <%= info.getM_name() %> </span> <i
                           class="icon-submenu lnr lnr-chevron-down"></i></a>
                     <ul class="dropdown-menu">
                        <li><a href="myFarm.jsp"><i class="lnr lnr-leaf"></i> <span>내 농장</span></a></li>
                        <li><a href="updateMember.jsp"><i class="lnr lnr-cog"></i> <span>회원정보수정</span></a></li>
                        <li><a href="LogoutServiceCon.do"><i class="lnr lnr-exit"></i> <span>로그아웃</span></a></li>
                     </ul>
                  </li>
                  <li class="dropdown">
                     <a href="#" class="dropdown-toggle icon-menu" data-toggle="dropdown">
                        <i class="lnr lnr-bubble"></i>
                        <span class="badge bg-danger"> <%
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
                        <span class="badge rounded-pill bg-success">5</span>
                     </a>
                     <!-- ? 대매니 : m_id가 아니라 subscriptioned_id (이웃의 아이디)가  들어가야하는 거 아닌가요? 
                                사용자의 이웃의 수 만큼 li 반복 되어야합니다  -->
                     <!-- "m_id"의 코드가 들어가고, 클릭 시, 해당 회원의 농장화면으로 넘어감. -->

                     <ul id='neighbor' class="dropdown-menu notifications">
                        <li><a href="OtherFarm.jsp" class="notification-item"><span
                                 class="lnr lnr-user"></span>&nbsp;damin0722</a></li>
                        <li><a href="OtherFarm.jsp" class="notification-item"><span
                                 class="lnr lnr-user"></span>&nbsp;chanyoung0831</a></li>
                        <li><a href="OtherFarm.jsp" class="notification-item"><span
                                 class="lnr lnr-user"></span>&nbsp;seolmi0303</a></li>
                        <li><a href="OtherFarm.jsp" class="notification-item"><span
                                 class="lnr lnr-user"></span>&nbsp;hyeonji2231</a></li>
                        <li><a href="OtherFarm.jsp" class="notification-item"><span
                                 class="lnr lnr-user"></span>&nbsp;jingwan1996</a></li>
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
                  <li><a href="commu_E.jsp" class=""><i class="lnr lnr-list"></i> <span>체험농장</span></a></li>
                  <li><a href="commu_W.jsp" class=""><i class="lnr lnr-list"></i> <span>농촌일자리</span></a></li>
                  <li><a href="commu_F.jsp" class=""><i class="lnr lnr-list"></i> <span>자유게시판</span></a></li>

                  <!-- 로그아웃시 삭제2 start -->
                  <% if(info != null){%>
                  <li>
                     <a href="#subPages" data-toggle="collapse" class="active"><i class="lnr lnr-user"></i>
                        <span><%= info.getM_name() %></span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
                     <div id="subPages" class="collapse in">
                        <ul class="nav">
                           <li><a href="myFarm.jsp" class="active"><i class="lnr lnr-leaf"></i>내 농장</a></li>
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
                              <img src="assets/img/user-medium.png" class="img-circle" alt="Avatar">
                              <!-- 로그인한 회원 이름변수 ㄱ -->
                              <h3 class="name"><%= info.getM_name() %></h3>
                           </div>
                        </div>
                        <!-- END PROFILE HEADER -->
                        <!-- PROFILE DETAIL -->
                        <div class="profile-detail">
                           <div class="profile-info">
                              <!-- 변경 선택한 농장의 정보로 변경 -->
                              <% FarmDTO Farminfo = new FarmDAO().myFarm(info.getM_id()); %>
                              <h4 class="heading">회원정보</h4>
                              <ul class="list-unstyled list-justify">
                                 <li>농장주소 <span><%= Farminfo.getF_region() %></span></li>
                                 <li>재배작목 <span><%= Farminfo.getF_crops() %></span></li>
                                 <li>재배시설 <span><%= Farminfo.getF_facility() %></span></li>
                              </ul>
                              <br>
                              
                              <!-- 변경 : 환경정보에 따라서 바뀌어야 함. 정보가 범주를 벗어나면 글자색 빨간색  경고창 기능 추가-->
                              
                              <span class="fa fa-bell award-icon"></span> <span style="color:#3f7647"><strong>현재 온실은 정상 범위 입니다.</strong></span>
                          <!--<span class="fa fa-bell award-icon"></span>  <span style="color:red">현재 온실의[]이 정상 범위를 넘어섰습니다. 환경을 조정해주세요.</span>  -->
                           <!-- 실시간현재 날짜/시간 -->
                              <div id="current_date"> 
                                 <script>
                                    date = new Date();
                                    year = date.getFullYear();
                                    month = date.getMonth() + 1;
                                    day = date.getDate();
                                    document.getElementById("current_date").innerHTML = year + "/" + month + "/" + day +" ";
                                    let today = new Date();
                                    let hours = today.getHours(); // 시
                                    let minutes = today.getMinutes();  // 분
                                    document.write(hours + ':' + minutes);
                                 </script>
                              </div>
                              <br>
                              <center>
                              <!-- 자세히 보기 클릭시 현재 선택한 농장정보 페이지(차트,테이블 있는 곳)로 이동  -->
                                 <a href="myFarm_detail.jsp"> <button type="button"
                                       class="btn btn-primary">자세히보기</button></a>
                              </center>
                           </div>
                           <!-- current_date끝 -->
                        </div>
                        <!-- END PROFILE DETAIL -->
                     </div>
                     <!-- END LEFT COLUMN -->
                     <!-- RIGHT COLUMN -->
                     <div class="profile-right">
                        <strong>농장선택</strong>
                        <!-- 변경 회원의 등록된 농장으로 변경 -->
                        <div class="input-group">
                           <select class="form-control">
                              <option value="cheese">대매니 농장</option>
                              <option value="tomatoes">다민이의 토마토농장</option>
                              <option value="mozarella">Mozzarella</option>
                              <option value="mushrooms">Mushrooms</option>
                              <option value="pepperoni">Pepperoni</option>
                              <option value="onions">Onions</option>
                           </select>
                           <span class="input-group-btn"><button class="btn btn-primary"
                                 type="button">선택</button></span>
                        </div>
                        <br><br>
                        <h4 class="heading">농장정보</h4>

                        <!-- AWARDS -->
                        <div class="awards">
                           <div class="row">
                              <div class="col-md-3 col-sm-6">
                                 <div class="award-item">
                                    <div class="hexagon">
                                       <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-brightness-high-fill" viewBox="0 0 16 16">
                                          <path d="M12 8a4 4 0 1 1-8 0 4 4 0 0 1 8 0zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z"/>
                                       </svg>
                                    </div>
                                    <!-- 변경 현재 선택한 농장에 대한 현재 값 불러오는 변수설정 -->
                                    <span>일사량(1200W/㎡)</span>
                                 </div>
                              </div>
                              <div class="col-md-3 col-sm-6">
                                 <div class="award-item">
                                    <div class="hexagon">
                                       <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-droplet-half" viewBox="0 0 16 16">
                                          <path fill-rule="evenodd" d="M7.21.8C7.69.295 8 0 8 0c.109.363.234.708.371 1.038.812 1.946 2.073 3.35 3.197 4.6C12.878 7.096 14 8.345 14 10a6 6 0 0 1-12 0C2 6.668 5.58 2.517 7.21.8zm.413 1.021A31.25 31.25 0 0 0 5.794 3.99c-.726.95-1.436 2.008-1.96 3.07C3.304 8.133 3 9.138 3 10c0 0 2.5 1.5 5 .5s5-.5 5-.5c0-1.201-.796-2.157-2.181-3.7l-.03-.032C9.75 5.11 8.5 3.72 7.623 1.82z"/>
                                          <path fill-rule="evenodd" d="M4.553 7.776c.82-1.641 1.717-2.753 2.093-3.13l.708.708c-.29.29-1.128 1.311-1.907 2.87l-.894-.448z"/>
                                        </svg>
                                    </div>
                                     <!-- 변경 현재 선택한 농장에 대한 현재 값 불러오는 변수설정 -->
                                    <span>토양습도(99%)</span>
                                 </div>
                              </div>
                              <div class="col-md-3 col-sm-6">
                                 <div class="award-item">
                                    <div class="hexagon">
                                       <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-thermometer-half" viewBox="0 0 16 16">
                                          <path d="M9.5 12.5a1.5 1.5 0 1 1-2-1.415V6.5a.5.5 0 0 1 1 0v4.585a1.5 1.5 0 0 1 1 1.415z"/>
                                          <path d="M5.5 2.5a2.5 2.5 0 0 1 5 0v7.55a3.5 3.5 0 1 1-5 0V2.5zM8 1a1.5 1.5 0 0 0-1.5 1.5v7.987l-.167.15a2.5 2.5 0 1 0 3.333 0l-.166-.15V2.5A1.5 1.5 0 0 0 8 1z"/>
                                        </svg>
                                    </div>
                                     <!-- 변경 현재 선택한 농장에 대한 현재 값 불러오는 변수설정 -->
                                    <span>기온(25℃)</span>
                                 </div>
                              </div>
                              <div class="col-md-3 col-sm-6">
                                 <div class="award-item">
                                    <div class="hexagon">
                                       <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-cloud-rain" viewBox="0 0 16 16">
                                          <path d="M4.158 12.025a.5.5 0 0 1 .316.633l-.5 1.5a.5.5 0 0 1-.948-.316l.5-1.5a.5.5 0 0 1 .632-.317zm3 0a.5.5 0 0 1 .316.633l-1 3a.5.5 0 0 1-.948-.316l1-3a.5.5 0 0 1 .632-.317zm3 0a.5.5 0 0 1 .316.633l-.5 1.5a.5.5 0 0 1-.948-.316l.5-1.5a.5.5 0 0 1 .632-.317zm3 0a.5.5 0 0 1 .316.633l-1 3a.5.5 0 1 1-.948-.316l1-3a.5.5 0 0 1 .632-.317zm.247-6.998a5.001 5.001 0 0 0-9.499-1.004A3.5 3.5 0 1 0 3.5 11H13a3 3 0 0 0 .405-5.973zM8.5 2a4 4 0 0 1 3.976 3.555.5.5 0 0 0 .5.445H13a2 2 0 0 1 0 4H3.5a2.5 2.5 0 1 1 .605-4.926.5.5 0 0 0 .596-.329A4.002 4.002 0 0 1 8.5 2z"/>
                                        </svg>
                                    </div>
                                     <!-- 변경 현재 선택한 농장에 대한 현재 값 불러오는 변수설정 -->
                                    <span>습도(89%)</span>
                                 </div>
                              </div>
                           </div>

                        </div>
                        <!-- END AWARDS -->
                        <!-- TABBED CONTENT -->
                           <!-- 이모티콘 왜안대액 <i class="fa fa-refresh"></i> -->
                           <!-- 업데이트 버튼을 누를시에 현재 선택한 농장의 실시간 정보가 넘어와야함  -->
                           <center>
                              <button type="button" class="btn btn-primary" onClick="window.location.reload()">
                              <i class="fa fa-refresh"></i> 업데이트</button>
                              <!-- 변경 마지막으로업데이트된시간 -->
                               <p class="text-success"> (2022/03/26 12:21)</p>
                           </center>
                        </div>
                        <!-- END TABBED CONTENT -->
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
   <script src="assets/vendor/jquery/jquery.min.js"></script>
   <script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
   <script src="assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
   <script src="assets/scripts/klorofil-common.js"></script>
   <!--아이콘 왜안댐?  <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script> -->
   <!-- <script src="https://kit.fontawesome.com/a20ebfca81.js" crossorigin="anonymous"></script> -->

</body>

</html>