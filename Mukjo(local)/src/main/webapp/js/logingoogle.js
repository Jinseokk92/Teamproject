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

let pwd1 = document.querySelector('#pwd1');
let pwd2 = document.querySelector('#pwd2');

let phone = document.querySelector('#phone');
let birth = document.querySelector('#birth');

let chkbtn = document.querySelector('#chkbtn');

let error = document.querySelectorAll('.error_next_box');
/*각 변수에 대한 이벤트핸들러 */
userName.addEventListener("focusout", checkName);

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


// 비밀번호
function checkPw() {

    let pwPattern = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&]).*$/;

    if(pwd1.value == "") {
        error[1].innerHTML = "비밀번호를 입력해주세요.";
        error[1].style.display = "block";
    } else if(!pwPattern.test(pwd1.value)) {
        error[1].innerHTML = "8~16자 영문, 숫자, 특수문자(!@#$%^&)를 사용하세요.";
        error[1].style.display = "block";
    } else {
        error[1].style.display = "none";
    }
}

// 비밀번호 재입력
function confirmPw() {

    if(pwd2.value == pwd1.value && pwd1.value != "") {
        error[2].style.display = "none";
    } else if(pwd2.value !== pwd1.value) {
        error[2].innerHTML = "비밀번호가 일치하지 않습니다.";
        error[2].style.display = "block";
    } 
    
    if(pwd2.value == "") {
        error[2].innerHTML = "비밀번호 재확인하셔야죠!";
        error[2].style.display = "block";
    }
}

// 핸드폰 번호 검사
function checkPhoneNum() {
    let isPhoneNum = /([01]{2})([01679]{1})([0-9]{4})([0-9]{4})/;

    if(phone.value === "") {
        error[3].innerHTML = "핸드폰 번호를 입력해주세요.";
        error[3].style.display = "block";
    } else if(!isPhoneNum.test(phone.value)) {
        error[3].innerHTML = "형식에 맞지 않는 번호입니다.";
        error[3].style.display = "block";
    } else {
        error[3].style.display = "none";
    }  
}

// 생년월일 검사
function isBirthCorrect() {
    let checkBirthNum = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;

    if(!checkBirthNum.test(birth.value)) {
        error[4].innerHTML = "제대로 입력해주세요.";
        error[4].style.display = "block";
    } else if(birth.value == "") {
        error[4].innerHTML = "필수 입력입니다."
    } else {
        error[4].style.display = "none";
    }
}