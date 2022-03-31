<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
               <!-- 변경 : action값은 우리가 만든 서비스 값으로 줘야 함. -->
                     <form class="form-auth-small" action="JoinService.do" method="post">
                        <div class="form-group">
                           <label for="signin-id" class="control-label sr-only">아이디</label>
                           <!-- 변경 : name값 id로 줌. -->
                           <input type="text" name="id" class="form-control" placeholder="아이디">
                           <!-- 변경 : ajax기능 구현하려고 버튼에 id값 줬고, 나머지들에게도 id값 부여함.-->
                           <button type="button" class="btn btn-primary btn-lg btn-block" id="btn">중복확인</button>
                        </div>
                         <!-- 변경 : 이름 값 안 넣어져 있길래 넣음-->
                        <div class="form-group">
                           <label for="signin-id" class="control-label sr-only">이름</label>
                           <input type="text" class="form-control" name="name"  placeholder="이름">
                        </div>
                        
                        <div class="form-group">
                           <label for="signin-id" class="control-label sr-only">이메일</label>
                           <input type="text" class="form-control" name="email" id="email" placeholder="이메일">
                        </div>

                        <div class="form-group">
                           <label for="signin-id" class="control-label sr-only">전화번호</label>
                           <input type="number" class="form-control" name="tel" id="tel"  placeholder="전화번호">
                        </div>
                        <!-- 변경 : 비밀번호 확인 기능 구현함.(JQuery)-->
                        <div class="form-group">
                           <label for="signin-password" class="control-label sr-only">비밀번호</label>
                           <input type="password" class="form-control" name="pw1" id="userPw" placeholder="비밀번호">
                        </div>
                        <div class="form-group">
                           <label for="signin-password" class="control-label sr-only">비밀번호 확인</label>
                           <input type="password" class="form-control" name="pw2" id="userPwChk" placeholder="비밀번호 확인">
                           <font id="chkNotice" size="2"></font>

                        </div>
                        <input type="submit" value="회원가입" id="Join" class="btn btn-primary btn-lg btn-block">
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

<!-- 변경: 여기 js없어서 js불러오는 코드 넣었다. -->
 <!-- Javascript -->
<script type="text/javascript" src="assets/vendor/jquery/jquery.min.js"></script>
 <script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
 <script src="assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
 <script src="assets/vendor/jquery.easy-pie-chart/jquery.easypiechart.min.js"></script>
 <script src="assets/vendor/chartist/js/chartist.min.js"></script>
 <script src="assets/scripts/klorofil-common.js"></script>

<!-- 변경: 중복확인 불러오는 제이쿼리임. 안되어 있더라.... -->
 <script type="text/javascript">
   //0. 아이디 중복체크 버튼을 클릭했을 때
   $('#btn').on('click',function(){
   //1. 입력한 email 가져오기
      let id = $('input[name=id]').val();
      console.log(id);
   
   //2. ajax로 email 보내기(설미누나가 만든 서비스콘 이름으로 지정해야 함.)
   $.ajax({
      url : 'CheckIDService.do', //어디로 보낼지
      data : {//입력한 email data보내기
         id : id //이름지정 : input태그값 
      },
      dataType : "text", //중복체크 결과값 text로 받아오기
      success : function(result){
         if(result=='false'){
         alert('중복없음', result);
            //중복X
            //$('#idcheck').html('중복되는 아이디가 없습니다.')
         }else{
            alert('중복있음', result);
            //중복O
           // $('#idcheck').html('아이디가 중복됩니다.')
         }
      },
      error : function(){
         alert('실패');
      }
   });
      
   })

<!-- 변경: 비밀번호 확인하는 제이쿼리임. 안되어 있더라.... -->

   $(function(){
    $('#userPw').keyup(function(){
      $('#chkNotice').html('');
    });

    $('#userPwChk').keyup(function(){

        if($('#userPw').val() != $('#userPwChk').val()){
          $('#chkNotice').html('비밀번호 일치하지 않음');
          $('#chkNotice').attr('color', '#f82a2aa3');
        } else{
          $('#chkNotice').html('비밀번호 일치함');
          $('#chkNotice').attr('color', '#199894b3');
        }

    });
});
   

   $('#email').keyup(function(){
      let m_email = $('input[name=email]').val();
   
   $.ajax({
      url : 'CheckInfoService.do',
      data : {
         m_email : m_email,
      },
      dataType : "text",
      success : function(res){
         console.log(res);
         if(res == 'email'){
            alert('중복된 이메일입니다');
         }
      },
      error : function(res){
         console.log('error')
      }
   });
   })
   
    $('#tel').keyup(function(){
      let m_tel = $('input[name=tel]').val();
   
   $.ajax({
      url : 'CheckInfoService.do',
      data : {
         m_phone : m_tel
      },
      dataType : "text",
      success : function(res){
         console.log(res);
         if(res == 'phone'){
            alert('중복된 번호입니다');
         }
      },
      error : function(res){
         console.log('error')
      }
   });
   })
   
   </script>


</body>

</html>