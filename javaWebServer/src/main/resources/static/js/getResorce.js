window.onload = function() {
    let randomValue;
    let tabEmot = new Array();
    let tabNum = new Array();
    let answer = new Array();

    for(let l=0; l < 15; l++){
        randomValue = Math.floor(Math.random() * 6);
        if (randomValue == 0) tabEmot[l] = "sadness";
        else if (randomValue == 1) tabEmot[l] = "happiness";
        else if (randomValue == 2) tabEmot[l] = "anger";
        else if (randomValue == 3) tabEmot[l] = "fear";
        else if (randomValue == 4) tabEmot[l] = "surprise";
        else if (randomValue == 5) tabEmot[l] = "disgust";
        else l--;
    }



    for(let l=0; l < 15; l++){  
        randomValue = Math.floor(Math.random() * 21) + 1;
        tabNum[l] = String(randomValue).padStart(4, '0');
    }

    let imageElement = document.getElementById('photo');
    let buttons = document.querySelectorAll('button');

    let currentImageIndex = 0;

    
    
        

    function updateImage() {
        let sex;
        if(tabEmot[currentImageIndex] == 'sadness'){
            if(tabNum[currentImageIndex] >= 14) sex="1";
            else sex="0";
        }
        if(tabEmot[currentImageIndex] == 'happiness'){
            if(tabNum[currentImageIndex] >= 21) sex="1";
            else sex="0";
        }
        if(tabEmot[currentImageIndex] == 'anger'){
            if(tabNum[currentImageIndex] >= 11) sex="1";
            else sex="0";
        }
        if(tabEmot[currentImageIndex] == 'fear'){
            if(tabNum[currentImageIndex] >14)
                tabNum[currentImageIndex] -= randomValue = Math.floor(Math.random() * 13);
            if(tabNum[currentImageIndex] >= 9) sex="1";
            else sex="0";
        }
        if(tabEmot[currentImageIndex] == 'surprise'){
            if(tabNum[currentImageIndex] >= 14) sex="1";
            else sex="0";
        }
        if(tabEmot[currentImageIndex] == 'disgust'){
            if(tabNum[currentImageIndex] >18)
                tabNum[currentImageIndex] -= randomValue = Math.floor(Math.random() * 17);
            if(tabNum[currentImageIndex] >= 13) sex="1";
            else sex="0";
        }
        imageElement.src = '/image/' + tabEmot[currentImageIndex] + '/' + tabNum[currentImageIndex].padStart(4,'0') + '_'+ sex + '.jpg';
    }

    buttons.forEach((button) => {
        button.addEventListener('click', function() {
            answer[currentImageIndex] = this.id; 
            console.log('Kliknięto przycisk: ' + this.innerHTML);
            currentImageIndex++;
            if (currentImageIndex < tabEmot.length) {
                updateImage();
            } else {
                console.log('Koniec gry! Twoje odpowiedzi to: ', answer);
                sendPostRequest(answer);
            }
        });
    });

    updateImage();  // Wyświetl pierwsze zdjęcie


    function sendPostRequest(tablica) {
     let formData = new FormData();
        formData.append('answered', JSON.stringify(answer));
        formData.append('drawn', JSON.stringify(tabEmot));
        formData.append('userId', 1);

    // Log JSON data to console
    console.log('Sending JSON data: ', {
        answer: JSON.stringify(answer),
        tabEmot: JSON.stringify(tabEmot)
    });

    fetch('/api/answers', {
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
}

    
      
}
