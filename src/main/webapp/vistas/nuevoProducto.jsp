<%@ page import="com.sistemaventas.model.Categoria" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Nuevo Producto</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/nuevoProducto.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
</head>
<body>

<div class="form-card">
    <div class="form-header">
        <h2>Registrar Nuevo Producto</h2>
        <p>Completa la información para agregar un nuevo producto al inventario.</p>
    </div>

    <form action="${pageContext.request.contextPath}/ProductoServlet" method="post" class="form-body">
        <input type="hidden" name="accion" value="insertar">

        <!-- Columna izquierda -->
        <div class="form-column">
            <div class="form-group">
                <label>Nombre</label>
                <div class="input-box">
                    <span>🏷️</span>
                    <input type="text" name="nombre" required placeholder="Ej: Camisa Polo">
                </div>
            </div>

            <div class="form-group">
                <label>Categoría</label>
                <div class="input-box">
                    <span>📂</span>
                    <select name="id_categoria" required>
                        <option value="">-- Selecciona una categoría --</option>
                        <%
                            List<com.sistemaventas.model.Categoria> categorias =
                                    (List<com.sistemaventas.model.Categoria>) request.getAttribute("categorias");
                            if (categorias != null) {
                                for (com.sistemaventas.model.Categoria c : categorias) { %>
                        <option value="<%= c.getId() %>"><%= c.getNombre() %></option>
                        <%      }
                        }
                        %>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label>Precio Compra</label>
                <div class="input-box">
                    <span>💰</span>
                    <input type="number" step="0.01" name="precio_compra" required placeholder="0.00">
                </div>
            </div>
        </div>

        <!-- Columna derecha -->
        <div class="form-column">
            <div class="form-group">
                <label>Precio Venta</label>
                <div class="input-box">
                    <span>💵</span>
                    <input type="number" step="0.01" name="precio_venta" required placeholder="0.00">
                </div>
            </div>

            <div class="form-group">
                <label>Stock</label>
                <div class="input-box">
                    <span>📦</span>
                    <input type="number" name="stock" required placeholder="Cantidad disponible">
                </div>
            </div>

            <div class="form-group">
                <label>Stock Mínimo</label>
                <div class="input-box">
                    <span>⚠️</span>
                    <input type="number" name="stock_minimo" required placeholder="Cantidad mínima">
                </div>
            </div>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn-primary">💾 Guardar</button>
            <a href="${pageContext.request.contextPath}/ProductoServlet?accion=listar" class="btn-secondary">↩️ Cancelar</a>
        </div>
    </form>
</div>

</body>
</html>
