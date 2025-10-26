package com.sistemaventas.controller;

import com.sistemaventas.dao.ProductoDAO;
import com.sistemaventas.dao.CategoriaDAO;
import com.sistemaventas.model.Producto;
import com.sistemaventas.model.Categoria;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/ProductoServlet")
public class ProductoServlet extends HttpServlet {

    ProductoDAO productoDAO = new ProductoDAO();
    CategoriaDAO categoriaDAO = new CategoriaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        switch (accion == null ? "listar" : accion) {
            case "listar" -> {
                List<Producto> lista = productoDAO.listar();
                request.setAttribute("productos", lista);
                request.getRequestDispatcher("vistas/listaProductos.jsp").forward(request, response);
            }

            case "nuevo" -> {
                // 🔹 Enviar lista de categorías al JSP
                List<Categoria> categorias = categoriaDAO.listar();
                request.setAttribute("categorias", categorias);
                request.getRequestDispatcher("vistas/nuevoProducto.jsp").forward(request, response);
            }

            case "editar" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                Producto p = productoDAO.obtenerPorId(id);
                List<Categoria> categorias = categoriaDAO.listar();
                request.setAttribute("producto", p);
                request.setAttribute("categorias", categorias);
                request.getRequestDispatcher("vistas/editarProducto.jsp").forward(request, response);
            }

            case "eliminar" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                productoDAO.eliminar(id);
                response.sendRedirect("ProductoServlet?accion=listar");
            }

            default -> response.sendRedirect("ProductoServlet?accion=listar");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("insertar".equalsIgnoreCase(accion)) {
            Producto p = new Producto();
            p.setNombre(request.getParameter("nombre"));
            p.setIdCategoria(Integer.parseInt(request.getParameter("id_categoria")));
            p.setPrecioCompra(Double.parseDouble(request.getParameter("precio_compra")));
            p.setPrecioVenta(Double.parseDouble(request.getParameter("precio_venta")));
            p.setStock(Integer.parseInt(request.getParameter("stock")));
            p.setStockMinimo(Integer.parseInt(request.getParameter("stock_minimo")));

            productoDAO.agregar(p);
            response.sendRedirect("ProductoServlet?accion=listar");

        } else if ("actualizar".equalsIgnoreCase(accion)) {
            Producto p = new Producto();
            p.setId(Integer.parseInt(request.getParameter("id")));
            p.setNombre(request.getParameter("nombre"));
            p.setIdCategoria(Integer.parseInt(request.getParameter("id_categoria")));
            p.setPrecioCompra(Double.parseDouble(request.getParameter("precio_compra")));
            p.setPrecioVenta(Double.parseDouble(request.getParameter("precio_venta")));
            p.setStock(Integer.parseInt(request.getParameter("stock")));
            p.setStockMinimo(Integer.parseInt(request.getParameter("stock_minimo")));

            productoDAO.actualizar(p);
            response.sendRedirect("ProductoServlet?accion=listar");
        }
    }
}

