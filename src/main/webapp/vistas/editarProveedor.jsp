<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.sistemaventas.model.Proveedor" %>
<%
    Proveedor p = (Proveedor) request.getAttribute("proveedor");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Proveedor</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/editarProveedor.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
</head>
<body>

<div class="form-card">
    <div class="form-header">
        <h2>Editar Proveedor</h2>
        <p>Modifica los datos del proveedor y guarda los cambios.</p>
    </div>

    <form action="${pageContext.request.contextPath}/ProveedorServlet" method="post" class="form-body">
        <input type="hidden" name="id" value="<%= p.getId() %>">
        <input type="hidden" name="accion" value="actualizar">

        <div class="form-column">
            <div class="form-group">
                <label>Nombre</label>
                <div class="input-box">
                    <span>🏷️</span>
                    <input type="text" name="nombre" value="<%= p.getNombre() %>" required>
                </div>
            </div>

            <div class="form-group">
                <label>Contacto</label>
                <div class="input-box">
                    <span>👤</span>
                    <input type="text" name="contacto" value="<%= p.getContacto() %>">
                </div>
            </div>
        </div>

        <div class="form-column">
            <div class="form-group">
                <label>Teléfono</label>
                <div class="input-box">
                    <span>📞</span>
                    <input type="text" name="telefono" value="<%= p.getTelefono() %>">
                </div>
            </div>

            <div class="form-group">
                <label>Correo</label>
                <div class="input-box">
                    <span>✉️</span>
                    <input type="email" name="correo" value="<%= p.getCorreo() %>">
                </div>
            </div>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn-primary">💾 Guardar Cambios</button>
            <a href="${pageContext.request.contextPath}/ProveedorServlet?accion=listar" class="btn-secondary">↩️ Cancelar</a>
        </div>
    </form>
</div>

</body>
</html>
