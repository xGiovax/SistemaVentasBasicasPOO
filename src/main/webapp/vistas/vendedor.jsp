
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.sistemaventas.model.Usuario" %>

<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuario") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    Usuario u = (Usuario) sesion.getAttribute("usuario");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel del Vendedor</title>
    <link rel="stylesheet" href="../styles/vendedor.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
</head>

<body>
<div class="vendedor-container">
    <header>
        <h1>🛍️ Panel del Vendedor</h1>
        <p>Gestione sus ventas y visualice sus registros con facilidad.</p>
    </header>

    <section class="welcome-box">
        <h2>Bienvenido, <span><%= u.getNombreCompleto() %></span> 👋</h2>
        <p class="role">Rol: <strong><%= u.getNombreRol() %></strong></p>
    </section>

    <div class="acciones">
        <a href="../VentaServlet?accion=nueva" class="btn-action primary">
            💵 Registrar Venta
        </a>
        <a href="../VentaServlet?accion=listar" class="btn-action secondary">
            📊 Ver Ventas Registradas
        </a>
        <a href="../index.jsp" class="btn-action logout">
            🚪 Cerrar Sesión
        </a>
    </div>
</div>
</body>
</html>
