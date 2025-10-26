<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sistemaventas.model.Producto" %>

<%
    List<Producto> inventario = (List<Producto>) request.getAttribute("inventario");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reporte de Inventario</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/reporte_inventario.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
</head>

<body>
<div class="report-container">
    <header>
        <h2>📦 Reporte de Inventario Actual</h2>
        <p>Visualiza el estado actual del inventario, precios y existencias mínimas por producto.</p>
    </header>

    <div class="acciones">
        <form action="${pageContext.request.contextPath}/ReporteServlet" method="get" class="filter-form">
            <input type="hidden" name="accion" value="pdfInventario">
            <input type="submit" value="📄 Descargar PDF" class="btn-primary">
        </form>
        <a href="${pageContext.request.contextPath}/vistas/admin.jsp" class="btn-secondary">⬅️ Volver al Panel</a>
    </div>

    <section class="results">
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Producto</th>
                <th>Categoría</th>
                <th>Precio Compra ($)</th>
                <th>Precio Venta ($)</th>
                <th>Stock</th>
                <th>Stock Mínimo</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (inventario != null && !inventario.isEmpty()) {
                    for (Producto p : inventario) {
            %>
            <tr>
                <td><%= p.getId() %></td>
                <td><%= p.getNombre() %></td>
                <td><%= p.getCategoria() %></td>
                <td>$<%= String.format("%.2f", p.getPrecioCompra()) %></td>
                <td>$<%= String.format("%.2f", p.getPrecioVenta()) %></td>
                <td><%= p.getStock() %></td>
                <td><%= p.getStockMinimo() %></td>
            </tr>
            <%      }
            } else { %>
            <tr><td colspan="7">No hay productos registrados.</td></tr>
            <% } %>
            </tbody>
        </table>
    </section>
</div>
</body>
</html>
