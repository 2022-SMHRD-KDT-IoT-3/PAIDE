<%@page import="Model.SubscriptionDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.SubscriptionDAO"%>
<%@page import="Model.MemberDTO"%>
<%@page import="Model.MemberDAO"%>
<%@page import="Model.FarmDTO"%>
<%@page import="Model.FarmDAO"%>
<%@page import="Model.CommunityDAO"%>
<%@page import="Model.CommunityDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">

<head>
    <title>PAI:DE | 다른농장.OtherFarm</title>
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
    <script src="https://kit.fontawesome.com/def66b134a.js" crossorigin="anonymous"></script>

    
    <style>
        #form-commentInfo {
            width: 100%;
        }

        #comment-count {
            margin-bottom: 10px;
        }

        #comment-input {
            width: 50%;
            height: 3.3em;
        }

        #submit {
            background-color: #3f7647;
            width: 5.5em;
            height: 3.3em;
            ;
            font-size: 15px;
            font-weight: bold;
            color: aliceblue;
        }

        #voteUp,
        #voteDown {
            width: 3.5em;
            height: 1.9em;
            background-color: aqua;
        }

        #comments {
            margin-top: 10px;
        }

        .eachComment {
            width: 50%;
            margin: 10px;
            padding: 0.5em;
            border-bottom: 1px solid #c1bcba;
        }

        .eachComment .name {
            font-size: 1.5em;
            font-weight: bold;
            margin-bottom: 0.3em;
            display: flex;
            justify-content: space-between;
        }

        .eachComment .inputValue {
            font-size: 1.2em;
            font-style: italic;
        }

        .eachComment .time {
            font-size: 0.7em;
            color: #c1bcba;
            font-style: oblique;
            margin-top: 0.5em;
            margin-bottom: 0.5em;
        }

        .eachComment .voteDiv {
            display: flex;
            justify-content: flex-end;
        }

        .eachComment .deleteComment {
            background-color: red;
            color: aliceblue;
        }
    </style>
    <style>
	#profile {
		width: 20px;
		height: 20px;
		object-fit: cover;
	}
</style>

</head>

<body>
<% 	MemberDTO info = (MemberDTO)session.getAttribute("info");
	int f_seq = Integer.parseInt(request.getParameter("seq")); 
	FarmDTO fdto = new FarmDAO().selectFarm(f_seq);
	ArrayList<SubscriptionDTO> sublist = new SubscriptionDAO().sub_list(info.getM_id());
	ArrayList<FarmDTO> farmlist = new FarmDAO().myfarm(fdto.getF_owner_id()); 
    MemberDTO otherinfo = new MemberDAO().otherinfo(fdto.getF_owner_id());
