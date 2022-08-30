'use strict';

/* 아무것도 입력안하고 submit 눌렀을 때 화면 */
window.addEventListener('load', () => {
    const forms = document.getElementsByClassName('validation-form');

    Array.prototype.filter.call(forms, (form) => {
        form.addEventListener('submit', function (event) {

            if (form.checkValidity() === false) {
                event.preventDefault();
                event.stopPropagation();
            }

            form.classList.add('was-validated');

        }, false);
    });
}, false);


/* 각 입력 폼에 대한 기능 */

/*변수 선언*/
let userName = document.querySelector('#userName');

let email = document.querySelector('#email');
let error = document.querySelectorAll('.error_next_box');

let pwd1 = document.querySelector('#pwd1');
let pwd2 = document.querySelector('#pwd2');

let phone = document.querySelector('#phone');
let birth = document.querySelector('#birth');

let chkbtn = document.querySelector('#chkbtn');

/*각 변수에 대한 이벤트핸들러 */
userName.addEventListener("focusout", checkName);

email.addEventListener("focusout", isEmailCorrect);

pwd1.addEventListener("focusout", checkPw);
pwd2.addEventListener("focusout", confirmPw);

phone.addEventListener("focusout", checkPhoneNum);

birth.addEventListener("focusout", isBirthCorrect)


// 이메일 검사
function checkName() {
    let namePattern = /[a-zA-Z가-힣]/;
    if(userName.value === "") {
        error[0].innerHTML = "필수 입력입니다.";
        error[0].style.display = "block";
    } else if(!namePattern.test(userName.value) || userName.value.indexOf(" ") > -1) {
        error[0].innerHTML = "한글과 영문 대소문자를 사용하세요. (특수기호, 공백 사용 불가)";
        error[0].style.display = "block";
    } else {
        error[0].style.display = "none";
    }
}

function isEmailCorrect() {

    let emailPattern = /[a-z0-9]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/;

    if(email.value === ""){ 
        error[1].innerHTML = "이메일을 입력하세요.";
        error[1].style.display = "block";
    } else if(!emailPattern.test(email.value)) {
        error[1].innerHTML = "이메일 형식이 맞지 않습니다.";
        error[1].style.display = "block";
    } else {
        error[1].style.display = "none"; 
    }
}

// 비밀번호
function checkPw() {

    let pwPattern = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&]).*$/;

    if(pwd1.value == "") {
        error[2].innerHTML = "비밀번호를 입력해주세요.";
        error[2].style.display = "block";
    } else if(!pwPattern.test(pwd1.value)) {
        error[2].innerHTML = "8~16자 영문, 숫자, 특수문자(!@#$%^&)를 사용하세요.";
        error[2].style.display = "block";
    } else {
        error[2].style.display = "none";
    }
}

// 비밀번호 재입력
function confirmPw() {

    if(pwd2.value == pwd1.value && pwd1.value != "") {
        error[3].style.display = "none";
    } else if(pwd2.value !== pwd1.value) {
        error[3].innerHTML = "비밀번호가 일치하지 않습니다.";
        error[3].style.display = "block";
    } 
    
    if(pwd2.value == "") {
        error[3].innerHTML = "비밀번호 재확인하셔야죠!";
        error[3].style.display = "block";
    }
}

// 핸드폰 번호 검사
function checkPhoneNum() {
    let isPhoneNum = /([01]{2})([01679]{1})([0-9]{4})([0-9]{4})/;

    if(phone.value === "") {
        error[4].innerHTML = "핸드폰 번호를 입력해주세요.";
        error[4].style.display = "block";
    } else if(!isPhoneNum.test(phone.value)) {
        error[4].innerHTML = "형식에 맞지 않는 번호입니다.";
        error[4].style.display = "block";
    } else {
        error[4].style.display = "none";
    }  
}

// 생년월일 검사
function isBirthCorrect() {
    let checkBirthNum = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;

    if(!checkBirthNum.test(birth.value)) {
        error[5].innerHTML = "제대로 입력해주세요.";
        error[5].style.display = "block";
    } else if(birth.value == "") {
        error[5].innerHTML = "필수 입력입니다."
    } else {
        error[5].style.display = "none";
    }

    // 13월이상 쓰면 오류
    // 32일이상 쓰면 오류나게 해야함
}


// 중복검사 버튼 
/*
$("#chkbtn").click(function () {
    // 중복검사 

    const Toast = Swal.mixin({
      toast: true,
      position: 'center-center',
      showConfirmButton: false,
      timer: 1000,
      timerProgressBar: true,
      didOpen: (toast) => {
        toast.addEventListener('mouseenter', Swal.stopTimer)
        toast.addEventListener('mouseleave', Swal.resumeTimer)
      }
    })

    Toast.fire({
    //   icon: 'error', 
    //   title: '사용하실 수 없는 이메일입니다 잠시만 기다려주세요!'

      icon: 'success', 
      title: '사용하실 수 있는 이메일입니다 잠시만 기다려주세요!'
    })
  });


// 가입완료 버튼 

$("#sbtn").click(function () {
    // 모든 형식이 다 갖춰졌으면 데이터 받아서 버튼 클릭 후 confirm 실행

    Swal.fire({
      title: '회원가입이 진행중입니다.',
      text: "이대로 회원가입을 진행하시겠습니까?",
      icon: 'confirm',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: '승인',
      cancelButtonText: '취소',
      reverseButtons: false, // 버튼 순서 거꾸로
      
    }).then((result) => {
      if (result.isConfirmed) {
        Swal.fire(
          '가입이 완료되었습니다.',
          'Welcome to Mukjo',
          'success'
        )  
        location.href="./login.do"; 
      }
      
    }) 
    
  });
*/



/*

기본 alert창 띄우기 

function btn1_click() {
    
    alert("사용할 수 있는 이메일입니다!");
    //중복검사할 것
}

function btn2_click() {
    alert("축하합니다! 회원가입이 완료되었습니다.");
    
}
*/



/* 
 Ajax vs jQuery 쓸지 정해야함

버튼을 만드려고했는데 버튼 짤리는 문제 떄문에
validation check할 때 중복 이메일 있는거는 validation으로 내가 나중에 처리할게
ajax써서 내가 처리함
ajax => 디비에 있는 데이터로 작업을 할 때 화면을 새로고침 안하고 작업을 하기위해 제이쿼리로 하려면 새로고침
*/
