<%@ page language="java" contentType="text/html; charset=UTf-8"
    pageEncoding="UTf-8"%>
    
<!doctype html>
<html lang="en">

<head>
   <title> PAI:DE | boardSelect.게시글</title>
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
   

</head>

<body>
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
                         <a href="#" class="dropdown-toggle" data-toggle="dropdown"><img src="assets/img/user1.png"
                                 class="img-circle" alt="Avatar"> <span> 송다민 </span> <i
                                 class="icon-submenu lnr lnr-chevron-down"></i></a>
                         <ul class="dropdown-menu">
                             <li><a href="myFarm.html"><i class="lnr lnr-leaf"></i> <span>내 농장</span></a></li>
                             <li><a href="updateMember.html"><i class="lnr lnr-cog"></i> <span>회원정보수정</span></a></li>
                             <li><a href="index.html"><i class="lnr lnr-exit"></i> <span>로그아웃</span></a></li>
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
                             <li><a href="OtherFarm.html" class="notification-item"><span
                                         class="lnr lnr-user"></span>&nbsp;damin0722</a></li>
                             <li><a href="OtherFarm.html" class="notification-item"><span
                                         class="lnr lnr-user"></span>&nbsp;chanyoung0831</a></li>
                             <li><a href="OtherFarm.html" class="notification-item"><span
                                         class="lnr lnr-user"></span>&nbsp;seolmi0303</a></li>
                             <li><a href="OtherFarm.html" class="notification-item"><span
                                         class="lnr lnr-user"></span>&nbsp;hyeonji2231</a></li>
                             <li><a href="OtherFarm.html" class="notification-item"><span
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
                   <!--변경 active-> 게시글의 카테고리에 active를 넣어줘야한다   -->
                  <li><a href="index.html" class=""><i class="lnr lnr-home"></i> <span>Home</span></a></li>
                  <li><a href="commu_D.html" class="active"><i class="lnr lnr-list"></i> <span>농산물 직거래</span></a></li>
                  <li><a href="commu_E.html" class=""><i class="lnr lnr-list"></i> <span>체험농장</span></a></li>
                  <li><a href="commu_W.html" class=""><i class="lnr lnr-list"></i> <span>농촌일자리</span></a></li>
				      <li><a href="commu_F.html" class=""><i class="lnr lnr-list"></i> <span>자유게시판</span></a></li>
                  <li>
                     <a href="#subPages" data-toggle="collapse" class="collapsed"><i class="lnr lnr-user"></i> <span>송다민</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
                     <div id="subPages" class="collapse ">
                        <ul class="nav">
                           <li><a href="myFarm.html" class=""><i class="lnr lnr-leaf"></i>내 농장</a></li>
                           <li><a href="farmSelect.html" class=""><i class="lnr lnr-magnifier"></i>농장검색</a></li>
                           <li><a href="commuWrite.html" class=""><i class="lnr lnr-pencil"></i>글쓰기</a></li>
                        </ul>
                     </div>
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
                    <!-- 변경 :                                                                             선택한 게시글의 카테고리로 -->
					<h5 class="page-title"><i class="lnr lnr-home"></i> HOME <i class="lnr lnr-chevron-right"></i>농산물직거래<i class="lnr lnr-chevron-right"></i><strong>게시글</strong></h5>
					<div id="toastr-demo" class="panel">
						<div class="panel-body">
                     <div class="container-fluid">
                        <div class="row">
                           <div class="col-md-12">
                              <div class="container-fluid">
                                 <div class="row">
                                    <div class="col-md-12">
                                       <!-- 변경 : 선택한 게시글 제목 article_title -->
                                    <h3 style="text-align: center; margin: 3%;"   >수완에서 딸기 직거래 하실 분 </h3>
                                       <!--
                                       글 순번 article_seq 
                                       글 제목 article_title
                                       글 작성자 m_id
                                       글 작성일자 article_date
                                       글 첨부파일 article_file
                                       글 카테고리 article_category
                                       -->
                                       
                                       <table class="table">
                                          <thead>
                                             <tr>
                                                <th>
                                                작성일
                                                <!-- article_date -->
                                                22.03.24
                                                </th>
                                                <th>
                                                작성자
                                                <!-- m_id -->
                                                <!-- 작성자 클릭시 작성자(chanyoung0831)의 농장화면으로 이동 -->
                                                <a href="OtherFarm.html">chanyoung0831</a>
                                                </th>
                                             </tr>
                                          </thead>
                                          <tbody>
                                             <tr>
                                                <td colspan="2">
                                                   수완에서 토마토직거래하실분 있나요 맛있어요수완에서 토마토직거래하실분 있나요 맛있어요수완에서 토마토직거래하실분 있나요 맛있어요수완에서 토마토직거래하실분 있나요 맛있어요
                                                </td>
                                             </tr>
                                             <tr >
                                                <td colspan="2">
                                                   <img id = "boardimg2" alt="첨부된사진이 없습니다." src="assets/img/loginbg.jpg" /> 
                                                </td>
                                             </tr>
                                             <tr>
                                                <td colspan="2">
                                                 <!-- 변경 start 댓글  -->
                                                 <!-- 
                                                댓글 테이블 t_comment
                                                    댓글 순번 cmt_seq
                                                    원글 순번 article_seq
                                                    댓글 내용 cmt_content
                                                    댓글 작성일자 cmt_date
                                                    댓글 작성자 m_id
                                                    likes X 
                                                  -->
                                                   <div class="panel panel-scrolling">
                                                      <div class="panel-heading">
                                                         <h3 class="panel-title">댓글</h3>
                                                         <div class="right">
                                                            <button type="button" class="btn-toggle-collapse"><i class="lnr lnr-chevron-up"></i></button>
                                                         </div>
                                                      </div>
                                                      <div class="panel-body">
                                                         <ul class="list-unstyled activity-list">
                                                            <li>
                                                               <!-- 변경 댓글작성자 프로필 사진  -->
                                                               <img src="assets/img/user1.png" alt="Avatar" class="img-circle pull-left avatar">

                                                               <p><a href="#"> 댓글 작성자 m_id </a>  댓글 내용 cmt_content <span class="timestamp">  댓글 작성일자 cmt_date </span></p>
                                                            </li>
                                                            <li>
                                                               <img src="assets/img/user2.png" alt="Avatar" class="img-circle pull-left avatar">
                                                               <p><a href="#">Daniel</a> has been added as a team member to project <a href="#">System Update</a> <span class="timestamp">Yesterday</span></p>
                                                            </li>
                                                            <li>
                                                               <img src="assets/img/user3.png" alt="Avatar" class="img-circle pull-left avatar">
                                                               <p><a href="#">Martha</a> created a new heatmap view <a href="#">Landing Page</a> <span class="timestamp">2 days ago</span></p>
                                                            </li>
                                                            <li>
                                                               <img src="assets/img/user4.png" alt="Avatar" class="img-circle pull-left avatar">
                                                               <p><a href="#">Jane</a> has completed all of the tasks <span class="timestamp">2 days ago</span></p>
                                                            </li>
                                                            <li>
                                                               <img src="assets/img/user5.png" alt="Avatar" class="img-circle pull-left avatar">
                                                               <p><a href="#">Jason</a> started a discussion about <a href="#">Weekly Meeting</a> <span class="timestamp">3 days ago</span></p>
                                                            </li>
                                                         </ul>
                                                      </div>
                                                   </div>
                                                   <!-- END 댓글 -->
                                                </td>
                                             </tr>
                                             <tr>
                                                <td colspan="2">
                                                   <!-- 댓글입력창 -->
                                                   <div class="input-group">
                                                      <input class="form-control" type="text">
                                                      <span class="input-group-btn"><button class="btn btn-primary" type="button">작성</button></span>
                                                      <!-- 작성btton 클릭시 =>  댓글 테이블 t_comment -->
                                                   </div>
                                                </td>
                                             </tr>
                                          
                                          </tbody>
                                       </table>
                                    </div>
                                 </div>
                              </div>
                            
                           
                           </div>
                        </div>
                        <br>
                      
                        <br>
                        <div class="row">
                           <div class="col-md-12">
                            
                           </div>
                        </div>
                     </div>
	
			
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
         <span> 
             Copyright © PAIDE Corp. All Rights Reserved.</span>
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
   <script>
   $(function() {
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
         barColor: function(percent) {
            return "rgb(" + Math.round(200 * percent / 100) + ", " + Math.round(200 * (1.1 - percent / 100)) + ", 0)";
         },
         trackColor: 'rgba(245, 245, 245, 0.8)',
         scaleColor: false,
         lineWidth: 5,
         lineCap: "square",
         animate: 800
      });

      var updateInterval = 3000; // in milliseconds

      setInterval(function() {
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