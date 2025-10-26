package com.sistemaventas.dao;

import com.sistemaventas.model.Compra;
import com.sistemaventas.model.DetalleCompra;
import com.sistemaventas.util.Conexion;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;

public class CompraDAO {

    public boolean registrarCompra(Compra compra, List<DetalleCompra> detalles) {
        String sqlCompra = "INSERT INTO compras (id_proveedor, id_usuario, fecha, total) VALUES (?, ?, NOW(), ?)";
        String sqlDetalle = "INSERT INTO compras_detalle (id_compra, id_producto, cantidad, precio_compra) VALUES (?, ?, ?, ?)";
        String sqlActualizarStock = "UPDATE productos SET stock = stock + ? WHERE id = ?";

        try (Connection con = Conexion.getConexion()) {
            con.setAutoCommit(false); // Iniciar transacción

            // 1️⃣ Insertar la compra
            PreparedStatement psCompra = con.prepareStatement(sqlCompra, Statement.RETURN_GENERATED_KEYS);
            psCompra.setInt(1, compra.getIdProveedor());
            psCompra.setInt(2, compra.getIdUsuario());
            psCompra.setDouble(3, compra.getTotal());
            psCompra.executeUpdate();

            // Obtener el ID generado automáticamente
            ResultSet rs = psCompra.getGeneratedKeys();
            int idCompra = 0;
            if (rs.next()) idCompra = rs.getInt(1);

            // 2️⃣ Insertar cada detalle de compra
            PreparedStatement psDetalle = con.prepareStatement(sqlDetalle);
            PreparedStatement psStock = con.prepareStatement(sqlActualizarStock);

            for (DetalleCompra d : detalles) {
                psDetalle.setInt(1, idCompra);
                psDetalle.setInt(2, d.getIdProducto());
                psDetalle.setInt(3, d.getCantidad());
                psDetalle.setDouble(4, d.getPrecioUnitario());
                psDetalle.executeUpdate();

                // Actualizar stock
                psStock.setInt(1, d.getCantidad());
                psStock.setInt(2, d.getIdProducto());
                psStock.executeUpdate();
            }

            con.commit(); // Confirmar transacción
            System.out.println("✅ Compra registrada correctamente");
            return true;

        } catch (SQLException e) {
            System.err.println("❌ Error al registrar la compra: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public List<Compra> listarCompras() {
        List<Compra> lista = new ArrayList<>();
        String sql = """
        SELECT 
            c.id,
            p.nombre AS proveedor,
            u.nombre_completo AS usuario,
            c.fecha,
            c.total,
            pr.nombre AS producto,
            cd.cantidad
        FROM compras c
        INNER JOIN proveedores p ON c.id_proveedor = p.id
        INNER JOIN usuarios u ON c.id_usuario = u.id
        INNER JOIN compras_detalle cd ON c.id = cd.id_compra
        INNER JOIN productos pr ON cd.id_producto = pr.id
        ORDER BY c.fecha DESC
    """;

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Compra c = new Compra();
                c.setId(rs.getInt("id"));
                c.setNombreProveedor(rs.getString("proveedor"));
                c.setNombreUsuario(rs.getString("usuario"));
                c.setFecha(rs.getTimestamp("fecha"));
                c.setTotal(rs.getDouble("total"));
                c.setNombreProducto(rs.getString("producto"));
                c.setCantidadComprada(rs.getInt("cantidad"));
                lista.add(c);
            }

        } catch (SQLException e) {
            System.err.println("❌ Error al listar compras: " + e.getMessage());
        }
        return lista;
    }


}
