let score = 0;
let score3=0;
let isAnswerConfirmed = false;
let connections = new Array(8);
let count=0;

// Funkcija za učitavanje podataka iz localStorage
function loadGameData() {
    //Autor: Filip Rinkovec 2019/0463
  const gameData = localStorage.getItem("game_data");
  if (gameData) {
    try {
      const parsedData = JSON.parse(gameData);
      console.log("Parsed game data:", parsedData); // Dodato za debagovanje
      return parsedData;
    } catch (error) {
      console.error("Error parsing game data from localStorage:", error);
      return null;
    }
  } else {
    return null;
  }
}

document.addEventListener('DOMContentLoaded', function () {
    //Autor: Filip Rinkovec 2019/0463
    let selectedLeft = null; // Čuva trenutno selektovanu spojnicu sa leve strane

    const leftWords = document.querySelectorAll('#leftWords .word');
    const rightWords = document.querySelectorAll('#rightWords .match');

    // Funkcija za odabir leve spojnice
    leftWords.forEach(word => {
        word.addEventListener('click', function () {
            // Ako je spojnica već spojena, ignorisi dalje akcije
            if (this.classList.contains('connected') || this.classList.contains('wrongconnected')) return;

            // Deselektuj ako je ista spojnica kliknuta dva puta
            if (selectedLeft === this) {
                this.classList.remove('selected_link');
                selectedLeft = null;
            } else {
                // Promeni selekciju
                if (selectedLeft) {
                    selectedLeft.classList.remove('selected_link'); // Deselektuj prethodnu
                }
                this.classList.add('selected_link');
                selectedLeft = this; // Postavi trenutnu kao selektovanu
            }
        });
    });

    // Funkcija za odabir desne spojnice i "spajanje"
    rightWords.forEach(match => {
        match.addEventListener('click', function () {
            // Proverava da li je izabrana leva spojnica i da li su obe (leva i desna) nespojene
            if (selectedLeft && (!this.classList.contains('connected') || !this.classList.contains('wrongconnected')) && (!selectedLeft.classList.contains('connected') || !this.classList.contains('wrongconnected'))) {

                // Logika za proveru da li su spojnice ispravno uparene
                if(connections[selectedLeft.dataset.target-1]==event.currentTarget.dataset.id-1){
                    selectedLeft.classList.add('connected');
                    this.classList.add('connected');
                    score+=3;
                    score3+=3;
                    $("#score-header").text("Score: "+score);
                    count++;
                }
                else {
                    selectedLeft.classList.add('wrongconnected');
                    //this.classList.add('wrongconnected');
                    count++;
                }
                // Resetuj selekciju
                selectedLeft = null;

                // Ukloni klasu 'selected' sa svih levo izabranih, sada kada su spojene
                leftWords.forEach(word => word.classList.remove('selected_link'));
                if(count==8) {
                    for (match of rightWords) {
                        if (!match.classList.contains('connected')) {
                            match.classList.add('wrongconnected')
                        }
                    }
                }
            }
        });
    });
});


$(document).ready(async function() {
    //Autor: Filip Rinkovec 2019/0463
  let polja1 = new Set([0, 1, 2, 3, 4, 5, 6, 7 ]);
  let polja2 = new Set([0, 1, 2, 3, 4, 5, 6, 7 ]);


  if (parseInt(localStorage.getItem("score1"))>=0 && parseInt(localStorage.getItem("score2"))>=0) {
    score = parseInt(localStorage.getItem("score1"))+parseInt(localStorage.getItem("score2"));
  }

  const data = loadGameData();

  if(data){
    prompt = data.promptll;
    fields = data.logiclink;

    $("#prompt").text(prompt);
    for (let i=0;i<8;i++){
        let random_entryL = Math.floor(Math.random()*8);
        let random_entryR = Math.floor(Math.random()*8);
        while(!polja1.has(random_entryL)){
            random_entryL = Math.floor(Math.random()*8);
        }
        while(!polja2.has(random_entryR)){
            random_entryR = Math.floor(Math.random()*8);
        }
        polja1.delete(random_entryL);
        polja2.delete(random_entryR);
        connections[random_entryL]=random_entryR;

        $(".word").eq(random_entryL).text(fields[i][0]);
        $(".match").eq(random_entryR).text(fields[i][1]);

    }
    //prompt["connections"]=konekcije;
    //sessionStorage.setItem("connections",JSON.stringify(konekcije));
    $("#score-header").text("Score: "+score);
    //conns=getConnectionsFromSessionStorage();
  }


  $("#ll_confirm").click(function() {
      confirmAnswer();
  })


})

async function confirmAnswer() {
    //Autor: Filip Rinkovec 2019/0463
  if (!isAnswerConfirmed) {

    localStorage.setItem("score3", score3);
    $("header h2").text("Score: " + score);
    $("#ll_confirm").text("Next Game");

    isAnswerConfirmed = true;
  }
  else{
    window.location.href = "/etrivia/multiplayer-match/question-of-wisdom";
  }
}