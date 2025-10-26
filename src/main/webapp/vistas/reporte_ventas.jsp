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
    <title>Reporte de Ventas por Fecha</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/reporte_ventas.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
</head>

<body>
<div class="report-container">
    <header>
        <h2>📅 Reporte de Ventas por Fecha</h2>
        <p>Consulta las ventas registradas en un rango de fechas o genera un PDF detallado.</p>
    </header>

    <form action="${pageContext.request.contextPath}/ReporteServlet" method="get" class="filter-form">
        <input type="hidden" name="accion" id="accion" value="filtrarVentas">

        <div class="form-group">
            <label>Desde:</label>
            <input type="date" name="fechaInicio" id="fechaInicio" required>
        </div>

        <div class="form-group">
            <label>Hasta:</label>
            <input type="date" name="fechaFin" id="fechaFin" required>
        </div>

        <div class="form-actions">
            <input type="submit" value="🔍 Buscar" class="btn-primary"
                   onclick="document.getElementById('accion').value='filtrarVentas'">

            <input type="submit" value="📄 Descargar PDF" class="btn-secondary"
                   onclick="document.getElementById('accion').value='pdfVentas'">
        </div>
    </form>

    <% if (ventas != null) { %>
    <section class="results">
        <h3>📊 Resultados</h3>
        <table>
            <thead>
            <tr>
                <th># Factura</th>
                <th>Fecha</th>
                <th>Usuario</th>
                <th>Subtotal ($)</th>
                <th>IVA ($)</th>
                <th>Total ($)</th>
                <th>Método de Pago</th>
            </tr>
            </thead>
            <tbody>
            <% for (Venta v : ventas) { %>
            <tr>
                <td><%= v.getNumeroFactura() %></td>
                <td><%= v.getFecha() %></td>
                <td><%= v.getNombreUsuario() %></td>
                <td>$<%= String.format("%.2f", v.getSubtotal()) %></td>
                <td>$<%= String.format("%.2f", v.getIva()) %></td>
                <td>$<%= String.format("%.2f", v.getTotal()) %></td>
                <td><%= v.getMetodoPago() %></td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </section>
    <% } %>

    <footer>
        <a href="${pageContext.request.contextPath}/vistas/admin.jsp" class="btn-return">⬅️ Volver al Panel</a>
    </footer>
</div>
</body>
</html>
