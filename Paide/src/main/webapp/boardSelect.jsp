<%@page import="Model.MemberDTO"%>
<%@page import="Model.CommunityDAO"%>
<%@page import="Model.CommunityDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTf-8" pageEncoding="UTf-8"%>

<!doctype html>
<html lang="en">

<head>
<title>PAI:DE | boardSelect.게시글</title>
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
	<% 
      	MemberDTO info = (MemberDTO)session.getAttribute("info");
      
		String userID = null;
		if (session.getAttribute("info") != null) {
			userID = info.getM_id();
		}
		int article_seq = 0;
		if (request.getParameter("article_seq") != null) {
			article_seq = Integer.parseInt(request.getParameter("article_seq"));
		}
	%>

	<!-- WRAPPER -->
	<div id="wrapper">
		<!-- NAVBAR -->
		<nav class="navbar navbar-default navbar-fixed-top">
			<div class="brand">
				<a href="index.jsp"><img src="assets/img/pidelogoSmall.png" alt="piede Logo" class="img-responsive logo"></a>
			</div>
			<div class="container-fluid">
				<div class="navbar-btn">
					<button type="button" class="btn-toggle-fullwidth">
						<i class="lnr lnr-arrow-left-circle"></i>
					</button>
				</div>
				<form class="navbar-form navbar-left" method="post" name="search" action="SearchArticleService.do">
					<div class="input-group">
						<table>
							<tr>
								<td><select class="form-control" name="searchField">
										<option value="0">선택</option>
										<option value="article_title">제목</option>
										<option value="writer">작성자</option>
								</select></td>
								<td><input type="text" class="form-control" placeholder="Search dashboard..." name="searchText" maxlength="100"></td>
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
						<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><img src="assets/img/user1.png" class="img-circle" alt="Avatar"> <span> <%= info.getM_name() %> </span> <i class="icon-submenu lnr lnr-chevron-down"></i></a>
							<ul class="dropdown-menu">
								<li><a href="myFarm.jsp"><i class="lnr lnr-leaf"></i> <span>내 농장</span></a></li>
								<li><a href="updateMember.jsp"><i class="lnr lnr-cog"></i> <span>회원정보수정</span></a></li>
								<li><a href="index.jsp"><i class="lnr lnr-exit"></i> <span>로그아웃</span></a></li>
							</ul></li>
						<li class="dropdown"><a href="#" class="dropdown-toggle icon-menu" data-toggle="dropdown"> <i class="lnr lnr-bubble"></i> <span class="badge bg-danger">5</span>
						</a>
							<ul class="dropdown-menu notifications">
								<li><a href="#" class="notification-item"><span class="dot bg-warning"></span>System space is almost full</a></li>
								<li><a href="#" class="notification-item"><span class="dot bg-danger"></span>You have 9 unfinished tasks</a></li>
								<li><a href="#" class="notification-item"><span class="dot bg-success"></span>Monthly report is available</a></li>
								<li><a href="#" class="notification-item"><span class="dot bg-warning"></span>Weekly meeting in 1 hour</a></li>
								<li><a href="#" class="notification-item"><span class="dot bg-success"></span>Your request has been approved</a></li>
								<li><a href="#" class="more">See all notifications</a></li>
							</ul></li>
						<!-- 이웃목록
                     추가할 기능
                        1. 구독(이웃추가)을 눌렀을 때, 자동으로 class="dropdown-menu notifications으로 들어가고,
                        2.  class="dropdown-menu notifications에 있는 다른 농장의 수 만큼 자동으로 class="badge rounded-pill bg-success"에서 count가 들어가야 함.
                        3. 구독을 다시 한 번 눌렀을 때, 구독이 취소되고, 자동으로 class="badge rounded-pill bg-success"에서 카운트가 내려가고, class="dropdown-menu notifications"에서 목록이 빠져야 함. -->
						<li class="dropdown"><a href="#" class="dropdown-toggle icon-menu" data-toggle="dropdown"> <i class="lnr lnr-users"></i> <!-- 변경 5 =  이웃의 수 만큼 count가 되어야 함. --> <span class="badge rounded-pill bg-success">5</span>
						</a> <!-- ? 대매니 : m_id가 아니라 subscriptioned_id (이웃의 아이디)가  들어가야하는 거 아닌가요? 
                          사용자의 이웃의 수 만큼 li 반복 되어야합니다  --> <!-- "m_id"의 코드가 들어가고, 클릭 시, 해당 회원의 농장화면으로 넘어감. -->

							<ul id='neighbor' class="dropdown-menu notifications">
								<li><a href="OtherFarm.jsp" class="notification-item"><span class="lnr lnr-user"></span>&nbsp;damin0722</a></li>
								<li><a href="OtherFarm.jsp" class="notification-item"><span class="lnr lnr-user"></span>&nbsp;chanyoung0831</a></li>
								<li><a href="OtherFarm.jsp" class="notification-item"><span class="lnr lnr-user"></span>&nbsp;seolmi0303</a></li>
								<li><a href="OtherFarm.jsp" class="notification-item"><span class="lnr lnr-user"></span>&nbsp;hyeonji2231</a></li>
								<li><a href="OtherFarm.jsp" class="notification-item"><span class="lnr lnr-user"></span>&nbsp;jingwan1996</a></li>
							</ul></li>
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
						<li><a href="index.jsp" class=""><i class="lnr lnr-home"></i> <span>Home</span></a></li>
						<li><a href="commu_D.jsp" class="active"><i class="lnr lnr-list"></i> <span>농산물 직거래</span></a></li>
						<li><a href="commu_E.jsp" class=""><i class="lnr lnr-list"></i> <span>체험농장</span></a></li>
						<li><a href="commu_W.jsp" class=""><i class="lnr lnr-list"></i> <span>농촌일자리</span></a></li>
						<li><a href="commu_F.jsp" class=""><i class="lnr lnr-list"></i> <span>자유게시판</span></a></li>
						<li><a href="#subPages" data-toggle="collapse" class="collapsed"><i class="lnr lnr-user"></i> <span>송다민</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="subPages" class="collapse ">
								<ul class="nav">
									<li><a href="myFarm.jsp" class=""><i class="lnr lnr-leaf"></i>내 농장</a></li>
									<li><a href="farmSelect.jsp" class=""><i class="lnr lnr-magnifier"></i>농장검색</a></li>
									<li><a href="commuWrite.jsp" class=""><i class="lnr lnr-pencil"></i>글쓰기</a></li>
								</ul>
							</div></li>

					</ul>
				</nav>
			</div>
		</div>
		<!-- END LEFT SIDEBAR -->
		<%
		CommunityDTO dto = new CommunityDAO().getArticle(article_seq);
		%>


		<!-- MAIN -->
		<div class="main">
			<!-- MAIN CONTENT -->
			<div class="main-content">
				<div class="container-fluid">
					<!-- 변경 :                                                                             선택한 게시글의 카테고리로 -->
					<h5 class="page-title">
						<i class="lnr lnr-home"></i> HOME <i class="lnr lnr-chevron-right"></i>농산물직거래<i class="lnr lnr-chevron-right"></i><strong>게시글</strong>
					</h5>
					<div id="toastr-demo" class="panel">
						<div class="panel-body">
							<div class="container-fluid">
								<div class="row">
									<div class="col-md-12">
										<div class="container-fluid">
											<div class="row">
												<div class="col-md-12">
													<!-- 변경 : 선택한 게시글 제목 article_title -->
													<h3 style="text-align: center; margin: 3%;"><%=dto.getArticle_title().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></h3>
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
																<th>작성일 <!-- article_date --> 
																<%=dto.getArticle_date()%>
																</th>
																<th>작성자 <!-- m_id --> <!-- 작성자 클릭시 작성자(chanyoung0831)의 농장화면으로 이동 --> <a href="OtherFarm.jsp?m_id=<%=dto.getM_id()%>"><%=dto.getM_id()%></a>
																</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<td colspan="2"><%=dto.getArticle_content().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
															</tr>
															<tr>
																<td colspan="2"><img id="boardimg2" alt="첨부된사진이 없습니다." src="assets/img/loginbg.jpg" /></td>
															</tr>
															<tr>
																<td colspan="2">
																	<!-- 변경 start 댓글  --> <!-- 
                                                댓글 테이블 t_comment
                                                    댓글 순번 cmt_seq
                                                    원글 순번 article_seq
                                                    댓글 내용 cmt_content
                                                    댓글 작성일자 cmt_date
                                                    댓글 작성자 m_id
                                                    likes X 
                                                  --> <%
                                                  		CommunityDAO cmt = new CommunityDAO();
                                                  		ArrayList<CommunityDTO> cmtList = cmt.getCmtList(article_seq);
                                                  	%>

																	<div class="panel panel-scrolling">
																		<div class="panel-heading">
																			<h3 class="panel-title">댓글</h3>
																			<div class="right">
																				<button type="button" class="btn-toggle-collapse">
																					<i class="lnr lnr-chevron-up"></i>
																				</button>
																			</div>
																		</div>
																		<div class="panel-body">
																			<ul class="list-unstyled activity-list">
																				<%
                                                        							for(int i = 0; i < cmtList.size(); i++){
                                                        						 %>
																				<li>
																					<!-- 변경 댓글작성자 프로필 사진  --> <img src="assets/img/user1.png" alt="Avatar" class="img-circle pull-left avatar">

																					<p>
																						<a href="#" id="cmt_writer<%= cmtList.get(i).getCmt_seq() %>"><%= cmtList.get(i).getM_id() %></a> 
																						<span id="cmt_content<%= cmtList.get(i).getCmt_seq() %>"> <%= cmtList.get(i).getCmt_content() %>
																						</span> <span class="timestamp" id="cmt_date<%=cmtList.get(i).getCmt_seq() %>"><%= cmtList.get(i).getCmt_date() %></span> 
																						<span id="likeNum<%= cmtList.get(i).getCmt_seq() %>"><%= cmtList.get(i).getCmt_like() %></span> 
																						<span> 
																						<!-- 로그인한 회원이 해당 댓글에 좋아요를 누르지 않은 경우 기본적으로 좋아요 버튼 --> 
																						<% if(cmt.isLike(cmtList.get(i).getCmt_seq(), userID) == 0){ %>
																							<button id="like<%= cmtList.get(i).getCmt_seq() %>" onClick="likes(<%= cmtList.get(i).getCmt_seq() %>)">좋아요</button> 
																							<%} else{ %> <!-- 로그인한 회원이 해당 댓글을 좋아요 누른 경우 기본적으로 좋아요 취소 버튼 -->
																							<button id="dislike<%= cmtList.get(i).getCmt_seq() %>" onClick="dislikes(<%= cmtList.get(i).getCmt_seq() %>)">좋아요 취소</button>
																							<%} %> <!-- 댓글의 작성자만 수정/삭제 가능하도록 조건문 추가 --> 
																							<% if(userID.equals(cmtList.get(i).getM_id())) {%>
																							<button id="cmt_edit<%= cmtList.get(i).getCmt_seq() %>" onClick="cmtEdit(<%= cmtList.get(i).getCmt_seq() %>)">수정</button>
																							<button id="cmt_delete<%= cmtList.get(i).getCmt_seq() %>" onClick="cmtDelete(<%= cmtList.get(i).getCmt_seq() %>)">삭제</button> 
																							<%} %>
																						</span>
																					</p>
																				</li>
																				<%} %>
																			</ul>
																		</div>
																	</div> <!-- END 댓글 -->
																</td>
															</tr>
															<tr>
																<td colspan="2">
																	<!-- 댓글입력창 -->
																	<form action="WriteCmtService.do?article_seq=<%=dto.getArticle_seq()%>" method="post">
																		<div class="input-group">
																			<input type="hidden" name="cmtWriter" placeholder="<%=userID%>" value="<%=userID%>"> <input class="form-control" name="cmtContent" placeholder="댓글을 입력해주세요" type="text"> <span class="input-group-btn"><button class="btn btn-primary" type="submit">작성</button></span>
																	</form> <!-- 작성btton 클릭시 =>  댓글 테이블 t_comment -->
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
								<br> <br>
								<div class="row">
									<div class="col-md-12"></div>
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
				<span> Copyright © PAIDE Corp. All Rights Reserved.</span>
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
   
	// 좋아요 업데이트 함수
	function likes(cmt_seq){
		
		$.ajax({
			
			url : 'LikeUpdateService.do',
			type : 'post',
			data : {
				'cmt_seq' : cmt_seq
			},
			success :
				function(data){
					console.log(data);
					$('#likeNum' + cmt_seq).html(data);
					alert("좋아요가 반영되었습니다.")
				},
			
			error : 
				function(request, status, error){
				alert("실패")
				}
		});
		
		 $('#like' + cmt_seq).text('좋아요 취소');
		 $('#like' + cmt_seq).attr('onClick', 'dislikes(' + cmt_seq + ')');
		 $('#like' + cmt_seq).attr('id', 'dislike' + cmt_seq);
		 
	}
	
	// 좋아요 취소 함수
	function dislikes(cmt_seq){
		
		$.ajax({
			
			url : 'LikeMupdateService.do',
			type : 'post',
			data : {
				'cmt_seq' : cmt_seq
			},
			success :
				function(data){
					console.log(data);
					$('#likeNum' + cmt_seq).html(data);
					alert("좋아요 취소가 반영되었습니다.")
				},
			
			error : 
				function(request, status, error){
				alert("실패");
				}
		});
		
		 $('#dislike' + cmt_seq).text('좋아요');
		 $('#dislike' + cmt_seq).attr('onClick', 'likes(' + cmt_seq + ')');
		 $('#dislike' + cmt_seq).attr('id', 'like' + cmt_seq);
		 
	}

	// 댓글 삭제 함수
	function cmtDelete(cmt_seq){
		
		$.ajax({
			 
			url : 'DeleteCmtService.do',
			type : 'post',
			data : {
				'cmt_seq' : cmt_seq
			},
			success : 
				function(data){
				alert("댓글 삭제가 완료되었습니다.");
				location.reload();
			},
			error : 
				function(request, status, error){
				alert("ajax오류")
			}
				
		});
	
	}
	
	// 댓글 수정 함수 part1
	function cmtEdit(cmt_seq){
		
		let text = $('#cmt_content' + cmt_seq).html();
		
		console.log(text);
		
		$('#cmt_edit' + cmt_seq).text('수정완료');
		$('#cmt_content' + cmt_seq).html('<input type="textarea" name = "updateCmt" id="content'+ cmt_seq+'" value="' + text + '">');
		
		
		$('#cmt_edit' + cmt_seq).attr('onClick', 'updateCmt(' + cmt_seq + ')');
		
		
		
	}
	
	// 댓글 수정 함수 part2
	function updateCmt(cmt_seq){
		input = $('#content'+cmt_seq).val();
		console.log(input)
		$.ajax({
			
			url : 'UpdateCmtService.do',
			type : 'post',
			data : {
				'cmt_seq' : cmt_seq,
				'cmt_content' : input
			},
			success : 
				function(data){
				alert("댓글 수정이 완료되었습니다.");
				location.reload();
			},
			error : 
				function(request, status, error){
				alert("ajax오류")
			}	
		});
		
	}
	

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