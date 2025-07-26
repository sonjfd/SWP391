<%-- 
    Document   : footer.jsp
    Created on : May 21, 2025, 8:47:08 PM
    Author     : ASUS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            /* Gradient text for Pet24h */
            .logo-text {
                font-family: 'Arial', sans-serif;
                font-weight: bold;
                font-size: 24px;
                background: linear-gradient(45deg, #28a745, #007bff); /* Gradient green and blue */
                -webkit-background-clip: text;
                color: transparent;
                margin-left: 10px;
            }
        </style>
    </head>
    <body>
        <c:set var="cl" value="${sessionScope.clinicInfo}"></c:set>
            <!-- Start -->
            <footer class="bg-footer">
                <div class="container">
                    <div class="row">
                        <div class="col-xl-5 col-lg-4 mb-0 mb-md-4 pb-0 pb-md-2">
                            <a href="homepage" class="logo-footer">
                                <img src="${cl.logo}" height="50" width="50" class="">
                            <span class="logo-text">Pet24h</span>
                        </a>
                        <p class="mt-4 me-xl-5">${cl.description}</p>
                    </div><!--end col-->

                    <div class="col-xl-7 col-lg-8 col-md-12">
                        <div class="row">
                            <div class="col-md-6 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                                <ul class="list-unstyled footer-list mt-4">
                                    <li><a href="homeaboutus" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Về chúng tôi</a></li>
                                    <li><a href="homeaboutus#services" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Dịch vụ</a></li>
                                    <li><a href="homeaboutus#doctors" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i>Bác sĩ</a></li>
                                    <li><a href="homedoctor" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Tin tức</a></li>
                                    <li><a href="login" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Đăng nhập</a></li>
                                </ul>
                            </div><!--end col-->



                            <div class="col-md-6 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                                <h5 class="text-light title-dark footer-head">Liên hệ chúng tôi</h5>
                                <ul class="list-unstyled footer-list mt-4">
                                    <li class="d-flex align-items-center mb-2">
                                        <i data-feather="mail" class="fea icon-sm text-foot align-middle"></i>
                                        <a href="mailto:${cl.email}" class="text-foot ms-2">${cl.email}</a>
                                    </li>

                                    <li class="d-flex align-items-center mb-2">
                                        <i data-feather="phone" class="fea icon-sm text-foot align-middle"></i>
                                        <a href="tel:${cl.phone}" class="text-foot ms-2">${cl.phone}</a>
                                    </li>
                                    <li class="d-flex align-items-center mb-2">
                                        <i data-feather="clock" class="fea icon-sm text-foot align-middle"></i>
                                        <span  class="text-foot ms-2">${cl.workingHours}</span>
                                    </li>

                                    <li class="mb-2">
                                        <div class="d-flex align-items-center mb-1">
                                            <i data-feather="map-pin" class="fea icon-sm text-foot align-middle"></i>
                                            <span class="text-foot ms-2">Xem trên Google Map</span>
                                        </div>
                                        <iframe 
                                            src="${cl.googleMap}" 
                                            width="100%" 
                                            height="180" 
                                            style="border:0;" 
                                            allowfullscreen="" 
                                            loading="lazy" 
                                            referrerpolicy="no-referrer-when-downgrade">
                                        </iframe>
                                    </li>
                                </ul>


                                <ul class="list-unstyled social-icon footer-social mb-0 mt-4">
                                    <li class="list-inline-item"><a href="https://www.facebook.com/oquangai.426813" target="_blank" rel="noopener" class="rounded-pill"><i data-feather="facebook" class="fea icon-sm fea-social"></i></a></li>
                                    <li class="list-inline-item"><a href="https://www.instagram.com/?next=%2F" target="_blank" rel="noopener"class="rounded-pill"><i data-feather="instagram" class="fea icon-sm fea-social"></i></a></li>
                                    <li class="list-inline-item"><a href="#" class="rounded-pill"><i data-feather="twitter" class="fea icon-sm fea-social"></i></a></li>
                                    <li class="list-inline-item"><a href="#" class="rounded-pill"><i data-feather="linkedin" class="fea icon-sm fea-social"></i></a></li>
                                </ul><!--end icon-->
                            </div><!--end col-->
                        </div><!--end row-->
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->


        </footer><!--end footer-->
        <!-- End -->










    </body>
</html>

