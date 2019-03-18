package model;

public class Jogador {
    private String nome;
    private String email;
    private String senha;
    private String dia;
    private String mes;
    private String ano;
    private String sexo;
    private String nomeLogin;
    private int pontos;

    public Jogador(String nome,
                   String nomeLogin,
                   String email,
                   String senha,
                   String dia,
                   String mes,
                   String ano,
                   String sexo,
                   int pontos) {

        this.nome = nome;
        this.nomeLogin = nomeLogin;
        this.email = email;
        this.senha = senha;
        this.dia = dia;
        this.mes = mes;
        this.ano = ano;
        this.sexo = sexo;
        this.pontos = pontos;

    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getDia() {
        return dia;
    }

    public void setDia(String dia) {
        this.dia = dia;
    }

    public String getMes() {
        return mes;
    }

    public void setMes(String mes) {
        this.mes = mes;
    }

    public String getAno() {
        return ano;
    }

    public void setAno(String ano) {
        this.ano = ano;
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public String getNomeLogin() {
        return nomeLogin;
    }

    public void setNomeLogin(String nomeLogin) {
        this.nomeLogin = nomeLogin;
    }

    public int getPontos() {
        return pontos;
    }

    public void setPontos(int pontos) {
        this.pontos = pontos;
    }

    @Override
    public String toString() {
        return nome + "," +
                nomeLogin + "," +
                email + "," +
                senha + "," +
                dia + "," +
                mes + "," +
                ano + "," +
                sexo + "," +
                pontos;
    }
}