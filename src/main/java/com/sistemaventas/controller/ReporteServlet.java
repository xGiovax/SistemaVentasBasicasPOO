package com.sistemaventas.controller;

import com.sistemaventas.dao.ReporteDAO;
import com.sistemaventas.model.Compra;
import com.sistemaventas.model.Producto;
import com.sistemaventas.model.Venta;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

// Librerías para PDF
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

@WebServlet("/ReporteServlet")
public class ReporteServlet extends HttpServlet {

    ReporteDAO dao = new ReporteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        try {
            // ==========================
            // 🔹 REPORTE DE VENTAS
            // ==========================
            if ("filtrarVentas".equalsIgnoreCase(accion)) {
                String fechaInicio = request.getParameter("fechaInicio");
                String fechaFin = request.getParameter("fechaFin");

                if (fechaInicio != null && fechaFin != null && !fechaInicio.isEmpty() && !fechaFin.isEmpty()) {
                    List<Venta> ventas = dao.listarVentasPorFecha(fechaInicio, fechaFin);
                    request.setAttribute("ventas", ventas);
                } else {
                    request.setAttribute("ventas", null);
                }

                request.getRequestDispatcher("vistas/reporte_ventas.jsp").forward(request, response);
            }

            else if ("pdfVentas".equalsIgnoreCase(accion)) {
                String fechaInicio = request.getParameter("fechaInicio");
                String fechaFin = request.getParameter("fechaFin");
                List<Venta> ventas = dao.listarVentasPorFecha(fechaInicio, fechaFin);

                generarPdfBase(response, "reporte_ventas.pdf", "REPORTE DE VENTAS POR FECHA", document -> {
                    document.add(new Paragraph("Desde: " + fechaInicio + "     Hasta: " + fechaFin));
                    document.add(new Paragraph(" "));

                    PdfPTable table = crearTabla(new String[]{"Factura", "Fecha", "Usuario", "Subtotal ($)", "IVA ($)", "Total ($)"});
                    double totalGeneral = 0;

                    for (Venta v : ventas) {
                        table.addCell(v.getNumeroFactura());
                        table.addCell(v.getFecha() != null ? v.getFecha().toString() : "");
                        table.addCell(v.getNombreUsuario());
                        table.addCell(String.format("$%.2f", v.getSubtotal()));
                        table.addCell(String.format("$%.2f", v.getIva()));
                        table.addCell(String.format("$%.2f", v.getTotal()));
                        totalGeneral += v.getTotal();
                    }

                    document.add(table);
                    Paragraph totalParrafo = new Paragraph("\nTotal General: $" + String.format("%.2f", totalGeneral));
                    totalParrafo.setAlignment(Element.ALIGN_RIGHT);
                    document.add(totalParrafo);
                });
            }

            // ==========================
            // 🔹 PRODUCTOS MÁS VENDIDOS
            // ==========================
            else if ("productosMasVendidos".equalsIgnoreCase(accion)) {
                List<Producto> productos = dao.listarProductosMasVendidos();
                request.setAttribute("productos", productos);
                request.getRequestDispatcher("vistas/reporte_productos.jsp").forward(request, response);
            }

            else if ("pdfProductosMasVendidos".equalsIgnoreCase(accion)) {
                List<Producto> productos = dao.listarProductosMasVendidos();

                generarPdfBase(response, "reporte_productos_mas_vendidos.pdf", "REPORTE DE PRODUCTOS MÁS VENDIDOS", document -> {
                    PdfPTable table = crearTabla(new String[]{"ID Producto", "Nombre", "Cantidad Vendida", "Total Ingresos ($)"});

                    for (Producto p : productos) {
                        table.addCell(String.valueOf(p.getId()));
                        table.addCell(p.getNombre());
                        table.addCell(String.valueOf(p.getStock()));
                        table.addCell(String.format("$%.2f", p.getPrecioVenta()));
                    }

                    document.add(table);
                });
            }

            // ==========================
            // 🔹 REPORTE DE INVENTARIO
            // ==========================
            else if ("inventario".equalsIgnoreCase(accion)) {
                List<Producto> inventario = dao.listarInventario();
                request.setAttribute("inventario", inventario);
                request.getRequestDispatcher("vistas/reporte_inventario.jsp").forward(request, response);
            }

            else if ("pdfInventario".equalsIgnoreCase(accion)) {
                List<Producto> inventario = dao.listarInventario();

                generarPdfBase(response, "reporte_inventario.pdf", "REPORTE DE INVENTARIO ACTUAL", document -> {
                    PdfPTable table = crearTabla(new String[]{"ID", "Producto", "Categoría", "Stock", "Stock Mínimo", "Precio Venta ($)"});

                    for (Producto p : inventario) {
                        table.addCell(String.valueOf(p.getId()));
                        table.addCell(p.getNombre());
                        table.addCell(p.getCategoria());
                        table.addCell(String.valueOf(p.getStock()));
                        table.addCell(String.valueOf(p.getStockMinimo()));
                        table.addCell(String.format("$%.2f", p.getPrecioVenta()));
                    }

                    document.add(table);
                });
            }

            // ==========================
            // 🔹 REPORTE DE COMPRAS A PROVEEDORES
            // ==========================
            else if ("comprasProveedores".equalsIgnoreCase(accion)) {
                List<Compra> compras = dao.listarComprasProveedores();
                request.setAttribute("compras", compras);
                request.getRequestDispatcher("vistas/reporte_compras.jsp").forward(request, response);
            }

            else if ("pdfComprasProveedores".equalsIgnoreCase(accion)) {
                List<Compra> compras = dao.listarComprasProveedores();

                generarPdfBase(response, "reporte_compras_proveedores.pdf", "REPORTE DE COMPRAS A PROVEEDORES", document -> {
                    PdfPTable table = crearTabla(new String[]{
                            "ID Compra", "Proveedor", "Correo", "Producto", "Cantidad", "Precio Compra ($)", "Subtotal ($)", "Total ($)", "Fecha"
                    });

                    for (Compra c : compras) {
                        table.addCell(String.valueOf(c.getId()));
                        table.addCell(c.getNombreProveedor());
                        table.addCell(c.getCorreoProveedor() != null ? c.getCorreoProveedor() : "-");
                        table.addCell(c.getNombreProducto());
                        table.addCell(String.valueOf(c.getCantidadComprada()));
                        table.addCell(String.format("$%.2f", c.getPrecioCompra()));
                        table.addCell(String.format("$%.2f", c.getSubtotal()));
                        table.addCell(String.format("$%.2f", c.getTotal()));
                        table.addCell(c.getFecha() != null ? c.getFecha().toString() : "-");
                    }

                    document.add(table);
                });
            }

            // 🔹 Por defecto: abrir reporte de ventas
            else {
                request.getRequestDispatcher("vistas/reporte_ventas.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("❌ Error al generar reporte: " + e.getMessage());
        }
    }

    // ==========================
    // 🔧 MÉTODOS AUXILIARES
    // ==========================
    private void generarPdfBase(HttpServletResponse response, String fileName, String tituloTexto, PdfContent content) throws Exception {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);

        Document document = new Document(PageSize.A4, 50, 50, 70, 60);
        PdfWriter writer = PdfWriter.getInstance(document, response.getOutputStream());
        document.open();

        // 🎨 Paleta de colores del sistema
        BaseColor fondoClaro = new BaseColor(244, 233, 205); // #F4E9CD
        BaseColor oscuro = new BaseColor(3, 25, 38);         // #031926
        BaseColor verde = new BaseColor(119, 172, 162);      // #77ACA2
        BaseColor teal = new BaseColor(70, 129, 137);        // #468189;

        // 🖼️ Encabezado del PDF
        Paragraph header = new Paragraph("SISTEMA DE VENTAS BÁSICAS", new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD, oscuro));
        header.setAlignment(Element.ALIGN_LEFT);

