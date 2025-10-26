<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sistemaventas.dao.ProductoDAO" %>
<%@ page import="com.sistemaventas.model.Producto" %>

<%
    ProductoDAO daoProd = new ProductoDAO();
    List<Producto> productos = daoProd.listar();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Venta</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/ventas.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">

    <script>
        function agregarProducto() {
            const tabla = document.getElementById("detalle");
            const fila = tabla.insertRow(-1);

            const select = document.createElement("select");
            select.name = "idProducto[]";
            select.required = true;
            <% for (Producto p : productos) { %>
            select.innerHTML += "<option value='<%=p.getId()%>' data-precio='<%=p.getPrecioVenta()%>'><%=p.getNombre()%> ($<%=p.getPrecioVenta()%>)</option>";
            <% } %>

            const celdaProd = fila.insertCell(0);
            const celdaCant = fila.insertCell(1);
            const celdaPrecio = fila.insertCell(2);
            const celdaSub = fila.insertCell(3);

            celdaProd.appendChild(select);

            const inputCant = document.createElement("input");
            inputCant.type = "number";
            inputCant.name = "cantidad[]";
            inputCant.value = 1;
            inputCant.min = 1;
            inputCant.onchange = calcularTotales;
            celdaCant.appendChild(inputCant);

            const inputPrecio = document.createElement("input");
            inputPrecio.type = "number";
            inputPrecio.name = "precio[]";
            inputPrecio.value = select.options[select.selectedIndex].dataset.precio;
            inputPrecio.readOnly = true;
            celdaPrecio.appendChild(inputPrecio);

            const inputSub = document.createElement("input");
            inputSub.type = "number";
            inputSub.name = "subtotal[]";
            inputSub.value = inputPrecio.value * inputCant.value;
            inputSub.readOnly = true;
            celdaSub.appendChild(inputSub);

            select.onchange = function() {
                inputPrecio.value = select.options[select.selectedIndex].dataset.precio;
                calcularTotales();
            };

            inputCant.oninput = calcularTotales;
        }

        function calcularTotales() {
            const filas = document.querySelectorAll("#detalle tr");
            let subtotal = 0;
            filas.forEach((fila, i) => {
                if (i === 0) return;
                const cant = fila.querySelector("input[name='cantidad[]']").value;
                const precio = fila.querySelector("input[name='precio[]']").value;
                const sub = cant * precio;
                fila.querySelector("input[name='subtotal[]']").value = sub.toFixed(2);
                subtotal += sub;
            });
            const iva = subtotal * 0.13;
            const total = subtotal + iva;
            document.getElementById("subtotal").value = subtotal.toFixed(2);
            document.getElementById("iva").value = iva.toFixed(2);
            document.getElementById("total").value = total.toFixed(2);
        }
    </script>
</head>

<body>
<div class="form-card">
    <div class="form-header">
        <h2>💵 Registrar Nueva Venta</h2>
        <p>Agrega productos y genera automáticamente el total con IVA.</p>
    </div>

    <form action="${pageContext.request.contextPath}/VentaServlet" method="post" class="form-body">

        <div class="table-section">
            <table id="detalle">
                <tr>
                    <th>Producto</th>
                    <th>Cantidad</th>
                    <th>Precio Unitario ($)</th>
                    <th>Subtotal ($)</th>
                </tr>
            </table>
            <button type="button" class="btn-add" onclick="agregarProducto()">➕ Agregar Producto</button>
        </div>

        <div class="totales">
            <div class="input-group">
                <label>Subtotal:</label>
                <input type="text" id="subtotal" name="subtotal" readonly>
            </div>

            <div class="input-group">
                <label>IVA (13%):</label>
                <input type="text" id="iva" name="iva" readonly>
            </div>

            <div class="input-group">
                <label>Total:</label>
                <input type="text" id="total" name="total" readonly>
            </div>

            <div class="input-group">
                <label>Método de Pago:</label>
                <select name="metodoPago" required>
                    <option value="">Seleccione...</option>
                    <option value="Efectivo">Efectivo</option>
                    <option value="Tarjeta">Tarjeta</option>
                </select>
            </div>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn-primary">💾 Registrar Venta</button>
            <a href="${pageContext.request.contextPath}/VentaServlet?accion=listar" class="btn-secondary">📋 Ver Ventas</a>
            <a href="${pageContext.request.contextPath}/vistas/admin.jsp" class="btn-secondary">⬅️ Volver</a>
        </div>
    </form>
</div>
</body>
</html>

