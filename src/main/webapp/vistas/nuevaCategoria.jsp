<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Nueva Categoría</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/nuevaCategoria.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
</head>
<body>

<div class="form-card">
    <div class="form-header">
        <h2>Agregar Nueva Categoría</h2>
        <p>Completa el nombre de la categoría para registrarla en el sistema.</p>
    </div>

    <form action="${pageContext.request.contextPath}/CategoriaServlet" method="post" class="form-body">
        <input type="hidden" name="accion" value="agregar">

        <div class="form-column">
            <div class="form-group">
                <label>Nombre</label>
                <div class="input-box">
                    <span>📂</span>
                    <input type="text" name="nombre" required placeholder="Ej: Electrónica, Hogar, Ropa...">
                </div>
            </div>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn-primary">💾 Guardar</button>
            <a href="CategoriaServlet?accion=listar" class="btn-secondary">↩️ Cancelar</a>
        </div>
    </form>
</div>

</body>
</html>
