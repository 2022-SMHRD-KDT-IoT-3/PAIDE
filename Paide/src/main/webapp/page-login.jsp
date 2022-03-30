<%@ page language="java" contentType="text/html; charset=UTf-8"
    pageEncoding="UTf-8"%>
<!doctype html>
<html lang="en" class="fullscreen-bg">

<head>
	<title> PAI:DE | 로그인.page-login </title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<!-- VENDOR CSS -->
	<link rel="stylesheet" href="assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="assets/vendor/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="assets/vendor/linearicons/style.css">

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
		<div class="vertical-align-wrap">
			<div class="vertical-align-middle">
				<div class="auth-box ">
					<div class="left">
						<div class="content">
							<div class="header">
								<div class="logo text-center"><a href="index.jsp"><img src="assets/img/pidelogo.png" alt="Klorofil Logo"></a></div>
								<p class="lead">Login to your account</p>
							</div>
							<form class="form-auth-small" action="index.jsp">
								<div class="form-group">
									<label for="signin-id" class="control-label sr-only">아이디</label>
									<input type="text" class="form-control" id="signin-email"  placeholder="아이디">
								</div>
								
								<div class="form-group">
									<label for="signin-password" class="control-label sr-only">비밀번호</label>
									<input type="password" class="form-control" id="signin-password"  placeholder="비밀번호">
								</div>
								
								<button type="submit" class="btn btn-primary btn-lg btn-block" onclick="index.jsp">로그인</button>
								<div class="bottom">
									<span class="helper-text"><i class="fa fa-lock"></i> <a href="page-findPw.jsp">비밀번호찾기 | </a></span>
									<span class="helper-text"><i class="fa fa-lock"></i> <a href="page-findId.jsp"> 아이디찾기</a></span>
									<span class="helper-text"><a href="page-join.jsp"> | 회원가입</a></span>
								</div>
							</form>
						</div>
					</div>
					<div class="right">
						<div class="overlay"></div>
						<div class="content text">
							<h1 class="heading">Login to PAI:DE</h1>
							
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
		</div>
	</div>
	<footer>
		<div class="copyright-wrap">
		<span> 
			Copyright © PAIDE Corp. All Rights Reserved.</span>
		</div>
	 </footer>
	
	<!-- END WRAPPER -->
</body>

</html>