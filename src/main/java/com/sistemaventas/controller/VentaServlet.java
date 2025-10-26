package com.sistemaventas.controller;

import com.sistemaventas.dao.VentaDAO;
import com.sistemaventas.model.DetalleVenta;
import com.sistemaventas.model.Venta;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/VentaServlet")
public class VentaServlet extends HttpServlet {

    VentaDAO dao = new VentaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("listar".equalsIgnoreCase(accion)) {
            listarVentas(request, response);
        } else if ("nueva".equalsIgnoreCase(accion)) {
            // Muestra el formulario para registrar una nueva venta
            request.getRequestDispatcher("vistas/ventas.jsp").forward(request, response);
        } else {
            // Si no hay acción, redirige al panel principal
            response.sendRedirect("vistas/admin.jsp");
        }
    }

    private void listarVentas(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Venta> lista = dao.listarVentas();
            request.setAttribute("ventas", lista);
            request.getRequestDispatcher("vistas/lista_ventas.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("❌ Error al listar las ventas: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 🔹 Obtener usuario logueado de la sesión
            com.sistemaventas.model.Usuario usuario =
                    (com.sistemaventas.model.Usuario) request.getSession().getAttribute("usuario");

            if (usuario == null) {
                response.getWriter().println("❌ No hay usuario logueado.");
                return;
            }

            // 🔹 Validar campos principales
            String metodoPago = request.getParameter("metodoPago");
            String subtotalStr = request.getParameter("subtotal");
            String ivaStr = request.getParameter("iva");
            String totalStr = request.getParameter("total");

            if (subtotalStr == null || ivaStr == null || totalStr == null) {
                response.getWriter().println("⚠️ Error: Alguno de los totales no fue enviado.<br>");
                response.getWriter().println("subtotal=" + subtotalStr + "<br>");
                response.getWriter().println("iva=" + ivaStr + "<br>");
                response.getWriter().println("total=" + totalStr + "<br>");
                return;
            }

            double subtotal = Double.parseDouble(subtotalStr);
            double iva = Double.parseDouble(ivaStr);
            double total = Double.parseDouble(totalStr);

            // 🔹 Crear objeto Venta
            Venta venta = new Venta();
            venta.setIdUsuario(usuario.getId()); // 👈 usa el ID del usuario logueado
            venta.setMetodoPago(metodoPago);
            venta.setSubtotal(subtotal);
            venta.setIva(iva);
            venta.setTotal(total);

            // 🔹 Obtener los arrays de productos
            String[] idProductos = request.getParameterValues("idProducto[]");
            String[] cantidades = request.getParameterValues("cantidad[]");
            String[] precios = request.getParameterValues("precio[]");

            if (idProductos == null || cantidades == null || precios == null) {
                response.getWriter().println("⚠️ Error: No se enviaron los productos correctamente.<br>");
                return;
            }

            List<DetalleVenta> detalles = new ArrayList<>();
            for (int i = 0; i < idProductos.length; i++) {
                DetalleVenta det = new DetalleVenta();
                det.setIdProducto(Integer.parseInt(idProductos[i]));
                det.setCantidad(Integer.parseInt(cantidades[i]));
                det.setPrecioVenta(Double.parseDouble(precios[i]));
                detalles.add(det);
            }

            // 🔹 Registrar venta
            boolean exito = dao.registrarVenta(venta, detalles);

            if (exito) {
                request.setAttribute("venta", venta);
                request.setAttribute("detalles", detalles);
                RequestDispatcher rd = request.getRequestDispatcher("vistas/ticket.jsp");
                rd.forward(request, response);
            } else {
                response.getWriter().println("❌ Error al registrar la venta.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("❌ Error general: " + e.getMessage());
        }
    }

}
