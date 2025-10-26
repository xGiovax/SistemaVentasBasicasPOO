package com.sistemaventas.controller;

import com.sistemaventas.dao.UsuarioDAO;
import com.sistemaventas.model.Usuario;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UsuarioDAO dao = new UsuarioDAO();
        Usuario user = dao.validar(username, password);

        if (user != null && user.isActivo()) {
            // Crear sesión
            HttpSession session = request.getSession();
            session.setAttribute("usuario", user);
            session.setAttribute("rol", user.getNombreRol()); // 👈 Guarda el nombre del rol (ADMIN o VENDEDOR)

            // Redirección según rol
            if ("ADMIN".equalsIgnoreCase(user.getNombreRol())) {
                response.sendRedirect("vistas/admin.jsp");
            } else if ("VENDEDOR".equalsIgnoreCase(user.getNombreRol())) {
                response.sendRedirect("vistas/vendedor.jsp");
            } else {
                // En caso de que tenga otro rol no reconocido
                session.invalidate();
                request.setAttribute("error", "Rol no autorizado para acceder al sistema");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }

        } else {
            // Usuario no válido
            request.setAttribute("error", "Usuario o contraseña incorrectos o usuario inactivo");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}
