<%@ page language="java" contentType="text/html; charset=UTf-8"
    pageEncoding="UTf-8"%>
<!doctype html>
<html lang="en" class="fullscreen-bg">

<head>
	<title> PAI:DE | 회원가입.page-join </title>
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
		<div class="vertical-align-wrap">
			<div class="vertical-align-middle">
				<div class="auth-box ">
					<div class="left">
						<div class="content">
							<div class="header">
								<div class="logo text-center"><a href="index.html"><img src="assets/img/pidelogo.png" alt="Klorofil Logo"></a></div>
								<p class="lead">Join to your account</p>
							</div>

							<form class="form-auth-small" action="index.php">
								<div class="form-group">
									<label for="signin-id" class="control-label sr-only">아이디</label>
									<input type="text" class="form-control" id="signin-email"  placeholder="아이디">
									<button type="submit" class="btn btn-primary btn-lg btn-block">중복확인</button>
								</div><div class="form-group">
									<label for="signin-id" class="control-label sr-only">이메일</label>
									<input type="email" class="form-control" id="signin-email"  placeholder="이메일">
								</div>

								<div class="form-group">
									<label for="signin-id" class="control-label sr-only">전화번호</label>
									<input type="number" class="form-control" id="signin-email"  placeholder="전화번호">
								</div>
								
								<div class="form-group">
									<label for="signin-password" class="control-label sr-only">비밀번호</label>
									<input type="password" class="form-control" id="signin-password"  placeholder="비밀번호">
								</div>
								<div class="form-group">
									<label for="signin-password" class="control-label sr-only">비밀번호 확인</label>
									<input type="password" class="form-control" id="signin-password"  placeholder="비밀번호 확인">
								</div>
								<button type="submit" class="btn btn-primary btn-lg btn-block" onClick="href='index.html'">회원가입</button>

								
								<!-- <button type="submit" class="btn btn-default">회원가입</button> -->
								
								
								
							</form>
						</div>
					</div>
					<div class="right">
						<div class="overlay"></div>
						<div class="content text">
							<h1 class="heading">Join in to PIE:DE</h1>
							
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
		</div>
	</div>
	<!-- END WRAPPER -->
	<footer>
		<div class="copyright-wrap">
		<span> 
			Copyright © PAIDE Corp. All Rights Reserved.</span>
		</div>
	 </footer>
</body>

</html>
