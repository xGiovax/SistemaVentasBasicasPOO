<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sistemaventas.model.Venta" %>
<%@ page import="com.sistemaventas.model.DetalleVenta" %>

<%
    Venta venta = (Venta) request.getAttribute("venta");
    List<DetalleVenta> detalles = (List<DetalleVenta>) request.getAttribute("detalles");
    java.text.DecimalFormat df = new java.text.DecimalFormat("0.00");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ticket de Venta</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/ticket.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
</head>

<body>
<div class="ticket-card">
    <div class="ticket-header">
        <h2>🧾 Ticket de Venta</h2>
        <p>Gracias por su compra</p>
    </div>

    <div class="ticket-info">
        <p><strong>Fecha:</strong> <%= new java.util.Date() %></p>
        <p><strong>Método de Pago:</strong> <%= venta.getMetodoPago() %></p>
    </div>

    <div class="ticket-table">
        <table>
            <thead>
            <tr>
                <th>#</th>
                <th>ID Producto</th>
                <th>Cantidad</th>
                <th>Precio ($)</th>
                <th>Subtotal ($)</th>
            </tr>
            </thead>
            <tbody>
            <%
                double totalFinal = 0;
                int contador = 1;
                for (DetalleVenta d : detalles) {
                    double sub = d.getCantidad() * d.getPrecioVenta();
                    totalFinal += sub;
            %>
            <tr>
                <td><%= contador++ %></td>
                <td><%= d.getIdProducto() %></td>
                <td><%= d.getCantidad() %></td>
                <td><%= df.format(d.getPrecioVenta()) %></td>
                <td><%= df.format(sub) %></td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <div class="ticket-totales">
        <p><strong>Subtotal:</strong> $<%= df.format(venta.getSubtotal()) %></p>
        <p><strong>IVA (13%):</strong> $<%= df.format(venta.getIva()) %></p>
        <p class="total"><strong>Total:</strong> $<%= df.format(venta.getTotal()) %></p>
    </div>

    <div class="ticket-footer">
        <a href="${pageContext.request.contextPath}/vistas/admin.jsp" class="btn-secondary">⬅️ Volver al Panel</a>
    </div>
</div>
</body>
</html>
