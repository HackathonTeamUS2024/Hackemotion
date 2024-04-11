window.onload = function() {
    document.querySelector('#loginForm').addEventListener('submit', function(event) {
        event.preventDefault();

        let formData = new FormData();
        formData.append('email', document.getElementById("email").value);
        formData.append('password', document.getElementById("password").value);
        formData.append('name', document.getElementById("name").value);
        formData.append('password', document.getElementById("password").value);
        
        fetch('/api/register', {
            method: 'POST',
            body: formData
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Błąd sieci!');
            }
            return response.json();  
        })
        .then(data => {
            console.log(data);  
            alert('Sukces: ' + JSON.stringify(data));  
        })
        .catch((error) => {
            console.error(error);  
            alert('Błąd: ' + error.message);  
        });
    });
}
