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
    <title>Gestión de Productos</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/listaProductos.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
</head>
<body>

<div class="container">
    <header>
        <h2>📦 Lista de Productos</h2>
        <a href="${pageContext.request.contextPath}/ProductoServlet?accion=nuevo" class="btn-primary">➕ Nuevo Producto</a>
    </header>

    <section class="table-section">
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Categoría</th>
                <th>Precio Compra</th>
                <th>Precio Venta</th>
                <th>Stock</th>
                <th>Stock Mínimo</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <% if (productos != null && !productos.isEmpty()) {
                for (Producto p : productos) { %>
            <tr>
                <td><%= p.getId() %></td>
                <td><%= p.getNombre() %></td>
                <td><%= p.getCategoria() != null ? p.getCategoria() : "Sin categoría" %></td>
                <td>$<%= p.getPrecioCompra() %></td>
                <td>$<%= p.getPrecioVenta() %></td>
                <td><%= p.getStock() %></td>
                <td><%= p.getStockMinimo() %></td>
                <td class="acciones">
                    <a href="${pageContext.request.contextPath}/ProductoServlet?accion=editar&id=<%= p.getId() %>" class="btn-edit">✏️ Editar</a>
                    <a href="${pageContext.request.contextPath}/ProductoServlet?accion=eliminar&id=<%= p.getId() %>"
                       onclick="return confirm('¿Seguro que deseas eliminar este producto?')"
                       class="btn-delete">🗑️ Eliminar</a>
                </td>
            </tr>
            <% } } else { %>
            <tr><td colspan="8" class="no-data">No hay productos registrados.</td></tr>
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
