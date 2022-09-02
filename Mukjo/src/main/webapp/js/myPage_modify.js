'use strict';

/* 각 입력 폼에 대한 기능 */

/*변수 선언*/

let email = document.querySelector('#email');
let error = document.querySelectorAll('.error_next_box');

let pwd1 = document.querySelector('#pwd1');
let pwd2 = document.querySelector('#pwd2');

let phone = document.querySelector('#phone');
let birth = document.querySelector('#birth');

let chkbtn = document.querySelector('#chkbtn');


/* 각 변수에 대한 이벤트핸들러 */
birth.addEventListener("focusout", isBirthCorrect)

phone.addEventListener("focusout", checkPhoneNum);

pwd1.addEventListener("focusout", checkPw);

pwd2.addEventListener("focusout", confirmPw);

// 생년월일 검사
function isBirthCorrect() {
    let checkBirthNum = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;

    if(!checkBirthNum.test(birth.value)) {
        error[0].innerHTML = "제대로 입력해주세요.";
        error[0].style.display = "block";
    } else if(birth.value == "") {
        error[0].innerHTML = "필수 입력입니다."
    } else {
        error[0].style.display = "none";
    }
}

// 핸드폰 번호 검사
function checkPhoneNum() {
    let isPhoneNum = /([01]{2})([01679]{1})([0-9]{4})([0-9]{4})/;

    if(phone.value === "") {
        error[1].innerHTML = "핸드폰 번호를 입력해주세요.";
        error[1].style.display = "block";
    } else if(!isPhoneNum.test(phone.value)) {
        error[1].innerHTML = "형식에 맞지 않는 번호입니다.";
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