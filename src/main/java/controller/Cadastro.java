package controller;

import model.Jogador;
import util.FileUtils;
import util.SortUtils;
import util.SearchUtils;
import java.io.*;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author Rafael Sotero Rocha, Carlos Gustavo, Eduardo Augusto
 */
@WebServlet(name = "Cadastro", urlPatterns = {"/Cadastro"})
public class Cadastro extends HttpServlet {

    String jogador;
    boolean cadastrado;


    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullPathOfFile = getServletContext().getRealPath("/WEB-INF/" + "jogadores.txt");

        Jogador player = new Jogador(
                request.getParameter("jogador"),
                request.getParameter("jogadorLogin"),
                request.getParameter("email"),
                request.getParameter("senha"),
                request.getParameter("nascimento"),
                request.getParameter("mes"),
                request.getParameter("ano"),
                request.getParameter("rdsexo"),
                0
        );


        if (checkUserExistence(player.getNomeLogin(), fullPathOfFile)) {
            request.setAttribute("user", player.getNomeLogin());
            request.getRequestDispatcher("jacadastrado.jsp").forward(request, response);

        } else {
            insertNewUser(player.toString(), fullPathOfFile);
            request.setAttribute("nome", jogador);
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }


    }

    void insertNewUser(String jogador, String fullPathOfFile) {
        FileUtils file = new FileUtils(fullPathOfFile);
        ArrayList<ArrayList<String>> fileContent = file.getFileContent(",");

        fileContent.add(new ArrayList<>(Arrays.asList(jogador.split(","))));

        SortUtils.selectionSort(fileContent);

        int counter = 0;
        for (ArrayList<String> item : fileContent) {
            if (counter > 0) {
                jogador = String.join(",", item);
                file.writeFile(jogador, Boolean.TRUE);
            } else {
                file.writeFile(jogador, Boolean.FALSE);
            }
            counter++;

        }

    }


    boolean checkUserExistence(String login, String fullPathOfFile) {

        FileUtils file = new FileUtils(fullPathOfFile);
        ArrayList<ArrayList<String>> fileContent = file.getFileContent(",");

        String[] loginVet = new String[fileContent.size()];

        for (int i = 0; i < loginVet.length; i++) {
            loginVet[i] = fileContent.get(i).get(1);
        }

        return SearchUtils.binarySearch(loginVet, login) >= 0;

    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>


}

