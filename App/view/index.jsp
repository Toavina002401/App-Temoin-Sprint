<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String baseUrl = (String) request.getSession().getAttribute("baseUrl");
%>

<!doctype html>
<html class="no-js" lang="zxx">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>GoTrip Réservation Vol</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="shortcut icon" type="image/x-icon" href="<%= baseUrl %>/assets/frontOffice/assets/img/favicon.ico">

		<!-- CSS here -->
        <link rel="stylesheet" href="<%= baseUrl %>/assets/frontOffice/assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%= baseUrl %>/assets/frontOffice/assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="<%= baseUrl %>/assets/frontOffice/assets/css/flaticon.css">
        <link rel="stylesheet" href="<%= baseUrl %>/assets/frontOffice/assets/css/slicknav.css">
        <link rel="stylesheet" href="<%= baseUrl %>/assets/frontOffice/assets/css/animate.min.css">
        <link rel="stylesheet" href="<%= baseUrl %>/assets/frontOffice/assets/css/magnific-popup.css">
        <link rel="stylesheet" href="<%= baseUrl %>/assets/frontOffice/assets/css/fontawesome-all.min.css">
        <link rel="stylesheet" href="<%= baseUrl %>/assets/frontOffice/assets/css/themify-icons.css">
        <link rel="stylesheet" href="<%= baseUrl %>/assets/frontOffice/assets/css/slick.css">
        <link rel="stylesheet" href="<%= baseUrl %>/assets/frontOffice/assets/css/nice-select.css">
        <link rel="stylesheet" href="<%= baseUrl %>/assets/frontOffice/assets/css/style.css">
   </head>
   <body>
        <div id="preloader-active">
            <div class="preloader d-flex align-items-center justify-content-center">
                <div class="preloader-inner position-relative">
                    <div class="preloader-circle"></div>
                    <div class="preloader-img pere-text">
                        <img src="<%= baseUrl %>/assets/frontOffice/assets/img/logo/logo.png" alt="">
                    </div>
                </div>
            </div>
        </div>


        <main>
            <!-- slider Area Start-->
            <div class="slider-area ">
                <!-- Mobile Menu -->
                <div class="slider-active">
                    <div class="single-slider hero-overly  slider-height d-flex align-items-center" data-background="<%= baseUrl %>/assets/frontOffice/assets/img/hero/h1_hero.jpg">
                        <div class="container">
                            <div class="row">
                                <div class="col-xl-9 col-lg-9 col-md-9">
                                    <div class="hero__caption">
                                        <h1>Vol dispo sur <span>GoTrip</span> </h1>
                                        <p>Comparez et réservez votre vol au meilleur prix</p>
                                    </div>
                                </div>
                            </div>
                            <!-- Search Box -->
                            <div class="row">
                                <div class="col-xl-12">
                                    <!-- form -->
                                    <form action="#" class="search-box">
                                    </form>	
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- slider Area End-->

            <!-- Support Company Start-->
            <div class="support-company-area support-padding fix">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-xl-6 col-lg-6">
                            <div class="support-location-img mb-50">
                                <img src="<%= baseUrl %>/assets/frontOffice/assets/img/service/support-img.jpg" alt="">
                                <div class="support-img-cap">
                                    <span>Depuis 2025</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-6 col-lg-6">
                            <div class="right-caption">
                                <!-- Section Tittle -->
                                <div class="section-tittle section-tittle2">
                                    <span>IT University</span>
                                    <h2>Nous sommes Go Trip <br>Réservez votre vol facilement</h2>
                                </div>
                                <div class="support-caption">
                                    <p>Réservez votre vol en toute simplicité et profitez des meilleures offres pour votre prochaine destination</p>
                                    <div class="select-suport-items">
                                    </div>
                                    <a href="#" class="btn border-btn">Réservation</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Support Company End-->
        </main>
        <!-- JS here -->
        
        <!-- All JS Custom Plugins Link Here here -->
        <script src="./assets/js/vendor/modernizr-3.5.0.min.js"></script>
        
        <!-- Jquery, Popper, Bootstrap -->
        <script src="<%= baseUrl %>/assets/frontOffice/assets/js/vendor/jquery-1.12.4.min.js"></script>
        <script src="<%= baseUrl %>/assets/frontOffice/assets/js/popper.min.js"></script>
        <script src="<%= baseUrl %>/assets/frontOffice/assets/js/bootstrap.min.js"></script>
        <!-- Jquery Mobile Menu -->
        <script src="<%= baseUrl %>/assets/frontOffice/assets/js/jquery.slicknav.min.js"></script>

        <!-- Jquery Slick , Owl-Carousel Plugins -->
        <script src="<%= baseUrl %>/assets/frontOffice/assets/js/owl.carousel.min.js"></script>
        <script src="<%= baseUrl %>/assets/frontOffice/assets/js/slick.min.js"></script>
        <!-- One Page, Animated-HeadLin -->
        <script src="<%= baseUrl %>/assets/frontOffice/assets/js/wow.min.js"></script>
        <script src="<%= baseUrl %>/assets/frontOffice/assets/js/animated.headline.js"></script>
        <script src="<%= baseUrl %>/assets/frontOffice/assets/js/jquery.magnific-popup.js"></script>

        <!-- Scrollup, nice-select, sticky -->
        <script src="<%= baseUrl %>/assets/frontOffice/assets/js/jquery.scrollUp.min.js"></script>
        <script src="<%= baseUrl %>/assets/frontOffice/assets/js/jquery.nice-select.min.js"></script>
        <script src="<%= baseUrl %>/assets/frontOffice/assets/js/jquery.sticky.js"></script>
        
        <!-- contact js -->
        <script src="<%= baseUrl %>/assets/frontOffice/assets/js/contact.js"></script>
        <script src="<%= baseUrl %>/assets/frontOffice/assets/js/jquery.form.js"></script>
        <script src="<%= baseUrl %>/assets/frontOffice/assets/js/jquery.validate.min.js"></script>
        <script src="<%= baseUrl %>/assets/frontOffice/assets/js/mail-script.js"></script>
        <script src="<%= baseUrl %>/assets/frontOffice/assets/js/jquery.ajaxchimp.min.js"></script>
        
        <!-- Jquery Plugins, main Jquery -->	
        <script src="<%= baseUrl %>/assets/frontOffice/assets/js/plugins.js"></script>
        <script src="<%= baseUrl %>/assets/frontOffice/assets/js/main.js"></script>   
    </body>
</html>