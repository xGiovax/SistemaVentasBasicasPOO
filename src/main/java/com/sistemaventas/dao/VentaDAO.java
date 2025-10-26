package com.sistemaventas.dao;

import com.sistemaventas.model.DetalleVenta;
import com.sistemaventas.model.Venta;
import com.sistemaventas.util.Conexion;

import java.sql.*;
import java.util.List;
import java.util.ArrayList;

public class VentaDAO {

    public boolean registrarVenta(Venta venta, List<DetalleVenta> detalles) {
        String sqlVenta = "INSERT INTO ventas(id_usuario, metodo_pago, subtotal, iva, total) VALUES(?,?,?,?,?)";
        String sqlDetalle = "INSERT INTO ventas_detalle(id_venta, id_producto, cantidad, precio_venta) VALUES(?,?,?,?)";
        String sqlStock = "UPDATE productos SET stock = stock - ? WHERE id = ?";

        try (Connection con = Conexion.getConexion()) {
            con.setAutoCommit(false);

            PreparedStatement psVenta = con.prepareStatement(sqlVenta, Statement.RETURN_GENERATED_KEYS);
            psVenta.setInt(1, venta.getIdUsuario());
            psVenta.setString(2, venta.getMetodoPago());
            psVenta.setDouble(3, venta.getSubtotal());
            psVenta.setDouble(4, venta.getIva());
            psVenta.setDouble(5, venta.getTotal());
            psVenta.executeUpdate();

            ResultSet rs = psVenta.getGeneratedKeys();
            int idVenta = 0;
            if (rs.next()) idVenta = rs.getInt(1);

            for (DetalleVenta d : detalles) {
                PreparedStatement psDet = con.prepareStatement(sqlDetalle);
                psDet.setInt(1, idVenta);
                psDet.setInt(2, d.getIdProducto());
                psDet.setInt(3, d.getCantidad());
                psDet.setDouble(4, d.getPrecioVenta());
                psDet.executeUpdate();

                PreparedStatement psStock = con.prepareStatement(sqlStock);
                psStock.setInt(1, d.getCantidad());
                psStock.setInt(2, d.getIdProducto());
                psStock.executeUpdate();
            }

            con.commit();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    public List<Venta> listarVentas() {
        List<Venta> lista = new ArrayList<>();

        String sql = """
        SELECT 
            v.id,
            v.numero_factura,
            u.nombre_completo AS usuario,
            v.metodo_pago,
            v.subtotal,
            v.iva,
            v.total,
            v.fecha,
            p.nombre AS producto,
            dv.cantidad
        FROM ventas v
        INNER JOIN usuarios u ON v.id_usuario = u.id
        INNER JOIN ventas_detalle dv ON v.id = dv.id_venta
        INNER JOIN productos p ON dv.id_producto = p.id
        ORDER BY v.fecha DESC;
    """;

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Venta v = new Venta();
                v.setId(rs.getInt("id"));
                v.setNumeroFactura(rs.getString("numero_factura"));
                v.setNombreUsuario(rs.getString("usuario"));
                v.setMetodoPago(rs.getString("metodo_pago"));
                v.setSubtotal(rs.getDouble("subtotal"));
                v.setIva(rs.getDouble("iva"));
                v.setTotal(rs.getDouble("total"));
                v.setFecha(rs.getTimestamp("fecha"));
                v.setNombreProducto(rs.getString("producto"));
                v.setCantidadVendida(rs.getInt("cantidad"));
                lista.add(v);
            }

        } catch (SQLException e) {
            System.err.println("❌ Error al listar ventas: " + e.getMessage());
        }
        return lista;
    }


}
