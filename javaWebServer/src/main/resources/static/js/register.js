
    document.querySelector('#registerForm').addEventListener('submit', function(event) {
        event.preventDefault();

        let formData = new FormData();
        formData.append('email', document.getElementById("email1").value);
        formData.append('password', document.getElementById("password1").value);
        formData.append('name', document.getElementById("name").value);
        formData.append('surname', document.getElementById("surname").value);
        formData.append('birthYear', document.getElementById("birthYear").value);
        formData.append('sex', document.getElementById("sex").value);
        formData.append('placeOfResidence', document.getElementById("city").value);

        fetch('/api/register', {
            method: 'post',
            body: formData,
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

