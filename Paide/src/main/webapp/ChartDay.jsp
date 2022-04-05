<%@page import="java.util.ArrayList"%>
<%@page import="Model.CommunityDAO"%>
<%@page import="Model.CommunityDTO"%>
<%@page import="Model.MemberDAO"%>
<%@page import="Model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTf-8" pageEncoding="UTf-8"%>

<!doctype html>
<html lang="en">

<head>
    <title>PAI:DE | 일일차트.ChartDay</title>
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

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">

    <!-- chatjs(차트css) -->
    <link rel="stylesheet" href="assets/vendor/chartist/css/chartist-custom.css">

    <!-- 부트스트랩아이콘 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">


    <!--차트 스타일(차트페이지에만 넣어야함)-->
    <style>
        #inputdate_outer {
            text-align: center;
        }

        #input_date {
            display: inline-block;
        }
        #top{
            text-align: center;
        }

        #top-btn1 {
         display: inline-block;
         text-align: right;
         padding-left: 30%;
         padding-top:5%;
         padding-bottom: 2%;
        }

        #top-btn2 {
         display: inline-block;
         text-align: left;
         padding-right: 30%;
         padding-top:5%;
         padding-bottom: 2%;
        }

        #title{
            margin-top: 0px;
        }
 
    </style>
    <!--END 차트스타일 -->

</head>

