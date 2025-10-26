package com.sistemaventas.controller;

import com.sistemaventas.dao.CompraDAO;
import com.sistemaventas.model.Compra;
import com.sistemaventas.model.DetalleCompra;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/CompraListarServlet")
public class CompraListarServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CompraDAO dao = new CompraDAO();
        List<Compra> listaCompras = dao.listarCompras();
        request.setAttribute("compras", listaCompras);

        RequestDispatcher dispatcher = request.getRequestDispatcher("vistas/lista_compras.jsp");
        dispatcher.forward(request, response);
    }
}
