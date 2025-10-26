package com.sistemaventas.dao;

import com.sistemaventas.model.Categoria;
import com.sistemaventas.util.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDAO {

    public List<Categoria> listar() {
        List<Categoria> lista = new ArrayList<>();
        String sql = "SELECT * FROM categorias ORDER BY id ASC";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Categoria c = new Categoria();
                c.setId(rs.getInt("id"));
                c.setNombre(rs.getString("nombre"));
                lista.add(c);
            }

        } catch (SQLException e) {
            System.err.println("❌ Error al listar categorías: " + e.getMessage());
        }
        return lista;
    }

    public boolean agregar(Categoria c) {
        String sql = "INSERT INTO categorias (nombre) VALUES (?)";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, c.getNombre());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("❌ Error al agregar categoría: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminar(int id) {
        String sql = "DELETE FROM categorias WHERE id=?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("❌ Error al eliminar categoría: " + e.getMessage());
            return false;
        }
    }

    public Categoria obtenerPorId(int id) {
        Categoria c = null;
        String sql = "SELECT * FROM categorias WHERE id=?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                c = new Categoria();
                c.setId(rs.getInt("id"));
                c.setNombre(rs.getString("nombre"));
            }
        } catch (SQLException e) {
            System.err.println("❌ Error al obtener categoría: " + e.getMessage());
        }
        return c;
    }

    public boolean actualizar(Categoria c) {
        String sql = "UPDATE categorias SET nombre=? WHERE id=?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, c.getNombre());
            ps.setInt(2, c.getId());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("❌ Error al actualizar categoría: " + e.getMessage());
            return false;
        }
    }
}
