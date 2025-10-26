package com.sistemaventas.dao;

import com.sistemaventas.model.Proveedor;
import com.sistemaventas.util.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProveedorDAO {

    public List<Proveedor> listar() {
        List<Proveedor> lista = new ArrayList<>();
        String sql = "SELECT * FROM proveedores";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Proveedor p = new Proveedor();
                p.setId(rs.getInt("id"));
                p.setNombre(rs.getString("nombre"));
                p.setContacto(rs.getString("contacto"));
                p.setTelefono(rs.getString("telefono"));
                p.setCorreo(rs.getString("correo"));
                lista.add(p);
            }

        } catch (SQLException e) {
            System.err.println("❌ Error al listar proveedores: " + e.getMessage());
        }
        return lista;
    }

    public boolean agregar(Proveedor p) {
        String sql = "INSERT INTO proveedores (nombre, contacto, telefono, correo) VALUES (?, ?, ?, ?)";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getContacto());
            ps.setString(3, p.getTelefono());
            ps.setString(4, p.getCorreo());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("❌ Error al agregar proveedor: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminar(int id) {
        String sql = "DELETE FROM proveedores WHERE id = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("❌ Error al eliminar proveedor: " + e.getMessage());
            return false;
        }
    }

    public Proveedor obtenerPorId(int id) {
        Proveedor p = null;
        String sql = "SELECT * FROM proveedores WHERE id = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                p = new Proveedor();
                p.setId(rs.getInt("id"));
                p.setNombre(rs.getString("nombre"));
                p.setContacto(rs.getString("contacto"));
                p.setTelefono(rs.getString("telefono"));
                p.setCorreo(rs.getString("correo"));
            }
        } catch (SQLException e) {
            System.err.println("❌ Error al obtener proveedor: " + e.getMessage());
        }
        return p;
    }

    public boolean actualizar(Proveedor p) {
        String sql = "UPDATE proveedores SET nombre=?, contacto=?, telefono=?, correo=? WHERE id=?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getContacto());
            ps.setString(3, p.getTelefono());
            ps.setString(4, p.getCorreo());
            ps.setInt(5, p.getId());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("❌ Error al actualizar proveedor: " + e.getMessage());
            return false;
        }
    }
}
