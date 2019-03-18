<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <title>Cadastro - SOLETRA.ME</title>
    <link href="https://fonts.googleapis.com/css?family=Orbitron" rel="stylesheet">
    <link rel="stylesheet" href="css/rainLetters.css">
    <link rel="stylesheet" href="css/estilosCadastro.css">
    <link rel="stylesheet" href="css/sphinx.css">
    <link rel="stylesheet" href="css/restom.css">
    <script src="js/scriptCadastro.js"></script>

    <%
        String user = (String) request.getAttribute("user");

    %>


    <script>

        function changeBackground() {
            alert("Usuário " + "'<%=user%>'" + " já cadastrado, tente novamente com outro usuário");
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

    </script>

</head>
<body onload="changeBackground()">

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

<audio id="audioClique" src="sounds/CLICK21C.mp3" ></audio>
<audio id="focusSound" src="sounds/boom-kick.wav"></audio>

<div class="tamanho" style="position: absolute; left: 0; top: 0; width: 100%; padding: 0px 200px">
    <div class="linha">
        <div class="col-dp-12 col-dm-6 col-dg-6">
            <div class="caixaSobre">
                <div class="separator">
                    <h1>SOLETRA-ME</h1>
                </div>
                <h2>Objetivos do Jogo</h2>
                <p>O jogo SOLETRA-ME tem como objetivo ser uma ferramenta de aprendizado da grafia de palavras em
                    língua portuguesa. Com essa intenção buscamos desenvolver um jogo no estilo “Soletrando” em que o
                    jogador ouvirá uma palavra e terá que soletra-la. Deve existir um tempo para executar esta ação e
                    ganhará mais pontos conforme solucione o desafio mais rapidamente.</p>

                <p>O jogo conta também com diversos mecanismos de ajuda, sejam na forma de dicas, como por exemplo mostrar uma letra da palavra, ou até mesmo pular uma palavra
                    que esteja muito dificil. Existe um sistema de pontuação, que bonifica de acordo com a velocidade do jogador. Venha para o SOLETRA-ME</p>

                <p>Está pronto para desafiar a sabedoria da Esfinge?</p>
                <h4>Soletra-me ou te devoro!</h4>
                <div class="cad">
                    <img class="sphinx" src="img/sphinx.png" alt="">
                </div>
            </div>
        </div>
        <div class="caixa">
            <div class="col-dp-12 col-dm-6 col-dg-6">
                <div class="caixaRegistro">
                    <div class="separator">
                        <h1>REGISTRE-SE</h1>
                    </div>
                    <form action="Cadastro" method="POST" name="form1" id="form1">
                        <table>
                            <tr>
                                <td align="center">
                                    <label id="1sUser" for="campoNome" > Nome: </label>
                                </td>
                                <td align="center">
                                    <input type="text" name="jogador" placeholder="Insira seu nome" id="campoNome" onkeypress="playSound()" onfocus="enlargeLable('1sUser'), focusSound()" onblur="normalLable('1sUser')" onchange="somenteLetras()">
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <label id="1sUserLogin" for="campoNomeLogin" > Login: </label>
                                </td>
                                <td align="center">
                                    <input type="text" name="jogadorLogin" placeholder="Insira seu Login" id="campoNomeLogin" onkeypress="playSound()" onfocus="enlargeLable('1sUserLogin'), focusSound()" onblur="normalLable('1sUserLogin')" onchange="somenteLetrasLogin()">
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <label  id="1sEmail" for="campoEmail"> Email: </label>
                                </td>
                                <td align="center">
                                    <input type="email" name="email" min="0" max="100" placeholder="exemplo@exemplo.com" id="campoEmail" onkeypress="playSound()"  onfocus="enlargeLable('1sEmail'), focusSound()" onblur="normalLable('1sEmail')" onchange="validacaoEmail()">
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <label id="1sSenha" for="campoSenha"> Senha: </label>
                                </td>
                                <td align="center">
                                    <input type="password" name="senha" minlength="6" maxlength="12" placeholder="Digite sua Senha (6 à 12 caracteres)"
                                           id="campoSenha" onkeypress="playSound()"  onfocus="enlargeLable('1sSenha'), focusSound()" onblur="normalLable('1sSenha')" onchange="somenteLetraseNumeros()">
                                </td>
                            </tr>

                            <tr>
                                <td align="center">
                                    <label id="1sConfSenha" for="confSenha"> Confirmar Senha: </label>
                                </td>
                                <td align="center">
                                    <input type="password" minlength="6" maxlength="12" placeholder="Repita sua Senha"
                                           id="confSenha" onkeypress="playSound()"  onfocus="enlargeLable('1sConfSenha'), focusSound()" onblur="normalLable('1sConfSenha')">
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <label for=""> Data de Nascimento: </label>
                                </td>
                                <td align="center">
                                    <select name="nascimento" id="dia">
                                        <option value="0" selected='selected'>Dia</option>
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4">4</option>
                                        <option value="5">5</option>
                                        <option value="6">6</option>
                                        <option value="7">7</option>
                                        <option value="8">8</option>
                                        <option value="9">9</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                        <option value="13">13</option>
                                        <option value="14">14</option>
                                        <option value="15">15</option>
                                        <option value="16">16</option>
                                        <option value="17">17</option>
                                        <option value="18">18</option>
                                        <option value="19">19</option>
                                        <option value="20">20</option>
                                        <option value="21">21</option>
                                        <option value="22">22</option>
                                        <option value="23">23</option>
                                        <option value="24">24</option>
                                        <option value="25">25</option>
                                        <option value="26">26</option>
                                        <option value="27">27</option>
                                        <option value="28">28</option>
                                        <option value="29">29</option>
                                        <option value="30">30</option>
                                        <option value="31">31</option>
                                    </select><select id="mes" name="mes">
                                    <option value="0" selected='selected'>Mes</option>
                                    <option value="1">Jan</option>
                                    <option value="2">Fev</option>
                                    <option value="3">Mar</option>
                                    <option value="4">Abr</option>
                                    <option value="5">Maio</option>
                                    <option value="6">Jun</option>
                                    <option value="7">Jul</option>
                                    <option value="8">Ago</option>
                                    <option value="9">Set</option>
                                    <option value="10">Out</option>
                                    <option value="11">Nov</option>
                                    <option value="12">Dez</option>
                                </select><select id="ano" name="ano">
                                    <option value="0" selected='selected'>Ano</option>
                                    <option value="2018">2018</option>
                                    <option value="2017">2017</option>
                                    <option value="2016">2016</option>
                                    <option value="2015">2015</option>
                                    <option value="2014">2014</option>
                                    <option value="2013">2013</option>
                                    <option value="2012">2012</option>
                                    <option value="2011">2011</option>
                                    <option value="2010">2010</option>
                                    <option value="2009">2009</option>
                                    <option value="2008">2008</option>
                                    <option value="2007">2007</option>
                                    <option value="2006">2006</option>
                                    <option value="2005">2005</option>
                                    <option value="2004">2004</option>
                                    <option value="2003">2003</option>
                                    <option value="2002">2002</option>
                                    <option value="2001">2001</option>
                                    <option value="2000">2000</option>
                                    <option value="1999">1999</option>
                                    <option value="1998">1998</option>
                                    <option value="1997">1997</option>
                                    <option value="1996">1996</option>
                                    <option value="1995">1995</option>
                                    <option value="1994">1994</option>
                                    <option value="1993">1993</option>
                                    <option value="1992">1992</option>
                                    <option value="1991">1991</option>
                                    <option value="1990">1990</option>
                                    <option value="1989">1989</option>
                                    <option value="1988">1988</option>
                                    <option value="1987">1987</option>
                                    <option value="1986">1986</option>
                                    <option value="1985">1985</option>
                                    <option value="1984">1984</option>
                                    <option value="1983">1983</option>
                                    <option value="1982">1982</option>
                                    <option value="1981">1981</option>
                                    <option value="1980">1980</option>
                                    <option value="1979">1979</option>
                                    <option value="1978">1978</option>
                                    <option value="1977">1977</option>
                                    <option value="1976">1976</option>
                                    <option value="1975">1975</option>
                                    <option value="1974">1974</option>
                                    <option value="1973">1973</option>
                                    <option value="1972">1972</option>
                                    <option value="1971">1971</option>
                                    <option value="1970">1970</option>
                                    <option value="1969">1969</option>
                                    <option value="1968">1968</option>
                                    <option value="1967">1967</option>
                                    <option value="1966">1966</option>
                                    <option value="1965">1965</option>
                                    <option value="1964">1964</option>
                                    <option value="1963">1963</option>
                                    <option value="1962">1962</option>
                                    <option value="1961">1961</option>
                                    <option value="1960">1960</option>
                                    <option value="1959">1959</option>
                                    <option value="1958">1958</option>
                                    <option value="1957">1957</option>
                                    <option value="1956">1956</option>
                                    <option value="1955">1955</option>
                                    <option value="1954">1954</option>
                                    <option value="1953">1953</option>
                                    <option value="1952">1952</option>
                                    <option value="1951">1951</option>
                                    <option value="1950">1950</option>

                                </select>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <label>Sexo:</label>
                                </td>
                                <td align="center">
                                    <input type="radio" name="rdSexo" id="rdMasc"><label for="rdMasc">Masculino</label>
                                    <input type="radio" name="rdSexo" id="rdFemi"><label for="rdFemi">Feminino</label>

                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center">
                                    <input type="button" class="botaoRegistrar" value="Registrar" onclick="validaForm()">
                                </td>
                            </tr>
                        </table>
                    </form>
                    <div class="cad">
                        <label class="jConta">Ja tenho conta! </label>
                        <input type="button" class="botaoLogin" value="FAZER LOGIN" onclick="telaLogin()">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>







</body>


</html>
