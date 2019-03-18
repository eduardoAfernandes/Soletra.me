
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <title>Soletra.Me</title>

    <%--INICIO Favicon para todos os dispositivos--%>
    <link rel="apple-touch-icon-precomposed" sizes="57x57" href="img/favicon/apple-touch-icon-57x57.png"/>
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="img/favicon/apple-touch-icon-114x114.png"/>
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="img/favicon/apple-touch-icon-72x72.png"/>
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="img/favicon/apple-touch-icon-144x144.png"/>
    <link rel="apple-touch-icon-precomposed" sizes="60x60" href="img/favicon/apple-touch-icon-60x60.png"/>
    <link rel="apple-touch-icon-precomposed" sizes="120x120" href="img/favicon/apple-touch-icon-120x120.png"/>
    <link rel="apple-touch-icon-precomposed" sizes="76x76" href="img/favicon/apple-touch-icon-76x76.png"/>
    <link rel="apple-touch-icon-precomposed" sizes="152x152" href="img/favicon/apple-touch-icon-152x152.png"/>
    <link rel="icon" type="image/png" href="img/favicon/favicon-196x196.png" sizes="196x196"/>
    <link rel="icon" type="image/png" href="img/favicon/favicon-96x96.png" sizes="96x96"/>
    <link rel="icon" type="image/png" href="img/favicon/favicon-32x32.png" sizes="32x32"/>
    <link rel="icon" type="image/png" href="img/favicon/favicon-16x16.png" sizes="16x16"/>
    <link rel="icon" type="image/png" href="img/favicon/favicon-128.png" sizes="128x128"/>
    <meta name="application-name" content="&nbsp;"/>
    <meta name="msapplication-TileColor" content="#FFFFFF"/>
    <meta name="msapplication-TileImage" content="mstile-144x144.png"/>
    <meta name="msapplication-square70x70logo" content="mstile-70x70.png"/>
    <meta name="msapplication-square150x150logo" content="mstile-150x150.png"/>
    <meta name="msapplication-wide310x150logo" content="mstile-310x150.png"/>
    <meta name="msapplication-square310x310logo" content="mstile-310x310.png"/>
    <%--FIM Favicon para todos os dispositivos--%>

    <link href="https://fonts.googleapis.com/css?family=Orbitron" rel="stylesheet">
    <link rel="stylesheet" href="css/restom.css">
    <link rel="stylesheet" href="css/estillosRanking.css">
    <link rel="stylesheet" href="css/rainLetters.css">
    <link rel="stylesheet" href="css/game.css">
    <link rel="stylesheet" href="css/bounceInTop.css">
    <link rel="stylesheet" href="css/scaleInCenter.css">
    <link rel="stylesheet" href="css/toggleButton.css">
    <link rel="stylesheet" href="css/modal.css">
    <link rel="stylesheet" href="css/sphinx.css">

    <%
        String user = (String) session.getAttribute("user");
            if (user == null) {
            response.sendRedirect("index.jsp");
        }






    %>

    <style>

        * {
        }

        .letters {
            border-bottom: 3px solid black;
            display: inline;
            letter-spacing: 10px !important;
            width: 50px;
            padding: 6px;
        }


        body {
            background-repeat: no-repeat;
            -webkit-background-size: auto;
            -moz-background-size: auto;
            -o-background-size: auto;
            background-size: 100vw !important;
        }

    </style>
    <script src="js/modal.js"></script>
    <script src="js/game.js"></script>

    <script>

        var position = 0;
        var dificuldade = localStorage.getItem("dificuldade");
        if (dificuldade === null) dificuldade = "medium";
        var word = localStorage.getItem("palavra") === null ? getWord(dificuldade) : JSON.parse(localStorage.getItem("word"));
        localStorage.setItem('palavra',word.word);
        localStorage.setItem('word', JSON.stringify(word));
        var g_cronometro;
        console.log(dificuldade);
        var segundos = 0;
        var segundosStorage = localStorage.getItem('segundos');
        console.log(segundosStorage);
        var pontuacao = 0;
        // var pontuacaoStorage = localStorage.getItem('pontuacaoMatch');
        var pontuacaoStorage = getPts();
        var timer_audio = 0;
        var correct = 0; //Variavel usada na fucao de verificar letra
        var contador = 0; //Variavel usada na funcao de verificar letra
        var dicas = 0;
        var dicasStorage = localStorage.getItem('dicas');
        var pularPalavra = 0;
        var pularPalavraStorage = localStorage.getItem('nextWord');

        var arrayTips = [0,1,2];

        function populatePts(valor) {
            document.getElementById('pontuacao').innerHTML = valor;
            pontuacaoStorage = valor;
            alert("oi")
        }

        function getPts() {
            ajaxPost(populateGame, "<%=user%>", "pegar", 0);
        }

        function setPts(pts) {
            ajaxPost(getPts, "<%=user%>", "setar", pts);
        }

        function ajaxPost(callback, gamerLogin, tipo, pts) {
            var xmlDoc = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");

            url = "/Pontuacao";
            data = "jogador=" + gamerLogin + "&tipo=" + tipo + "&pontos=" + pts;

            xmlDoc.open('POST', url, true);
            xmlDoc.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

            xmlDoc.onreadystatechange = function () {
                if (xmlDoc.readyState === 4 && xmlDoc.status === 200) {
                    document.getElementById('pontuacao').innerHTML = xmlDoc.response;
                    pontuacaoStorage = xmlDoc.response;
                    callback(xmlDoc);
                }
            };

            xmlDoc.send(data);
            // xmlDoc.send();
        }


        function nextWord() {
            pularPalavra--;
            localStorage.removeItem('dicas');
            localStorage.removeItem('segundos');
            document.getElementById('spanPular').innerHTML = "Restantes: "+pularPalavra;

            location.reload();
            localStorage.removeItem('palavra');


            localStorage.setItem('nextWord',pularPalavra);

        }



        function run() {
            document.getElementsByTagName("body")[0].style.background = "url(" + word.url_image + ") no-repeat center center fixed";
            getPts();
            setSound("wordSound", word.url_word_sound, false);
            playSound("wordSound");

            setSound("backSound", word.url_background_sound, true);
            setSound("descriptionSound", word.description.description_url_list[1], false);
            playSound("backSound");

        }

        function startGame() {
            document.getElementById('pontuacao').innerHTML = pontuacaoStorage;


            run();
            timerControl();
            temporizador();
            controlGame();

        }

        function controlGame() {
            if(dicasStorage == null) {
                if (dificuldade == 'easy') {
                    dicas = 3;
                    document.getElementById('spanDicas').innerHTML = "Dicas restantes: "+dicas;

                }
                if (dificuldade == 'medium') {
                    dicas = 2;
                    document.getElementById('spanDicas').innerHTML = "Dicas restantes: "+dicas;

                }
                if (dificuldade == 'hard') {
                    dicas = 1;
                    document.getElementById('spanDicas').innerHTML = "Dicas restantes: "+dicas;

                }
            }else{
                dicas = dicasStorage;
            }
            if(dicasStorage == 0){
                document.getElementById('btnDicas').disabled = true;

            }

            if(pontuacaoStorage != null){
                pontuacao = pontuacao + parseInt(pontuacaoStorage);
            }


            if(pularPalavraStorage == null){
                if (dificuldade == 'easy') {
                    pularPalavra = 3;
                    document.getElementById('spanPular').innerHTML = "Restantes: "+pularPalavra;

                }
                if (dificuldade == 'medium') {
                    pularPalavra = 2;
                    document.getElementById('spanPular').innerHTML = "Restantes: "+pularPalavra;

                }
                if (dificuldade == 'hard') {
                    pularPalavra = 1;
                    document.getElementById('spanPular').innerHTML = "Restantes: "+pularPalavra;

                }
            }
            else {
                pularPalavra = pularPalavraStorage;
                document.getElementById('spanPular').innerHTML = " Restantes: "+pularPalavra;

            }


            if (pularPalavra == 0){
                document.getElementById('btnPular').disabled = true;
            }





        }

        function populateGame() {
            var insertElements = "";

            for (var i = 0; i < word.word.length; i++) {
                var insertElement = '<li name="listOfLetters" class="letters" value="' + word.word[i] + '" onclick="verify(' + "'" + word.word[i] + "'" + ')">' + word.word[i] + '</li><span>&nbsp;</span>';
                insertElements += insertElement.replace("@", word.word[i]);

            }

//            document.getElementById("listToGame").innerHTML = insertElements;
        }


        function setSound(idAudio, url, loop) {
            document.getElementById(idAudio).src = url;
            loop ? document.getElementById(idAudio).loop = true : document.getElementById(idAudio).loop = false;
        }

        function playSound(idAudio) {
            switchVolumeSound('backSound', 0.05, 10000, true);
            document.getElementById(idAudio).play();
        }

        function switchVolumeSound(idLowAudioVolume, decimalPercentage, time, firstTime) {
            document.getElementById(idLowAudioVolume).volume = decimalPercentage;
            console.log(document.getElementById(idLowAudioVolume).volume);
            if (!firstTime) {
                if (document.getElementById(idLowAudioVolume).volume < 1) {
                    timer_audio = setTimeout(switchVolumeSound, 1000, idLowAudioVolume, decimalPercentage+0.1, 0, false);
                } else {
                    return;
                }

            } else {
                clearTimeout(timer_audio);
                timer_audio = setTimeout(switchVolumeSound, time, idLowAudioVolume, decimalPercentage+0.1, time, false);
            }

        }

        function temporizador(){
            var entradaUser = document.getElementById('wordDigited').value.toLowerCase();
            segundos = segundos - 1;
            document.getElementById('tempo').innerHTML = segundos;
            localStorage.setItem('segundos',segundos);

            g_cronometro = setTimeout(temporizador, 1000);
            if (segundos <= 3) {
                document.getElementById('tempo').style.color = "red";
            }
            if (segundos == 0) {
                document.getElementById('tempo').style.display = "none";
                document.getElementById('wordDigited').disabled = true;
                localStorage.removeItem("segundos");
                console.log(segundosStorage);
                clearTimeout(g_cronometro)
                if(entradaUser != word.word){
                    // localStorage.removeItem('pontuacaoMatch')
                    localStorage.removeItem('dicas');
                    localStorage.removeItem('nextWord');
                    startModal('modal','failed')
                }



            }
        }


        function timerControl () {

            if (segundosStorage == null) {

                segundos = word.word.length * 3;
                if(segundos < 20){
                    segundos = 20;
                }
                document.getElementById('tempo').innerHTML = segundos;




            }
            else {
                segundos = segundosStorage;
            }
        }
        // IMPLEMENTADO CG
        // funcao para tocar som de click quando clica no botão
        function clickSound() {
            document.getElementById("clickSound").play();
        }

        // funcao para pausar e retornar musica

        function pausarFundo() {
            var on = document.getElementsByName("somFundo");

            if (on[0].checked== true)
                document.getElementById("backSound").pause();
            else
                document.getElementById("backSound").play();
        }


        function verifyWord() {
            var entradaUser = document.getElementById('wordDigited').value.toLowerCase();
            document.getElementById('wordDigited').style.borderBottom = "6px solid green";
            while(contador < word.word.length){
                console.log("A entrada esta aqui: "+entradaUser[contador])
                console.log("A palavra certa esta aqui: "+word.word[contador]);
                if(entradaUser[contador] == word.word[contador]){
                    console.log("Letra certa")

                    document.getElementById('pontuacao').innerHTML = pontuacao;

                    correct++;


                }else{
                    document.getElementById('wordDigited').style.borderBottom = "6px solid red";
                    console.log("Letra Incorreta")
                    return;
                }


                contador++;
                console.log(correct)
                console.log(word.word.length)

                if(correct == word.word.length){
                    if(entradaUser == word.word){
                        clearTimeout(g_cronometro);
                        localStorage.removeItem('segundos')
                        localStorage.removeItem('dicas');
                        localStorage.removeItem('nextWord');

                        if(dificuldade == 'easy'){
                            pontuacao += (word.word.length * 10) * segundos;
                        }if (dificuldade == 'medium'){
                            pontuacao += (word.word.length * 20) * segundos;

                        } if (dificuldade == 'hard'){
                            pontuacao += (word.word.length * 30) * segundos;

                        }
                        setPts(pontuacao);
                        startModal('modal','correct');
                    }
                }
                console.log("Segundo "+segundos);
                console.log("Pontos "+pontuacao);

                return ;


            }


        }
        function reload() {
            location.reload();
        }

        function  backRanking() {
            window.open('jogador.jsp','_self');
            localStorage.clear()
        }

        function randomTips() {
            dicas--;
            localStorage.setItem('dicas',dicas)
            var randomNumber = Math.floor(Math.random() * (arrayTips.length - 0)) + 0;
            var tipsSort = arrayTips[randomNumber];

            document.getElementById('spanDicas').innerHTML = "Dicas restantes: "+dicas;

            if(tipsSort == 0) {
                playSound('descriptionSound');
            }if (tipsSort == 1){
                tipLength();
            } if (tipsSort == 2){
                tipNextLetter();
            }
            arrayTips.splice(randomNumber,1);
            if (dicas <= 0){
                document.getElementById('btnDicas').disabled = true;
                document.getElementById('btnDicas').style.opacity = "0.5";
                document.getElementById('spanDicas').innerHTML = "Ajuda da Esfinge Indisponivel";

            }
        }
        function tipLength() {
            document.getElementById('tipsLenght').innerHTML = "Esfinge alerta: palavra tem "+word.word.length+" letras!!"
            document.getElementById('tipsLenght').style.display = "block";
        }

        function tipNextLetter() {
            var entradaUser = document.getElementById('wordDigited').value.toLowerCase();
            document.getElementById('wordDigited').value = document.getElementById('wordDigited').value + word.word[entradaUser.length];
            document.getElementById('tipsNextLetter').style.display = "block";

        }



    </script>

