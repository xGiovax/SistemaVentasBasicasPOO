<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.sistemaventas.model.Producto" %>
<%@ page import="com.sistemaventas.model.Categoria" %>
<%@ page import="java.util.List" %>

<%
    Producto p = (Producto) request.getAttribute("producto");
    List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Producto</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/editarProducto.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
</head>
<body>

<div class="form-card">
    <div class="form-header">
        <h2>Editar Producto</h2>
        <p>Modifica los datos del producto y guarda los cambios.</p>
    </div>

    <form action="${pageContext.request.contextPath}/ProductoServlet" method="post" class="form-body">
        <input type="hidden" name="accion" value="actualizar">
        <input type="hidden" name="id" value="<%= p.getId() %>">

        <!-- Columna izquierda -->
        <div class="form-column">
            <div class="form-group">
                <label>Nombre</label>
                <div class="input-box">
                    <span>🏷️</span>
                    <input type="text" name="nombre" value="<%= p.getNombre() %>" required>
                </div>
            </div>

            <div class="form-group">
                <label>Categoría</label>
                <div class="input-box">
                    <span>📂</span>
                    <select name="id_categoria" required>
                        <option value="">-- Selecciona una categoría --</option>
                        <% for (Categoria c : categorias) { %>
                        <option value="<%= c.getId() %>"
                                <%= (p.getIdCategoria() == c.getId()) ? "selected" : "" %>>
                            <%= c.getNombre() %>
                        </option>
                        <% } %>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label>Precio Compra</label>
                <div class="input-box">
                    <span>💰</span>
                    <input type="number" step="0.01" name="precio_compra" value="<%= p.getPrecioCompra() %>" required>
                </div>
            </div>
        </div>

        <!-- Columna derecha -->
        <div class="form-column">
            <div class="form-group">
                <label>Precio Venta</label>
                <div class="input-box">
                    <span>💵</span>
                    <input type="number" step="0.01" name="precio_venta" value="<%= p.getPrecioVenta() %>" required>
                </div>
            </div>

            <div class="form-group">
                <label>Stock</label>
                <div class="input-box">
                    <span>📦</span>
                    <input type="number" name="stock" value="<%= p.getStock() %>" required>
                </div>
            </div>

            <div class="form-group">
                <label>Stock Mínimo</label>
                <div class="input-box">
                    <span>⚠️</span>
                    <input type="number" name="stock_minimo" value="<%= p.getStockMinimo() %>" required>
                </div>
            </div>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn-primary">💾 Guardar Cambios</button>
            <a href="${pageContext.request.contextPath}/ProductoServlet?accion=listar" class="btn-secondary">↩️ Cancelar</a>
        </div>
    </form>
</div>

</body>
</html>
