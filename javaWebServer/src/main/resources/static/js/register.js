const form = document.getElementById("registerForm");
const submitButton = document.getElementById("register");
let user = {}

form.addEventListener('submit', function(event) { //pobranie danych z formularza
    event.preventDefault();

    user.email = form.querySelector('#email').value;       // formularz waliduje
    user.password = form.querySelector('#password').value; // te dane
    let name = form.querySelector('#name').value;
    let surname = form.querySelector('#surname').value;
    let birthYear = form.querySelector('#birthYear').value;
    let sex = form.querySelector('input[name="gender"]:checked').value; //te dane nie potrzebuja
    let city = form.querySelector('#city').value; // walidacji (nie da sie wprowadzic innej wartosci niz ustalone)

    let isValid = true;
    isValid = validate(name, surname, birthYear, sex, city);
    if(isValid) {
        fetch('/api/register', {
            method: 'post',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(user)
        })
        .then(response => {
            if (!response.ok) {
                window.alert("Połączenie z siecią powoduje problemy, dane nie zostały przesłane!");
            }
            return response.json();
        })
        .then(data => {
            console.log(data); // wyświetl odpowiedź z serwera
        })
        .catch(error => {
            window.alert("Podczas przesyłania danych wystąpił błąd, spróbuj ponownie!");
        });
    }
});

function validate(name, surname, birthYear, sex, city) {
    
    if(name.length <= 30 && name != null) {
        user.name = name;
    } else {
        window.alert(`Zbyt długie imię: ${name.length}, maksymalna liczba znaków to 30!`);
        return false;
    }

    if(surname.length <= 30 && surname != null) {
        user.surname = surname;
    } else {
        window.alert(`Zbyt długie nazwisko: ${surname.length}, maksymalna liczba znaków to 30!`);
        return false;
    }

    const date = new Date();
    const currentYear = date.getFullYear();

    if(currentYear - birthYear >= 3) {
        user.birthYear = birthYear;
    } else { 
        window.alert("Użytkownik musi mieć minimum 3 lata!");
        return false;
    }

    if(sex === "female" || sex === "male") {
        user.sex = sex;
    }

    if(city === "village" || city === "smallTown" || city === "midTown" || city === "bigTown") {
        user.city = city;
    }
return true;
}