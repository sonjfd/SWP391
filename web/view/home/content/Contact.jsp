<%-- 
    Document   : Contact
    Created on : May 22, 2025, 9:24:58 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pet24h - Liên Hệ</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="${pageContext.request.contextPath}/index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- SLIDER -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/tiny-slider.css"/>
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <style>
            .error-message {
                color: red;
                font-size: 0.9rem;
                margin-top: 4px;
            }
        </style>
    </head>
    <body>
        <%@include file="../layout/Header.jsp" %>


        <section class="section">


            <div class="container ">
                <div class="row align-items-center">

                    <!--       Modal thong bao-->
                    <div class="modal fade" id="statusModal" tabindex="-1" aria-labelledby="statusModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="statusModalLabel">Thông báo</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                </div>
                                <div class="modal-body" id="statusModalMessage">

                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Đóng</button>
                                </div>
                            </div>
                        </div>
                    </div>


                    <form id="contactForm" action="addcontact" method="post">
                        <div class="form-row">
                            <div class="form-group col-md-6 mb-3">
                                <label for="inputName">Họ Và Tên</label>
                                <input type="text" class="form-control" id="inputName14" name="name">
                            </div>
                            <div class="form-group col-md-6 mb-3">
                                <label for="inputEmail4">Email</label>
                                <input type="email" class="form-control" id="inputEmail4" name="email">
                            </div>
                            <div class="form-group col-md-6 mb-3">
                                <label for="inputPassword4">Số Điện Thoại</label>
                                <input type="text" class="form-control" id="inputPhone" name="phone">
                            </div>
                            <div class="form-group col-md-6 mb-3">
                                <label for="exampleFormControlTextarea1">Nhập Miêu Tả</label>
                                <textarea class="form-control" id="idtexttera" name="description"></textarea>
                            </div>

                        </div>
                        <button type="submit" class="btn btn-primary mt-5">Gửi thông tin</button>




                    </form>
                    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>

                    <script>
                        function getParam() {
                            const param = new URLSearchParams(window.location.search);
                            return param.get('success');
                        }

                        const success = getParam();

                        if (success === 'true' || success === 'false') {
                            var statusModal = new bootstrap.Modal(document.getElementById('statusModal'));
                            var messageElem = document.getElementById('statusModalMessage');

                            if (success === 'true') {
                                messageElem.textContent = 'Gửi liên hệ thành công! Cảm ơn bạn đã để lại thông tin';
                            } else {
                                messageElem.textContent = 'Gửi liên hệ thất bại';
                            }

                            statusModal.show();
                            if (history.replaceState) {
                                const url = new URL(window.location.href);
                                url.searchParams.delete('success');
                                window.history.replaceState(null, '', url.pathname + url.search);
                            }
                        }

                        const form = document.querySelector('form');
                        const nameInput = document.querySelector('input[name="name"]');
                        const phoneInput = document.querySelector('input[name="phone"]');
                        const emailInput = document.querySelector('input[name="email"]');
                        const descriptionInput = document.querySelector('textarea[name="description"]');

                        function createErrorElem(input) {
                            let err = input.nextElementSibling;
                            if (!err || !err.classList.contains('error-message')) {
                                err = document.createElement('div');
                                err.classList.add('error-message');
                                err.style.color = 'red';
                                err.style.fontSize = '0.9em';
                                input.parentNode.insertBefore(err, input.nextSibling);
                            }
                            return err;
                        }

                        function validatePhone() {
                            const val = phoneInput.value.trim();
                            const phonePattern = /^0\d{9}$/;
                            const errElem = createErrorElem(phoneInput);

                            if (!phonePattern.test(val)) {
                                errElem.textContent = 'Số điện thoại phải bắt đầu bằng số 0 và có đúng 10 số.';
                                return false;
                            } else {
                                errElem.textContent = '';
                                return true;
                            }
                        }

                        function validateEmail() {
                            const val = emailInput.value.trim();
                            const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                            const errElem = createErrorElem(emailInput);

                            if (!emailPattern.test(val)) {
                                errElem.textContent = 'Email phải là địa chỉ Gmail hợp lệ, ví dụ: ten@gmail.com.';
                                return false;
                            } else {
                                errElem.textContent = '';
                                return true;
                            }
                        }

                        function validateName() {
                            const val = nameInput.value.trim();
                            const errElem = createErrorElem(nameInput);

                            if (val === '') {
                                errElem.textContent = 'Họ và tên không được để trống.';
                                return false;
                            } else if (/\d/.test(val)) {
                                errElem.textContent = 'Họ và tên không được chứa số.';
                                return false;
                            } else {
                                errElem.textContent = '';
                                return true;
                            }
                        }


                        function validateDescription() {
                            const val = descriptionInput.value.trim();
                            const errElem = createErrorElem(descriptionInput);

                            if (val === '') {
                                errElem.textContent = 'Vui lòng nhập miêu tả.';
                                return false;
                            } else {
                                errElem.textContent = '';
                                return true;
                            }
                        }

                        nameInput.addEventListener('blur', validateName);
                        phoneInput.addEventListener('blur', validatePhone);
                        emailInput.addEventListener('blur', validateEmail);
                        descriptionInput.addEventListener('blur', validateDescription);

                        form.addEventListener('submit', function (e) {
                            const validName = validateName();
                            const validPhone = validatePhone();
                            const validEmail = validateEmail();
                            const validDescription = validateDescription();

                            if (!validName || !validPhone || !validEmail || !validDescription) {
                                e.preventDefault();
                            }
                        });
                    </script>


                </div><!--end row-->


            </div><!--end container-->
        </section><!--end section-->

        <%@include file="../layout/Footer.jsp" %>

        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <!-- javascript -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <!-- SLIDER -->
        <script src="${pageContext.request.contextPath}/assets/js/tiny-slider.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/tiny-slider-init.js"></script>
        <!-- Counter -->
        <script src="${pageContext.request.contextPath}/assets/js/counter.init.js"></script>
        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>
</html>