</head>

<body onload="startGame()">

<audio id="wordSound" src=""></audio>
<audio id="backSound" src=""></audio>
<audio id="descriptionSound" src=""></audio>
<audio id="clickSound" src="../sounds/CLICK21C.mp3"></audio>
<audio id="failed" src="./sounds/7_fail.mp3"></audio>

<div class="tamanho">
    <div class="caixa">
        <!--  Topo   -->
        <div class="linha">
            <div class="col-dp-12 col-dm-12 col-dg-12" style="background-color: rgba(168, 168, 168, 0.8); border-radius: 0px 0px 25px 25px">
                <div class="col-dp-4 col-dm-4 col-dg-4">
                    <h3 class="h3">NOME</h3>
                    <div class="div"> <%=user%></div>
                </div>

                <div class="col-dp-4 col-dm-4 col-dg-4">
                    <h3 class="h3">TEMPO</h3>
                    <div class="div" id="tempo"><span id="crono">0</span></div>
                </div>

                <div class="col-dp-4 col-dm-4 col-dg-4">
                    <h3 class="h3">PONTUAÇÃO</h3>
                    <div class="div" id="pontuacao"></div>
                </div>
            </div>
        </div>


        <!--      Coluna Game     -->


        <div class="col-dp-12 col-dm-12 col-dp-12">
            <div class="col-dp-10 col-dm-10 col-dp-10"  >
                <div class="caixaGame" >
                    <div class="col-dp-12 col-dm-12 col-dp-12" align="center">
                        <h3 class="h3" style="line-height: 2; margin: 10px;font-weight: 900">Ouvir a palavra</h3>
                        <img src="img/speaker.png" class="imgMicrofone" onclick="playSound('wordSound')">
                    </div>

                    <div class="col-dp-12 col-dm-12 col-dp-12" align="center">

                        <div  align="center" style="padding-top: 20px;">
                            <div class="caixaInput" >

                                <input type="text" id="wordDigited" class="inputUser"  onkeyup="verifyWord()">

                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <!--      Coluna Dicas     -->


            <div class="col-dp-2 col-dm-2 col-dp-2" align="center">

                <div class="caixaDicas">
                    <!-- Esse span so aparecera quando a dica for acionada   -->
                    <span id="tipsLenght" class="tipsLenght">Esfinge alerta</span>
                    <span id="tipsNextLetter" class="tipsNextLetter">Esfinge alerta: Uma  letra foi revelada!!</span>

                    <div class="linha">
                        <div class="col-dp-12 col-dm-12 col-dp-12 btnSpanDicas" >

                            <button class="btnDicas" id="btnDicas" onclick="randomTips()">Dica</button>
                            <span id="spanDicas" class="spanDicas"></span>
                        </div>

                    </div>


                    <div class="linha">
                        <div class="col-dp-12 col-dm-12 col-dp-12 btnSpanPular">

                            <button class="btnPular" id="btnPular" onclick="nextWord()">Pular Palavra</button>
                            <span id="spanPular" class="spanPular"></span>

                        </div>

                    </div>

                    <div class="linha">
                        <div class="col-dp-12 col-dm-12 col-dp-12">

                            <button class="btnRanking"onclick="backRanking()">Ver Ranking
                            </button>
                        </div>

                    </div>


                    <div class="linha">
                        <div class="col-dp-12 col-dm-12 col-dp-12">
                            <button class="btnMostrar" style="margin-top: -15%;" onclick="backRanking()">Mudar Dificuldade</button>

                        </div>
                    </div>

                    <div class="linha">
                        <div class="col-dp-12 col-dm-12 col-dp-12">

                            <button class="btnRanking" onclick="window.open('deslogar.jsp')">Logout
                            </button>
                        </div>

                    </div>
                    <div class="linha">
                        <div class="col-dp-12 col-dm-12 col-dp-12">

                            <p style="color: black;font-weight: 900;text-shadow: 1px 1px black">Som de fundo</p>
                            <div class="toggle">
                                <input type="checkbox" class="check" name="somFundo" checked onmousedown="pausarFundo()">
                                <b class="b switch"></b>
                                <b class="b track"></b>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="modal" class="modalContainer">
    <div class="modal">
        <h1 style="text-align: center">Voce <span id="h1Modal"></span>!!!</h1>
        <div class="col-dp-12 col-dm-12 col-dg-12"  >
            <div class="col-dp-4 col-dm-4 col-dg-4" align="center">
                <img src="" id="imgModal" class="sphinx" style="margin: 20px 0px" width="50%">
            </div>

            <div class="col-dp-8 col-dm-8 col-dg-8" align="center">
                <div id="caixaInfoPartida">
                    <p><span id="spanWordDigited" class="spanWordDigited"></span></p>
                    <p><span id="spanWordCorrect" class="spanWordCorrect"></span></p>
                    <p><span id="spanPontos"></span></p>
                    <p><span id="dicasUsed"></span></p>

                    <p><span id="timedUsed"></span></p>
                </div>

            </div>

        </div>
        <div class="col-dp-12 col-dm-12 col-dg-12"  align="center">
            <div class="col-dp-6 col-dm-6 col-dg-6">
                <p style="margin-bottom: 10px;color: black;font-weight: 900">Ouvir palavra novamente!</p>
                <img src="img/speaker.png" class="imgMicrofone" width="20%" onclick="playSound('wordSound')">

            </div>

            <div class="col-dp-6 col-dm-6 col-dg-6">
                <p style="margin-bottom: 30px">Ouvir dica novamente!</p>

                <button class="btnDicas" id="btnDicas" onclick="playSound('descriptionSound');">Dica</button>

            </div>

        </div>
        <div class="col-dp-12 col-dm-12 col-dg-12" align="center" >

            <span id="fraseEsfinge" class="fraseEsfinge"></span>


        </div>
        <div class="col-dp-12 col-dm-12 col-dg-12" align="center" >

            <input type="submit" class="btnModal" id="btnModalCorrect" value="Proxima Palavra" onclick="reload()">

            <input type="button" class="btnModal" id="btnModalFailed" value="Jogar Novamente" onclick="reload()">


        </div>

    </div>
</div>
</body>

</html>

