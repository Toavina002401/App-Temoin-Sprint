<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,dossiers.Modules.*,java.lang.Boolean" %>
<%
    String baseUrl = (String) request.getSession().getAttribute("baseUrl");
    Vector<Aeroport> listeAeroport = (Vector<Aeroport>)request.getAttribute("listeAeroport");
    Vector<Avion> listeAvion = (Vector<Avion>)request.getAttribute("listeAvion");
    Vector<Classe> listeClasse = (Vector<Classe>)request.getAttribute("listeClasse");
    String selectedAeroportDepart = (String) request.getAttribute("selectedAeroportDepart");
    String selectedAeroportArrive = (String) request.getAttribute("selectedAeroportArrive");
    String selectedAvion = (String) request.getAttribute("selectedAvion");
    String selectedClasse = (String) request.getAttribute("selectedClasse");
    String selectedDateDepart = (String) request.getAttribute("selectedDateDepart");
    String selectedDateArrive = (String) request.getAttribute("selectedDateArrive");
    Boolean search = false;
    if (request.getAttribute("search") != null) {
        search = (Boolean) request.getAttribute("search");
    }
%>

<!doctype html>
<html class="no-js" lang="zxx">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>GoTrip Réservation Vol</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="shortcut icon" type="image/x-icon" href="<%= baseUrl %>/assets/frontOffice/assets/img/favicon.ico">
        <script src="<%= baseUrl %>/assets/backOffice/public/assets/js/init-alpine.js"></script>

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
        <style>
            form.search-box {
                background-color: rgba(255, 255, 255, 0.8) !important;
            }

            .list{
                max-height: 200px;
                overflow-y: auto !important;
            }

            .hover-perso{
                transition: background-color 0.4s ease-in-out, color 0.4s ease-in-out;
            }

            .hover-perso:hover {
                color: #fff;
                background-color:#014B85;
            }

            .custom-modal {
                display: none; /* cachée par défaut */
                position: fixed;
                z-index: 9999;
                left: 0;
                top: 0;
                width: 100vw;
                height: 100vh;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.6); /* Fond noir semi-transparent */
                justify-content: center;
                align-items: center;
            }
            
            .custom-modal-content {
                background-color: #fff;
                margin: auto;
                padding: 30px 50px;
                border-radius: 8px;
                max-width: 1500px;
                width: 90%;
                position: relative;
                animation: slideDown 0.3s ease-out;
            }
            
            .custom-modal-close {
                position: absolute;
                top: 10px;
                right: 20px;
                font-size: 24px;
                cursor: pointer;
                color: #555;
            }
            
            @keyframes slideDown {
                from {
                    transform: translateY(-50px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }

            .vol-cards-container {
                display: flex;
                flex-wrap: wrap;
                gap: 1.4rem;
                max-height: 80vh;
                overflow-y: auto;
                padding: 20px 50px;
            }
            
            .vol-card {
                background: white;
                border: 1px solid #ccc;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                width: 300px;
                display: flex;
                flex-direction: column;
                transition: transform 0.2s ease-in-out;
            }
            
            .vol-card:hover {
                transform: scale(1.02);
            }
            
            .vol-card-header {
                background-color: #014B85;
                color: white;
                padding: 10px 15px;
                border-top-left-radius: 10px;
                border-top-right-radius: 10px;
                font-weight: bold;
                font-size: 16px;
            }
            
            .vol-card-body {
                padding: 12px 15px;
                font-size: 14px;
                color: #333;
                line-height: 1.5;
            }
            
            .vol-card-footer {
                padding: 10px 15px;
                border-top: 1px solid #ddd;
                background-color: #f7f7f7;
                border-bottom-left-radius: 10px;
                border-bottom-right-radius: 10px;
                font-size: 13px;
                color: #555;
            }
            .vol-card-footer span {
                display: block;
                margin-bottom: 5px;
            }
            
            
        </style>
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
                                    </div>
                                </div>
                            </div>
                            <!-- Search Box -->
                            <div class="row">
                                <div class="col-xl-12">
                                    <!-- Formulaire de recherche -->
                                    <form class="search-box px-10 py-4 rounded shadow" id="formComponent" method="post" action="<%= baseUrl %>/frontOffice/recherche">
                                        <div class="row g-3">
                                            <!-- Aéroport de départ -->
                                            <div class="col-12 col-md-6 mt-3">
                                                <label for="departureAirport" class="form-label">Aéroport de départ</label>
                                                <select class="form-select scroolable" id="departureAirport" name="aeroportDepart">
                                                    <option value="">Sélectionnez un aéroport</option>
                                                    <% for(int i=0;i<listeAeroport.size();i++) { %>
                                                        <option value="<%= listeAeroport.elementAt(i).getId() %>" 
                                                            <%= (selectedAeroportDepart != null && selectedAeroportDepart.equals(listeAeroport.elementAt(i).getId())) ? "selected" : "" %>>
                                                            <%= listeAeroport.elementAt(i).getVille() %> (<%= listeAeroport.elementAt(i).getCode_iata() %>)
                                                        </option>
                                                    <% } %>
                                                </select>
                                            </div>
                                            <!-- Aéroport d'arrivée -->
                                            <div class="col-md-6 mt-3">
                                                <label for="arrivalAirport" class="form-label">Aéroport d'arrivée</label>
                                                <select class="form-select" id="arrivalAirport" name="aeroportArrive">
                                                    <option value="">Sélectionnez un aéroport</option>
                                                    <% for(int i=0;i<listeAeroport.size();i++) { %>
                                                        <option value="<%= listeAeroport.elementAt(i).getId() %>" 
                                                            <%= (selectedAeroportArrive != null && selectedAeroportArrive.equals(listeAeroport.elementAt(i).getId())) ? "selected" : "" %>>
                                                            <%= listeAeroport.elementAt(i).getVille() %> (<%= listeAeroport.elementAt(i).getCode_iata() %>)
                                                        </option>
                                                    <% } %>
                                                </select>
                                            </div>
                                            <!-- Avion -->
                                            <div class="col-12 col-md-6 mt-3">
                                                <label for="airplane" class="form-label">Avion</label>
                                                <select class="form-select" id="airplane" name="avion">
                                                    <option value="">Tous les avions</option>
                                                    <% for(int i=0;i<listeAvion.size();i++) { %>
                                                        <option value="<%= listeAvion.elementAt(i).getId() %>" 
                                                            <%= (selectedAvion != null && selectedAvion.equals(listeAvion.elementAt(i).getId())) ? "selected" : "" %>>
                                                            <%= listeAvion.elementAt(i).getModele() %> (<%= listeAvion.elementAt(i).getCode_avion() %>)
                                                        </option>
                                                    <% } %>
                                                </select>
                                            </div>
                                            <!-- Classe -->
                                            <div class="col-12 col-md-6 mt-3">
                                                <label for="flightClass" class="form-label">Classe</label>
                                                <select class="form-select" id="flightClass" name="classe">
                                                    <option value="">Toutes les classes</option>
                                                    <% for(int i=0;i<listeClasse.size();i++) { %>
                                                        <option value="<%= listeClasse.elementAt(i).getId() %>" 
                                                            <%= (selectedClasse != null && selectedClasse.equals(listeClasse.elementAt(i).getId())) ? "selected" : "" %>>
                                                            <%= listeClasse.elementAt(i).getNom() %>
                                                        </option>
                                                    <% } %>
                                                </select>
                                            </div>
                                            <!-- Date de départ -->
                                            <div class="col-12 col-md-4 mt-4">
                                                <label for="departureDate" class="form-label">Date de départ</label>
                                                <input type="date" class="form-control" id="departureDate" name="dateDepart" value="<%= (selectedDateDepart != null) ? selectedDateDepart : "" %>">
                                            </div>
                                            
                                            <div class="col-12 col-md-4 mt-4">
                                                <div class="d-flex justify-content-center mt-3">
                                                    <button class="btn border-btn hover-perso" type="submit">Rechercher des vols</button>
                                                </div>
                                            </div>
                                            <!-- Date d'arrivée -->
                                            <div class="col-12 col-md-4 mt-4">
                                                <label for="arrivalDate" class="form-label">Date d'arrivée</label>
                                                <input type="date" class="form-control" id="arrivalDate" name="dateArrive" value="<%= (selectedDateArrive != null) ? selectedDateArrive : "" %>">
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- slider Area End-->

            <!-- Modal -->
            <div id="customModal" class="custom-modal">
                <div class="custom-modal-content">
                    <span class="custom-modal-close" id="customModalClose">&times;</span>
                    <h2>Résultats des vols</h2>
                    <div class="vol-cards-container" id="volResultCards">
                        <!-- Les cartes dynamiques seront injectées ici -->
                    </div>
                </div>
            </div>
            <!-- Fin Modal -->

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

        <script>
            // Ouvrir la modale avec contenu
            function showCustomModal(content) {
                document.getElementById("customModalBody").innerHTML = content;
                document.getElementById("customModal").style.display = "flex";
            }

            // Fermer la modale
            document.getElementById("customModalClose").onclick = function () {
                document.getElementById("customModal").style.display = "none";
            };

            // Fermer si on clique en dehors
            window.onclick = function (event) {
                const modal = document.getElementById("customModal");
                if (event.target === modal) {
                    modal.style.display = "none";
                }
            };

            function afficherVolsEnCards(vols) {
                const container = document.getElementById("volResultCards");
                container.innerHTML = "";
            
                vols.forEach(vol => {
                    const card = document.createElement("div");
                    card.className = "vol-card";
            
                    card.innerHTML =
                    '<div class="vol-card-header">' +
                        vol.departVille + ' <span style="font-size: 8px;">(' + vol.departCode + ')</span> → ' + vol.arriveeVille + ' <span style="font-size: 8px;">(' + vol.arriveeCode + ')</span>' +
                    '</div>' +
                    '<div class="vol-card-body">' +
                        '<div><strong>Départ :</strong> ' + vol.dateDepart + '</div>' +
                        '<div><strong>Arrivée :</strong> ' + vol.dateArrivee + '</div>' +
                        '<div><strong>Avion :</strong> ' + vol.avionModele + ' (' + vol.avionCode + ')</div>' +
                    '</div>' +
                    '<div class="vol-card-footer">' +
                        '<span><strong>Délai réservation :</strong> ' + vol.delaiReservation + 'h</span>' +
                        '<span><strong>Délai annulation :</strong> ' + vol.delaiAnnulation + 'h</span>' +
                    '</div>';
            
                    container.appendChild(card);
                });
            }

            if (<%= search %>) {
                const volsExemple = [
                <% 
                    Vector<Vol> vols = (Vector<Vol>) request.getAttribute("listeVols");
                    if (vols != null) {
                        for (int i = 0; i < vols.size(); i++) {
                            Vol vol = vols.get(i);
                            String departVille = vol.getAeroport_depart().getVille();
                            String departCode = vol.getAeroport_depart().getCode_iata();
                            String arriveeVille = vol.getAeroport_arrivee().getVille();
                            String arriveeCode = vol.getAeroport_arrivee().getCode_iata();
                            String dateDepart = vol.getDate_depart();
                            String dateArrivee = vol.getDate_arrivee();
                            String avionModele = vol.getAvion().getModele();
                            String avionCode = vol.getAvion().getCode_avion();
                            int delaiReservation = vol.getDelai_reservation_heures();
                            int delaiAnnulation = vol.getDelai_annulation_heures();
                %>
                {
                    departVille: "<%= departVille %>",
                    departCode: "<%= departCode %>",
                    arriveeVille: "<%= arriveeVille %>",
                    arriveeCode: "<%= arriveeCode %>",
                    dateDepart: "<%= dateDepart %>",
                    dateArrivee: "<%= dateArrivee %>",
                    avionModele: "<%= avionModele %>",
                    avionCode: "<%= avionCode %>",
                    delaiReservation: <%= delaiReservation %>,
                    delaiAnnulation: <%= delaiAnnulation %>
                }<%= (i < vols.size() - 1) ? "," : "" %>
                <% 
                        }
                    } 
                %>
            ];
                afficherVolsEnCards(volsExemple);
                document.getElementById("customModal").style.display = "flex";
            }
        </script>

        
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