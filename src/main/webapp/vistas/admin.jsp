<%--
  Created by IntelliJ IDEA.
  User: MINEDUCYT
  Date: 23/10/2025
  Time: 12:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.sistemaventas.model.Usuario" %>
<%
    Usuario user = (Usuario) session.getAttribute("usuario");
    if (user == null) {
        response.sendRedirect("../index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel Administrador</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
</head>
<body>

<!-- Topbar -->
<header class="topbar">
    <div class="brand">Sistema de Ventas</div>
    <div class="top-actions">
        <span>Bienvenido, <strong><%= user.getNombreCompleto() %></strong></span>
        <a href="../index.jsp" class="btn-out">Cerrar sesión</a>
    </div>
</header>

<!-- Toggle para móvil (sin JS) -->
<input type="checkbox" id="navToggle" class="nav-toggle" />
<label for="navToggle" class="hamburger" aria-label="Abrir menú">☰</label>

<!-- Sidebar -->
<aside class="sidebar">
    <div class="sidebar-header">
        <h3>Módulos</h3>
        <label for="navToggle" class="close-btn" aria-label="Cerrar menú">×</label>
    </div>
    <nav>
        <ul>
            <li><a href="../ProductoServlet?accion=listar">🛒 Productos</a></li>
            <li><a href="../ProveedorServlet?accion=listar">🏢 Proveedores</a></li>
            <li><a href="../CategoriaServlet?accion=listar">📂 Categorías</a></li>
            <li><a href="../CompraServlet">📥 Registrar Compras</a></li>
            <li><a href="../CompraServlet?accion=listar">📋 Ver Compras</a></li>
            <li><a href="../VentaServlet?accion=nueva">💵 Registrar Ventas</a></li>
            <li><a href="../VentaServlet?accion=listar">📊 Ver Ventas</a></li>
        </ul>

        <h3 class="group-title">Reportes</h3>
        <ul>
            <li><a href="../ReporteServlet?accion=ventas">🧮 Ventas por Fecha</a></li>
            <li><a href="../ReporteServlet?accion=productosMasVendidos">📈 Más Vendidos</a></li>
            <li><a href="../ReporteServlet?accion=inventario">📦 Inventario</a></li>
            <li><a href="../ReporteServlet?accion=comprasProveedores">📦 Compras Proveedores</a></li>
        </ul>
    </nav>
</aside>

<!-- Contenido -->
<main class="content">
    <div class="container">
        <h1>Panel de Administración</h1>
        <p class="subtitle">Selecciona una opción del menú o usa los accesos rápidos.</p>

        <!-- Accesos rápidos: tarjetas uniformes -->
        <section class="cards">
            <a class="card" href="../ProductoServlet?accion=listar">
                <div class="card-icon">🛒</div>
                <h4 class="card-title">Productos</h4>
                <p class="card-text">Administra el catálogo completo.</p>
                <span class="card-cta">Ver más</span>
            </a>

            <a class="card" href="../VentaServlet?accion=listar">
                <div class="card-icon">💵</div>
                <h4 class="card-title">Ventas</h4>
                <p class="card-text">Registra y consulta ventas.</p>
                <span class="card-cta">Ver más</span>
            </a>

            <a class="card" href="../CompraServlet?accion=listar">
                <div class="card-icon">📥</div>
                <h4 class="card-title">Compras</h4>
                <p class="card-text">Controla compras a proveedores.</p>
                <span class="card-cta">Ver más</span>
            </a>

            <a class="card" href="../ReporteServlet?accion=productosMasVendidos">
                <div class="card-icon">📈</div>
                <h4 class="card-title">Más Vendidos</h4>
                <p class="card-text">Top de productos por ventas.</p>
                <span class="card-cta">Ver más</span>
            </a>
        </section>
    </div>
</main>
</body>
</html>
