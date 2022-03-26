<%@ page language="java" contentType="text/html; charset=UTf-8"
    pageEncoding="UTf-8"%>
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
            <input placeholder="ID" type="text"/>
            <form class="confirm">
               <br>
               <div class="text1">
               <input type='button'
                      value='아이디 확인  '
                      class="Confirm1"
                      onclick='alert("확인 성공")'/>
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
            <input placeholder="E-mail" type="password"/>
            <form class="confirm">
               <br>
               <div class="text2">
               <input type='button' 
                      value='이메일 확인  '
                      class="Confirm2"
                      onclick='alert("확인 성공")'/>
                     </div>
             </form>
         </div>
         <br>
         <br>
         <br>
         <br>
            <input type='button'
            value='다음'
            class="Confirm3"
            onclick='alert("입력하신 이메일로 비밀번호를 전송하였습니다.")'/>
            
         <br>
        
         <div class="bottom">
            <span class="helper-text"><i class="fa fa-lock"></i> <a href="#"> 아이디찾기</a></span>
            <span class="helper-text"><a href="#"> | 회원가입</a></span>
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
</body>
</html>