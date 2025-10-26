<<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sistemaventas.model.Compra" %>

<%
    List<Compra> compras = (List<Compra>) request.getAttribute("compras");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reporte de Compras a Proveedores</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/reporte_compras.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
</head>

<body>
<div class="report-container">
    <header>
        <h2>📦 Reporte de Compras a Proveedores</h2>
        <p>Consulta el detalle de compras realizadas a los distintos proveedores del sistema.</p>
    </header>

    <div class="acciones">
        <form action="${pageContext.request.contextPath}/ReporteServlet" method="get" class="filter-form">
            <input type="hidden" name="accion" value="pdfComprasProveedores">
            <input type="submit" value="📄 Descargar PDF" class="btn-primary">
        </form>
        <a href="${pageContext.request.contextPath}/vistas/admin.jsp" class="btn-secondary">⬅️ Volver al Panel</a>
    </div>

    <section class="results">
        <table>
            <thead>
            <tr>
                <th>ID Compra</th>
                <th>Proveedor</th>
                <th>Correo</th>
                <th>Producto</th>
                <th>Cantidad</th>
                <th>Precio Compra ($)</th>
                <th>Subtotal ($)</th>
                <th>Total ($)</th>
                <th>Fecha</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (compras != null && !compras.isEmpty()) {
                    for (Compra c : compras) {
            %>
            <tr>
                <td><%= c.getId() %></td>
                <td><%= c.getNombreProveedor() %></td>
                <td><%= c.getCorreoProveedor() != null ? c.getCorreoProveedor() : "-" %></td>
                <td><%= c.getNombreProducto() %></td>
                <td><%= c.getCantidadComprada() %></td>
                <td>$<%= String.format("%.2f", c.getPrecioCompra()) %></td>
                <td>$<%= String.format("%.2f", c.getSubtotal()) %></td>
                <td>$<%= String.format("%.2f", c.getTotal()) %></td>
                <td><%= c.getFecha() != null ? c.getFecha() : "-" %></td>
            </tr>
            <%      }
            } else { %>
            <tr><td colspan="9">No hay compras registradas.</td></tr>
            <% } %>
            </tbody>
        </table>
    </section>
</div>
</body>
</html>
