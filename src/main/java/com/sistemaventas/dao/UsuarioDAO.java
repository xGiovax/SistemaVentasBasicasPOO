package com.sistemaventas.dao;

import com.sistemaventas.model.Usuario;
import com.sistemaventas.util.Conexion;
import java.sql.*;

public class UsuarioDAO {

    public Usuario validar(String username, String password) {
        Usuario usuario = null;

        String sql = """
            SELECT 
                u.id,
                u.username,
                u.password,
                u.nombre_completo,
                u.id_rol,
                r.nombre AS nombre_rol,
                u.activo
            FROM usuarios u
            INNER JOIN roles r ON u.id_rol = r.id
            WHERE u.username = ? AND u.password = ? AND u.activo = 1
        """;

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setUsername(rs.getString("username"));
                usuario.setPassword(rs.getString("password"));
                usuario.setNombreCompleto(rs.getString("nombre_completo"));
                usuario.setIdRol(rs.getInt("id_rol"));
                usuario.setNombreRol(rs.getString("nombre_rol")); // 👈 importante para el LoginServlet
                usuario.setActivo(rs.getBoolean("activo"));
            }

        } catch (SQLException e) {
            System.err.println("❌ Error al validar usuario: " + e.getMessage());
        }

        return usuario;
    }
}
