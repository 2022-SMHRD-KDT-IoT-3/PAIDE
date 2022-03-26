<%@ page language="java" contentType="text/html; charset=UTf-8"
    pageEncoding="UTf-8"%>

<!doctype html>
<html lang="en">

<head>
   <title> PAI:DE | index_logout.메인</title>
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
		   <a href="index_logout.jsp"><img src="assets/img/pidelogoSmall.png" alt="piede Logo" class="img-responsive logo"></a>
		</div>
		<div class="container-fluid">
		   <div class="navbar-btn">
			  <button type="button" class="btn-toggle-fullwidth"><i class="lnr lnr-arrow-left-circle"></i></button>
		   </div>
		   <form class="navbar-form navbar-left">
			  <div class="input-group">
				 <input type="text" value="" class="form-control" placeholder="Search dashboard...">
				 <span class="input-group-btn"><button type="button" class="btn btn-primary">Go</button></span>
			  </div>
		   </form>
		
		   <div id="navbar-menu">
			  <ul class="nav navbar-nav navbar-right">
           
            <!-- 로그아웃-->
            <div class="navbar-btn navbar-btn-right">
               <!-- <button type="button" class="btn btn-primary">로그인</button> -->
					<a class="btn btn-primary" href="page-login.jsp"  ><i class="lnr lnr-leaf"></i> <span>   로그인</span></a>
				</div>
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
                  <li><a href="index.html" class="active"><i class="lnr lnr-home"></i> <span>Home</span></a></li>
                  <li><a href="commu_D.html" class=""><i class="lnr lnr-list"></i> <span>농산물 직거래</span></a></li>
                  <li><a href="commu_E.html" class=""><i class="lnr lnr-list"></i> <span>체험농장</span></a></li>
                  <li><a href="commu_W.html" class=""><i class="lnr lnr-list"></i> <span>농촌일자리</span></a></li>
				      <li><a href="commu_F.html" class=""><i class="lnr lnr-list"></i> <span>자유게시판</span></a></li>
                  <!-- 로그아웃 -->
                  <!-- 로그아웃시 사라지게하기 -->
               </ul>
            </nav>
         </div>
      </div>
      <!-- END LEFT SIDEBAR -->
      <!-- MAIN -->
      <div class="main">
         <!-- MAIN CONTENT -->
         <div class="main-content" >
            <h1>메인홈화면</h1>
            <div class="container-fluid">
               <!-- OVERVIEW -->
               
               <!-- END OVERVIEW -->
               <div class="row">
                  <div class="col-md-6">
                     <!-- RECENT PURCHASES -->
                     
                     <!-- END RECENT PURCHASES -->
                  </div>
                  <div class="col-md-6">
                     <!-- MULTI CHARTS -->
                     
                     <!-- END MULTI CHARTS -->
                  </div>
               </div>
               <div class="row">
                  <div class="col-md-7">
                     <!-- TODO LIST -->
                     
                     <!-- END TODO LIST -->
                  </div>
                  <div class="col-md-5">
                     <!-- TIMELINE -->
                     
                     <!-- END TIMELINE -->
                  </div>
               </div>
               <div class="row">
                  <div class="col-md-4">
                     <!-- TASKS -->
                  
                     <!-- END TASKS -->
                  </div>
                  <div class="col-md-4">
                     <!-- VISIT CHART -->
                     
                     <!-- END VISIT CHART -->
                  </div>
                  <div class="col-md-4">
                     <!-- REALTIME CHART -->
                     
                     <!-- END REALTIME CHART -->
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