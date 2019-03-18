function validaCampo() {
    // pega o texto do campo usuario
    var usuario = document.getElementById('campoUser').value.trim();

    //  pega o texto do campo senha
    var senha = document.getElementById('campoSenha').value.trim();


    if (usuario == '') {
        document.getElementById('campoUser').focus();
        return alert("Campo Usuário está vazio!");
    }

    else if (senha == '' || senha.length < 6) {
        return alert("São aceitos entre 6 e 12 caracteres!!")

    } else {
        document.getElementById("formLogin").submit();

    }

    function confirmSenha(senha, confSenha) {
        return senha == confSenha;
    }


}

function somenteLetras() {
    var filter_nome = /^([a-zA-Zà-úÀ-Ú]|\s+)+$/;
    var aviso = "Somente letras e letras com acentos sáo permitidos!";

    if (!filter_nome.test(document.getElementById('campoUser').value)) {
        document.getElementById('campoUser').value = '';
        document.getElementById('campoUser').placeholder = "Caracteres inválidos!!";
        document.getElementById('avisoCampoUser').className = "visivel";
        document.getElementById('spanCampoUser').innerHTML = aviso;
        delete usuario;

    }
    if (filter_nome.test(document.getElementById('campoUser').value)) {
        var usuario = document.getElementById('campoUser').value.trim();

        document.getElementById('campoUser').value = usuario;
        document.getElementById('avisoCampoUser').className = "invisivel";
        document.getElementById('spanCampoUser').innerHTML = aviso;


    }

}


function somenteLetraseNumeros() {
    var filter_nome = /[^a-zA-Z 0-9]+/g;


    if (filter_nome.test(document.getElementById('campoSenha').value)) {
        document.getElementById('campoSenha').value = '';
        document.getElementById('campoSenha').placeholder = "Somente letras e números são aceitos!";
        delete senha;
    }

    if (!filter_nome.test(document.getElementById('campoSenha').value)) {
        var senha = document.getElementById('campoSenha').value.trim();

        document.getElementById('campoSenha').value = senha;


    }


}

function enlargeLable(x) {
    document.getElementById(x).style.color = "rgba(255, 47, 47, 0.83)";
    document.getElementById(x).style.letterSpacing = "1.5px";

}

function normalLable(x) {
    document.getElementById(x).style.color = "black";
    document.getElementById(x).style.letterSpacing = "0px";
}

function playSound() {
    document.getElementById('audioClique').play();
}

function focusSound() {
    document.getElementById('focusSound').play();
}


function telaCadastro() {
    window.location.href = 'cadastro.jsp';
}
























