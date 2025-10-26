package com.sistemaventas.controller;

import com.sistemaventas.dao.CompraDAO;
import com.sistemaventas.dao.ProductoDAO;
import com.sistemaventas.dao.ProveedorDAO;
import com.sistemaventas.model.Compra;
import com.sistemaventas.model.DetalleCompra;
import com.sistemaventas.model.Producto;
import com.sistemaventas.model.Proveedor;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/CompraServlet")
public class CompraServlet extends HttpServlet {

    CompraDAO dao = new CompraDAO();
    ProductoDAO productoDAO = new ProductoDAO();
    ProveedorDAO proveedorDAO = new ProveedorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("listar".equalsIgnoreCase(accion)) {
            listarCompras(request, response);
        } else {
            // 🔹 Cargar listas de productos y proveedores para el formulario
            try {
                List<Producto> productos = productoDAO.listar();
                List<Proveedor> proveedores = proveedorDAO.listar();

                request.setAttribute("productos", productos);
                request.setAttribute("proveedores", proveedores);

                request.getRequestDispatcher("vistas/nuevaCompra.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("❌ Error al cargar formulario de compra: " + e.getMessage());
            }
        }
    }

    private void listarCompras(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Compra> lista = dao.listarCompras();
            request.setAttribute("compras", lista);
            request.getRequestDispatcher("vistas/lista_compras.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("❌ Error al listar las compras: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int idProveedor = Integer.parseInt(request.getParameter("id_proveedor"));
            int idUsuario = 1; // 🔹 Temporal, luego se usará el del usuario logueado
            int idProducto = Integer.parseInt(request.getParameter("id_producto"));
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));
            double precioUnitario = Double.parseDouble(request.getParameter("precio_unitario"));
            double total = cantidad * precioUnitario;

            // Crear compra
            Compra compra = new Compra();
            compra.setIdProveedor(idProveedor);
            compra.setIdUsuario(idUsuario);
            compra.setTotal(total);

            // Crear detalle
            DetalleCompra detalle = new DetalleCompra();
            detalle.setIdProducto(idProducto);
            detalle.setCantidad(cantidad);
            detalle.setPrecioUnitario(precioUnitario);

            List<DetalleCompra> detalles = new ArrayList<>();
            detalles.add(detalle);

            boolean exito = dao.registrarCompra(compra, detalles);

            if (exito) {
                response.sendRedirect("vistas/compraExitosa.jsp");
            } else {
                response.getWriter().println("❌ Error al registrar la compra.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("⚠️ Error al procesar la compra: " + e.getMessage());
        }
    }
}
