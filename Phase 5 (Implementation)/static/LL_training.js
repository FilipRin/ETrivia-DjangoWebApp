var prompt;
var fields=[];
var conns;
let score=0;
let count=0;
//Autor: Filip Rinkovec 2019/0463
$(document).ready(function() {

    window.addEventListener("beforeunload",function(e){

        sessionStorage.clear();
    });


    let polja1 = new Set([0, 1, 2, 3, 4, 5, 6, 7]);
    let polja2 = new Set([0, 1, 2, 3, 4, 5, 6, 7]);
    let konekcije = new Array(8);
    if (sessionStorage.getItem("score")) {
        score = parseInt(sessionStorage.getItem("score"));
    }
    (async()=>{


        prompt = await ajax_request_prompt();
        sessionStorage.setItem("prompt",JSON.stringify(prompt));
        fields = prompt["fields"];

        $("#prompt").text(prompt["prompt"]);
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

            konekcije[random_entryL]=random_entryR;


            $(".word").eq(random_entryL).text(fields[i][0]);
            $(".match").eq(random_entryR).text(fields[i][1]);

        }
        prompt["connections"]=konekcije;
        sessionStorage.setItem("connections",JSON.stringify(konekcije));
        $("#score-header").text("Score: "+score);
        conns=getConnectionsFromSessionStorage();
    })();



    $("#back-button").click(function(){
        sessionStorage.clear();
    })

})


async function ajax_request_prompt() {
    const response =await fetch("http://localhost:8000/etrivia/get_qll", {
        method: "GET",
        headers: {
            "Content-Type": "application/json"
        }

    });
    console.log("Buh");
    const data = await response.json();
    return data;
}

document.addEventListener('DOMContentLoaded', function () {
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
                // "Spoji" selektovane spojnice

                // Opcionalno: Dodaj logiku za proveru da li su spojnice ispravno uparene
                if(conns[selectedLeft.dataset.target-1]==event.currentTarget.dataset.id-1){
                    selectedLeft.classList.add('connected');
                    this.classList.add('connected');
                    score+=3;
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
function myFunction()
{
    var x = document.getElementById("myLinks");
    if (x.style.display === "block")
    {
        x.style.display = "none";
    }
    else
    {
        x.style.display = "block";
    }
}
function myFunction1(x) {
  x.classList.toggle("change");
}

function getConnectionsFromSessionStorage(){
    return JSON.parse(sessionStorage.getItem("connections"));
}