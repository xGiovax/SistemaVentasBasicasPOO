<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sistemaventas.model.Compra" %>

<%
    List<Compra> compras = (List<Compra>) request.getAttribute("compras");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Compras</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/lista_compras.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
</head>
<body>

<div class="container">
    <header>
        <h2>📋 Registro de Compras</h2>
        <a href="${pageContext.request.contextPath}/CompraServlet" class="btn-primary">➕ Registrar Nueva Compra</a>
    </header>

    <section class="table-section">
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Proveedor</th>
                <th>Usuario</th>
                <th>Producto</th>
                <th>Cantidad Comprada</th>
                <th>Fecha</th>
                <th>Total ($)</th>
            </tr>
            </thead>
            <tbody>
            <% if (compras != null && !compras.isEmpty()) {
                for (Compra c : compras) { %>
            <tr>
                <td><%= c.getId() %></td>
                <td><%= c.getNombreProveedor() %></td>
                <td><%= c.getNombreUsuario() %></td>
                <td><%= c.getNombreProducto() %></td>
                <td><%= c.getCantidadComprada() %></td>
                <td><%= c.getFecha() %></td>
                <td>$<%= String.format("%.2f", c.getTotal()) %></td>
            </tr>
            <% } } else { %>
            <tr>
                <td colspan="7" class="no-data">No hay compras registradas.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </section>

    <footer>
        <a href="${pageContext.request.contextPath}/vistas/admin.jsp" class="btn-secondary">⬅️ Volver al Panel</a>
    </footer>
</div>

</body>
</html>
