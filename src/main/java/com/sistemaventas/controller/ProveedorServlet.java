package com.sistemaventas.controller;

import com.sistemaventas.dao.ProveedorDAO;
import com.sistemaventas.model.Proveedor;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/ProveedorServlet")
public class ProveedorServlet extends HttpServlet {

    ProveedorDAO dao = new ProveedorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        switch (accion) {
            case "nuevo":
                request.getRequestDispatcher("vistas/nuevoProveedor.jsp").forward(request, response);
                break;
            case "editar":
                int idEditar = Integer.parseInt(request.getParameter("id"));
                Proveedor p = dao.obtenerPorId(idEditar);
                request.setAttribute("proveedor", p);
                request.getRequestDispatcher("vistas/editarProveedor.jsp").forward(request, response);
                break;
            case "eliminar":
                int idEliminar = Integer.parseInt(request.getParameter("id"));
                dao.eliminar(idEliminar);
                response.sendRedirect("ProveedorServlet?accion=listar");
                break;
            default:
                request.setAttribute("lista", dao.listar());
                request.getRequestDispatcher("vistas/proveedores.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if ("actualizar".equals(accion)) {
            Proveedor p = new Proveedor();
            p.setId(Integer.parseInt(request.getParameter("id")));
            p.setNombre(request.getParameter("nombre"));
            p.setContacto(request.getParameter("contacto"));
            p.setTelefono(request.getParameter("telefono"));
            p.setCorreo(request.getParameter("correo"));
            dao.actualizar(p);
            response.sendRedirect("ProveedorServlet?accion=listar");
        } else {
            Proveedor p = new Proveedor();
            p.setNombre(request.getParameter("nombre"));
            p.setContacto(request.getParameter("contacto"));
            p.setTelefono(request.getParameter("telefono"));
            p.setCorreo(request.getParameter("correo"));
            dao.agregar(p);
            response.sendRedirect("ProveedorServlet?accion=listar");
        }
    }
}
