<%--
  Created by IntelliJ IDEA.
  User: MINEDUCYT
  Date: 23/10/2025
  Time: 14:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Compra Exitosa</title></head>
<body>
<h2>✅ Compra registrada exitosamente</h2>
<a href="${pageContext.request.contextPath}/CompraServlet">Registrar otra compra</a><br>
<a href="${pageContext.request.contextPath}/ProductoServlet?accion=listar">Ver Productos</a>
</body>
</html>
