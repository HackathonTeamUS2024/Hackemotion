window.onload = function() {
    let randomValue;
    let tabEmot = new Array();
    let tabNum = new Array();
    let answer = new Array();

    for (let l = 0; l < 15; l++) {
        randomValue = Math.floor(Math.random() * 6);
        if (randomValue == 0) tabEmot[l] = "sadness";
        else if (randomValue == 1) tabEmot[l] = "happiness";
        else if (randomValue == 2) tabEmot[l] = "anger";
        else if (randomValue == 3) tabEmot[l] = "fear";
        else if (randomValue == 4) tabEmot[l] = "surprise";
        else if (randomValue == 5) tabEmot[l] = "disgust";
        else l--;
    }

    for (let l = 0; l < 15; l++) {
        randomValue = Math.floor(Math.random() * 21) + 1;
        tabNum[l] = String(randomValue).padStart(4, '0');
    }

    let buttons = document.querySelectorAll('button');
    let myAudio = document.getElementById("myAudio");
    let currentImageIndex = 0;

    function updateImage() {
        let sex;
        if (tabEmot[currentImageIndex] === 'sadness' ||
            tabEmot[currentImageIndex] === 'happiness' ||
            tabEmot[currentImageIndex] === 'anger' ||
            tabEmot[currentImageIndex] === 'fear' ||
            tabEmot[currentImageIndex] === 'surprise' ||
            tabEmot[currentImageIndex] === 'disgust') {
            if (tabNum[currentImageIndex] >= 11) sex = "1";
            else sex = "0";
        }

        document.getElementById('myAudio').src = '/audio/' + tabEmot[currentImageIndex] + '/' + tabNum[currentImageIndex].padStart(4, '0') + '_' + sex + '.wav';
        document.getElementById('myAudio').load();
        setTimeout(function() {
            document.getElementById('myAudio').play();
        }, 1000); // Opóźnienie 1 sekundy
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

    updateImage(); // Wyświetl pierwsze zdjęcie
}
