<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inicio de Sesión | Sistema de Ventas</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Enlace al CSS externo -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/index.css">

    <!-- Fuente -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">

</head>
<body>

<div class="login-box">
    <div class="brand">💼 Sistema de Ventas</div>
    <h2>Bienvenido</h2>
    <p>Ingresa tus credenciales para continuar</p>

    <form action="LoginServlet" method="post">
        <input type="text" name="username" class="form-control" placeholder="Usuario" required>
        <input type="password" name="password" class="form-control" placeholder="Contraseña" required>
        <button type="submit" class="btn-login">Iniciar Sesión</button>
        <div class="error">${error}</div>
    </form>

    <footer>
        © 2025 Sistema de Ventas Básicas
    </footer>
</div>

</body>
</html>
