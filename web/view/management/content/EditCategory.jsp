<%-- 
    Document   : EditCategory
    Created on : Jun 16, 2025, 11:03:19 AM
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Model.Category" %>
<%
    Category c = (Category) request.getAttribute("category");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Category</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Edit Category</h2>
    <form method="post" action="category">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= c.getCategoryId() %>">
        <div class="mb-3">
            <label>Name</label>
            <input type="text" name="name" value="<%= c.getCategoryName() %>" class="form-control" required maxlength="50">
        </div>
        <div class="mb-3">
            <label>Description</label>
            <textarea name="description" class="form-control"><%= c.getDescription() %></textarea>
        </div>
        <button type="submit" class="btn btn-warning">Update</button>
        <a href="category" class="btn btn-secondary">Back</a>
    </form>
</div>
</body>
</html>