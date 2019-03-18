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
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *

     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */



    boolean leArquivo(String email, String senha) {

        boolean cadastrado = false;

        String caminhoDir = getServletContext().getRealPath("/WEB-INF/");


        File f = new File(caminhoDir + "jogadores.txt");
        System.out.println(caminhoDir);
        FileReader leitor;
        try {
            leitor = new FileReader(f);
            BufferedReader bf = new BufferedReader(leitor);
            String linha = "";
            while ((linha = bf.readLine()) != null) {
                String partes[] = linha.split(",");


                if (email.equals(partes[1]) && senha.equals(partes[3])) {
                    cadastrado = true;
                    break;
                }

            }
            leitor.close();
            bf.close();
        } catch (Exception ex) {
            System.out.println("Não foi possível ler no arquivo");
            System.out.println(ex.getMessage());
        }

        return cadastrado;

    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("campoUser");
        String senha = request.getParameter("campoSenha");


        boolean cadastrado = leArquivo(email, senha);

        if (cadastrado) {
            request.setAttribute("mensagemServlet", "Jogador Existente");
            request.setAttribute("usr", email);
            request.setAttribute("pwd", senha);
//            request.getRequestDispatcher("index.jsp").forward(request, response);
            request.getRequestDispatcher("gravando.jsp").forward(request, response);

        }else {
            request.setAttribute("mensagemServlet", "Jogador Inexistente");
            request.getRequestDispatcher("index.jsp").forward(request, response);

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
