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
   <!-- 부트스트랩아이콘 -->
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
</head>

<body>
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
                 <button type="button" class="btn-toggle-fullwidth"><i
                         class="lnr lnr-arrow-left-circle"></i></button>
             </div>
             <form class ="navbar-form navbar-left" method="post" name="search" action="SearchArticleService.do">
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
                        <input type="text" class="form-control" placeholder="Search dashboard..." name="searchText" maxlength="100">
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
                     <li class="dropdown">
                         <a href="#" class="dropdown-toggle" data-toggle="dropdown"><img src="assets/img/user.png"
                                 class="img-circle" alt="Avatar"> <span> 송다민 </span> <i
                                 class="icon-submenu lnr lnr-chevron-down"></i></a>
                         <ul class="dropdown-menu">
                             <li><a href="myFarm.jsp"><i class="lnr lnr-leaf"></i> <span>내 농장</span></a></li>
                             <li><a href="updateMember.jsp"><i class="lnr lnr-cog"></i> <span>회원정보수정</span></a></li>
                             <li><a href="index.jsp"><i class="lnr lnr-exit"></i> <span>로그아웃</span></a></li>
                         </ul>
                     </li>
                     <li class="dropdown">
                         <a href="#" class="dropdown-toggle icon-menu" data-toggle="dropdown">
                             <i class="lnr lnr-bubble"></i>
                             <span class="badge bg-danger">5</span>
                         </a>
                         <ul class="dropdown-menu notifications">
                             <li><a href="#" class="notification-item"><span class="dot bg-warning"></span>System
                                     space is
                                     almost full</a></li>
                             <li><a href="#" class="notification-item"><span class="dot bg-danger"></span>You have 9
                                     unfinished tasks</a></li>
                             <li><a href="#" class="notification-item"><span class="dot bg-success"></span>Monthly
                                     report is
                                     available</a></li>
                             <li><a href="#" class="notification-item"><span class="dot bg-warning"></span>Weekly
                                     meeting in
                                     1 hour</a></li>
                             <li><a href="#" class="notification-item"><span class="dot bg-success"></span>Your
                                     request has
                                     been approved</a></li>
                             <li><a href="#" class="more">See all notifications</a></li>
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
                  <li>
                     <a href="#subPages" data-toggle="collapse" class="active"><i class="lnr lnr-user"></i>
                        <span>송다민</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
                     <div id="subPages" class="collapse in">
                        <ul class="nav">
                           <li><a href="myFarm.jsp" class="active"><i class="lnr lnr-leaf"></i>내 농장</a></li>
                           <li><a href="farmSelect.jsp" class=""><i class="lnr lnr-magnifier"></i>농장검색</a></li>
                           <li><a href="commuWrite.jsp" class=""><i class="lnr lnr-pencil"></i>글쓰기</a></li>
                        </ul>
                     </div>
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
                              <h3 class="name">송다민</h3>
                           </div>
                        </div>
                        <!-- END PROFILE HEADER -->
                        <!-- PROFILE DETAIL -->
                        <div class="profile-detail">
                           <div class="profile-info">
                              <!-- 변경 선택한 농장의 정보로 변경 -->
                              <!-- 선택한 농장의 이름  -->
                              <h4 class="heading">대매니의 토마토농장</h4>
                              <ul class="list-unstyled list-justify">
                                 <li>농장주소 <span>광주광역시 풍영로330번길 16</span></li>
                                 <li>재배작목 <span>토마토</span></li>
                                 <li>재배시설 <span>유리온실</span></li>
                              </ul>
                              <br>
                              <br>
                              <center>
                                 <!--  나의 농장 첫번째 화면으로 돌아가기 -->
                                 <a href="myFarm.jsp"> <button type="button" class="btn btn-primary">농장홈화면</button></a>
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
                        <form action="">
                           <div class="input-group">
                              <input type="date" name="startday" id='currentDate'/>

                              <input type="submit" value="선택" class="btn btn-primary"/>
                           </div>
                        </form>
                        <br>
                        <!-- 선택한 농장의 정보테이블  -->
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
                                 <td>온도</td>
                                 <td>25℃</td>
                                 <td>29℃</td>
                                 <td>15:32</td>
                                 <td>24℃</td>
                                 <td>09:30</td>
                              </tr>
                              <tr>
                                 <td>습도</td>
                                 <td>89%</td>
                                 <td>90%</td>
                                 <td>06:40</td>
                                 <td>87%</td>
                                 <td>13:05</td>
                              </tr>
                              <tr>
                                 <td>일사량</td>
                                 <td>1200W/㎡</td>
                                 <td>1300W/㎡</td>
                                 <td>14:05</td>
                                 <td>0W/㎡</td>
                                 <td>19:30</td>
                              </tr>
                              <tr>
                                 <td>토양습도</td>
                                 <td>99%</td>
                                 <td>99%</td>
                                 <td>15:32</td>
                                 <td>89%</td>
                                 <td>09:30</td>
                              </tr>
                           </tbody>
                        </table>
                        <!-- 농장정보 테이블 끝  -->
                        <!-- 차트버튼 -->
                        <center>
                           <!-- 농장하루평균차트 -->
                           <a href="ChartDay.jsp"> <button type="button" class="btn btn-primary btn-lg"><i class="lnr lnr-chevron-left-circle"></i>&nbsp;&nbsp;일일차트&nbsp;&nbsp;<i class="bi bi-graph-up-arrow"></i></button></a>
                           <!-- 농장평균차트 -->
                           <a href="ChartAvg.jsp"> <button type="button" class="btn btn-primary btn-lg">평균차트&nbsp;&nbsp;<i class="bi bi-bar-chart-line"></i>&nbsp;&nbsp;<i class="lnr lnr-chevron-right-circle"></i></button></a>
                        </center>
                        <br>
                        <!-- 댓글달기 Start -->
                        <div class="panel panel-scrolling">
                           <div class="panel-heading">
                              <h3 class="panel-title">댓글</h3>
                              <div class="right">
                                 <button type="button" class="btn-toggle-collapse"><i
                                       class="lnr lnr-chevron-up"></i></button>
                              </div>
                           </div>
                           <div class="panel-body">
                              <ul class="list-unstyled activity-list">
                                 <!-- 변경 댓글   -->
                                 <li>
                                    <img src="assets/img/user1.png" alt="Avatar" class="img-circle pull-left avatar">
                                    <p><a href="#"> 댓글 작성자 m_id </a> 댓글 내용 cmt_content <span class="timestamp"> 댓글 작성일자 cmt_date </span></p>
                                 </li>
                                 <li>
                                    <img src="assets/img/user2.png" alt="Avatar" class="img-circle pull-left avatar">
                                    <p><a href="#">Daniel</a> has been added as a team member to project <a
                                          href="#">System Update</a> <span class="timestamp">Yesterday</span></p>
                                 </li>
                                 <li>
                                    <img src="assets/img/user3.png" alt="Avatar" class="img-circle pull-left avatar">
                                    <p><a href="#">Martha</a> created a new heatmap view <a href="#">Landing Page</a>
                                       <span class="timestamp">2 days ago</span>
                                    </p>
                                 </li>
                                 <li>
                                    <img src="assets/img/user4.png" alt="Avatar" class="img-circle pull-left avatar">
                                    <p><a href="#">Jane</a> has completed all of the tasks <span class="timestamp">2
                                          days ago</span></p>
                                 </li>
                                 <li>
                                    <img src="assets/img/user5.png" alt="Avatar" class="img-circle pull-left avatar">
                                    <p><a href="#">Jason</a> started a discussion about <a href="#">Weekly Meeting</a>
                                       <span class="timestamp">3 days ago</span>
                                    </p>
                                 </li>
                              </ul>
                           </div>
                        </div>
                        <!-- 댓글 END -->
                        <form action="#" method="" >
                           <div class="input-group">
                              <input class="form-control" type="text">
                              <span class="input-group-btn"><button class="btn btn-primary" type="submit">입력</button></span>
                           </div>
                        </form>
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

</body>

</html>
