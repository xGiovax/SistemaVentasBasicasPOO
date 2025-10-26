<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sistemaventas.model.Categoria" %>

<%
    List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listado de Categorías</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/lista_categorias.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
</head>
<body>

<div class="container">
    <header>
        <h2>📂 Listado de Categorías</h2>
        <a href="CategoriaServlet?accion=nuevo" class="btn-primary">➕ Nueva Categoría</a>
    </header>

    <section class="table-section">
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <% if (categorias != null && !categorias.isEmpty()) {
                for (Categoria c : categorias) { %>
            <tr>
                <td><%= c.getId() %></td>
                <td><%= c.getNombre() %></td>
                <td class="acciones">
                    <a href="CategoriaServlet?accion=editar&id=<%= c.getId() %>" class="btn-edit">✏️ Editar</a>
                    <a href="CategoriaServlet?accion=eliminar&id=<%= c.getId() %>"
                       onclick="return confirm('¿Seguro que deseas eliminar esta categoría?');"
                       class="btn-delete">🗑️ Eliminar</a>
                </td>
            </tr>
            <% } } else { %>
            <tr><td colspan="3" class="no-data">No hay categorías registradas.</td></tr>
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
