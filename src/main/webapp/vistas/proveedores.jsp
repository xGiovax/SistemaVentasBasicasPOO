<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.sistemaventas.model.Proveedor" %>
<%
    List<Proveedor> lista = (List<Proveedor>) request.getAttribute("lista");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Proveedores</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/proveedores.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
</head>
<body>

<div class="container">
    <header>
        <h2>Listado de Proveedores</h2>
        <a href="ProveedorServlet?accion=nuevo" class="btn-primary">➕ Nuevo Proveedor</a>
    </header>

    <section class="table-section">
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Contacto</th>
                <th>Teléfono</th>
                <th>Correo</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <% if (lista != null && !lista.isEmpty()) {
                for (Proveedor p : lista) { %>
            <tr>
                <td><%= p.getId() %></td>
                <td><%= p.getNombre() %></td>
                <td><%= p.getContacto() %></td>
                <td><%= p.getTelefono() %></td>
                <td><%= p.getCorreo() %></td>
                <td class="acciones">
                    <a href="ProveedorServlet?accion=editar&id=<%= p.getId() %>" class="btn-edit">✏️ Editar</a>
                    <a href="ProveedorServlet?accion=eliminar&id=<%= p.getId() %>"
                       onclick="return confirm('¿Seguro que deseas eliminar este proveedor?')"
                       class="btn-delete">🗑️ Eliminar</a>
                </td>
            </tr>
            <% } } else { %>
            <tr><td colspan="6" class="no-data">No hay proveedores registrados.</td></tr>
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
