package com.sistemaventas.dao;

import com.sistemaventas.model.Producto;
import com.sistemaventas.util.Conexion;
import java.sql.*;
import java.util.*;

public class ProductoDAO {

    // 🔹 LISTAR PRODUCTOS con el nombre de la categoría
    public List<Producto> listar() {
        List<Producto> lista = new ArrayList<>();
        String sql = """
            SELECT p.*, c.nombre AS categoria_nombre 
            FROM productos p
            LEFT JOIN categorias c ON p.id_categoria = c.id
            ORDER BY p.id ASC
        """;

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Producto p = new Producto();
                p.setId(rs.getInt("id"));
                p.setNombre(rs.getString("nombre"));
                p.setIdCategoria(rs.getInt("id_categoria"));
                p.setCategoria(rs.getString("categoria_nombre"));
                p.setPrecioCompra(rs.getDouble("precio_compra"));
                p.setPrecioVenta(rs.getDouble("precio_venta"));
                p.setStock(rs.getInt("stock"));
                p.setStockMinimo(rs.getInt("stock_minimo"));
                lista.add(p);
            }

        } catch (SQLException e) {
            System.err.println("❌ Error al listar productos: " + e.getMessage());
        }
        return lista;
    }

    // 🔹 AGREGAR PRODUCTO con id_categoria dinámico
    public boolean agregar(Producto p) {
        String sql = "INSERT INTO productos(nombre, id_categoria, precio_compra, precio_venta, stock, stock_minimo) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setInt(2, p.getIdCategoria()); // 👈 ahora el id_categoria viene del formulario
            ps.setDouble(3, p.getPrecioCompra());
            ps.setDouble(4, p.getPrecioVenta());
            ps.setInt(5, p.getStock());
            ps.setInt(6, p.getStockMinimo());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("❌ Error al agregar producto: " + e.getMessage());
            return false;
        }
    }

    // 🔹 ELIMINAR PRODUCTO
    public boolean eliminar(int id) {
        String sql = "DELETE FROM productos WHERE id = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("❌ Error al eliminar producto: " + e.getMessage());
            return false;
        }
    }

    // 🔹 OBTENER PRODUCTO POR ID (para editar)
    public Producto obtenerPorId(int id) {
        Producto p = null;
        String sql = """
            SELECT p.*, c.nombre AS categoria_nombre 
            FROM productos p
            LEFT JOIN categorias c ON p.id_categoria = c.id
            WHERE p.id = ?
        """;
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                p = new Producto();
                p.setId(rs.getInt("id"));
                p.setNombre(rs.getString("nombre"));
                p.setIdCategoria(rs.getInt("id_categoria"));
                p.setCategoria(rs.getString("categoria_nombre"));
                p.setPrecioCompra(rs.getDouble("precio_compra"));
                p.setPrecioVenta(rs.getDouble("precio_venta"));
                p.setStock(rs.getInt("stock"));
                p.setStockMinimo(rs.getInt("stock_minimo"));
            }
        } catch (SQLException e) {
            System.err.println("❌ Error al obtener producto: " + e.getMessage());
        }
        return p;
    }

    // 🔹 ACTUALIZAR PRODUCTO con categoría editable
    public boolean actualizar(Producto p) {
        String sql = "UPDATE productos SET nombre=?, id_categoria=?, precio_compra=?, precio_venta=?, stock=?, stock_minimo=? WHERE id=?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getNombre());
            ps.setInt(2, p.getIdCategoria());
            ps.setDouble(3, p.getPrecioCompra());
            ps.setDouble(4, p.getPrecioVenta());
            ps.setInt(5, p.getStock());
            ps.setInt(6, p.getStockMinimo());
            ps.setInt(7, p.getId());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("❌ Error al actualizar producto: " + e.getMessage());
            return false;
        }
    }
}
