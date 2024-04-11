window.onload = function() {
    document.querySelector('#loginForm').addEventListener('submit', function(event) {
        event.preventDefault();

        let formData = new FormData();
        formData.append('email', document.getElementById("email").value);
        formData.append('password', document.getElementById("password").value);

        fetch('/api/login', {
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
