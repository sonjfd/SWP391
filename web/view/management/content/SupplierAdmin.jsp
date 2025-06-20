<%-- 
    Document   : SupplierAdmin
    Created on : Jun 15, 2025, 1:33:55 PM
    Author     : Admin
--%>


<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Supplier" %>
<%
    List<Supplier> list = (List<Supplier>) request.getAttribute("supplierList");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Supplier Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="container py-4">
        <h2>Supplier Management</h2>

        <!-- Table -->
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Supplier Name</th>
                    <th>Contact Name</th>
                    <th>Phone</th>
                    <th>Email</th>
                    <th>Address</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% int index = 1;
                   for (Supplier s : list) {
                %>
                <tr>
                    <td><%= index++ %></td>
                    <td><%= s.getSupplierName() %></td>
                    <td><%= s.getContactName() %></td>
                    <td><%= s.getPhone() %></td>
                    <td><%= s.getEmail() %></td>
                    <td><%= s.getAddress() %></td>
                    <td>
                        <a href="editSupplier?id=<%= s.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                        <a href="deleteSupplier?id=<%= s.getId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Xóa nhà cung cấp này?')">Delete</a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <!-- Add Button -->
        <a href="/SWP391/view/management/content/AddSupplier.jsp" class="btn btn-primary">Add Supplier</a>

       
    </body>
</html>
