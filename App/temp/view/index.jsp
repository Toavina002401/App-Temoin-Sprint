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
    Boolean dispo = false;
    Boolean confirmer = false;
    if (request.getAttribute("search") != null) {
        search = (Boolean) request.getAttribute("search");
    }

    if (request.getAttribute("dispo") != null) {
        dispo = (Boolean) request.getAttribute("dispo");
    }

    if (request.getAttribute("confirmer") != null) {
        confirmer = (Boolean) request.getAttribute("confirmer");
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

            .custom-modal,
            .custom-modal-Reservation,
            .custom-modal-Confirmation,
            .custom-modal-FormReservation {
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

            .custom-modal-content-FormReservation,
            .custom-modal-content-Confirmation {
                background-color: #fff;
                margin: auto;
                padding: 30px 50px;
                border-radius: 8px;
                max-width: 1500px;
                width: 40%;
                position: relative;
                animation: slideDown 0.3s ease-out;
            }
            
            .custom-modal-content,
            .custom-modal-content-Reservation {
                background-color: #fff;
                margin: auto;
                padding: 30px 50px;
                border-radius: 8px;
                max-width: 1500px;
                width: 90%;
                position: relative;
                animation: slideDown 0.3s ease-out;
            }
            
            .custom-modal-close,
            .custom-modal-close-Reservation,
            .custom-modal-close-FormReservation,
            .custom-modal-close-Confirmation
            {
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

            .vol-cards-container,
            .vol-cards-container-Reservation {
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
            
            .crud-perso{
                float: right;
                margin-top: -30px;
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
                                        <h1>Les vols sur <span>GoTrip</span> </h1>
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
                                                    <option value="">Tous les aéroports</option>
                                                    <% for(int i=0;i<listeAeroport.size();i++) { %>
                                                        <option value="<%= listeAeroport.elementAt(i).getId() %>" <%= (selectedAeroportDepart != null && selectedAeroportDepart.equals(String.valueOf(listeAeroport.elementAt(i).getId()))) ? "selected" : "" %>>
                                                            <%= listeAeroport.elementAt(i).getVille() %> (<%= listeAeroport.elementAt(i).getCode_iata() %>)
                                                        </option>
                                                    <% } %>
                                                </select>
                                            </div>
                                            <!-- Aéroport d'arrivée -->
                                            <div class="col-md-6 mt-3">
                                                <label for="arrivalAirport" class="form-label">Aéroport d'arrivée</label>
                                                <select class="form-select" id="arrivalAirport" name="aeroportArrive">
                                                    <option value="">Tous les aéroports</option>
                                                    <% for(int i=0;i<listeAeroport.size();i++) { %>
                                                        <option value="<%= listeAeroport.elementAt(i).getId() %>" 
                                                            <%= (selectedAeroportArrive != null && selectedAeroportArrive.equals(String.valueOf(listeAeroport.elementAt(i).getId()))) ? "selected" : "" %>>
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
                                                            <%= (selectedAvion != null && selectedAvion.equals(String.valueOf(listeAvion.elementAt(i).getId()))) ? "selected" : "" %>>
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
                                                            <%= (selectedClasse != null && selectedClasse.equals(String.valueOf(listeClasse.elementAt(i).getId()))) ? "selected" : "" %>>
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

            <!-- Modal Réservation -->
            <div id="customModal-Reservation" class="custom-modal-Reservation">
                <div class="custom-modal-content-Reservation">
                    <span class="custom-modal-close-Reservation" id="customModalClose-Reservation">&times;</span>
                    <h2>Résultats des vols disponnibles pour une réservation</h2>
                    <div class="vol-cards-container-Reservation" id="volResultCards-Reservation">
                        <!-- Les cartes dynamiques seront injectées ici -->
                    </div>
                </div>
            </div>
            <!-- Fin Modal -->

            <!-- Modal formulaire de réservation -->
            <div id="customModal-FormReservation" class="custom-modal-FormReservation">
                <div class="custom-modal-content-FormReservation">
                    <span class="custom-modal-close-FormReservation" id="customModalClose-FormReservation">&times;</span>
                    <h2>Formulaire d'une réservation d'un vol</h2>
                    <div id="infoDetaille" style="margin: 10px 0px;"></div>
                    <form class="row g-3" action="<%=baseUrl %>/frontOffice/reserver" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="idVolRes" id="idVolRes">
                        <!-- Nom du client -->
                        <div class="col-12 col-md-6 mt-3">
                            <label for="nomClient" class="form-label">Info du client :</label>
                            <input type="text" class="form-control" id="nomClient" name="nomClient" placeholder="Nom du client..." required>
                        </div>
                        <!-- Prénom du client -->
                        <div class="col-12 col-md-6 mt-3">
                            <label for="prenomClient" class="form-label">...</label>
                            <input type="text" class="form-control" id="prenomClient" name="prenomClient" placeholder="Prénom du client...">
                        </div>
                        <!-- Chemin du passport -->
                        <div class="col-12 col-md-12 mt-3">
                            <label for="passport" class="form-label">Insérer ici votre passport :</label>
                            <input type="file" class="form-control" id="passport" name="passport" style="border:none !important;" required> 
                        </div>
                        <!-- Classe -->
                        <div class="col-12 col-md-12 mt-3">
                            <label for="ClassReservation" class="form-label">Classe</label>
                            <select class="form-select" id="ClassReservation" name="ClassReservation">
                                <% for(int i=0;i<listeClasse.size();i++) { %>
                                    <option value="<%= listeClasse.elementAt(i).getId() %>">
                                        <%= listeClasse.elementAt(i).getNom() %>
                                    </option>
                                <% } %>
                            </select>
                        </div>

                        <!-- Personnel -->
                        <div class="col-12 col-md-12 mt-3">
                            <label class="form-label">Personnel :</label>

                            <!-- Bébé -->
                            <div class="d-flex align-items-center mb-2">
                                <span class="me-3" style="width: 30%;padding-left: 40px;">Bébé (- 2 ans)</span>
                                <button type="button" class="btn btn-outline-secondary btn-sm" onclick="changerValeur('bebe', -1)" style="padding: 20px 25px !important;">-</button>
                                <input type="text" id="bebe" name="bebe" value="0" min="0" class="form-control mx-2" style="width:200px;text-align:center;">
                                <button type="button" class="btn btn-outline-secondary btn-sm" onclick="changerValeur('bebe', 1)" style="padding: 20px 23px !important;">+</button>
                            </div>

                            <!-- Enfant -->
                            <div class="d-flex align-items-center mb-2">
                                <span class="me-3" style="width: 30%;padding-left: 40px;">Enfant (2 à 16 ans)</span>
                                <button type="button" class="btn btn-outline-secondary btn-sm" onclick="changerValeur('enfant', -1)" style="padding: 20px 25px !important;">-</button>
                                <input type="text" id="enfant" name="enfant" value="0" min="0" class="form-control mx-2" style="width:200px;text-align:center;">
                                <button type="button" class="btn btn-outline-secondary btn-sm" onclick="changerValeur('enfant', 1)" style="padding: 20px 23px !important;">+</button>
                            </div>

                            <!-- Adulte -->
                            <div class="d-flex align-items-center">
                                <span class="me-3" style="width: 30%;padding-left: 40px;">Adulte (+ 16 ans)</span>
                                <button type="button" class="btn btn-outline-secondary btn-sm" onclick="changerValeur('adulte', -1)" style="padding: 20px 25px !important;">-</button>
                                <input type="text" id="adulte" name="adulte" value="0" min="0" class="form-control mx-2" style="width:200px;text-align:center;">
                                <button type="button" class="btn btn-outline-secondary btn-sm" onclick="changerValeur('adulte', 1)" style="padding: 20px 23px !important;">+</button>
                            </div>
                        </div>
                        <div class="col-12 col-md-12 mt-4">
                            <div class="d-flex justify-content-center">
                                <p class="btn border-btn hover-perso" style="margin-right: 60px;" onclick="annulation()">Annuler</p>
                                <button class="btn border-btn hover-perso" type="submit">Réserver</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <!-- Fin Modal -->

            <!-- Modal de confirmation -->
            <div id="customModal-Confirmation" class="custom-modal-Confirmation">
                <div class="custom-modal-content-Confirmation">
                    <span class="custom-modal-close-Confirmation" id="customModalClose-Confirmation">&times;</span>
                    <h2>Réservation confirmée avec succès.</h2>
                    <div id="infoDetaille-Confirmation" style="margin: 10px 0px;"></div>
                    <h5>Plus de détail:</h5>
                    <div class="col-12 col-md-12">
                        <p>Date du réservation : <span id="dateReservationConfirmation"><span></p>
                    </div>
                    <div class="col-12 col-md-12">
                        <p>Cher(e) client(e) : <span id="clientConfirmation"><span></p>
                    </div>
                    <div class="row">
                        <div class="col-12 col-md-4">
                            <p>Classe réservée : <span id="cabine"><span></p>
                        </div>
                        <div class="col-12 col-md-8">
                            <p>Montant total (avec/sans promotion) : <span id="prixcabine"><span></p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 col-md-4">
                            <p id="bebeConfirmation" style="font-size: 0.9rem;"></p>
                        </div>
                        <div class="col-12 col-md-4">
                            <p id="enfantConfirmation" style="font-size: 0.9rem;"></p>
                        </div>
                        <div class="col-12 col-md-4">
                            <p id="adulteConfirmation" style="font-size: 0.9rem;"></p>
                        </div>
                    </div>
                    <div class="col-12 col-md-12">
                        <p>Montant final de la réservation : <strong id="smtotalConfirmation"><strong></p>
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
                                    <button onclick="reserver()" class="btn border-btn hover-perso">Réservation</button>
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
            function changerValeur(id, delta) {
                let input = document.getElementById(id);
                let value = parseInt(input.value) || 0;
                value += delta;
                if (value < 0) value = 0;
                input.value = value;
            }

            function reserver(){
                window.location.href = "<%= baseUrl %>/frontOffice/dispo";
            }

            function annulation(){
                document.getElementById("customModal-FormReservation").style.display = "none";
            }

            function reserverVol(vol){
                document.getElementById("customModal-FormReservation").style.display = "flex";
                const container = document.getElementById("infoDetaille");
                container.innerHTML = "";
                const input = document.getElementById("idVolRes");
                input.value = vol.idVol;
                const card = document.createElement("div");
                card.className = "vol-card";

                // Étoile si au moins une promotion
                const star = vol.promotions && vol.promotions.length > 0 
                    ? ' ⭐' 
                    : '';

                // Liste des promotions
                let promoHTML = "";
                if (vol.promotions && vol.promotions.length > 0) {
                    promoHTML += '<div class="promo-list">';
                    vol.promotions.forEach(promo => {
                    promoHTML += 
                        '<div style="font-size: 9px; margin-bottom: 1px;">' +
                        '<strong>' + promo.idClasse + '</strong> : ' +
                        promo.pourcentage + '% (' + promo.nbSieges + ' sièges)' +
                        '</div>';
                    });
                    promoHTML += '</div>';
                }

                card.innerHTML =
                    '<div class="vol-card-header">' +
                    vol.departVille + ' <span style="font-size: 8px;">(' + vol.departCode + ')</span> → ' +
                    vol.arriveeVille + ' <span style="font-size: 8px;">(' + vol.arriveeCode + ')</span>' +
                    ' <span style="font-size: 10px;float: inline-end;">' + star + '</span>' +
                    '</div>' +
                    '<div class="vol-card-body">' +
                    '<div><strong>Départ :</strong> ' + vol.dateDepart + '</div>' +
                    '<div><strong>Arrivée :</strong> ' + vol.dateArrivee + '</div>' +
                    '<div><strong>Avion :</strong> ' + vol.avionModele + ' (' + vol.avionCode + ')</div>' +
                    '<div><strong>Montant :</strong></div>' +
                    '<div style="font-size: 0.5rem;">'+
                        '<div><span>Économique :</span>'+vol.economie+' AR</div>' +
                        '<div><span>Affaires :</span>'+vol.affaire+' AR</div>' +
                        '<div><span>Première :</span>'+vol.premiere+' AR</div>' +
                    '</div>' +
                    '</div>' +
                    '<div class="vol-card-footer">' +
                    '<span><strong>Promotion: </strong></span>' +
                    promoHTML +
                    '</div>';
                container.appendChild(card);
            }

            // Ouvrir la modale avec contenu
            function showCustomModal(content) {
                document.getElementById("customModalBody").innerHTML = content;
                document.getElementById("customModal").style.display = "flex";
            }

            // Fermer la modale
            document.getElementById("customModalClose").onclick = function () {
                document.getElementById("customModal").style.display = "none";
            };

            // Fermer la modale reservation
            document.getElementById("customModalClose-Reservation").onclick = function () {
                document.getElementById("customModal-Reservation").style.display = "none";
            };

            // Fermer la modale du formulaire de reservation
            document.getElementById("customModalClose-FormReservation").onclick = function () {
                document.getElementById("customModal-FormReservation").style.display = "none";
            };

            // Fermer la modale du confirmation
            document.getElementById("customModalClose-Confirmation").onclick = function () {
                document.getElementById("customModal-Confirmation").style.display = "none";
            };

            // Fermer si on clique en dehors
            window.onclick = function (event) {
                const modal = document.getElementById("customModal");
                const modalReservation = document.getElementById("customModal-Reservation");
                const modalFormReservation = document.getElementById("customModal-FormReservation");
                const modalConfirmation = document.getElementById("customModal-Confirmation");
                if (event.target === modal) {
                    modal.style.display = "none";
                }
                if (event.target === modalReservation) {
                    modalReservation.style.display = "none";
                }
                if (event.target === modalFormReservation) {
                    modalFormReservation.style.display = "none";
                }
                if (event.target === modalConfirmation) {
                    modalConfirmation.style.display = "none";
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

            function afficherVolsEnCardsReservation(vols) {
                const container = document.getElementById("volResultCards-Reservation");
                container.innerHTML = "";

                vols.forEach(vol => {
                const card = document.createElement("div");
                card.className = "vol-card";

                // Étoile si au moins une promotion
                const star = vol.promotions && vol.promotions.length > 0 
                    ? ' ⭐' 
                    : '';

                // Liste des promotions
                let promoHTML = "";
                if (vol.promotions && vol.promotions.length > 0) {
                    promoHTML += '<div class="promo-list">';
                    vol.promotions.forEach(promo => {
                    promoHTML += 
                        '<div style="font-size: 9px; margin-bottom: 1px;">' +
                        '<strong>' + promo.idClasse + '</strong> : ' +
                        promo.pourcentage + '% (' + promo.nbSieges + ' sièges)' +
                        '</div>';
                    });
                    promoHTML += '</div>';
                }

                card.innerHTML =
                    '<div class="vol-card-header">' +
                    vol.departVille + ' <span style="font-size: 8px;">(' + vol.departCode + ')</span> → ' +
                    vol.arriveeVille + ' <span style="font-size: 8px;">(' + vol.arriveeCode + ')</span>' +
                    ' <span style="font-size: 10px;float: inline-end;">' + star + '</span>' +
                    '</div>' +
                    '<div class="vol-card-body">' +
                    '<div><strong>Départ :</strong> ' + vol.dateDepart + '</div>' +
                    '<div><strong>Arrivée :</strong> ' + vol.dateArrivee + '</div>' +
                    '<div><strong>Avion :</strong> ' + vol.avionModele + ' (' + vol.avionCode + ')</div>' +
                    '<div><strong>Montant :</strong></div>' +
                    '<div style="font-size: 0.5rem;">'+
                        '<div><span>Économique :</span>'+vol.economie+' AR</div>' +
                        '<div><span>Affaires :</span>'+vol.affaire+' AR</div>' +
                        '<div><span>Première :</span>'+vol.premiere+' AR</div>' +
                    '</div>' +
                    '</div>' +
                    '<div class="vol-card-footer">' +
                    '<span><strong>Promotion: </strong></span>' +
                    '<div class="flex space-x-2 crud-perso">'+
                        '<a class="text-blue-500 hover:text-blue-700" style="margin-right: 15px;cursor:pointer;" onclick=\'reserverVol('+ JSON.stringify(vol)+')\'>'+
                            '<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 24 24" aria-labelledby="titleReserve" role="img">'+
                            '<title id="titleReserve">Réservation de vol</title>'+
                            '<rect x="1.5" y="3.5" width="21" height="17" rx="2.2" fill="#ffffff" stroke="#0ea5e9" stroke-width="1.25"/>'+
                            '<circle cx="1.5" cy="8.5" r="0.9" fill="#ffffff" stroke="#0ea5e9" stroke-width="1.25"/>'+
                            '<circle cx="1.5" cy="15.5" r="0.9" fill="#ffffff" stroke="#0ea5e9" stroke-width="1.25"/>'+
                            '<rect x="3.2" y="4.6" width="17.6" height="3.0" rx="0.8" fill="#0ea5e9" />'+
                            '<path d="M7.3 13.6c-.1-.3.1-.7.5-.8l4.1-1.6c.3-.1.7 0 .9.2l2.1 1.8 1.0-.4c.4-.2.8 0 .9.4.1.4-.1.8-.5 1.0l-3.0 1.6c-.4.2-.9.2-1.3 0l-2.1-1.1-2.1 1.1c-.3.1-.7.1-1.0-.1-.4-.2-.6-.6-.5-1.0l.0.0z" fill="#0369a1"/>'+
                            '<circle cx="18" cy="15.5" r="3.0" fill="#10b981"/>'+
                            '<path d="M16.3 15.5l.9.9 2.0-2.2" fill="none" stroke="#ffffff" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round"/>'+
                           ' </svg>'+
                        '</a>'+
                    '</div>'+
                    promoHTML +
                    '</div>';

                container.appendChild(card);
                });
            }

            function afficheDetails(detailComplet){
                const container = document.getElementById("infoDetaille-Confirmation");
                container.innerHTML = "";
                const card = document.createElement("div");
                card.className = "vol-card";

                // Étoile si au moins une promotion
                const star = detailComplet.sespromotion && detailComplet.sespromotion.length > 0 
                    ? ' ⭐' 
                    : '';

                // Liste des promotions
                let promoHTML = "";
                if (detailComplet.sespromotion && detailComplet.sespromotion.length > 0) {
                    promoHTML += '<div class="promo-list">';
                    detailComplet.sespromotion.forEach(promo => {
                    promoHTML += 
                        '<div style="font-size: 9px; margin-bottom: 1px;">' +
                        '<strong>' + promo.id_classe + '</strong> : ' +
                        promo.pourcentage + '% (' + promo.nb_sieges + ' sièges)' +
                        '</div>';
                    });
                    promoHTML += '</div>';
                }

                card.innerHTML =
                    '<div class="vol-card-header">' +
                    detailComplet.vol.aeroport_depart.ville + ' <span style="font-size: 8px;">(' + detailComplet.vol.aeroport_depart.code_iata + ')</span> → ' +
                    detailComplet.vol.aeroport_arrivee.ville + ' <span style="font-size: 8px;">(' + detailComplet.vol.aeroport_arrivee.code_iata + ')</span>' +
                    ' <span style="font-size: 10px;float: inline-end;">' + star + '</span>' +
                    '</div>' +
                    '<div class="vol-card-body">' +
                    '<div><strong>Départ :</strong> ' + detailComplet.vol.date_depart + '</div>' +
                    '<div><strong>Arrivée :</strong> ' + detailComplet.vol.date_arrivee + '</div>' +
                    '<div><strong>Avion :</strong> ' + detailComplet.vol.avion.modele + ' (' + detailComplet.vol.avion.code_avion + ')</div>' +
                    '<div><strong>Montant :</strong></div>' +
                    '<div style="font-size: 0.5rem;">'+
                        '<div><span>Économique :</span>'+detailComplet.vol.economie+' AR</div>' +
                        '<div><span>Affaires :</span>'+detailComplet.vol.affaire+' AR</div>' +
                        '<div><span>Première :</span>'+detailComplet.vol.premiere+' AR</div>' +
                    '</div>' +
                    '</div>' +
                    '<div class="vol-card-footer">' +
                    '<span><strong>Promotion: </strong></span>' +
                    promoHTML +
                    '</div>';
                container.appendChild(card);

                document.getElementById("dateReservationConfirmation").innerHTML = detailComplet.date_reservation;
                document.getElementById("clientConfirmation").innerHTML = detailComplet.clients;
                document.getElementById("cabine").innerHTML = detailComplet.id_classe;
                document.getElementById("prixcabine").innerHTML = detailComplet.prixFinaleClasse + " AR";
                document.getElementById("smtotalConfirmation").innerHTML = detailComplet.prixTotal + " AR";

                const frs = detailComplet.filleReservation; 
                const prixPerso = detailComplet.prixFinalPersonnel;

                function getPhrase(personnelCode) {
                    const fr = frs.find(f => f.personnel === personnelCode);
                    const labels = { 10: "Bébé", 100: "Enfant", 1000: "Adulte" };
                    
                    const nbSieges = fr ? fr.nb_sieges : 0;
                    const prix = prixPerso[personnelCode.toString()] || 0;
                    const label = labels[personnelCode] || "";
                    
                    return label + " (" + nbSieges + " siège" + (nbSieges > 1 ? "s" : "") + ") : " + prix.toLocaleString() + " AR";
                }


                document.getElementById("bebeConfirmation").innerHTML = getPhrase(10);
                document.getElementById("enfantConfirmation").innerHTML = getPhrase(100);
                document.getElementById("adulteConfirmation").innerHTML = getPhrase(1000);
            }

            if (<%= dispo %>){
                const volsExemple = [
                <% 
                    Vector<Vol> volsReservations = (Vector<Vol>) request.getAttribute("listeVolsReservation");
                    Vector<Vector<Promotion>> lesPromos = (Vector<Vector<Promotion>>) request.getAttribute("lesPromos");
                    if (volsReservations != null) {
                        for (int i = 0; i < volsReservations.size(); i++) {
                            Vector<Promotion> tempsPromo = lesPromos.elementAt(i);
                            Vol vol = volsReservations.get(i);
                            int idVol = vol.getId();
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
                            double economie = vol.getEconomie();
                            double affaire = vol.getAffaire();
                            double premiere = vol.getPremiere();
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
                    delaiAnnulation: <%= delaiAnnulation %>,
                    idVol: "<%= idVol %>",
                    economie: "<%= economie %>",
                    affaire: "<%= affaire %>",
                    premiere: "<%= premiere %>",
                    promotions: [
                    <% for (int p = 0; p < tempsPromo.size(); p++) { 
                        Promotion promo = tempsPromo.get(p);
                        String classe = "";
                        if (promo.getIdClasse() == 1) {
                            classe = "Économique";
                        } else if (promo.getIdClasse() == 2) {
                            classe = "Affaires";
                        } else if (promo.getIdClasse() == 3) {
                            classe = "Première";
                        }
                    %>
                        {
                        id: <%= promo.getId() %>,
                        pourcentage: <%= promo.getPourcentage() %>,
                        idClasse: "<%= classe %>",
                        nbSieges: <%= promo.getNbSieges() %>
                        }<%= (p < tempsPromo.size() - 1) ? "," : "" %>
                    <% } %>
                    ]
                }<%= (i < volsReservations.size() - 1) ? "," : "" %>
                <% 
                    }
                    } 
                %>
            ];
                afficherVolsEnCardsReservation(volsExemple);
                document.getElementById("customModal-Reservation").style.display = "flex";
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

            if (<%= confirmer %>){
                const detailComplet = [
                <% 
                    DetailReservation details = (DetailReservation) request.getAttribute("detailReservation");
                    if (details != null) {
                        Vol volDetail = details.getVol();
                        String cls = "";
                        if (details.getId_classe() == 1) {
                            cls = "Économique";
                        } else if (details.getId_classe() == 2) {
                            cls = "Affaires";
                        } else if (details.getId_classe() == 3) {
                            cls = "Première";
                        }
                %>
                {
                    date_reservation: "<%= details.getDate_reservation() %>",
                    clients: "<%= details.getClients() %>",
                    chemin_passport: "<%= details.getChemin_passport() %>",
                    id_classe: "<%= cls %>",
                    
                    vol: {
                        id: <%= volDetail.getId() %>,
                        date_depart: "<%= volDetail.getDate_depart() %>",
                        date_arrivee: "<%= volDetail.getDate_arrivee() %>",
                        delai_reservation_heures: <%= volDetail.getDelai_reservation_heures() %>,
                        delai_annulation_heures: <%= volDetail.getDelai_annulation_heures() %>,
                        aeroport_depart: {
                            id: <%= volDetail.getAeroport_depart().getId() %>,
                            ville: "<%= volDetail.getAeroport_depart().getVille() %>",
                            code_iata: "<%= volDetail.getAeroport_depart().getCode_iata() %>"
                        },
                        aeroport_arrivee: {
                            id: <%= volDetail.getAeroport_arrivee().getId() %>,
                            ville: "<%= volDetail.getAeroport_arrivee().getVille() %>",
                            code_iata: "<%= volDetail.getAeroport_arrivee().getCode_iata() %>"
                        },
                        avion: {
                            id: <%= volDetail.getAvion().getId() %>,
                            modele: "<%= volDetail.getAvion().getModele() %>",
                            code_avion: "<%= volDetail.getAvion().getCode_avion() %>"
                        },
                        economie:<%= volDetail.getEconomie() %>,
                        affaire:<%= volDetail.getAffaire() %>,
                        premiere:<%= volDetail.getPremiere() %>
                    },

                    filleReservation: [
                        <% 
                        Vector<FilleReservation> frs = details.getFilleReservation();
                        for (int i = 0; i < frs.size(); i++) {
                            FilleReservation fr = frs.get(i);
                        %>
                        {
                            personnel: <%= fr.getPersonnel() %>,
                            nb_sieges: <%= fr.getNb_sieges() %>
                        }<%= (i < frs.size() - 1) ? "," : "" %>
                        <% } %>
                    ],

                    sespromotion: [
                        <% 
                        Vector<Promotion> promos = details.getSespromotion();
                        for (int i = 0; i < promos.size(); i++) {
                            Promotion p = promos.get(i);
                            String classe = "";
                            if (p.getIdClasse() == 1) {
                                classe = "Économique";
                            } else if (p.getIdClasse() == 2) {
                                classe = "Affaires";
                            } else if (p.getIdClasse() == 3) {
                                classe = "Première";
                            }
                        %>
                        {
                            id: <%= p.getId() %>,
                            pourcentage: <%= p.getPourcentage() %>,
                            id_classe: "<%= classe %>",
                            id_vol: <%= p.getIdVol() %>,
                            nb_sieges: <%= p.getNbSieges() %>
                        }<%= (i < promos.size() - 1) ? "," : "" %>
                        <% } %>
                    ],

                    prixFinaleClasse: <%= details.getPrixFinaleClasse() %>,
                    prixFinalPersonnel: {
                        <% 
                        Map<Integer, Double> prixMap = details.getPrixFinalPersonnel();
                        int count = 0;
                        for (Map.Entry<Integer, Double> entry : prixMap.entrySet()) {
                        %>
                        <%= entry.getKey() %>: <%= entry.getValue() %><%= (++count < prixMap.size()) ? "," : "" %>
                        <% } %>
                    },
                    prixTotal: <%= details.getPrixTotal() %>
                }
                <% } %>
                ];
                afficheDetails(detailComplet[0]);
                document.getElementById("customModal-Confirmation").style.display = "flex";
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