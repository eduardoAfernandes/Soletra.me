 <%@ page contentType="text/html;charset=UTF-8" language="java" %> 
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <title>Cadastro - SOLETRA.ME</title>

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
    <link rel="stylesheet" href="css/game.css">
    <link rel="stylesheet" href="css/rainLetters.css">
    <link rel="stylesheet" href="css/estilosJogador.css">
    <link rel="stylesheet" href="css/restom.css">
    <link rel="stylesheet" href="css/modalRanking.css">

    <link rel="stylesheet" href="css/sphinx.css">
    <script src="js/script.js"></script>
    <script src="js/modalRanking.js"></script>

    <%
       String user = (String) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("index.jsp");
        }


    %>
;
    <script>
        var dificuldade;
        var nome = "<%=user%>";

        function changeBackground() {
            var backgroundImageNumber = random(3);
            // alert(backgroundImageNumber);
            document.getElementsByTagName("body")[0].style.backgroundImage = 'url("img/background/letters/background-big-' + backgroundImageNumber + '.jpg")';
            document.getElementsByTagName("body")[0].style.backgroundSize = "cover";
            document.getElementsByTagName("body")[0].style.backgroundRepeat = "repeat";

        }

        function random(max) {
            var result = Math.floor(Math.random() * max);
            return result;
        }

        function selectDif(x) {
            if (x == 'e') {
                dificuldade = "easy";
                document.getElementById("dificuldade").style.backgroundColor = "rgba(124, 252, 0, 0.99)";
            }
            if (x == 'm') {
                dificuldade = "medium";
                document.getElementById("dificuldade").style.backgroundColor = "rgba(255, 255, 0, 0.7)";
            }
            if (x == "h") {
                dificuldade = "hard";
                document.getElementById("dificuldade").style.backgroundColor = "orangered";
            }
            document.getElementById("dificuldade").innerHTML = dificuldade;
            localStorage.setItem("dificuldade", dificuldade);

        }

        function playSound() {
            document.getElementById('audioClique').play();
        }

        function focusSound() {
            document.getElementById('focusSound').play();
        }

        function jogar() {
            dificuldade == null ? alert("Primeiro Selecione a Dificuldade") : window.location.href = 'game.jsp';

        }

        function telaLogin() {
            window.location.href = 'index.jsp';
        }

        function carregarRanking() {
            changeBackground();
            ajaxPost(popularRanking);
        }

        function quickSortRanking(valor){

            var ranking = valor.response;
            ranking = ranking.split(";");
            console.log(ranking);


        }

        function popularRanking(valor) {

            var ranking = valor.response;
            ranking = ranking.split(";");
            var top8 = false;
            
            quickSortRanking(valor);

            for (var i = 0; i < ranking.length-1; i++) {
                var pessoa = ranking[i].split(",");

                if (i <= 19) {
                    document.getElementById("compnome" + i + "").innerHTML = pessoa[0];
                    document.getElementById("comppontos" + i + "").innerHTML = pessoa[1] !== null ? pessoa[1] + " .pts" : "";
                    document.getElementById("complugar" + i).innerHTML =  pessoa[1] !== null ? (i+1) + "&deg;" : "";

                }

                if (i <= 7) {
                    document.getElementById("nome" + i + "").innerHTML = pessoa[0];
                    document.getElementById("pontos" + i + "").innerHTML = pessoa[1];

                    if (nome == pessoa[0]) {
                        top8 = true;
                        highLightPlayer(i);
                        document.getElementById("pontuacao").innerHTML = parseInt(i + 1) + "&deg;";
                    }
                }

                if (nome == pessoa[0] && top8 == false) {
                    document.getElementById("colocacao").innerHTML = i + 1;
                    document.getElementById("nome7").innerHTML = pessoa[0];
                    document.getElementById("pontos7").innerHTML = pessoa[1];
                    document.getElementById("pontuacao").innerHTML = parseInt(i + 1) + "&deg;";
                    highLightPlayer(i);
                }
            }
        }

        function ajaxPost(callback) {
            var xmlDoc = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");

            url = "/Ranking";
            // data = "player=" + getActualPlayer();     (envia info para o servlet)

            xmlDoc.open('POST', url, true);
            xmlDoc.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

            xmlDoc.onreadystatechange = function () {
                if (xmlDoc.readyState === 4 && xmlDoc.status === 200) {
                    callback(xmlDoc);
                }
            };

            //xmlDoc.send(data);    (envia info para o servlet)
            xmlDoc.send();
        }

        function debugAjax(respostaAjax) {
            console.log(respostaAjax);
        }

        function highLightPlayer(id) {

            if (id > 7) {
                id = 7;
            }

            id = "tr" + id;

            var elemento = document.getElementById(id);
            elemento.classList.add("trPlayer");
        }

    </script>



