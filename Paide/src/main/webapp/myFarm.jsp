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

   /* 댓글 */
   <style>
    #form-commentInfo{ 
      width: 100%;
     } 
    #comment-count{
        margin-bottom: 10px; 
      } 
    #comment-input{ 
      width: 50%; height: 3.3em; 
    } 
    #submit{ 
      background-color: #3f7647; width: 5.5em; height: 3.3em;; font-size: 15px; font-weight: bold; color: aliceblue; 
    } 
    #voteUp, #voteDown{ 
      width: 3.5em; height: 1.9em; background-color: aqua; 
    } 
    #comments{ 
      margin-top: 10px; 
    } 
    .eachComment{
      width :50%; margin: 10px; padding: 0.5em; border-bottom: 1px solid #c1bcba; 
    } 
    .eachComment .name{ 
      font-size: 1.5em; font-weight: bold; margin-bottom: 0.3em; display: flex; justify-content: space-between; 
    } 
    .eachComment .inputValue{ 
      font-size: 1.2em; font-style: italic; 
    } 
    .eachComment .time{ 
      font-size: 0.7em; color: #c1bcba; font-style: oblique; margin-top: 0.5em; margin-bottom: 0.5em; 
    } 
    .eachComment .voteDiv{ 
      display: flex; justify-content: flex-end; 
    }
     .eachComment .deleteComment{
        background-color: red; color: aliceblue; 
      }
   </style>
   
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
                        <li><a href="#" class="notification-item"><span class="dot bg-warning"></span>System space is
                              almost full</a></li>
                        <li><a href="#" class="notification-item"><span class="dot bg-danger"></span>You have 9
                              unfinished tasks</a></li>
                        <li><a href="#" class="notification-item"><span class="dot bg-success"></span>Monthly report is
                              available</a></li>
                        <li><a href="#" class="notification-item"><span class="dot bg-warning"></span>Weekly meeting in
                              1 hour</a></li>
                        <li><a href="#" class="notification-item"><span class="dot bg-success"></span>Your request has
                              been approved</a></li>
                        <li><a href="#" class="more">See all notifications</a></li>
                     </ul>
                  </li>
                  <li class="dropdown">
                     <a href="#" class="dropdown-toggle icon-menu" data-toggle="dropdown">
                        <i class="lnr lnr-heart"></i>
                        <span class="badge bg-danger">5</span>
                     </a>
                     <ul class="dropdown-menu notifications">
                        <li><a href="#" class="notification-item"><span class="dot bg-warning"></span>System space is
                              almost full</a></li>
                        <li><a href="#" class="notification-item"><span class="dot bg-danger"></span>You have 9
                              unfinished tasks</a></li>
                        <li><a href="#" class="notification-item"><span class="dot bg-success"></span>Monthly report is
                              available</a></li>
                        <li><a href="#" class="notification-item"><span class="dot bg-warning"></span>Weekly meeting in
                              1 hour</a></li>
                        <li><a href="#" class="notification-item"><span class="dot bg-success"></span>Your request has
                              been approved</a></li>
                        <li><a href="#" class="more">See all notifications</a></li>
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
                  <li><a href="index.html" class="active"><i class="lnr lnr-home"></i> <span>Home</span></a></li>
                  <li><a href="commu_D.html" class=""><i class="lnr lnr-list"></i> <span>농산물 직거래</span></a></li>
                  <li><a href="commu_E.html" class=""><i class="lnr lnr-list"></i> <span>체험농장</span></a></li>
                  <li><a href="commu_W.html" class=""><i class="lnr lnr-list"></i> <span>농촌일자리</span></a></li>
                  <li><a href="commu_F.html" class=""><i class="lnr lnr-list"></i> <span>자유게시판</span></a></li>

                  <!-- 로그아웃시 삭제2 start -->
                  <li>
                     <a href="#subPages" data-toggle="collapse" class="collapsed"><i class="lnr lnr-user"></i>
                        <span>송다민</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
                     <div id="subPages" class="collapse ">
                        <ul class="nav">
                           <li><a href="myFarm.jsp class=""><i class="lnr lnr-leaf"></i>내 농장</a></li>
                           <li><a href="farmSelect.html" class=""><i class="lnr lnr-magnifier"></i>농장검색</a></li>
                           <li><a href="commuWrite.html" class=""><i class="lnr lnr-pencil"></i>글쓰기</a></li>
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
                              <!-- 변경 대맨 -->
                              <h4 class="heading">회원정보</h4>
                              <ul class="list-unstyled list-justify">
                                 <li>농장주소 <span>광주광역시 풍영로330번길 16</span></li>
                                 <li>재배작목 <span>딸기</span></li>
                                 <li>재배시설 <span>유리온실</span></li>
                              </ul>
                              <br>
                              <strong>농장선택</strong>
                              <select class="form-control">
                                 <option value="cheese">Cheese</option>
                                 <option value="tomatoes">Tomatoes</option>
                                 <option value="mozarella">Mozzarella</option>
                                 <option value="mushrooms">Mushrooms</option>
                                 <option value="pepperoni">Pepperoni</option>
                                 <option value="onions">Onions</option>
                              </select>
                              <br>
                                 <h4 class="heading">일자</h4>
                                 <div id="current_date" ></p>
                                    <script>
                                    date = new Date();
                                    year = date.getFullYear();
                                    month = date.getMonth() + 1;
                                    day = date.getDate();
                                    document.getElementById("current_date").innerHTML =  year + "/" + month + "/" + day;
                                    </script>
                              <br><br>
                              <h4 class="heading">현재시각</h4>
                              <script>
                                 let today = new Date();   
      
                                 let hours = today.getHours(); // 시
                                 let minutes = today.getMinutes();  // 분
                                 
                                 document.write( hours + ':' + minutes);
                               </script>
                              <span class="fa fa-bell award-icon"></span> <span style="color:#3f7647"><strong>현재 온실은 정상 범위 입니다.</strong></span> 
                              <!-- 변경 : 환경정보에 따라서 바뀌어야 함. 정보가 범주를 벗어나면 경고창 기능 추가-->
                              <!-- <br>
                              <span class="fa fa-bell award-icon"></span>  <span style="color:red">현재 온실의[]이 정상 범위를 넘어섰습니다. 환경을 조정해주세요.</span>  -->
                              <br><br>
                              <center>
                                 <a href="myFarm_detail.jsp"> <button type="button" class="btn btn-primary">자세히보기</button></a>
                              </center>
                           </div>
                    
                           </div>
                        
                        </div>
                        <!-- END PROFILE DETAIL -->
                     </div>
                     <!-- END LEFT COLUMN -->
                     <!-- RIGHT COLUMN -->
                     <div class="profile-right">
                        <h4 class="heading">농장정보</h4>
                        <!-- AWARDS -->
                        <div class="awards">
                           <div class="row">
                              <div class="col-md-3 col-sm-6">
                                 <div class="award-item">
                                    <div class="hexagon">
                                       <!-- 각 농장정보에 대한 현재 값 불러오는 변수설정 -->
                                       <span class="lnr lnr-sun award-icon"></span>
                                    </div>
                                    <span>일사량(1200W/㎡)</span>
                                 </div>
                              </div>
                              <div class="col-md-3 col-sm-6">
                                 <div class="award-item">
                                    <div class="hexagon">
                                       <span class="lnr lnr-map-marker award-icon"></span>
                                    </div>
                                    <span>토양습도(99%)</span>
                                 </div>
                              </div>
                              <div class="col-md-3 col-sm-6">
                                 <div class="award-item">
                                    <div class="hexagon">
                                       <span class="fa fa-line-chart award-icon"></span>
                                    </div>
                                    <span>기온(25℃)</span>
                                 </div>
                              </div>
                              <div class="col-md-3 col-sm-6">
                                 <div class="award-item">
                                    <div class="hexagon">
                                       <span class="lnr lnr-drop award-icon"></span>
                                    </div>
                                    <span>습도(89%)</span>
                                 </div>
                              </div>
                           </div>
                           <br>
                           <br>
                           <center>
                              <button type="button" class="btn btn-primary" onClick="window.location.reload()">최신 업데이트</button>
                           </center>
                           <br>
                           
                        </div>
                        <!-- END AWARDS -->
                        <!-- TABBED CONTENT -->
                        <div class="custom-tabs-line tabs-line-bottom left-aligned">
                           <br>
                           <br>

                           <!-- 댓글 -->
                           <h5 class="heading">대화하기</h5>
                           <br>
                           
                           <div id="form-commentInfo"> 
                                    <div id="comment-count">댓글 <span id="count">0</span></div> 
                                    <input id="comment-input" placeholder="댓글을 입력해 주세요."> 
                                    <button id="submit">등록</button> 
                                 </div> 
                                 <div id=comments> 

                                 </div> 
                                 <script src="myFarm.js"></script>
                                 <!-- 댓글 끝 -->
                              </div>
                           </div>
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
   
</body>

</html>