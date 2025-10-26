# 🛒 Sistema de Gestión de Ventas (Java EE + MVC)

Proyecto académico de **Sistema de Ventas Básicas** desarrollado con **Java EE (Jakarta)** bajo el patrón **MVC**, utilizando **JSP**, **Servlets**, y **MySQL**.

El sistema permite la **gestión completa de productos, ventas, compras, inventario y reportes** con distinción de roles de usuario.

## 🌟 Características Principales

Esta aplicación web está diseñada para el control operativo de un negocio y se centra en los siguientes módulos:

| Módulo | Funcionalidad | Roles de Acceso |
| :--- | :--- | :--- |
| **Ventas** | Registro, consulta y visualización de transacciones. | Administrador, Vendedor |
| **Inventario** | Administración del stock de productos. | Administrador |
| **Productos** | CRUD de productos, categorías y proveedores. | Administrador |
| **Compras** | Registro y visualización de compras a proveedores. | Administrador |
| **Reportes** | Generación de informes en **PDF** (Ventas, Inventario, Compras). | Administrador |
| **Usuarios** | Gestión de usuarios y roles (Admin/Vendedor). | Administrador |

### 🔑 Credenciales de Prueba

| Rol | Usuario de Prueba | Contraseña |
| :--- | :--- | :--- |
| 👨‍💼 **Administrador** | `admin` | `admin123` |
| 🧾 **Vendedor** | `vendedor` | `vendedor123` |

## 💻 Tecnologías Utilizadas

| Categoría | Tecnología | Versión / Propósito |
| :--- | :--- | :--- |
| **Backend** | **Java EE (Jakarta Servlets 6)** | Lógica del servidor (Controladores). |
| **Frontend** | **JSP (JavaServer Pages)** | Vistas y presentación de datos. |
| **Base de Datos** | **MySQL** | Servidor de base de datos relacional. |
| **Persistencia** | **JDBC** | Conexión y acceso a datos (Patrón DAO). |
| **Reportes** | **iTextPDF 5.5.13** | Librería para generar informes en formato PDF. |
| **Herramientas** | **Maven** | Gestión de dependencias (`pom.xml`) y compilación. |
| **Servidor** | **Apache Tomcat 10** | Servidor de aplicaciones. |
| **Diseño** | **HTML5 / CSS3** | Interfaz y estilos de usuario. |

---

## 🛠️ Configuración y Ejecución del Proyecto

Sigue estos pasos para poner en marcha el proyecto en tu entorno local.

### 1️⃣ Requisitos Previos

Asegúrate de tener instaladas las siguientes herramientas:

* **JDK 17** o superior.
* **Apache Tomcat 10**.
* **MySQL Server**.
* **IDE Recomendado:** IntelliJ IDEA o Eclipse.

### 2️⃣ Configuración de la Base de Datos

1.  **Crea la base de datos:**
    ```sql
    CREATE DATABASE sistemaventas;
    USE sistemaventas;
    ```
2.  **Importa el Esquema:** Ejecuta el script SQL incluido (`sistemaventas.sql`) en tu servidor MySQL. Este script creará las tablas necesarias (usuarios, roles, productos, ventas, etc.).

### 3️⃣ Configuración de la Conexión

Edita el archivo de conexión (generalmente ubicado en la carpeta `com.sistemaventas.util/`) con tus credenciales locales:

```java
private static final String URL = "jdbc:mysql://localhost:3306/sistemaventas";
private static final String USER = "root"; // Tu usuario de MySQL
private static final String PASSWORD = "tu_contraseña"; // Tu contraseña de MySQL

4️⃣ Ejecución

1- Abre el proyecto en tu IDE.

2- Ejecuta con la configuración de Tomcat Server (Local).

3- Accede a la aplicación a través de tu navegador:$$\text{http://localhost:8080/SistemaVentasBasicas/}$$

📂 Estructura del Código

El proyecto sigue el patrón de diseño Modelo-Vista-Controlador (MVC):

SistemaVentasBasicas/
├── src/main/java/com/sistemaventas/
│   ├── controller/ # Servlets (C): Lógica de negocio y enrutamiento.
│   ├── dao/        # Acceso a datos: Implementación de la capa DAO.
│   ├── model/      # Clases modelo (M): POJOs.
│   └── util/       # Clases utilitarias (Conexión, helpers).
└── src/main/webapp/
    ├── vistas/     # Páginas JSP (V): La capa de presentación.
    ├── styles/     # Archivos CSS: Estilos específicos.
    └── index.jsp   # Página de inicio de sesión.

📝 Autores y Contexto Académico

Este proyecto fue desarrollado como parte de la asignatura Programación Orientada a Objetos (POO404).

Institución: Universidad Don Bosco (UDB)
Año: 2025

Nombre del Autor                   Rol
Manuel Aaron Aleman Cruz           Desarrollador
Victor Francisco Nuñez Cruz        Desarrollador
Erika Gabriela Guevara Chicas      Desarrollador
Giovanni Alberto Ruano Martínez    Desarrollador
Eduardo Wilfredo Diaz Alvarez      Desarrollador