</head>
<body onload="carregarRanking()">

<div class="rain-letters">
    <img src="img/colorful-letters/a.png" class="down img1">
    <img src="img/colorful-letters/b.png" class="down img2">
    <img src="img/colorful-letters/c.png" class="down img3">
    <img src="img/colorful-letters/d.png" class="down img4">
    <img src="img/colorful-letters/e.png" class="down img5">
    <img src="img/colorful-letters/f.png" class="down img6">
    <img src="img/colorful-letters/g.png" class="down img7">
    <img src="img/colorful-letters/h.png" class="down img8">
    <img src="img/colorful-letters/i.png" class="down img9">
    <img src="img/colorful-letters/j.png" class="down img10">
    <img src="img/colorful-letters/k.png" class="down img11">
    <img src="img/colorful-letters/l.png" class="down img12">
    <img src="img/colorful-letters/m.png" class="down img13">
    <img src="img/colorful-letters/n.png" class="down img14">
    <img src="img/colorful-letters/o.png" class="down img15">
</div>

<audio id="audioClique" src="sounds/CLICK21C.mp3"></audio>
<audio id="focusSound" src="sounds/boom-kick.wav"></audio>
<audio id="backSound" autoplay loop>
    <source src="sounds/background/backSoundDesert.mp3" type="audio/mp3">
</audio>

