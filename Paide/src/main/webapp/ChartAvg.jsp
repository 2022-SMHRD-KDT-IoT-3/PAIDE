<%@page import="Model.GraphDTO"%>
<%@page import="Service.ChartDrowService"%>
<%@page import="Model.FarmDTO"%>
<%@page import="Model.FarmDAO"%>
<%@page import="Model.SubscriptionDTO"%>
<%@page import="Model.SubscriptionDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.CommunityDAO"%>
<%@page import="Model.CommunityDTO"%>
<%@page import="Model.MemberDAO"%>
<%@page import="Model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTf-8" pageEncoding="UTf-8"%>

<!doctype html>
<html lang="en">

<head>
    <title>PAI:DE | 평균차트.ChartAvg</title>
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
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.1/chart.min.js"
        integrity="sha512-QSkVNOCYLtj73J4hbmVoOV6KVZuMluZlioC+trLpewV8qMjsWqlIQvkn1KGX2StWvPMdWGBqim1xlC8krl1EKQ=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>

    <!-- 부트스트랩아이콘 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">


    <!--차트 스타일(차트페이지에만 넣어야함)-->
    <style>
        #inputdate_outer {
            text-align: center;

            /* display: flex;
                  justify-content: center; */
        }

        #input_date {
            display: inline-block;
            /* text-align: inline-block; */
            /* position: absolute;
                 left: 50%;
                 transform: translateX(-50%);

             */
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
	int f_seq = Integer.parseInt(request.getParameter("seq"));
	String startday = request.getParameter("startday");
	ArrayList<SubscriptionDTO> sublist = new SubscriptionDAO().sub_list(info.getM_id());
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
                           class="img-circle" alt="Avatar" id="profile"> <%= info.getM_name() %> 
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
                    <h5 class="page-title"><i class="lnr lnr-leaf"></i> 자세히보기 <i
                            class="lnr lnr-chevron-right"></i><strong>평균차트</strong></h5>
                    <!-- Start -->
                    <div class="row">
                        <div class="col-md-4" style="text-align: center;font-weight: bolder">
                            <div class="panel" id="inputdate_outer">
                                <br>
                                <div id="current_date"></div>
                                <br>
                                <!-- 변경: 현재 그래프에 표시되는 날짜가 나오게 해야함 (막대그래프의 색으로 글자색 변경해주면 좋을듯) -->
                                <div>
                                    어제 평균 (2022/04/09) <br>
                                    7일간 평균(2022/04/02 ~ 2022/04/09) <br>
                                    30일간 평균(2022/03/10 ~ 2022/04/09) <br>
                                </div>
                                <br>
                            </div>
                            <center style="padding-bottom: 3%;">
                                <!-- 농장자세히보기 -->
                                <a href="myFarm_detail.jsp?seq=<%=f_seq%>&startday=TO_CHAR(SYSDATE, 'YYYY-MM-DD')"> <button type="button" class="btn btn-primary btn-lg"
                                        style="margin: 1%;"><i
                                            class="lnr lnr-chevron-left-circle"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;자세히보기</button></a>
                                <!-- 평균차트-->
                                <a href="ChartDay.jsp?seq=<%=f_seq%>&startday=TO_CHAR(SYSDATE, 'YYYY-MM-DD')"> <button type="button"
                                        class="btn btn-primary btn-lg">일일차트&nbsp;&nbsp;&nbsp;<i
                                            class="bi bi-graph-up-arrow"></i>&nbsp;&nbsp;<i
                                            class="lnr lnr-chevron-right-circle"></i></button></a>
                            </center>
                        </div>

                        <!-- Start차트  -->

                        <!-- 온도차트  -->
                        <div class="col-md-4" id="chart_c" >
                            <!-- 차트의 높이 고정가능  -->
                            <h3 class="panel-subtitle">온도</h3>
                            <div class="panel" id="chart_p" style="padding:5%; height: 300px; " >
                                <canvas id="tempchart" ></canvas>
                            </div>
                        </div>
                        <!-- 습도차트 -->
                        <div class="col-md-4" id="chart_c">
                            <h3 class="panel-subtitle">습도</h3>
                            <div class="panel" id="chart_p" style="padding:5%; height: 300px; " >
                                <canvas id="humichart" ></canvas>
                            </div>
                        </div>

                    </div>
                    <!-- row1 끝 -->

                    <!-- Start row2 -->
                    <div class="row">
                        <div class="col-md-4" id="chart_c" >
                            <h3 class="panel-subtitle">CO2</h3>
                            <div class="panel" id="chart_p" style="padding:5%; height: 300px; " >
                                <canvas id="co2chart" ></canvas>
                            </div>
                        </div>
                        <!-- 습도차트 -->
                        <div class="col-md-4" id="chart_c">
                            <h3 class="panel-subtitle">일사량</h3>
                            <div class="panel" id="chart_p" style="padding:5%; height: 300px; " >
                                <canvas id="insolchart" ></canvas>
                            </div>
                        </div>
                        <div class="col-md-4" id="chart_c">
                            <h3 class="panel-subtitle">토양습도</h3>
                            <div class="panel" id="chart_p" style="padding:5%; height: 300px; " >
                                <canvas id="humisoilchart" ></canvas>
                            </div>
                        </div>
                    </div>
                    <!-- END row2 -->
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
    <script>
        date = new Date();
        year = date.getFullYear();
        month = date.getMonth() + 1;
        day = date.getDate();
        document.getElementById("current_date").innerHTML = '<i class="lnr lnr-calendar-full"></i>&nbsp;' + "현재 : " + year + "/" + month + "/" + day + "&nbsp;&nbsp;&nbsp;";
        let today = new Date();
        let hours = today.getHours(); // 시
        let minutes = today.getMinutes();  // 분
        document.write('(' + hours + ':' + minutes + ')');
    </script>

    <script src="assets/vendor/jquery/jquery.min.js"></script>
    <script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
    <script src="assets/scripts/klorofil-common.js"></script>
    <script src="assets/vendor/jquery.easy-pie-chart/jquery.easypiechart.min.js"></script>
    <script src="assets/vendor/chartist/js/chartist.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>

    <!-- 온도차트 -->
    <script>
    <%FarmDAO fdao = new FarmDAO(); 
      FarmDTO fdto = new FarmDTO();
      ChartDrowService cds = new ChartDrowService();
      GraphDTO gdto = new GraphDTO();
      gdto = fdao.avgGraph_yesterday(f_seq);
      
    %>
        const labels1 = ['어제평균', '7일평균', '30일평균'];
        const data1 = {
            labels: labels1,
            datasets: [{
                label: '온도',
                //100 = 최대 값 넣어주믄 댐 
                data: [<%=gdto.getAvg_temperature()%>, 59, 80,100],
                backgroundColor: [
                    'rgb( 255, 80, 80, 0.3)',
                    'rgb( 255, 80, 80,  0.6)',
                    'rgb( 255, 80, 80,  0.9)',
                ],
                borderColor: [
                'rgb( 255, 80, 80, 1)',
                ],
                borderWidth: 2
            }]
            
        };
        //그래프설정 
        const config1 = {
            type: 'bar',
            data: data1,
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
                maintainAspectRatio:false,
                plugins: {
                     legend : {display : false}
                }
              
                
            },
        };
        const tempchart = new Chart(
            document.getElementById('tempchart'),
            config1
        );
    
    </script>
    <!-- 온도차트 끝  -->

    <!-- 습도차트 -->
    <script>
         labels2 = ['어제평균', '7일평균', '30일평균'];
         data2 = {
            labels: labels2,
            datasets: [{
                label: '습도',
                //100 = 최대 값 넣어주믄 댐 
                data: [<%=gdto.getAvg_humidity()%>, 59, 80,100],
                backgroundColor: [
                'rgb( 30, 130, 255,0.3 )',
                'rgb( 30, 130, 255,0.6 )',
                'rgb( 30, 130, 255,0.9 )',

                ],
                borderColor: [
                'rgb( 30, 130, 255 )',
                ],
                borderWidth: 2
            }]
            
        };
        //그래프설정 
         config2 = {
            type: 'bar',
            data: data2,
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    },
                    x: {
                        grid:{ offset: true}
                    }
                },
                //비율유지 하지마라 
                maintainAspectRatio:false,
                plugins: {
                     legend : {display : false}
                }
            },
        };
        const humichart = new Chart(
            document.getElementById('humichart'),
            config2
        );
    </script>
    <!-- 습도 끝  -->

    <!-- co2 시작-->
    <script>
        labels3 = ['어제평균', '7일평균', '30일평균'];
        data3 = {
           labels: labels3,
           datasets: [{
               label: 'co2',
               //100 = 최대 값 넣어주믄 댐 
               data: [<%=gdto.getAvg_co2()%>, 550, 660,1500],
               backgroundColor: [
               'rgb( 34, 214, 178, 0.3 )',
               'rgb( 34, 214, 178, 0.6 )',
               'rgb( 34, 214, 178, 0.9 )',
                   
               ],
               borderColor: [
               'rgb( 34, 214, 178 )',

               ],
               borderWidth: 2
           }]
           
       };
       //그래프설정 
        config3 = {
           type: 'bar',
           data: data3,
           options: {
               scales: {
                   y: {
                       beginAtZero: true
                   },
                   x: {
                       grid:{ offset: true}
                   }
               },
               //비율유지 하지마라 
               maintainAspectRatio:false,
               plugins: {
                     legend : {display : false}
                }
           },
       };
       const co2chart = new Chart(
           document.getElementById('co2chart'),
           config3
       );
   </script>
    <!-- co2 끝-->
      
    <!-- 일사량 avg_insolation 시작-->
    <script>
        labels4 = ['어제평균', '7일평균', '30일평균'];
        data4 = {
           labels: labels4,
           datasets: [{
               label: '일사량',
               //100 = 최대 값 넣어주믄 댐 
               data: [7, 5, 6,10],
               backgroundColor: [
               'rgb( 255, 160, 30, 0.3)',
               'rgb( 255, 160, 30, 0.6)',
               'rgb( 255, 160, 30, 0.9)',
               ],
               borderColor: [
               'rgb( 255, 160, 30 )',
               ],
               borderWidth: 2
           }]
           
       };
       //그래프설정 
        config4 = {
           type: 'bar',
           data: data4,
           options: {
               scales: {
                   y: {
                       beginAtZero: true
                   },
                   x: {
                       grid:{ offset: true}
                   }
               },
               //비율유지 하지마라 
               maintainAspectRatio:false,
               plugins: {
                     legend : {display : false}
                }
           },
       };
       const insolchart = new Chart(
           document.getElementById('insolchart'),
           config4
       );
   </script>
    <!-- 일사량 차트 끝-->

    <!-- 토양습도 (avg_humidity_soil) 시작-->
    <script>
        labels5 = ['어제평균', '7일평균', '30일평균'];
        data5 = {
           labels: labels5,
           datasets: [{
               label: '토양습도',
               //100 = 최대 값 넣어주믄 댐 
               data: [<%=gdto.getAvg_humidity_soil()%>, 59, 80,100],
               backgroundColor: [
               'rgb( 184, 149, 99, 0.3)',
               'rgb( 184, 149, 99, 0.6)',
               'rgb( 184, 149, 99, 0.9)',
               ],
               borderColor: [
               'rgb( 184, 149, 99)',

               ],
               borderWidth: 2
           }]
           
       };
       //그래프설정 
        config4 = {
           type: 'bar',
           data: data5,
           options: {
               scales: {
                   y: {
                       beginAtZero: true
                   },
                   x: {
                       grid:{ offset: true}
                   }
               },
               //비율유지 하지마라 
               maintainAspectRatio:false,
               plugins: {
                     legend : {display : false}
                }
           },
       };
       const humisoilchart = new Chart(
           document.getElementById('humisoilchart'),
           config4
       );
   </script>
    <!-- 토양습도 차트 끝-->

</body>

</html>