<body>
<% MemberDTO info = (MemberDTO)session.getAttribute("info"); %>
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
                                    <input type="text" class="form-control" placeholder="Search dashboard..."
                                        name="searchText" maxlength="100">
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
                           class="img-circle" alt="Avatar"> <%= info.getM_name() %> 
                            <i class="icon-submenu lnr lnr-chevron-down"></i></a>
                     <ul class="dropdown-menu">
                        <li><a href="myFarm.jsp"><i class="lnr lnr-leaf"></i> <span>내 농장</span></a></li>
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
                     <a href="#subPages" data-toggle="collapse" class="collapsed"><i class="lnr lnr-user"></i>
                        <span><%= info.getM_name() %></span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
                     <div id="subPages" class="collapse ">
                        <ul class="nav">
                           <li><a href="myFarm.jsp" class=""><i class="lnr lnr-leaf"></i>내 농장</a></li>
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
                    <h5 class="page-title"><i class="lnr lnr-leaf"></i> 자세히보기&nbsp;<i
                            class="lnr lnr-chevron-right"></i><strong>&nbsp;일일차트</strong></h5>
                    <!-- 차트상단 시작  -->

                    <div class="row">

                        <div class="col-md-12" id="top">
                            <!-- 평균차트버튼 -->
                            <div class="col-md-4" >
                                <div id="top-btn1">
                                <!-- 평균차트  -->
                                <a href="ChartAvg.jsp"> <button type="button"
                                    class="btn btn-primary btn-lg"><i
                                    class="lnr lnr-chevron-left-circle"></i>&nbsp;평균차트&nbsp;&nbsp;<i
                                        class="bi bi-bar-chart-line"></i>&nbsp;&nbsp;</button></a>
                                </div>
                            </div>
                            <div class="clear"></div>

                            <!-- 날짜선택 -->
                            <div class="col-md-4" id="top-date" style="text-align: center; ">
                                <div class="panel" id="inputdate_outer" style="margin-top: 2px;">
                                    <br>
                                    <div id="current_date"></div>
                                    <h3 class="panel-title" style="padding-bottom: 15px;"><span
                                            class="lnr lnr-calendar-full"></span>&nbsp;&nbsp;조회하고싶은 날짜를 선택해주세요</h3>
                                    <!-- 변경 입력 : 조회하고싶은 날짜 선택  -->
                                    <form action="">
                                        <div class="input-group" id="input_date">
                                            <input type="date" name="startday" id='currentDate' />
                                            <input type="submit" value="선택" class="btn btn-primary" />
                                        </div>
                                    </form>
                                    <br>
                                </div>
                            </div> 

                            <!-- 자세히보기버튼 -->
                            <div class="col-md-4"  >
                            <!-- <div class="col-md-4" style="padding-bottom: 2%;  padding-top:5%; text-align: left;" > -->
                                <div id="top-btn2">
                                    <!-- 농장자세히보기 -->
                                    <a href="myFarm_detail.jsp"> <button type="button"
                                            class="btn btn-primary btn-lg">&nbsp;&nbsp;자세히보기&nbsp;<i
                                            class="lnr lnr-chevron-right-circle"></i></button></a>
                                </div>
                            </div>
                         </div>
                    </div>
                    <!-- 차트 상단 끝  -->

                    <!-- Start차트 -->
                    <!-- 종합차트(멀티차트) -->
                    <div class="row">
                        <div class="col-md-12">
                            <h3 class="panel-subtitle" id="title"> 종합차트</h3>
                            <div class="panel" id="chart_p" style="padding:4%; height: 500px; " >
                                <canvas id="multichart_d" ></canvas>
                            </div>
                        </div>
                    </div>

                    <!-- CO2차트 -->
                    <div class="row">
                        <div class="col-md-12">
                            <h3 class="panel-subtitle">CO2</h3>
                            <div class="panel" id="chart_p" style="padding:4%; height: 500px; " >
                                <canvas id="co2chart_d"></canvas>
                            </div>
                        </div>
                    </div>

                    <!-- 일사랑차트 -->
                    <div class="row">
                        <div class="col-md-12">
                            <h3 class="panel-subtitle">일사량</h3>
                            <div class="panel" id="chart_p" style="padding:4%; height: 500px; " >
                                <canvas id="insolchart_d" ></canvas>
                            </div>
                        </div>
                    </div>

                    <!-- END 차트 -->
                </div>
            </div>
        </div>
        <!--END MAIN CONTENT -->
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
    <!-- 날짜계산  -->
    <script>
        date = new Date();
        year = date.getFullYear();
        month = date.getMonth() + 1;
        day = date.getDate();
        document.getElementById("current_date").innerHTML = '<i class="lnr lnr-calendar-full"></i>&nbsp;' + "오늘날짜 : " + year + "/" + month + "/" + day + "&nbsp;&nbsp;&nbsp;";
        let today = new Date();
        let hours = today.getHours(); // 시
        let minutes = today.getMinutes();  // 분
        document.write('(' + hours + ':' + minutes + ')');

        //날짜계산 뻘짓헀네 .................
        today = new Date();
        yesterday = new Date();
        weekago = new Date();
        backMonth = new Date();

        yesterday.setDate(yesterday.getDate() - 1);
        weekago.setDate(yesterday.getDate() - 7);
        backMonth.setDate(backMonth.getDate() - 30);

        today = today.toLocaleString();
        weekago = weekago.toLocaleDateString();
        yesterday = yesterday.toLocaleDateString();
        backMonth = backMonth.toLocaleDateString();

        //document.getElementById("yesterday").innerHTML = "어제 ("+ today +")";
        //document.getElementById("weekago").innerHTML = "7일간 ("+ weekago + "~"+ yesterday +")";
        //document.getElementById("backMonth").innerHTML = "30일간 ("+ backMonth +" ~ "+ yesterday +")" ;

    </script>

    <script src="assets/vendor/jquery/jquery.min.js"></script>
    <script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
    <script src="assets/scripts/klorofil-common.js"></script>
    <script src="assets/vendor/jquery.easy-pie-chart/jquery.easypiechart.min.js"></script>
    <script src="assets/vendor/chartist/js/chartist.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <!-- 멀티차트 -->
    <script>
        const labels1111 = ['0','','','3','','','6','','','9','','','12','','','15','','','18','','','21','','','24'];
        const data1111 = {
            labels: labels1111,
            datasets: [{
                label: '이슬점',
                //100= 마지막에 넣어주기 최대범위설정 
                data: [40,50,30,25,45,80,20,45,50,60,45,50,40,50,30,25,45,80,20,45,50,60,45,50,60,100],
                backgroundColor: [
                     //라인선 색(0.2 = 투명도 )
                     'rgb( 100, 110, 255, 0.5)',
                ],
                borderColor: [
                     // border 색 
                     'rgb( 100, 110, 255)',
                ],
                //선두께
                borderWidth: 2,
                
                //둥근선 
                tension: 0.3,
                
                //꼭지점 사이즈, 모양 (세모)
                pointBorderWidth: 2,
                pointStyle : 'triangle',
                
            },{
                label: '내부습도',
                data: [80,70,80,75,95,90,80,80,70,80,75,95,90,80,80,70,80,75,95,90,80,95,90,80,70],
                backgroundColor: [
                    'rgb( 30, 130, 255,0.5 )',
                ],
                borderColor: [
                    'rgb( 30, 130, 255 )',
                ],
                borderWidth: 2,
                tension: 0.3,
                pointBorderWidth: 1,
                
            },{
                label: '외부습도',
                data: [90,80,70,90,80,70,90,80,70,90,80,70,90,80,70,90,80,70,90,80,70,90,80,70],
                backgroundColor: [
                    'rgb( 80, 200, 255,0.5)',
                    
                ],
                borderColor: [
                    'rgb( 80, 200, 255)',
                ],

                borderWidth: 2,
                tension: 0.3,
                pointBorderWidth: 1,
           
            },{
                label: '내부온도',
                data: [21,22,25,26,21,70,90,80,70,90,80,70,90,80,70,90,80,70,90,80,70,90,80,70],
                backgroundColor: [
                'rgb( 255, 80, 80, 0.5)',
                    
                ],
                borderColor: [
                'rgb( 255, 80, 80)',
                ],
                borderWidth: 2,
                tension: 0.3,
                pointBorderWidth: 3, 
                pointStyle : 'cross',
                pointBorderWidth: 4,

           
            },{
                label: '외부온도',
                data: [30,28,23,25,80,70,90,80,70,90,80,70,90,80,70,90,80,70,90,80,70,90,80,70],
                backgroundColor: [
                'rgb( 255, 175, 0, 0.5)',
                    
                ],
                borderColor: [
                'rgb( 255, 175, 0)',
                ],
                borderWidth: 2,
                tension: 0.3,
                pointBorderWidth: 3,
                pointStyle : 'star',
           
            },{
                label: '창문',
                data: [0,0,0,10,0,20,0,0,50,90,80,70,90,80,70,90,80,70,90,80,70,90,80,70],
                backgroundColor: [
                'rgb( 30, 170, 170,0.5)', 
                ],
                borderColor: [
                'rgb( 30, 170, 170)', 
                ],
                borderWidth: 2,
                
                stepped: true, //계단식 설정 
                pointStyle : 'star',
                pointBorderWidth: 0, // 보이지 않게 0으로 지정 
           
            },{
                label: '토양습도',
                data: [10,11,13,14,15,16,17,18,70,90,80,70,90,80,70,90,80,70,90,80,70,90,80,70],
                backgroundColor: [
                'rgb( 184, 149, 99)', 
                ],
                borderColor: [
                'rgb( 184, 149, 99)', 
                ],
                borderWidth: 2,
                pointBorderWidth: 0,
            }]
            
        };

        //그래프설정 
        const config1111 = {
            type: 'line',
            data: data1111,
            options: {
                scales: {
                    y: {
                        //0부터 시작하기
                        beginAtZero: true
                    },
                    X: {
                    showGrid: false
                },
                },
                //비율유지 하지마라 
                maintainAspectRatio:false
            }
            

        };
        const multichart_d = new Chart(
            document.getElementById('multichart_d'),
            config1111
        );
    </script>

    <!-- co2 시작-->
    <script>
        labels2 = ['0','','','3','','','6','','','9','','','12','','','15','','','18','','','21','','','24'];
        data2 = {
            labels: labels2,
            datasets:[{
                label:'CO2',
                data :[ 750,754,730,720,710,700,600,750,754,730,720,710,700,600,750,754,730,720,710,700,600,750,754,730,720,710,700,300,1500],
                backgroundColor : [
                'rgb( 34, 214, 178, 0.2)',
                ],
                borderColor: [
                     // pointer 색 
                     'rgb( 34, 214, 178 )',
                ],
                //선두께
                borderWidth: 1,
                //포인터 모양
                pointStyle : ''
            }]
        };
         config2 = {
            type: 'line',
            data: data2,
            options: {
                scales: {
                   
                    yAxes: [{
                        showGrid:true,
                        ticks:{
                            min:300,
                            max:1500,
                            stepSize: 100,
                        }
                    } ],
                    X: {
                    showGrid: false,
                    },
                },
                //비율유지 하지마라 
                maintainAspectRatio:false,
                //범례는 플러그인 씨워줘야댐 
                plugins: {
                     legend : {display : false}
                }
            }
        };
        const co2chart_d = new Chart(
            document.getElementById('co2chart_d'),
            config2
        );
    </script>
    <!-- co2 끝-->

    <!-- 일사량 시작-->
    <script>
        labels3 = ['0','','','3','','','6','','','9','','','12','','','15','','','18','','','21','','','24'];
        data3 = {
            labels: labels3,
            datasets:[{
                label:'일사량',
                data :[ 0,0,0,20,30,40,50,60,70,80,90,100,200,300,350,454,530,520,600,600,600,650,654,600,500,500,500,300,],
                backgroundColor : [
                    'rgb( 255, 160, 30, 1)',
                ],
                borderColor: [
                     // pointer 색 
                    'rgb( 255, 160, 30 )',
                ],
                //선두께
                borderWidth: 2,
                //포인터 모양
                pointStyle : 'line',
                tension: 0.3
            }]
        };
         config3 = {
            type: 'line',
            data: data3,
            options: {
                scales: {
                    yAxes: [{
                        showGrid:true,
                        ticks:{
                            min:0,
                            max:700,
                            stepSize: 100,
                        }
                    } ],
                    X: {
                    showGrid: false,
                    },
                },
                //비율유지 하지마라 
                maintainAspectRatio:false,
                //범례는 플러그인 씨워줘야댐 
                plugins: {
                     legend : {display : false}
                }
            }
        };
        const insolchart_d = new Chart(
            document.getElementById('insolchart_d'),
            config3
        );
    </script>
    <!-- co2 끝-->




   

</body>

</html>