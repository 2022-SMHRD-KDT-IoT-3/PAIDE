<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype HTML>
<head>
   <meta charset="UTF-8">
   <title> PAI:DE | page-findPw.비밀번호찾기</title>
   
   <link rel="stylesheet" href="assets/css/style.css">
   <script src="https://kit.fontawesome.com/51db22a717.js" crossorigin="anonymous"></script>
   
</head>

<style>
   input.Confirm3 {
  width: 500px;
  height: 32px;
  font-size: 15px;
  border: 0;
  
  outline: none;
  padding-left: 10px;
  color: white;
  background-color: #3f7647;
}

input.Confirm2 {
  width: 100px;
  height: 32px;
  font-size: 15px;
  border: 0;
  
  outline: none;
  padding-left: 10px;
  color: white;
  background-color: #3f7647;
  text-align:center;
}
div.text2{
   text-align:center;
}

input.Confirm1 {
  width: 100px;
  height: 32px;
  font-size: 15px;
  border: 0;
  
  outline: none;
  padding-left: 10px;
  color: white;
  background-color: #3f7647;
  text-align:center;
}

div.text1{
   text-align:center;
}
</style>

<body>
   <div class="main-container">
      <div class="main-wrap">
      <header>
        
         <div class="logo-wrap">
            <span>PAI:DE</span>
         </div>
      </header>
      <section class="login-input-section-wrap">
         <p class="lead">01. 아이디 입력></p>
         <p class="lead">비밀번호를 찾고자 하는 아이디를 입력해 주세요.</p>
         <br>
         <div class="login-input-wrap"> 
            <input placeholder="ID" type="text" name="userid"/>
            <form class="confirm">
               <br>
               <div class="text1">
               <input type='button'
                      value='아이디 확인  '
                      class="Confirm1"
                      id="checkid"/>
               </div>
             </form>
         </div>
         <br>
         <br>
         <br>
         <br>
         <p class="lead">02. 본인확인></p>
         <p class="lead">회원가입시 등록한 이메일을 입력해 주세요.</p>
         <div class="login-input-wrap password-wrap">   
            <input placeholder="E-mail" type="text" name="email"/>
            <form class="confirm">
               <br>
               <div class="text2">
               <input type='button' 
                      value='이메일 확인'
                      class="Confirm2"
         			  id = "sendmail"/>
                     </div>
             </form>
         </div>
         <br>
         <br>
         <br>
         <br>
            <!-- 변경(최설미 주관) : 바로 로그인 화면으로 전환-->
         <input type='button'
         value='다음'
         class="Confirm3"
         style='cursor:pointer'
         onClick="location.href='page-login.jsp'">
            
         <br>
        
         <div class="bottom">
            <span class="helper-text"><i class="fa fa-lock"></i> <a href="page-findId.jsp"> 아이디찾기</a></span>
            <span class="helper-text"><a href="page-join.jsp"> | 회원가입</a></span>
         </div>

      </section>
     
      <footer>
         <div class="copyright-wrap">
         <span> 
             Copyright © PAIDE Corp. All Rights Reserved.</span>
         </div>
      </footer>
      </div>
   </div>
   
   <script type="text/javascript" src="assets/vendor/jquery/jquery.min.js"></script>
   <script type="text/javascript" src="assets/vendor/jquery/jquery.cookie-1.4.1.min.js"></script>
    <script type="text/javascript">
    
    	
    $('#checkid').on('click',function(){
		$.ajax({
			url : "SearchPWService.do",
			type : "post",
			data : {
				"m_id" : $('input[name=userid]').val()
			},
			dataType : "json",
			success : function(res){
				alert("본인확인이 완료되었습니다.");
				let m_id = res[2];
				let m_pw = res[0];
				$.cookie('mailid', m_id, { expires: 1 });
				$.cookie('mailpw', m_pw, { expires: 1 });
			},
			error : function(){
				alert("회원정보가 없습니다.")
			}
		})
	});
    
    $('#sendmail').on('click',function(){
		$.ajax({
			url : "PWSendMailService.do",
			type : "post",
			data : {
				"m_email" : $('input[name=email]').val(),
				"mailid" : $.cookie('mailid'),
				"mailpw" : $.cookie('mailpw')
			},
			success : function(res){
				if(res=='true'){
					alert("메일을 보내드렸습니다. 확인 후 다시 로그인해주세요.")
					}else{
						alert("등록된 이메일이 아닙니다.");
					}
					console.log(res)
			},
			error : function(){
				alert("등록된 이메일이 아닙니다.");
			}
		})
	});
    
    
    </script>
</body>
</html>