<%

    String user = (String)request.getAttribute("usr");
    session.setAttribute("user",user);
    request.getRequestDispatcher("jogador.jsp").forward(request, response);
    System.out.println("teste");
%>
