<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.sistemaventas.model.Categoria" %>

<%
    Categoria c = (Categoria) request.getAttribute("categoria");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Categoría</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/editarCategoria.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
</head>
<body>

<div class="form-card">
    <div class="form-header">
        <h2>✏️ Editar Categoría</h2>
        <p>Modifica el nombre de la categoría y guarda los cambios.</p>
    </div>

    <form action="${pageContext.request.contextPath}/CategoriaServlet" method="post" class="form-body">
        <input type="hidden" name="accion" value="actualizar">
        <input type="hidden" name="id" value="<%= c.getId() %>">

        <div class="form-column">
            <div class="form-group">
                <label>Nombre</label>
                <div class="input-box">
                    <span>📂</span>
                    <input type="text" name="nombre" value="<%= c.getNombre() %>" required>
                </div>
            </div>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn-primary">💾 Guardar Cambios</button>
            <a href="CategoriaServlet?accion=listar" class="btn-secondary">↩️ Cancelar</a>
        </div>
    </form>
</div>

</body>
</html>