%>
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
        <a name ="top">맨위</a>
        <div id="sidebar-nav" class="sidebar">
           <div class="sidebar-scroll">
              <nav>
                 <ul class="nav">
                    <li><a href="index.html" class=""><i class="lnr lnr-home"></i> <span>Home</span></a></li>
                    <li><a href="commu_D.html" class=""><i class="lnr lnr-list"></i> <span>농산물 직거래</span></a></li>
                    <li><a href="commu_E.html" class=""><i class="lnr lnr-list"></i> <span>체험농장</span></a></li>
                    <li><a href="commu_W.html" class=""><i class="lnr lnr-list"></i> <span>농촌일자리</span></a></li>
                    <li><a href="commu_F.html" class=""><i class="lnr lnr-list"></i> <span>자유게시판</span></a></li>
  
                    <!-- 로그아웃시 삭제2 start -->
                    <% if(info != null){%>
                    <li>
                       <a href="#subPages" data-toggle="collapse" class="collapsed"><i class="lnr lnr-user"></i>
                          <span><%= info.getM_name() %></span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
                       <div id="subPages" class="collapse ">
                          <ul class="nav">
                             <li><a href="myFarm.jsp?seq=<%=farmlist.get(0).getF_seq()%>" class=""><i class="lnr lnr-leaf"></i>내 농장</a></li>
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
                    <div class="panel panel-profile">
                        <div class="clearfix">
                            <!-- LEFT COLUMN -->
                            <div class="profile-left">
                                <!-- PROFILE HEADER -->
                                <div class="profile-header">
                                    <div class="overlay"></div>
                                    <div class="profile-main">
                                        <img src="assets/img/<%=otherinfo.getM_profile() %>" class="img-circle" alt="Avatar">
                                        <!-- (여기는 다른농장회원(사용자가 선택한 사람) 이름이 와야함!!! 로그인한 회원 이름변수 ㄱ -->
                                        <h3 class="name"><%=fdto.getF_owner_id() %></h3>
                                    </div>
                                </div>
                                <!-- END PROFILE HEADER -->
                                <!-- PROFILE DETAIL -->
                                <div class="profile-detail">
                                    <div class="profile-info">
                                        <!-- 변경 선택한 농장의 정보로 변경 -->
                                        <h4 class="heading">농장정보 (<%=fdto.getF_owner_id() %>)</h4>
                                        <ul class="list-unstyled list-justify">
                                            <!-- 농장선택을 누르면 <span>안의 선택한 농장의 정보가 떠야한다 -->
                                            <% FarmDTO Farminfo = new FarmDAO().myFarm(f_seq); %>
                                            <li>농장이름 <span id="farmname"><%=fdto.getF_name() %></span></li>
                                            <li>농장지역 <span><%=fdto.getF_region() %></span></li>
                                            <li>재배작목 <span><%=fdto.getF_crops() %></span></li>
                                            <%if("P".equals(Farminfo.getF_facility())){ %>
                                			<li>재배시설 <span>비닐온실</span></li>
                                 			<%}else if("G".equals(Farminfo.getF_facility())){ %>
                                 			<li>재배시설 <span>유리온실</span></li>
                                 			<%} %>
                                        </ul>
                                        <input type = "hidden" name="m_id" value="<%=info.getM_id() %>">
                                        <input type = "hidden" name="f_seq" value="<%=fdto.getF_seq() %>">

                                        <br>
                                        <center>
                                            <a href="OtherFarm_detail.jsp?seq=<%=f_seq%>&startday=TO_CHAR(SYSDATE, 'YYYY-MM-DD')"> <button type="button"
                                                    class="btn btn-primary">자세히보기</button></a>
                                         <% 
                                         int check = 0;
                                         for(int i = 0; i<sublist.size(); i++){ %>
                                            <% if(!sublist.get(i).getF_name().equals(fdto.getF_name())){ %>
                                            <%}else if((sublist.get(i).getF_name().equals(fdto.getF_name()))){ %>
                                            <%check ++;}%>
                                         <%};%>
                                         <%if(check > 0) {%>
                                         <button type="button" id='addValue' class="btn btn-primary" onclick="removeItem()" />이웃취소</button>
                                          <%}else { %>
                                         <button type="button" id='addValue' class="btn btn-primary" onclick="addList()" />이웃추가</button>
                                            <%}%>
                                        </center>
                                        <br>
                                        <!-- 실시간현재 날짜/시간 -->
                                        <div id="current_date">
                                            <script>
                                                date = new Date();
                                                year = date.getFullYear();
                                                month = date.getMonth() + 1;
                                                day = date.getDate();
                                                document.getElementById("current_date").innerHTML = year + "/" + month + "/" + day + " ";
                                                let today = new Date();
                                                let hours = today.getHours(); // 시
                                                let minutes = today.getMinutes();  // 분
                                                document.write(hours + ':' + minutes);
                                            </script>
                                        </div>
                                    </div>
                                    <!-- current_date끝 -->
                                </div>
                                <!-- END PROFILE DETAIL -->
                            </div>
                            <!-- END LEFT COLUMN -->
                            <!-- RIGHT COLUMN -->
                            <div class="profile-right">
                                <strong>농장선택</strong>
                                <!-- 변경 회원의 등록된 농장으로 변경 -->
                                <form action = myFarm.jsp method="get">
                                <div class="input-group">
                                    <select name="seq" class="form-control">
                                       <%for(int i = 0; i<farmlist.size(); i++){%>
                              			<option value="<%=farmlist.get(i).getF_seq()%>"><%=farmlist.get(i).getF_name()%></option>
                           				<%} %>
                                    </select>
                                    <span class="input-group-btn"><button class="btn btn-primary"
                                            type="button">선택</button></span>
                                </div>
                                </form>
                                <br><br>
                                <!-- 게시판 목록 -->
                                <!--  변경 '송찬영'이라는 자리에는 선택한 subscriptioned_id가 와야함. -->
                                <div class="panel panel-scrolling">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">송찬영 님의 게시글 작성 목록</h3>
                                        <div class="right">
                                            <button type="button" class="btn-toggle-collapse"><i
                                                    class="lnr lnr-chevron-up"></i></button>
                                        </div>
                                    </div>
                                    <!-- 송찬영가 작성한 게시글들이 나와야한다. -->
                                    <div class="panel-body">
                                        <!-- 변경 클릭 시, 해당 게시글으로 가는 기능 구현해야한당. -->
                                        <ul class="list-unstyled activity-list">
                                            <li>
                                                <p><a href="boardSelect.html"> 게시글제목 </a> <span class="timestamp">
                                                       게시글 내용 </span></p>
                                            </li>
                                            <li>

                                                <p><a href="boardSelect.html">PAIDE에서 딸기 직거래 하실 분</a><span
                                                        class="timestamp">직접 친환경 재배 딸기 한상자 당 20억</span></p>
                                            </li>
                                            <li>

                                                <p><a href="boardSelect.html">수완에서 딸기 직거래 하실 분</a><span
                                                        class="timestamp">수완에서 토마토직거래하실분 있나요 맛있어요수완에서 토마토직거래하실분 있나요
                                                        맛있어요수완에서 토마토직거래하실분 있나요 맛있어요수완에서 토마토직거래하실분 있나요 맛있어요</span></p>
                                            </li>
                                            <li>

                                                <p><a href="boardSelect.html">수완에서 딸기 직거래 하실 분</a><span
                                                        class="timestamp">수완에서 토마토직거래하실분 있나요 맛있어요수완에서 토마토직거래하실분 있나요
                                                        맛있어요수완에서 토마토직거래하실분 있나요 맛있어요수완에서 토마토직거래하실분 있나요 맛있어요</span></p>
                                            </li>
                                            <li>

                                                <p><a href="boardSelect.html">수완에서 딸기 직거래 하실 분</a><span
                                                        class="timestamp">수완에서 토마토직거래하실분 있나요 맛있어요수완에서 토마토직거래하실분 있나요
                                                        맛있어요수완에서 토마토직거래하실분 있나요 맛있어요수완에서 토마토직거래하실분 있나요 맛있어요</span></p>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <!-- END RIGHT COLUMN -->
                            <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END MAIN CONTENT -->
        </div>
        <!-- END MAIN -->
        <div class="clearfix"></div>
        <footer>
            <div class="container-fluid">
               <div class="copyright-wrap">
                  <span>Copyright © PAIDE Corp. All Rights Reserved.</span>
               </div>
            </div>
         </footer>
    </div>
    <!-- END WRAPPER -->
    <!-- Javascript -->
    <!-- 이웃추가기능 -->
    <script type="text/javascript" src="JS/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
    
    function addList() {
    let addfarm = $('#farmname').text()
    console.log(addfarm)
            $.ajax({
            	url : "AddSubscriptionService.do",
            	type : "post",
            	data : {
            		"m_id" : $('input[name=m_id]').val(),
            		"f_seq" : $('input[name=f_seq]').val()
            	},
            	success : function(res){
            		if(res == 'success'){
                    	$('#addValue').text("이웃취소");
            			$('#addValue').attr("onClick", "removeItem()");
            		}else{
            			console.log('fail')
            		}
            	},
            	error : function(){
            		console.log('addfail')
            	}
            })
			
    		
        };
        
        function removeItem(){
        	let addfarm = $('#farmname').text()
        	$.ajax({
        		url : 'DeleteSubscriptionService.do',
        		type : "get",
        		data : {
        			"m_id" : $('input[name=m_id]').val(),
            		"f_seq" : $('input[name=f_seq]').val()
        		},
        		success : function(res){
            		if(res == 'success'){
                    	$('#addValue').text("이웃추가");
                    	$('#addValue').attr("onClick", "addList()");
            		}else{
            			console.log('fail')
            		}
            	},
            	error : function(){
            		console.log('deletefail')
            	}
        	})
        };
        
        

        
    </script>
    <!-- 끝.이웃추가기능 -->
</script> -->
    <!-- 끝.이웃삭제기능 -->
    <script src="assets/vendor/jquery/jquery.min.js"></script>
    <script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
    <script src="assets/scripts/klorofil-common.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
    <!--아이콘 왜안댐?  <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script> -->
    <!-- <script src="https://kit.fontawesome.com/a20ebfca81.js" crossorigin="anonymous"></script> -->
</body>

</html>