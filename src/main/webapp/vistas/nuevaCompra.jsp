<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sistemaventas.model.Producto" %>
<%@ page import="com.sistemaventas.model.Proveedor" %>

<%
    List<Producto> productos = (List<Producto>) request.getAttribute("productos");
    List<Proveedor> proveedores = (List<Proveedor>) request.getAttribute("proveedores");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Nueva Compra</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/nuevaCompra.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
</head>
<body>

<div class="form-card">
    <div class="form-header">
        <h2>Registrar Nueva Compra</h2>
        <p>Completa los datos de la compra realizada al proveedor.</p>
    </div>

    <form action="${pageContext.request.contextPath}/CompraServlet" method="post" class="form-body">

        <!-- Columna izquierda -->
        <div class="form-column">
            <div class="form-group">
                <label>Proveedor</label>
                <div class="input-box">
                    <span>🏢</span>
                    <select name="id_proveedor" required>
                        <option value="">Seleccione...</option>
                        <% for (Proveedor prov : proveedores) { %>
                        <option value="<%=prov.getId()%>"><%=prov.getNombre()%></option>
                        <% } %>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label>Producto</label>
                <div class="input-box">
                    <span>📦</span>
                    <select name="id_producto" required>
                        <option value="">Seleccione...</option>
                        <% for (Producto p : productos) { %>
                        <option value="<%=p.getId()%>"><%=p.getNombre()%> ($<%=p.getPrecioCompra()%>)</option>
                        <% } %>
                    </select>
                </div>
            </div>
        </div>

        <!-- Columna derecha -->
        <div class="form-column">
            <div class="form-group">
                <label>Cantidad</label>
                <div class="input-box">
                    <span>🔢</span>
                    <input type="number" name="cantidad" required placeholder="Ej: 10">
                </div>
            </div>

            <div class="form-group">
                <label>Precio Unitario</label>
                <div class="input-box">
                    <span>💰</span>
                    <input type="number" name="precio_unitario" step="0.01" required placeholder="Ej: 5.50">
                </div>
            </div>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn-primary">💾 Registrar Compra</button>
            <a href="${pageContext.request.contextPath}/ProductoServlet?accion=listar" class="btn-secondary">📋 Ver Productos</a>
        </div>
    </form>
</div>

</body>
</html>
