<%@ page language="java" contentType="text/html; charset=UTf-8"
    pageEncoding="UTf-8"%>

<!doctype html>
<html lang="en">

<head>
   <title>PAI:DE | commuWrite.게시판글쓰기</title>
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

<style>

   table.table2{
           border-collapse: separate;
           border-spacing: 1px;
           text-align: left;
           line-height: 1.5;
           border-top: 1px solid #ccc;
           margin : 20px 10px;
   }
   table.table2 tr {
            width: 50px;
            padding: 10px;
           font-weight: bold;
           vertical-align: top;
           border-bottom: 1px solid #ccc;
   }
   table.table2 td {
            width: 100px;
            padding: 10px;
            vertical-align: top;
            border-bottom: 1px solid #ccc;
   }
   
</style>

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
                  <li>
                     <a href="#subPages" data-toggle="collapse" class="active" class="collapsed"><i class="lnr lnr-user"></i> <span>송다민</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
                     <div id="subPages" class="collapse in">
                        <ul class="nav">
                           <li><a href="myFarm.jsp" class=""><i class="lnr lnr-leaf"></i>내 농장</a></li>
                           <li><a href="farmSelect.jsp" class=""><i class="lnr lnr-magnifier"></i>농장검색</a></li>
                           <li><a href="commuWrite.jsp" class="active"><i class="lnr lnr-pencil"></i>글쓰기</a></li>
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
         <div class="main-content" >
           
            <div class="container-fluid">
               <div class="panel">

              <!-- 변경 : action값 frontcontroller에서 받아옴. -->
               <form action="WriteArticleService.do" method="post" enctype = "multipart/form-data">
                  <div class="panel-heading">
                     <h3 class="panel-title">게시판 선택</h3> 
                     <br>
                     <select class="form-control">
                       <!-- 변경: value값 게시판 의미에 맞게 바꿈. -->
                        <option name="category" value="trade">농산물직거래</option>
                        <option name="category" value="experience">체험농장</option>
                        <option name="category" value="farmjob">농촌일자리</option>
                        <option name="category" value="free_board">자유게시판</option>
                     </select>
                  </div>
                  <div class="panel-body">

                     <table class = "table2">
                     <tr>
                        <td>제목</td>
                        <td><input type = "text" name = "title" size=60 style="width:70%;float:left">
                           &nbsp;
                           <input name="fileName" type="file" style="width:28%; float: right;"></td>
                     </tr>
                     <br>
                     <br>
                     <tr>
                        <td>내용</td>
                        <td><textarea name = content cols=92 rows=15></textarea></td>
                     </tr>
                     </table>
                  
                     <center>
                        <!-- 저장을 누르면 자신이 선택한 카테고리 게시판으로 넘어가야함. -->
                       <input type="submit" class="btn btn-primary" value="저장"> <a href="myFarm.jsp"><button type="button" class="btn btn-primary" value="취소">취소</button></a>
                     </center>
                </form>  
                  <!-- form태그 버튼 까지 씌워서 버튼 값이 넘어갈 수 있게 함. -->
                  </div>
               </div>  
               
               
               
            </div>
         </div>
         

           
         <!-- END MAIN CONTENT -->
      </div>
      <!-- END MAIN -->
      <div class="clearfix"></div>
      
      <br>
      <br>
      
      
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