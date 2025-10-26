package com.sistemaventas.controller;

import com.sistemaventas.dao.CategoriaDAO;
import com.sistemaventas.model.Categoria;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/CategoriaServlet")
public class CategoriaServlet extends HttpServlet {

    CategoriaDAO dao = new CategoriaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("listar".equalsIgnoreCase(accion)) {
            List<Categoria> lista = dao.listar();
            request.setAttribute("categorias", lista);
            request.getRequestDispatcher("vistas/lista_categorias.jsp").forward(request, response);

        } else if ("nuevo".equalsIgnoreCase(accion)) {
            request.getRequestDispatcher("vistas/nuevaCategoria.jsp").forward(request, response);

        } else if ("editar".equalsIgnoreCase(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Categoria c = dao.obtenerPorId(id);
            request.setAttribute("categoria", c);
            request.getRequestDispatcher("vistas/editarCategoria.jsp").forward(request, response);

        } else if ("eliminar".equalsIgnoreCase(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.eliminar(id);
            response.sendRedirect("CategoriaServlet?accion=listar");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("agregar".equalsIgnoreCase(accion)) {
            String nombre = request.getParameter("nombre");
            Categoria c = new Categoria();
            c.setNombre(nombre);
            dao.agregar(c);
            response.sendRedirect("CategoriaServlet?accion=listar");

        } else if ("actualizar".equalsIgnoreCase(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            Categoria c = new Categoria();
            c.setId(id);
            c.setNombre(nombre);
            dao.actualizar(c);
            response.sendRedirect("CategoriaServlet?accion=listar");
        }
    }
}
