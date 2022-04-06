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
    <title>PAI:DE | 당일차트보기.Chart</title>
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
        #chart {
            background-image: url("assets/img/loginbg.jpg");
            background-repeat: no-repeat;
            background-size: cover;
            position: relative;
            padding: 20px;
        }
    </style>
    <!--END 차트스타일 -->
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
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><img src="assets/img/<%= info.getM_profile() %>"
                                    class="img-circle" alt="Avatar" id="profile"> <span> <%= info.getM_name() %> </span> <i
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
                                <span class="badge bg-danger"><%
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
                     	
                     	%><li><a href="#" class="notification-item"><span class="dot bg-warning"></span>회원님의 글 <%-- <%=cmtlist.get(i).getArticle_title() %>에 <%=cmtlist.get(i).getM_id() %> --%>님이 댓글을 작성하였습니다 </a></li>
                              <%} %>
                        <%for(int i = 0; i< fcmtlist.size(); i++){
                     	%>
                     	<li><a href="#" class="notification-item"><span class="dot bg-warning"></span>회원님의 농장에<%-- <%=fcmtlist.get(i).getM_id()%> --%>님이 댓글을 작성하였습니다 </a></li>
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
                                    <li><a href="farmSelect.jsp" class=""><i class="lnr lnr-magnifier"></i>농장검색</a>
                                    </li>
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
                    <i class=""></i>
                    <h5 class="page-title"><i class="lnr lnr-leaf"></i> 자세히보기&nbsp;<i
                            class="lnr lnr-chevron-right"></i><strong>&nbsp;일일차트</strong></h5>
                    <!-- Start -->
                    <div class="row">
                        <div class="col-md-12" id="chart_c">
                            <div class="panel" id="chart_p">
                                <div class="panel-heading" id="chart">
                                    <p class="panel-subtitle">
                                    <div id="current_date">
                                        <script>
                                            date = new Date();
                                            year = date.getFullYear();
                                            month = date.getMonth() + 1;
                                            day = date.getDate();
                                            document.getElementById("current_date").innerHTML = "현재 : " + year + "/" + month + "/" + day + "&nbsp;&nbsp;&nbsp;";
                                            let today = new Date();
                                            let hours = today.getHours(); // 시
                                            let minutes = today.getMinutes();  // 분
                                            document.write('(' + hours + ':' + minutes + ')');
                                        </script>
                                    </div>
                                    </p>
                                    <h3 class="panel-title" style="padding-bottom: 15px;"><span
                                            class="lnr lnr-calendar-full"></span>&nbsp;&nbsp;조회하고싶은 날짜를 선택해주세요</h3>
                                    <form action="">
                                        <!-- 변경 입력 : 조회하고싶은 날짜 선택  -->
                                        <div class="input-group">
                                            <input type="date" name="startday" id='currentDate' />
                                            <input type="submit" value="선택" class="btn btn-primary" />
                                        </div>
                                    </form>
                                </div>
                                <div class="panel-body">
                                    <br>
                                    <div id="multiple-chart" class="ct-chart"></div>
                                    </td>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <!-- 차트버튼 -->
                        <div class="col-md-12" style="text-align: center; padding-bottom: 3%;">
                            <center>
                                <!-- 농장하루평균차트 -->
                                <a href="myFarm_detail.jsp"> <button type="button" class="btn btn-primary btn-lg"><i
                                            class="lnr lnr-chevron-left-circle"></i>&nbsp;&nbsp;자세히보기&nbsp;</button></a>
                                <!-- 농장평균차트 -->
                                <a href="myFarm_ChartAvg.jsp"> <button type="button"
                                        class="btn btn-primary btn-lg">&nbsp;&nbsp;평균차트&nbsp;&nbsp;<i
                                            class="bi bi-bar-chart-line"></i>&nbsp;&nbsp;<i
                                            class="lnr lnr-chevron-right-circle"></i></button></a>
                            </center>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="panel">
                                <div class="panel-heading">
                                    <h3 class="panel-subtitle">CO2</h3>
                                </div>
                                <div class="panel-body">
                                    <div id="demo-line-chart" class="ct-chart"></div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="panel">
                                <div class="panel-heading">
                                    <h3 class="panel-subtitle">일사량</h3>
                                </div>
                                <div class="panel-body">
                                    <div id="demo-bar-chart" class="ct-chart"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- END -->
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

    <script src="assets/vendor/jquery/jquery.min.js"></script>
    <script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
    <script src="assets/scripts/klorofil-common.js"></script>
    <script src="assets/vendor/jquery.easy-pie-chart/jquery.easypiechart.min.js"></script>
    <script src="assets/vendor/chartist/js/chartist.min.js"></script>

    <script>
        $(function () {
            var options;

            var data1 = {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                series: [
                    [200, 380, 350, 320, 410, 450, 570, 400, 555, 620, 750, 900],
                ]
            };
            
			// line chart
            options = {
                height: "300px",
                showPoint: true,
                axisX: {
                    showGrid: false
                },
                lineSmooth: false,
            };

            new Chartist.Line('#demo-line-chart', data, options);

            // bar chart
            options = {
                height: "300px",
                axisX: {
                    showGrid: false
                },
            };

            new Chartist.Bar('#demo-bar-chart', data, options);


            // area chart
            options = {
                height: "270px",
                showArea: true,
                showLine: false,
                showPoint: false,
                axisX: {
                    showGrid: false
                },
                lineSmooth: false,
            };

            new Chartist.Line('#demo-area-chart', data, options);


            // multiple chart
            var data = {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                series: [{
                    name: 'series-real',
                    data: [200, 380, 350, 320, 410, 450, 570, 400, 555, 620, 750, 900],
                }, {
                    name: 'series-projection',
                    data: [240, 350, 360, 380, 400, 450, 480, 523, 555, 600, 700, 800],
                }]
            };

            var options = {
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

            new Chartist.Line('#multiple-chart', data, options);

        });
    </script>


</body>

</html>