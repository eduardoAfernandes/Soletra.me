package controller;

import sun.security.pkcs11.wrapper.Functions;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

//import java.io.PrintWriter;

/**
 * @author Junior
 */
@WebServlet(name = "Ranking", urlPatterns = {"/Ranking"})
public class Ranking extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *

     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */

    private String pontos [];
    private String names [];

    public String carregarranking() {
        String caminhoDir = getServletContext().getRealPath("/WEB-INF/");

        File f = new File(caminhoDir + "jogadores.txt");
        System.out.println(caminhoDir);
        FileReader leitor;
        String pontuacao = "";
        String nomes = "";
        try {
            leitor = new FileReader(f);
            BufferedReader bf = new BufferedReader(leitor);
            String linha = "";
            while ((linha = bf.readLine()) != null) {
                String partes[] = linha.split(",");
                pontuacao += partes[8] + ";";
                nomes += partes[1]+";";
                pontos = pontuacao.split(";");
                names = nomes.split(";");
            }
            leitor.close();
            bf.close();
        } catch (Exception ex) {
            System.out.println("Não foi possível ler no arquivo");
            System.out.println(ex.getMessage());
        }
        String rankingOrdenado = quickSort(0, pontos.length-1);
        return rankingOrdenado;
    }

    public void troca(int i, int j) {
        String tempPontos = pontos[j];
        String tempNome = names[j];
        pontos[j] = pontos[i];
        names[j] = names[i];
        pontos[i] = tempPontos;
        names[i] = tempNome;
    }

    public String quickSort(int ini, int fim) {
        int i = ini;
        int f = fim;
        String rankingOrdenado = "";
        int pivo = 0;
        pivo = Integer.parseInt(pontos[(ini + fim) / 2]);
        if (i <= f) {
            while (Integer.parseInt(pontos[i]) > pivo)
                i++;
            while (Integer.parseInt(pontos[f]) < pivo)
                f--;
            if (i <= f) {
                troca(i, f);
                i++;
                f--;
            }
        }
        if (f > ini) {
            quickSort(ini, f);
        }
        if (i < fim){
            quickSort(i, fim);
        }
        for(int j = 0; j<pontos.length; j++) {
            rankingOrdenado += names[j]+ ","+String.valueOf(pontos[j])+";";
        }
        return rankingOrdenado;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        String ranking = "";
        ranking = carregarranking();

       response.setContentType("text/html");
       PrintWriter out = response.getWriter();

       out.append(ranking);
       out.close();

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
