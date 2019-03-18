<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Login - SOLETRA.ME</title>

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

    <link rel="stylesheet" href="css/estilosLogin.css">
    <link rel="stylesheet" href="css/rainLetters.css">
    <% String mensagemServlet = (String) request.getAttribute("mensagemServlet");
        if (mensagemServlet == null) {
            mensagemServlet = "";
        }

        String usr = (String) request.getAttribute("usr");
        String pwd = (String) request.getAttribute("pwd");

        if (usr == null) {
            usr = "";
            pwd = "";
        }

    %>
    <script>
        function changeBackground() {
            var backgroundImageNumber = random(3);
            // alert(backgroundImageNumber);
            document.getElementsByTagName("body")[0].style.backgroundImage = 'url("img/background/letters/background-big-' + backgroundImageNumber + '.jpg")';
            document.getElementsByTagName("body")[0].style.backgroundSize = "cover";
            document.getElementsByTagName("body")[0].style.backgroundRepeat = "no-repeat";

        }

        function random(max) {
            var result = Math.floor(Math.random() * max);
            return result;
        }


        function verifyUser() {
            changeBackground();
            var tagValue = document.getElementById("msgServlet").innerHTML;
            var myFlag = document.getElementById("checkConnect");
            console.log(myFlag);


            if (tagValue.indexOf("Jogador Existente") > -1 && myFlag.checked) {
                localStorage.setItem("usr", document.getElementById("usr").value);
                localStorage.setItem("pwd", document.getElementById("pwd").value);
            } else {
                document.getElementById("checkConnect").checked = false;
                try {
                    localStorage.removeItem("usr");
                    localStorage.removeItem("pwd");
                    myFlag.checked = false;
                } catch (e) {
                    console.log(e);
                }


            }

            if (localStorage.getItem("usr") != "" && localStorage.getItem("usr") != null) {
                document.getElementById("msgServlet").innerHTML = "Jogador Existente";

            }


        }
    </script>
    <script src="js/script.js"></script>

</head>

<body onload="verifyUser()">

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

<div class="formulario">
    <form id="formLogin" action="Login" method="post">
        <div class="separator">
            <h1>SOLETRA-ME</h1>
            <br>

        </div>

        <h3 style="color: red" id="msgServlet"><%= mensagemServlet %>
        </h3>


        <% out.println("<input type=\"hidden\" id=\"usr\" value=\"" + usr + "\">"); %>
        <% out.println("<input type=\"hidden\" id=\"pwd\" value=\"" + pwd + "\">"); %>

        <label id="lsUser">
            USUÁRIO
        </label>
        <input type="text" placeholder="Digite seu Usuário" id="campoUser" name="campoUser"
               onfocus="enlargeLable('lsUser'), focusSound()"
               onblur="normalLable('lsUser')"
               onchange="somenteLetras()" onkeypress="playSound()">
        <div class="invisivel" id="avisoCampoUser"><span id="spanCampoUser"></span></div>

        <label id="lsPass">
            SENHA
        </label>
        <input type="password" placeholder="Digite sua Senha (6 à 12 caracteres)" maxlength="12" id="campoSenha"
               name="campoSenha"
               onfocus="enlargeLable('lsPass'), focusSound()" onblur="normalLable('lsPass')" onkeypress="playSound()"
               onchange="somenteLetraseNumeros()">


        <input type="button" class="btnLogin" value="JOGAR" onclick="validaCampo()">

        <div class="cadastro">
            <label>AINDA NÃO TEM CADASTRO ? </label>
            <input type="button" value="CADASTRAR-SE" onclick="telaCadastro()">
        </div>
    </form>
</div>


</div>

</body>

</html>