        Paragraph titulo = new Paragraph("\n" + tituloTexto, new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD, teal));
        titulo.setAlignment(Element.ALIGN_CENTER);

        document.add(header);
        document.add(titulo);
        document.add(new Paragraph("\nFecha de generación: " + new java.util.Date(), new Font(Font.FontFamily.HELVETICA, 10)));
        document.add(new Paragraph(" ", new Font(Font.FontFamily.HELVETICA, 6)));

        // 📄 Contenido principal del reporte
        content.writeContent(document);

        // ✍️ Pie de página
        document.add(new Paragraph("\n\n__________________________________________", new Font(Font.FontFamily.HELVETICA, 8, Font.ITALIC, verde)));
        Paragraph footer = new Paragraph("Generado automáticamente por el Sistema de Ventas Básicas © 2025",
                new Font(Font.FontFamily.HELVETICA, 9, Font.ITALIC, oscuro));
        footer.setAlignment(Element.ALIGN_CENTER);
        document.add(footer);

        document.close();
    }

    private PdfPTable crearTabla(String[] headers) throws DocumentException {
        PdfPTable table = new PdfPTable(headers.length);
        table.setWidthPercentage(100);
        table.setSpacingBefore(10f);
        table.setSpacingAfter(10f);

        // Paleta del sistema
        BaseColor headerColor = new BaseColor(3, 25, 38);  // Oscuro
        BaseColor altRowColor = new BaseColor(244, 233, 205); // Fondo claro (#F4E9CD)
        BaseColor textColor = BaseColor.WHITE;

        Font headFont = new Font(Font.FontFamily.HELVETICA, 11, Font.BOLD, textColor);
        Font bodyFont = new Font(Font.FontFamily.HELVETICA, 10, Font.NORMAL, BaseColor.BLACK);

        // Encabezados
        for (String header : headers) {
            PdfPCell cell = new PdfPCell(new Phrase(header, headFont));
            cell.setBackgroundColor(headerColor);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setPadding(8);
            table.addCell(cell);
        }

        // Estilo uniforme para filas (bordes suaves)
        table.getDefaultCell().setPadding(6);
        table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
        table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);

        // ⚙️ Alternancia de color de filas al agregar desde otros métodos
        table.setHeaderRows(1);

        // Hook visual: cada fila alternará automáticamente en addCell()
        // (iText no tiene alternancia automática, pero puedes hacerlo manualmente donde agregas datos si deseas más color)
        return table;
    }



    @FunctionalInterface
    private interface PdfContent {
        void writeContent(Document document) throws Exception;
    }
}
