const form = document.getElementById("registerForm");
const submitButton = document.getElementById("register");
const errorMessage = document.getElementById("error");
const date = new Date();
const currentYear = date.getFullYear;

let user = {}

if(addEventListener(submitButton, onclick)) { //pobranie danych z formularza
    user.email = form.querySelector('#enterEmail2').value;       // formularz waliduje
    user.password = form.querySelector('#enterPassword2').value; // te dane
    let name = form.querySelector('#enterName').value;
    let surname = form.querySelector('#enterSurname').value;
    let birthYear = form.querySelector('#birthYear').value;
    let sex = form.querySelector('#sex').value;
    let city = form.querySelector('#city').value;

    validateName(name);
    validateSurname(surname);
    validateBirthYear(birthYear);
    validateSex(sex);
    validateCity(city);
}

function validateName(name) {
    if(name.length <= 30 && name != null) {
        user.name = name;
    }
}

function validateSurname(surname) {
    if(surname <= 30 && surname != null) {
        user.surname = surname;
    }
}

function validateBirthYear(birthYear) {
    if(currentYear - birthYear >= 3) {
        user.birthYear = birthYear;
    }
}

function validateSex(sex) {
    if(sex === "female" || sex === "male") {
        user.sex = sex;
    }
}

function validateCity(city) {
    if(city === "village" || city === "smallTown" || city === "midTown" || city === "bigTown") {
        user.city = city;
    }
}
