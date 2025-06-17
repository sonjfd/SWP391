<%-- 
    Document   : AddCategory
    Created on : Jun 16, 2025, 11:02:57 AM
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Category</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Add New Category</h2>
    <form method="post" action="category">
        <input type="hidden" name="action" value="add">
        <div class="mb-3">
            <label>Name</label>
            <input type="text" name="name" class="form-control" required maxlength="50">
        </div>
        <div class="mb-3">
            <label>Description</label>
            <textarea name="description" class="form-control" maxlength="255"></textarea>
        </div>
        <button type="submit" class="btn btn-success">Add</button>
        <a href="category" class="btn btn-secondary">Back</a>
    </form>
</div>
</body>
</html>
