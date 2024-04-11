const form = document.getElementById("registerForm");
const submitButton = document.getElementById("register");
const errorMessage = document.getElementById("error");
const date = new Date();
const currentYear = date.getFullYear;

let user = {}

submitButton.addEventListener('click', function(){ //pobranie danych z formularza
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

    fetch("localhost:8080/api/login", {
    method: "POST",
    body: JSON.stringify({
    userId: 1,
    title: "Fix my bugs",
    completed: false
    }),
    headers: {
    "Content-type": "application/json; charset=UTF-8"
    }
})
.then((response) =>  response.json())
.then((json) =>  console.log(json));


});

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
