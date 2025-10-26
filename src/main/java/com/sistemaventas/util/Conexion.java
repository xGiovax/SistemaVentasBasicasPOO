package com.sistemaventas.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    // Datos de conexión
    private static final String URL = "jdbc:mysql://localhost:3306/sistemaventas?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = ""; // si tienes clave en XAMPP, escríbela aquí

    private static Connection conexion;

    // Método para obtener la conexión
    public static Connection getConexion() {
        try {
            if (conexion == null || conexion.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conexion = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("✅ Conexión exitosa a la base de datos.");
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("❌ Error de conexión: " + e.getMessage());
        }
        return conexion;
    }

    // Método para cerrar la conexión
    public static void cerrarConexion() {
        try {
            if (conexion != null && !conexion.isClosed()) {
                conexion.close();
                System.out.println("🔒 Conexión cerrada.");
            }
        } catch (SQLException e) {
            System.err.println("⚠️ Error al cerrar conexión: " + e.getMessage());
        }
    }

    // Prueba rápida
    public static void main(String[] args) {
        getConexion();
        cerrarConexion();
    }
}
