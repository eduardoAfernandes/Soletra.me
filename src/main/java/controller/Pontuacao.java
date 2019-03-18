package controller;

import model.Jogador;
import sun.security.pkcs11.wrapper.Functions;
import util.FileUtils;
import util.SortUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;

//import java.io.PrintWriter;

/**
 * @author Junior
 */
@WebServlet(name = "Pontuacao", urlPatterns = {"/Pontuacao"})
public class Pontuacao extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */


    ArrayList<Jogador> leArquivo() {

        ArrayList<Jogador> listaDeJogadores = new ArrayList<>();

        String caminhoDir = getServletContext().getRealPath("/WEB-INF/");


        File f = new File(caminhoDir + "jogadores.txt");
        System.out.println(caminhoDir);
        FileReader leitor;
        try {
            leitor = new FileReader(f);
            BufferedReader bf = new BufferedReader(leitor);
            String linha = "";
            int i = 0;
            while ((linha = bf.readLine()) != null) {
                String[] partes = linha.split(",");
                Jogador jogador = new Jogador(
                        partes[0],
                        partes[1],
                        partes[2],
                        partes[3],
                        partes[4],
                        partes[5],
                        partes[6],
                        partes[7],
                        Integer.parseInt(partes[8])
                );
                listaDeJogadores.add(jogador);
                i++;
            }
            leitor.close();
            bf.close();
        } catch (Exception ex) {
            System.out.println("Não foi possível ler no arquivo");
            System.out.println(ex.getMessage());
        }

        return listaDeJogadores;

    }

    void updateUser(ArrayList<String> writeContent) {
        String caminhoDir = getServletContext().getRealPath("/WEB-INF/jogadores.txt");

        FileUtils file = new FileUtils(caminhoDir);
//        ArrayList<ArrayList<String>> fileContent = file.getFileContent(",");

        int counter = 0;
        for (String item : writeContent) {
            if (counter > 0) {
                file.writeFile(item, Boolean.TRUE);
            } else {
                file.writeFile(item, Boolean.FALSE);
            }
            counter++;
        }

    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String jogador = request.getParameter("jogador");
        String pontos = request.getParameter("pontos");
        String tipo = request.getParameter("tipo");


        response.setContentType("text/html");
        PrintWriter out = response.getWriter();



        if (tipo.equals("pegar")) {
            for (Jogador item : leArquivo()) {
                if (item.getNomeLogin().equals(jogador)) {
                        out.append(String.valueOf(item.getPontos())).close();
                }
            }
        } else {
            ArrayList<String> jogadoresArquivo = new ArrayList<>();
            for (Jogador item : leArquivo()) {
                if (item.getNomeLogin().equals(jogador)) {
                    item.setPontos(Integer.parseInt(pontos));
                }
                jogadoresArquivo.add(item.toString());
                updateUser(jogadoresArquivo);
                out.append(String.valueOf(item.getPontos())).close();
            }
        }



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
