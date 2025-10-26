<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sistemaventas.model.Venta" %>

<%
    List<Venta> ventas = (List<Venta>) request.getAttribute("ventas");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ventas Registradas</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/lista_ventas.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
</head>

<body>
<div class="container">
    <header>
        <h2>Ventas Registradas</h2>
        <a href="${pageContext.request.contextPath}/vistas/admin.jsp" class="btn-secondary">⬅️ Volver al Panel</a>
        <a href="${pageContext.request.contextPath}/VentaServlet?accion=nueva" class="btn-primary">➕ Registrar Nueva Venta</a>
    </header>

    <section class="table-section">
        <% if (ventas != null && !ventas.isEmpty()) { %>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Número Factura</th>
                <th>Usuario</th>
                <th>Producto Vendido</th>
                <th>Cantidad Vendida</th>
                <th>Método de Pago</th>
                <th>Subtotal ($)</th>
                <th>IVA ($)</th>
                <th>Total ($)</th>
                <th>Fecha</th>
            </tr>
            </thead>
            <tbody>
            <% for (Venta v : ventas) { %>
            <tr>
                <td><%= v.getId() %></td>
                <td><%= v.getNumeroFactura() %></td>
                <td><%= v.getNombreUsuario() %></td>
                <td><%= v.getNombreProducto() %></td>
                <td><%= v.getCantidadVendida() %></td>
                <td><%= v.getMetodoPago() %></td>
                <td>$<%= String.format("%.2f", v.getSubtotal()) %></td>
                <td>$<%= String.format("%.2f", v.getIva()) %></td>
                <td>$<%= String.format("%.2f", v.getTotal()) %></td>
                <td><%= v.getFecha() %></td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } else { %>
        <p class="no-data">❌ No hay ventas registradas.</p>
        <% } %>
    </section>

    <footer>
        <a href="${pageContext.request.contextPath}/vistas/admin.jsp" class="btn-secondary">⬅️ Volver al Panel</a>
    </footer>
</div>
</body>
</html>
