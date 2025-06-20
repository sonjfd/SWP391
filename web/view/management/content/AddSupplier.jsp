<%-- 
    Document   : AddSupplier
    Created on : Jun 15, 2025, 2:32:27 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Add Supplier</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="container py-4">
        <h2>Add New Supplier</h2>
        <form action="${pageContext.request.contextPath}/addSupplier" method="post">
            <div class="mb-3">
                <label>Supplier Name: <span class="text-danger">*</span></label>
                <input type="text" name="supplier_name" id="supplier_name" class="form-control" maxlength="50" required>
                <div id="supplier_nameError" class="text-danger" style="display:none;"></div>
            </div>
            <div class="mb-3">
                <label>Contact Name: <span class="text-danger">*</span></label>
                <input type="text" name="contact_name" id="contact_name" class="form-control" maxlength="50" required>
                <div id="contact_nameError" class="text-danger" style="display:none;"></div>
            </div>
            <div class="mb-3">
                <label>Phone: <span class="text-danger">*</span></label>
                <input type="text" name="phone" id="phone" class="form-control" maxlength="50" required>
                <div id="phoneError" class="text-danger" style="display:none;"></div>
            </div>
            <div class="mb-3">
                <label>Email: <span class="text-danger">*</span></label>
                <input type="email" name="email" id="email" class="form-control" maxlength="50" required>
                <div id="emailError" class="text-danger" style="display:none;"></div>
            </div>
            <div class="mb-3">
                <label>Address: <span class="text-danger">*</span></label>
                <input type="text" name="address" id="address" class="form-control" maxlength="100" required>
                <div id="addressError" class="text-danger" style="display:none;"></div>
            </div>
            <button type="submit" class="btn btn-success">Add</button>
            <a href="/SWP391/supplier" class="btn btn-secondary">Cancel</a>
        </form>

        <script>
            function isValidPhone(phone) {
                return /^(032|033|034|035|036|037|038|039|096|097|098|086|081|082|083|084|091|090|093|089|070|079|077|076|078)\d{7}$/.test(phone);
            }

            function showError(id, message) {
                const el = document.getElementById(id + 'Error');
                if (el) {
                    el.textContent = message;
                    el.style.display = message ? 'block' : 'none';
                }
            }

            function validateTextField(id, fieldName, maxLength) {
                const val = document.getElementById(id).value.trim();
                if (!val) {
                    showError(id, `${fieldName} không được để trống!`);
                    return false;
                }
                if (val.length > 50) {
                    showError('val','Không được quá 50 ký tự');
                    return false;
                }
                showError(id, '');
                return true;
            }

             // Kiểm tra số điện thoại
            function validatePhone() {
                const phone = document.getElementById('phone').value.trim();
                if (!phone) {
                    showError('phone', 'Số điện thoại không được để trống! số phải thuộc các nhà mạng Viettel, Vinaphone, Mobiphone');
                    return false;
                }
                if (!isValidPhone(phone)) {
                    showError('phone', 'Số điện thoại không hợp lệ!');
                    return false;
                }
                showError('phone', '');
                return true;
            }

            function isValidEmail(email) {
                return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
            }

            function validateEmail() {
                const email = document.getElementById("email").value.trim();
                if (!email) {
                    showError("email", "Email không được để trống!");
                    return false;
                }
                if (email.length > 50) {
                    showError("email", "Email không được vượt quá 50 ký tự!");
                    return false;
                }
                if (!isValidEmail(email)) {
                    showError("email", "Email không hợp lệ!");
                    return false;
                }
                showError("email", "");
                return true;
            }

            function validateForm() {
                return validateTextField("supplier_name", "Tên nhà cung cấp", 50)
                        && validateTextField("contact_name", "Tên người liên hệ", 50)
                        && validatePhone()
                        && validateEmail()
                        && validateTextField("address", "Địa chỉ", 100);
            }

            document.addEventListener("DOMContentLoaded", function () {
                document.querySelector("form").addEventListener("submit", function (e) {
                    if (!validateForm()) {
                        e.preventDefault();
                    }
                });

                const fields = [
                    {id: "supplier_name", name: "Tên nhà cung cấp", max: 50},
                    {id: "contact_name", name: "Tên người liên hệ", max: 50},
                    {id: "address", name: "Địa chỉ", max: 100},
                ];

                fields.forEach(f => {
                    const el = document.getElementById(f.id);
                    if (el) {
                        el.addEventListener("blur", () => validateTextField(f.id, f.name, f.max));
                    }
                });

                document.getElementById("phone").addEventListener("blur", validatePhone);
                document.getElementById("email").addEventListener("blur", validateEmail);
            });
        </script>
    </body>
</html>