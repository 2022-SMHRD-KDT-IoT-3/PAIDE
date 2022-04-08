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
<style>
#heart{
	background-color: transparent;
	border: none;
	width: 17px;
	height: 17px;
	}
.heartbtn{
	background-color: transparent;
	border: none;
	cursor: pointer;
	}
	
	
</style>

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
		
		String article_category = request.getParameter("article_category");
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
						<li><a href="#subPages" data-toggle="collapse" class="collapsed"><i class="lnr lnr-user"></i> <span><%= info.getM_name() %></span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
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
																<th>작성일 :  <!-- article_date --> 
																<%=dto.getArticle_date()%>
																</th>
																<th>작성자 :  <!-- m_id --> <!-- 작성자 클릭시 작성자(chanyoung0831)의 농장화면으로 이동 --> <a href="OtherFarm.jsp?m_id=<%=dto.getM_id()%>"><%=dto.getM_id()%></a>
																</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<td colspan="2"><%=dto.getArticle_content().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
															</tr>
															<tr>
																<td colspan="2"><img style="text-align:center;" id="boardimg2" alt="첨부된사진이 없습니다." src="assets/img/loginbg.jpg" /></td>
															</tr>
															<tr>
																<td colspan="2">
																<a href="commu_<%= article_category %>" class="btn btn-primary" style="float:right; margin-left:5px;">목록</a>
																<%
																	if(dto.getM_id().equals(userID)){
																%>
																<a href="updateArticle.jsp?article_seq=<%=article_seq%>" class="btn btn-primary" style="float:right; margin-left:5px;">수정</a>
																<a onClick="deleteArticle(<%= article_seq %>,'<%= article_category %>')" class="btn btn-primary" style="float:right;">삭제</a>
																<%
																	}
																%>
													<%
                                                  		CommunityDAO cmt = new CommunityDAO();
                                                  		ArrayList<CommunityDTO> cmtList = cmt.getCmtList(article_seq);
                                                  	%>
                                                  	<%
                                              			if(cmtList.size() != 0){
                                                  	%>
																</td>
															</tr>
															<tr>
																<td colspan="2">
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
																					<!-- 변경 댓글작성자 프로필 사진  --> 
																					<img src="assets/img/user1.png" alt="Avatar" class="img-circle pull-left avatar">
																					<p>
																						<a style="font-size : 18px; font-weight:bolder;" href="#" id="cmt_writer<%= cmtList.get(i).getCmt_seq() %>"><%= cmtList.get(i).getM_id() %>&nbsp;&nbsp;</a> 
																						
																						<span  style="font-size : 16px" id="cmt_content<%= cmtList.get(i).getCmt_seq() %>"> <%= cmtList.get(i).getCmt_content() %></span>
																						<span class="timestamp" id="cmt_date<%=cmtList.get(i).getCmt_seq() %>"><%= cmtList.get(i).getCmt_date() %></span> 
																							
																						<div style ="text-align: right; padding-right: 5%;">
																							<span id="likeNum<%= cmtList.get(i).getCmt_seq() %>"><%= cmtList.get(i).getCmt_like() %></span> 
																							<span> 
																							<!-- 로그인한 회원이 해당 댓글에 좋아요를 누르지 않은 경우 기본적으로 좋아요 버튼 --> 
																								<% if(cmt.isLike(cmtList.get(i).getCmt_seq(), userID) == 0){ %>
																								<button class="heartbtn" id="like<%= cmtList.get(i).getCmt_seq() %>" onClick="likes(<%= cmtList.get(i).getCmt_seq() %>)"><img id="heart" src="img/heart.png"></button> 
																								<%} else{ %> <!-- 로그인한 회원이 해당 댓글을 좋아요 누른 경우 기본적으로 좋아요 취소 버튼 -->
																								<button class="heartbtn" id="dislike<%= cmtList.get(i).getCmt_seq() %>" onClick="dislikes(<%= cmtList.get(i).getCmt_seq() %>)"><img id="heart" src="img/heartfull.png"></button>
																								<%} %> <!-- 댓글의 작성자만 수정/삭제 가능하도록 조건문 추가 --> 
																								<% if(userID.equals(cmtList.get(i).getM_id())) {%>
																								<button class="btn btn-default" id="cmt_edit<%= cmtList.get(i).getCmt_seq() %>" onClick="cmtEdit(<%= cmtList.get(i).getCmt_seq() %>)" style="font-size : 13px">수정</button>
																								<button class="btn btn-default" id="cmt_delete<%= cmtList.get(i).getCmt_seq() %>" onClick="cmtDelete(<%= cmtList.get(i).getCmt_seq() %>)" style="font-size : 13px">삭제</button> 
																						</div>
																							<%} %>
																						</span>
																					</p>
																				</li>
																				<%} %>
																			</ul>
																		</div>
																	</div> <!-- END 댓글 -->
																	<%	} %>
																</td>
															</tr>
															<tr>
																<td colspan="2">
																	<!-- 댓글입력창 -->
																	<%
																		if(info != null){
																	%>
																	<form action="WriteCmtService.do?article_seq=<%=dto.getArticle_seq()%>" method="post">
																		<div class="input-group">
																			<input type="hidden" name="cmtWriter" placeholder="<%=userID%>" value="<%=userID%>"> 
																			<input class="form-control" name="cmtContent" placeholder="댓글을 입력해주세요" type="text">
																			<span class="input-group-btn">
																				<button class="btn btn-primary" type="submit">작성</button>
																			</span>
																	</form> <!-- 작성btton 클릭시 =>  댓글 테이블 t_comment -->
																	<%
																		}
																	%>
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
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	<script>
   
	// 게시글 삭제 함수
	
	function deleteArticle(article_seq, article_category){
		Swal.fire({
			  title: '게시글을 정말 삭제하시겠습니까?',
			  text: "삭제하시면 다시 복구시킬 수 없습니다.",
			  showCancelButton: true,
			  confirmButtonColor: '#357653',
			  cancelButtonColor: '#EAEAEA',
			  confirmButtonText: '삭제',
			  cancelButtonText: '취소'
			}).then((result) => {
				if(result.value){
					$.ajax({
						url : 'DeleteArticleService.do',
						type : 'post',
						data : {
							'article_seq' : article_seq,
							'article_category' : article_category
						},
						success : 
							function(data){
							Swal.fire({
								  title: '삭제완료',
								  showCancelButton: false,
								  confirmButtonColor: '#357653',
								  confirmButtonText: '확인'
								}).then((result) => {
									// Paide이동시 Paide_test -> Paide로 변경
									location.href = "/Paide_test/commu_" + article_category + ".jsp"
								})
						},
						error : 
							function(request, status, error){
							alert("ajax오류")
						}	
					})
				}	
			})	
	}
	
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
					Swal.fire({
						  title: '좋아요가 반영되었습니다.',
						  showCancelButton: false,
						  confirmButtonColor: '#357653',
						  confirmButtonText: '확인'
						}).then((result) => {
							location.reload();
						})
				},
			error : 
				function(request, status, error){
				alert("실패")
				}
		});
		 $('#like' + cmt_seq).attr('onClick', 'dislikes(' + cmt_seq + ')');
		 $('#like' + cmt_seq).attr('id', 'dislike' + cmt_seq);
		 $('#heart').attr('src', 'img/heartfull.png');
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
					Swal.fire({
						  title: '좋아요가 취소되었습니다.',
						  showCancelButton: false,
						  confirmButtonColor: '#357653',
						  confirmButtonText: '확인'
						}).then((result) => {
							location.reload();
						})
				},
			error : 
				function(request, status, error){
				alert("실패");
				}
		});
		 $('#dislike' + cmt_seq).attr('onClick', 'likes(' + cmt_seq + ')');
		 $('#dislike' + cmt_seq).attr('id', 'like' + cmt_seq);
		 $('#heart').attr('src', 'img/heart.png');
		 
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
				Swal.fire({
					  title: '댓글이 삭제되었습니다.',
					  showCancelButton: false,
					  confirmButtonColor: '#357653',
					  confirmButtonText: '확인'
					}).then((result) => {
						location.reload();
					})
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
				Swal.fire({
					  title: '댓글 수정이 완료되었습니다.',
					  showCancelButton: false,
					  confirmButtonColor: '#357653',
					  confirmButtonText: '확인'
					}).then((result) => {
						location.reload();
					})
			},
			error : 
				function(request, status, error){
				alert("ajax오류")
			}	
		});
	}
	

  
   </script>
</body>

</html>