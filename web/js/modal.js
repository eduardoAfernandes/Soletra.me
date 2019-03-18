function startModal(modalId,checkRespost) {
    const modal = document.getElementById(modalId);
    modal.classList.add('mostrar');
    localStorage.removeItem('palavra');


    if(checkRespost == 'correct'){
        localStorage.setItem('pontuacaoMatch',pontuacao);


        document.getElementById('h1Modal').innerHTML= "Acertou";
        document.getElementById('imgModal').src = "img/sphinx.png";
        document.getElementById('spanPontos').innerHTML ="Pontuação Parcial: "+ pontuacao;
        document.getElementById('spanWordCorrect').innerHTML = "Palavra correta: "+word.word;
        document.getElementById('spanWordDigited').innerHTML = "Palavra soletrada: "+document.getElementById('wordDigited').value.toLowerCase();
        document.getElementById('spanWordCorrect').classList.add("correct")
        document.getElementById('spanWordDigited').classList.add("correct")
        document.getElementById('btnModalFailed').style.display = "none";

    }
    else{
        document.getElementById('backSound').pause();
        document.getElementById('failed').play();
        document.getElementById('spanPontos').innerHTML ="Pontuação Final: "+ pontuacao;

        document.getElementById('h1Modal').innerHTML= "Errou";
        document.getElementById('imgModal').src = "img/sphinx.png";
        document.getElementById('spanWordCorrect').innerHTML = "Palavra correta: "+word.word;
        document.getElementById('spanWordDigited').innerHTML = "Palavra soletrada: "+document.getElementById('wordDigited').value.toLowerCase();
        document.getElementById('spanWordCorrect').classList.add("failed")
        document.getElementById('spanWordDigited').classList.add("failed")
        document.getElementById('btnModalCorrect').style.display = 'none';

        frasesEsfinge();


    }




}
function frasesEsfinge() {
    var frases = ['seus miolos são apetitosos?','SOLETRA-ME OU DEVORO-TE!','oba, almoço!','continue assim, meu estômago agradece','meu banquete se aproxima']
    var randomNumber = Math.floor(Math.random() * (frases.length - 0)) + 0;
    document.getElementById('fraseEsfinge').innerHTML = frases[randomNumber];


}
