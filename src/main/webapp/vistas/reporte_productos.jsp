<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sistemaventas.model.Producto" %>

<%
    List<Producto> productos = (List<Producto>) request.getAttribute("productos");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reporte de Productos Más Vendidos</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/reporte_productos.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
</head>

<body>
<div class="report-container">
    <header>
        <h2>🏆 Reporte de Productos Más Vendidos</h2>
        <p>Consulta los productos con mayor volumen de ventas registrados en el sistema.</p>
    </header>

    <form action="${pageContext.request.contextPath}/ReporteServlet" method="get" class="filter-form">
        <input type="hidden" name="accion" id="accion" value="productosMasVendidos">

        <div class="form-actions">
            <input type="submit" value="🔍 Ver Reporte" class="btn-primary"
                   onclick="document.getElementById('accion').value='productosMasVendidos'">
            <input type="submit" value="📄 Descargar PDF" class="btn-secondary"
                   onclick="document.getElementById('accion').value='pdfProductosMasVendidos'">
        </div>
    </form>

    <% if (productos != null) { %>
    <section class="results">
        <h3>📊 Resultados</h3>
        <table>
            <thead>
            <tr>
                <th>ID Producto</th>
                <th>Nombre</th>
                <th>Cantidad Vendida</th>
                <th>Total Ingresos ($)</th>
            </tr>
            </thead>
            <tbody>
            <% for (Producto p : productos) { %>
            <tr>
                <td><%= p.getId() %></td>
                <td><%= p.getNombre() %></td>
                <td><%= p.getStock() %></td>
                <td>$<%= String.format("%.2f", p.getPrecioVenta()) %></td>
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