<div class="tamanho" style="position: absolute; left: 0; top: 0; width: 100%; padding: 0px 200px">
    <div class="linha">

        <div class="linha">
            <div class="col-dp-12 col-dm-12 col-dg-12">
                <div class="col-dp-4 col-dm-4 col-dg-4">
                    <h3 class="h3" style="background-color: rgba(168, 168, 168, 0.8);">NOME</h3>
                    <div id="nomePrincipal" class="div"><%=user%>
                    </div>
                </div>

                <div class="col-dp-4 col-dm-4 col-dg-4">
                    <h3 class="h3" style="background-color: rgba(168, 168, 168, 0.8);">DIFICULDADE</h3>
                    <div class="div" id="dificuldade"><span>Não selecionado</span></div>
                </div>

                <div class="col-dp-4 col-dm-4 col-dg-4">
                    <h3 class="h3" style="background-color: rgba(168, 168, 168, 0.8);">RANKING</h3>
                    <div class="div pontuacaoPrincipal" id="pontuacao">0</div>
                </div>
            </div>
        </div>

        <div class="col-dp-12 col-dm-6 col-dg-6">
            
                <div class="caixaSobre">
                <div class="linha">
                    <div class="separator">
                        <h1>SOLETRA-ME</h1>
                    </div>
                    <p>Olá <span class="user"><%=user%></span>, você acabou de adentrar no covil da Esfinge. Aqui você
                        encontrará desafios e só sairá
                        com sabedoria se soletrar corretamente o as palavras que a esfinge te perguntar.</p>

                    <p>Ouça com atenção! Use as dicas, elas podem te ajudar muito, podem dizer qual a proxima letra ou
                        mesmo quantas letras a palavra tem! mas cuidado, as esfinge é traiçoeira e sábia ao mesmo tempo.
                        Ela pode simplesmente te dizer o significado da palavra, e ao menos você aprendeu mais um pouco
                        antes de ser devorado. </p>

                    <p>Não falei sobre isso ainda? Então... Ao iniciar o jogo você terá um tempo para acertar o desafio.
                        Se falhar... A esfinge terá ganho ... E você perderá...</p>
                    <p>Está pronto para começar o desafio?</p>
                    <p>Escolha a dificuldade abaixo e depois clique na Esfinge para jogar!</p>

                    <div class="dificuldade">
                        <input type="button" class="difBotao verde" value="FÁCIL" name="btnDificuldade"
                               onclick="selectDif('e'), focusSound()" onmouseover="playSound()">
                        <input type="button" class="difBotao amarelo" value="MÉDIO" name="btnDificuldade"
                               onclick="selectDif('m'), focusSound()" onmouseover="playSound()">
                        <input type="button" class="difBotao vermelho" value="DIFÍCIL" name="btnDificuldade"
                               onclick="selectDif('h'), focusSound()" onmouseover="playSound()">
                    </div>
                    <h4>Soletra-me ou te devoro!</h4>
                    <div class="dificuldade">
                        <input type="image" src="img/sphinx.png" title="Clique para jogar" class="sphinx jog" value="Jogar" name="btnJogar"
                               onclick="jogar(), focusSound()" onmouseover="playSound()">
                        <h4 class="avisoJogar" title="Clique no desenho acima para jogar" style="cursor: pointer" onclick="jogar()">Jogar</h4>
                    </div>
                </div>
            </div>
        </div>
        <div class="caixa">
            <div class="col-dp-12 col-dm-6 col-dg-6">
                <div class="linha">
                    <div class="caixaRegistro">
                        <div class="separator">
                            <h1>RANKING GERAL</h1>
                        </div>

                        <div class="rankingCadastro">
                            <table>
                                <tr id="tr0">
                                    <td class="colocacao"><span>1&deg;</span></td>
                                    <td class="nome"><p id="nome0">Vazio</p></td>
                                    <td class="pontos"><span id="pontos0">0000</span> .pts</td>
                                </tr>
                                <tr id="tr1">
                                    <td class="colocacao"><span>2&deg;</span></td>
                                    <td class="nome"><p id="nome1">Vazio</p></td>
                                    <td class="pontos"><span id="pontos1">0000</span> .pts</td>
                                </tr>
                                <tr id="tr2">
                                    <td class="colocacao"><span>3&deg;</span></td>
                                    <td class="nome"><p id="nome2">Vazio</p></td>
                                    <td class="pontos"><span id="pontos2">0000</span> .pts</td>
                                </tr>
                                <tr id="tr3">
                                    <td class="colocacao"><span>4&deg;</span></td>
                                    <td class="nome"><p id="nome3">Vazio</p></td>
                                    <td class="pontos"><span id="pontos3">0000</span> .pts</td>
                                </tr>
                                <tr id="tr4">
                                    <td class="colocacao"><span>5&deg;</span></td>
                                    <td class="nome"><p id="nome4">Vazio</p></td>
                                    <td class="pontos"><span id="pontos4">0000</span> .pts</td>
                                </tr>
                                <tr id="tr5">
                                    <td class="colocacao"><span>6&deg;</span></td>
                                    <td class="nome"><p id="nome5">Vazio</p></td>
                                    <td class="pontos"><span id="pontos5">0000</span> .pts</td>
                                </tr>
                                <tr id="tr6">
                                    <td class="colocacao"><span>7&deg;</span></td>
                                    <td class="nome"><p id="nome6">Vazio</p></td>
                                    <td class="pontos"><span id="pontos6">0000</span> .pts</td>
                                </tr>
                                <tr id="tr7">
                                    <td class="colocacao"><span id="colocacao">8</span>&deg;</td>
                                    <td class="nome"><p id="nome7">Vazio</p></td>
                                    <td class="pontos"><span id="pontos7">0000</span> .pts</td>
                                </tr>

                            </table>
                            <div class="linha">
                                <div class="col-dp-12 col-dm-12 col-dg-12" align="center">
                                    <input type="button" value="Ranking Completo" class="jogarBotao vermelho" onclick="openModal('modal')">
                                </div>
                            </div>
                        </div>
                        <div class="linha">
                            <div class="saida">
                                <p>Parece que você deu sorte! Se não quiser enfrentar a Esfinge é só clicar no botão e
                                    fugir do covil</p><br>
                                <input type="button" class="jogarBotao vermelho" value="Sair do jogo"
                                       onclick="telaLogin(), focusSound()" onmouseover="playSound()">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<%--Modal--%>
