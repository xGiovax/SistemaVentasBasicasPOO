<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Nuevo Proveedor</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/nuevoProveedor.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
</head>
<body>

<div class="form-card">
    <div class="form-header">
        <h2>Registrar Nuevo Proveedor</h2>
        <p>Completa la información del proveedor para agregarlo al sistema.</p>
    </div>

    <form action="${pageContext.request.contextPath}/ProveedorServlet" method="post" class="form-body">
        <div class="form-column">
            <div class="form-group">
                <label>Nombre</label>
                <div class="input-box">
                    <span>🏷️</span>
                    <input type="text" name="nombre" required placeholder="Ej: Distribuidora San José">
                </div>
            </div>

            <div class="form-group">
                <label>Contacto</label>
                <div class="input-box">
                    <span>👤</span>
                    <input type="text" name="contacto" placeholder="Nombre del contacto principal">
                </div>
            </div>
        </div>

        <div class="form-column">
            <div class="form-group">
                <label>Teléfono</label>
                <div class="input-box">
                    <span>📞</span>
                    <input type="text" name="telefono" placeholder="Ej: 2222-3333">
                </div>
            </div>

            <div class="form-group">
                <label>Correo</label>
                <div class="input-box">
                    <span>✉️</span>
                    <input type="email" name="correo" placeholder="Ej: contacto@empresa.com">
                </div>
            </div>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn-primary">💾 Guardar</button>
            <a href="${pageContext.request.contextPath}/ProveedorServlet?accion=listar" class="btn-secondary">↩️ Cancelar</a>
        </div>
    </form>
</div>

</body>
</html>
