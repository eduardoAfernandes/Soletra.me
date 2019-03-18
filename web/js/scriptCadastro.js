function validaForm() {

    var nome = document.getElementById('campoNome').value.trim();
    var nomeLogin = document.getElementById('campoNomeLogin').value.trim();
    var email = document.getElementById('campoEmail').value.trim();
    var senha = document.getElementById('campoSenha').value.trim();
    var confSenha = document.getElementById('confSenha').value.trim();
    var dia = document.getElementById('dia').value.trim();
    var mes = document.getElementById('mes').value.trim();
    var ano = document.getElementById('ano').value.trim();

    if (nome == '') {
        document.getElementById('campoNome').focus();
        alert("Campo nome está vazio!");
    }

    else if (nomeLogin == '') alert("Campo login está vazio!");
    else if (email == '') alert("Campo email está vazio!");

    else if (email == '') alert("Campo email está vazio!");

    else if (senha == '') {
        alert("Campo senha está vazio!")
    }
    else if (confSenha == '') {
        document.getElementById('confSenha').focus();
        alert("Confirmar senha em Branco!")
    }
    else if (confirmSenha(senha, confSenha) == false) {
        alert("Senhas não Coincidem!")
    }

    else if (dia == "0")
        alert("Selecione o dia do seu nascimento");

    else if (mes == "0")
        alert("Selecione o mês do seu nascimento");

    else if (ano == "0")
        alert("Selecione o ano do seu nascimento");

    else if (document.getElementsByName('rdSexo')[0].checked == false
        && document.getElementsByName('rdSexo')[1].checked == false) {
        alert('Favor informar seu Sexo!');
    }
    else
        // alert("Cadastro efetuado com sucesso.");
        document.getElementById("form1").submit();


    function confirmSenha(senha, confSenha) {
        return senha == confSenha;
    }


}

function playSound() {
    document.getElementById('audioClique').play();
}

function focusSound() {
    document.getElementById('focusSound').play();
}

function enlargeLable(id) {
    document.getElementById(id).style.color = "rgba(255,47,47,0.83)";
    document.getElementById(id).style.letterSpacing = "1.5px";
}

function normalLable(id) {
    document.getElementById(id).style.color = "black";
    document.getElementById(id).style.letterSpacing = "0px";
}

function somenteLetras() {
    var filter_nome = /^([a-zA-Zà-úÀ-Ú]|\s+)+$/;

    if (!filter_nome.test(document.getElementById("campoNome").value)) {
        document.getElementById("campoNome").value = '';
        document.getElementById("campoNome").placeholder = "Caracteres inválidos!";

        delete nome;

    }
    if (filter_nome.test(document.getElementById("campoNome").value)) {
        var nome = document.getElementById("campoNome").value;

        document.getElementById("campoNome").value = nome;

    }

}

function validateEmail(email) {
    var regexEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return regexEmail.test(email);
}

function validacaoEmail() {

    if (!validateEmail(document.getElementById("campoEmail").value)) {
        document.getElementById("campoEmail").value = '';
        document.getElementById("campoEmail").placeholder = "Insira um e-mail válido!";

    }else {
        var email = document.getElementById("campoEmail").value;

        document.getElementById("campoEmail").value = email;

    }
}

function somenteLetrasLogin() {
    var filter_nome = /^([a-zA-Zà-úÀ-Ú]|\s+)+$/;

    if (!filter_nome.test(document.getElementById("campoNomeLogin").value)) {
        document.getElementById("campoNomeLogin").value = '';
        document.getElementById("campoNomeLogin").placeholder = "Caracteres inválidos!";


    }
    if (filter_nome.test(document.getElementById("campoNomeLogin").value)) {

        document.getElementById("campoNomeLogin").value =  document.getElementById("campoNomeLogin").value;


    }

}


function somenteLetraseNumeros() {
    var filter_nome = /[^a-zA-Z 0-9]+/g;


    if (filter_nome.test(document.getElementById('campoSenha').value)) {
        document.getElementById('campoSenha').value = '';
        document.getElementById('campoSenha').placeholder = "Insira só letras e números!";
        delete senha;
    }

    if (!filter_nome.test(document.getElementById('campoSenha').value)) {
        var senha = document.getElementById('campoSenha').value;

        document.getElementById('campoSenha').value = senha;


    }
}


function telaLogin() {
    window.location.href = 'index.jsp';
}