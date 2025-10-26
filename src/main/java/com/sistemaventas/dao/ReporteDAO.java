package com.sistemaventas.dao;

import com.sistemaventas.model.Compra;
import com.sistemaventas.model.Producto;
import com.sistemaventas.model.Venta;
import com.sistemaventas.util.Conexion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReporteDAO {

    // 🔹 Reporte de ventas por fecha
    public List<Venta> listarVentasPorFecha(String fechaInicio, String fechaFin) {
        List<Venta> lista = new ArrayList<>();

        String sql = """
            SELECT v.numero_factura, v.fecha, u.nombre_completo AS usuario,
                   v.subtotal, v.iva, v.total, v.metodo_pago
            FROM ventas v
            INNER JOIN usuarios u ON v.id_usuario = u.id
            WHERE v.fecha >= ? AND v.fecha < DATE_ADD(?, INTERVAL 1 DAY)
            ORDER BY v.fecha ASC;
        """;

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, fechaInicio);
            ps.setString(2, fechaFin);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Venta v = new Venta();
                v.setNumeroFactura(rs.getString("numero_factura"));

                Timestamp ts = rs.getTimestamp("fecha");
                if (ts != null) {
                    v.setFecha(new java.util.Date(ts.getTime()));
                }

                v.setNombreUsuario(rs.getString("usuario"));
                v.setSubtotal(rs.getDouble("subtotal"));
                v.setIva(rs.getDouble("iva"));
                v.setTotal(rs.getDouble("total"));
                v.setMetodoPago(rs.getString("metodo_pago"));

                lista.add(v);
            }

        } catch (SQLException e) {
            System.err.println("❌ Error al filtrar ventas por fecha: " + e.getMessage());
        }

        return lista;
    }

    // 🔹 Reporte de productos más vendidos
    public List<Producto> listarProductosMasVendidos() {
        List<Producto> lista = new ArrayList<>();
        String sql = """
            SELECT 
                p.id AS id_producto,
                p.nombre AS nombre_producto,
                SUM(vd.cantidad) AS total_vendido,
                SUM(vd.subtotal) AS total_ingresos
            FROM ventas_detalle vd
            JOIN productos p ON vd.id_producto = p.id
            GROUP BY p.id, p.nombre
            ORDER BY total_vendido DESC;
        """;

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Producto p = new Producto();
                p.setId(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre_producto"));
                p.setStock(rs.getInt("total_vendido")); // reutilizamos stock para cantidad vendida
                p.setPrecioVenta(rs.getDouble("total_ingresos")); // reutilizamos precioVenta para ingresos totales
                lista.add(p);
            }

        } catch (SQLException e) {
            System.err.println("❌ Error al listar productos más vendidos: " + e.getMessage());
        }
        return lista;
    }

    // 🔹 Reporte de inventario (productos con su categoría y stock)
    public List<Producto> listarInventario() {
        List<Producto> lista = new ArrayList<>();

        String sql = """
        SELECT 
            p.id,
            p.nombre,
            c.nombre AS categoria,
            p.precio_compra,
            p.precio_venta,
            p.stock,
            p.stock_minimo
        FROM productos p
        INNER JOIN categorias c ON p.id_categoria = c.id
        ORDER BY p.stock ASC;
        """;

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Producto p = new Producto();
                p.setId(rs.getInt("id"));
                p.setNombre(rs.getString("nombre"));
                p.setCategoria(rs.getString("categoria"));
                p.setPrecioCompra(rs.getDouble("precio_compra"));
                p.setPrecioVenta(rs.getDouble("precio_venta"));
                p.setStock(rs.getInt("stock"));
                p.setStockMinimo(rs.getInt("stock_minimo"));
                lista.add(p);
            }

        } catch (SQLException e) {
            System.err.println("❌ Error al listar inventario: " + e.getMessage());
        }
        return lista;
    }

    // 🔹 Reporte de compras a proveedores
    public List<Compra> listarComprasProveedores() {
        List<Compra> lista = new ArrayList<>();

        String sql = """
        SELECT 
            c.id AS id_compra,
            p.nombre AS proveedor,
            p.correo AS correo_proveedor,
            pr.nombre AS producto,
            d.cantidad,
            d.precio_compra,
            d.subtotal,
            c.fecha,
            c.total
        FROM compras c
        INNER JOIN proveedores p ON c.id_proveedor = p.id
        INNER JOIN compras_detalle d ON c.id = d.id_compra
        INNER JOIN productos pr ON d.id_producto = pr.id
        ORDER BY c.fecha DESC;
        """;

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Compra compra = new Compra();
                compra.setId(rs.getInt("id_compra"));
                compra.setNombreProveedor(rs.getString("proveedor"));
                compra.setCorreoProveedor(rs.getString("correo_proveedor"));
                compra.setNombreProducto(rs.getString("producto"));
                compra.setCantidadComprada(rs.getInt("cantidad"));
                compra.setPrecioCompra(rs.getDouble("precio_compra"));
                compra.setSubtotal(rs.getDouble("subtotal"));
                compra.setFecha(rs.getTimestamp("fecha"));
                compra.setTotal(rs.getDouble("total"));
                lista.add(compra);
            }

        } catch (SQLException e) {
            System.err.println("❌ Error al listar compras por proveedor: " + e.getMessage());
        }

        return lista;
    }
}
