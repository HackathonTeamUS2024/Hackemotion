window.onload = function() {
    // Przykładowe połączenie z bazą danych i pobranie ścieżki do zdjęcia
    fetch('/api/getImagePath', {
        method: 'POST'
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Błąd sieci!');
        }
        return response.json(); 
    })
    .then(data => {
        console.log(data);  

        // Ustawienie ścieżki do zdjęcia na stronie
        let imageElement = document.getElementById('photo');

        let buttonAngry = document.getElementById('angry');
        let buttonHappy = document.getElementById('happy');
        let buttonSurprised = document.getElementById('surprised');
        let buttonSad = document.getElementById('sad');
        let buttonShamed = document.getElementById('shamed');
        let buttonFear = document.getElementById('fear');

        var buttons = document.getElementsByTagName('button');

        let k = 0;
        let answer = new Array();
    
        for(let i = 0;i < data.name.length; i++){
            switch(data.name[i]) {
                case 'anger':
                
            var buttons = document.getElementsByTagName('button');
                
            for (var i = 0; i < buttons.length; i++) {
                buttons[i].addEventListener('click', function() {
                    if (this.id === 'anger') {
                        answer[i] = 'anger'; 
                        console.log('Kliknięto konkretny przycisk: ' + this.innerHTML);
                    } else {
                        answer[i] = String(this.id); 
                        console.log('Kliknięto inny przycisk: ' + this.innerHTML);
                    }
                });
            }
       
                break;
                case 'contempt':
                
                break;
                case 'fear':
                
                break;
                case 'disgust':
                
                break;
                case 'happiness':
                
                break;
                case 'surprise':
                
                break;
                default:
                alert("Brak danej w bazie danych");
            }
        }



        imageElement.src = data.imagePath;


    })
    .catch((error) => {
        console.error(error);  
        alert('Błąd: ' + error.message);  
    });
}
