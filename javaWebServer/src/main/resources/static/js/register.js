window.onload = function() {
    document.querySelector('#registerForm').addEventListener('submit', function(event) {
        event.preventDefault();

        let formData = new FormData();
        formData.append('email', document.getElementById("email1").value);
        formData.append('password', document.getElementById("password1").value);
        formData.append('name', document.getElementById("name").value);
        formData.append('surname', document.getElementById("surname").value);
        formData.append('birthYear', document.getElementById("birthYear").value);

        let genderRadios = document.getElementsByName("gender");
        for(let i = 0; i < genderRadios.length; i++) {
            if(genderRadios[i].checked) {
                formData.append('sex', genderRadios[i].value);
                break;
            }
        }

        formData.append('placeOfResidence', document.getElementById("city").value);

        // Tworzenie tablicy z danymi
        let dataArray = Array.from(formData.entries());
        alert(dataArray);  // Tutaj logujemy dane do konsoli

        fetch('/api/register', {
            method: 'POST',
            body: formData
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Błąd sieci!');
            }
            return response.json();  // Tutaj przekształcamy odpowiedź w JSON
        })
        .then(data => {
            console.log(data);  // Tutaj logujemy dane do konsoli
            alert('Sukces: ' + JSON.stringify(data));  // Tutaj wyświetlamy dane w alercie
        })
        .catch((error) => {
            console.error(error);  // Tutaj logujemy błąd do konsoli
            alert('Błąd: ' + error.message);  // Tutaj wyświetlamy błąd w alercie
        });
    });
}
