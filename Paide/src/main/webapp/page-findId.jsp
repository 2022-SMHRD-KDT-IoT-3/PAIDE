<%@ page language="java" contentType="text/html; charset=UTf-8"
    pageEncoding="UTf-8"%>
<!doctype HTML>
<head>
   <meta charset="UTF-8">
   <title> PAI:DE | page-findId.아이디찾기</title>
   
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
         <p class="lead">01. 본인확인 ></p>
         <p class="lead">본인의 이름, 전화번호를 입력해주세요.</p>
         <br>
         <div class="login-input-wrap"> 
            <input placeholder="ID" type="text"/>
            <br>
            <br>
            <div class="login-input-wrap"> 
                <input placeholder="전화번호" type="text"/>
            <form class="confirm">
               <br>
               <div class="text1">
               <input type='button'
                      value='본인확인  '
                      class="Confirm1"
                      onclick='alert("확인 성공")'/>
               </div>
            </div>
             </form>
         </div>
         <br>
         <br>
         <br>
         <br>
         <br>
         <br>
         <br>
         <p class="lead">02. 이메일 입력></p>
         <p class="lead">회원가입시 등록한 이메일을 입력해 주세요.</p>
         <div class="login-input-wrap password-wrap">   
            <input placeholder="E-mail" type="password"/>
            <form class="confirm">
               <br>
               <div class="text2">
               <input type='button' 
                      value='확인  '
                      class="Confirm2"
                      onclick='alert("아이디를 해당 이메일로 보냈습니다. 아이디 확인 후 로그인을 진행해주세요.")'/>
                     </div>
             </form>
         </div>
         <br>
         <br>
         <br>
         <br>
         <div class="bottom">
            <span class="helper-text"><i class="fa fa-lock"></i> <a href="#"> 비밀번호 찾기</a></span>
            <span class="helper-text"><a href="#"> | 회원가입</a></span>
            <span class="helper-text"><a href="#"> | 로그인</a></span>
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