<div id="modal" class="modalContainer">

    <div class="modal">
        <span onclick="fechaModal('modal')" class="closeModal">X</span>

        <h1 align="center" class="h1Modal">RANKING</h1>
        <table>
            <tr id="comptr0">
                <td class="colocacao"><span id="complugar0"></span></td>
                <td class="nome"><p id="compnome0"></p></td>
                <td class="pontos"><span id="comppontos0"></span></td>
            </tr>
            <tr id="comptr1">
                <td class="colocacao"><span id="complugar1"></span></td>
                <td class="nome"><p id="compnome1"></p></td>
                <td class="pontos"><span id="comppontos1"></span></td>
            </tr>
            <tr id="comptr2">
                <td class="colocacao"><span id="complugar2"></span></td>
                <td class="nome"><p id="compnome2"></p></td>
                <td class="pontos"><span id="comppontos2"></span></td>
            </tr>
            <tr id="comptr3">
                <td class="colocacao"><span id="complugar3"></span></td>
                <td class="nome"><p id="compnome3"></p></td>
                <td class="pontos"><span id="comppontos3"></span></td>
            </tr>
            <tr id="comptr4">
                <td class="colocacao"><span id="complugar4"></span></td>
                <td class="nome"><p id="compnome4"></p></td>
                <td class="pontos"><span id="comppontos4"></span></td>
            </tr>
            <tr id="comptr5">
                <td class="colocacao"><span id="complugar5"></span></td>
                <td class="nome"><p id="compnome5"></p></td>
                <td class="pontos"><span id="comppontos5"></span></td>
            </tr>
            <tr id="comptr6">
                <td class="colocacao"><span id="complugar6"></span></td>
                <td class="nome"><p id="compnome6"></p></td>
                <td class="pontos"><span id="comppontos6"></span></td>
            </tr>
            <tr id="comptr7">
                <td class="colocacao"><span id="complugar7"></span></td>
                <td class="nome"><p id="compnome7"></p></td>
                <td class="pontos"><span id="comppontos7"></span></td>
            </tr>

            <tr id="comptr8">
                <td class="colocacao"><span id="complugar8"></span></td>
                <td class="nome"><p id="compnome8"></p></td>
                <td class="pontos"><span id="comppontos8"></span></td>
            </tr>
            <tr id="comptr9">
                <td class="colocacao"><span id="complugar9"></span></td>
                <td class="nome"><p id="compnome9"></p></td>
                <td class="pontos"><span id="comppontos9"></span></td>
            </tr>
            <tr id="comptr10">
                <td class="colocacao"><span id="complugar10"></span></td>
                <td class="nome"><p id="compnome10"></p></td>
                <td class="pontos"><span id="comppontos10"></span></td>
            </tr>
            <tr id="comptr11">
                <td class="colocacao"><span id="complugar11"></span></td>
                <td class="nome"><p id="compnome11"></p></td>
                <td class="pontos"><span id="comppontos11"></span></td>
            </tr>
            <tr id="comptr12">
                <td class="colocacao"><span id="complugar12"></span></td>
                <td class="nome"><p id="compnome12"></p></td>
                <td class="pontos"><span id="comppontos12"></span></td>
            </tr>
            <tr id="comptr13">
                <td class="colocacao"><span id="complugar13"></span></td>
                <td class="nome"><p id="compnome13"></p></td>
                <td class="pontos"><span id="comppontos13"></span></td>
            </tr>
            <tr id="comptr14">
                <td class="colocacao"><span id="complugar14"></span></td>
                <td class="nome"><p id="compnome14"></p></td>
                <td class="pontos"><span id="comppontos14"></span></td>
            </tr>
            <tr id="comptr15">
                <td class="colocacao"><span id="complugar15"></span></td>
                <td class="nome"><p id="compnome15"></p></td>
                <td class="pontos"><span id="comppontos15"></span></td>
            </tr>
            <tr id="comptr16">
                <td class="colocacao"><span id="complugar16"></span></td>
                <td class="nome"><p id="compnome16"></p></td>
                <td class="pontos"><span id="comppontos16"></span></td>
            </tr>
            <tr id="comptr17">
                <td class="colocacao"><span id="complugar17"></span></td>
                <td class="nome"><p id="compnome17"></p></td>
                <td class="pontos"><span id="comppontos17"></span></td>
            </tr>
            <tr id="comptr18">
                <td class="colocacao"><span id="complugar18"></span></td>
                <td class="nome"><p id="compnome18"></p></td>
                <td class="pontos"><span id="comppontos18"></span></td>
            </tr>
            <tr id="comptr19">
                <td class="colocacao"><span id="complugar19"></span></td>
                <td class="nome"><p id="compnome19"></p></td>
                <td class="pontos"><span id="comppontos19"></span></td>
            </tr>



        </table>
    </div>
</div>

</body>


</html>
