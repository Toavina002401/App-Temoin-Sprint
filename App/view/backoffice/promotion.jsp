<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,dossiers.Modules.*,java.lang.Boolean" %>
<%
    String baseUrl = (String) request.getSession().getAttribute("baseUrl");
    Boolean authentifier = (Boolean) request.getSession().getAttribute("authUser");
    if (authentifier == null || !authentifier) {
      response.sendRedirect(request.getContextPath() + "/backOffice"); 
    }
%>
<!DOCTYPE html>
<html :class="{ 'theme-dark': dark }" x-data="data()" lang="en" class="theme-dark">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="shortcut icon" type="image/x-icon" href="<%= baseUrl %>/assets/frontOffice/assets/img/favicon.ico">
    <title>Promotion</title>
    <link rel="stylesheet" href="<%= baseUrl %>/assets/backOffice/public/assets/css/tailwind.output.css" />
    <script src="<%= baseUrl %>/assets/backOffice/public/assets/js/init-alpine.js"></script>
    <style>
      #styleDeconnexion{
        position: fixed;
        top: 95vh;
        left: 1vw;
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
        width: 250px;
        display: flex;
        flex-direction: column;
        transition: transform 0.2s ease-in-out;
      }
      
      .vol-card:hover {
        transform: scale(1.02);
      }
      
      .vol-card-header {
        background-color: #7E3AF2;
        color: white;
        padding: 10px 15px;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        font-weight: bold;
        font-size: 12px;
      }
      
      .vol-card-body {
        padding: 12px 15px;
        font-size: 10px;
        color: #333;
        line-height: 1.5;
      }
      
      .vol-card-footer {
        padding: 10px 15px;
        border-top: 1px solid #ddd;
        background-color: #f7f7f7;
        border-bottom-left-radius: 10px;
        border-bottom-right-radius: 10px;
        font-size: 10px;
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
    <div
      class="flex h-screen bg-gray-50 dark:bg-gray-900"
      :class="{ 'overflow-hidden': isSideMenuOpen }"
    >
      <!-- Desktop sidebar -->
      <aside class="z-20 hidden w-64 overflow-y-auto bg-white dark:bg-gray-800 md:block flex-shrink-0">
        <div class="py-4 text-gray-500 dark:text-gray-400">
          <a class="ml-6 text-lg font-bold text-gray-800 dark:text-gray-200" href="<%= baseUrl %>/backOffice/home">
            Go Trip
          </a>
          <ul class="mt-6">
            <li class="relative px-6 py-3">
              <a class="inline-flex items-center w-full text-sm font-semibold text-gray-800 transition-colors duration-150 hover:text-gray-800 dark:hover:text-gray-200 dark:text-gray-100" href="<%= baseUrl %>/backOffice/home">
                <svg
                  class="w-5 h-5"
                  aria-hidden="true"
                  fill="none"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"
                  ></path>
                </svg>
                <span class="ml-4">Accueil</span>
              </a>
            </li>
          </ul>
          <ul> 
            <li class="relative px-6 py-3">
                <span
                    class="absolute inset-y-0 left-0 w-1 bg-purple-600 rounded-tr-lg rounded-br-lg"
                    aria-hidden="true"
                ></span>
              <a
                class="inline-flex items-center w-full text-sm font-semibold transition-colors duration-150 hover:text-gray-800 dark:hover:text-gray-200"
                href="<%= baseUrl %>/backOffice/promotion"
              >
                <svg
                  class="w-5 h-5"
                  aria-hidden="true"
                  fill="none"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"
                  ></path>
                </svg>
                <span class="ml-4">Promotion</span>
              </a>
            </li>
            <li class="relative px-6 py-3">
              <a
                class="inline-flex items-center w-full text-sm font-semibold transition-colors duration-150 hover:text-gray-800 dark:hover:text-gray-200"
                href="<%= baseUrl %>/backOffice/reservation"
              >
                <svg
                  class="w-5 h-5"
                  aria-hidden="true"
                  fill="none"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"
                  ></path>
                </svg>
                <span class="ml-4">Réservation</span>
              </a>
            </li>
            <li class="relative px-6 py-3">
              <a
                class="inline-flex items-center w-full text-sm font-semibold transition-colors duration-150 hover:text-gray-800 dark:hover:text-gray-200"
                href="<%= baseUrl %>/backOffice/rechercheMultiCritere"
              >
                <svg
                  class="w-5 h-5"
                  aria-hidden="true"
                  fill="none"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    d="M15 15l-2 5L9 9l11 4-5 2zm0 0l5 5M7.188 2.239l.777 2.897M5.136 7.965l-2.898-.777M13.95 4.05l-2.122 2.122m-5.657 5.656l-2.12 2.122"
                  ></path>
                </svg>
                <span class="ml-4">Recherche multi-critère vol</span>
              </a>
            </li>
          </ul>
          <div class="px-6 my-6">
            <a
              class="flex items-center justify-between w-full px-4 py-2 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple"
              href="<%= baseUrl %>/backOffice/crudVol"
              >
              CRUD vol
              <span class="ml-2" aria-hidden="true">+</span>
            </a>
          </div>
          <div id="styleDeconnexion">
            <a
              class="inline-flex items-center w-full px-2 py-1 text-sm font-semibold transition-colors duration-150 rounded-md hover:bg-gray-100 hover:text-gray-800 dark:hover:bg-gray-800 dark:hover:text-gray-200"
              href="<%= baseUrl %>/deconnexion"
            >
              <svg
                class="w-4 h-4 mr-3"
                aria-hidden="true"
                fill="none"
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path
                  d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1"
                ></path>
              </svg>
              <span>Deconnexion</span>
            </a>
          </div>
        </div>
      </aside>


      <div id="modalBackdrop" class="fixed inset-0 z-30 flex items-end bg-black bg-opacity-50 sm:items-center sm:justify-center" style="display: none;">
        <!-- Modal -->
        <div class="w-full px-6 py-4 overflow-hidden bg-white rounded-t-lg dark:bg-gray-800 sm:rounded-lg sm:m-4 sm:max-w-xl" role="dialog" id="modal">
          <!-- Remove header if you don't want a close icon. Use modal body to place modal tile. -->
          <header class="flex justify-end">
            <button id="closeModalBtn" class="inline-flex items-center justify-center w-6 h-6 text-gray-400 transition-colors duration-150 rounded dark:hover:text-gray-200 hover:text-gray-700" aria-label="close">
              <svg
                class="w-4 h-4"
                fill="currentColor"
                viewBox="0 0 20 20"
                role="img"
                aria-hidden="true"
              >
                <path
                  d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                  clip-rule="evenodd"
                  fill-rule="evenodd"
                ></path>
              </svg>
            </button>
          </header>
          <!-- Modal body -->
          <form class="mt-4 mb-6 perso" method="post" action="<%= baseUrl %>/backOffice/promotions">
            <input type="hidden" name="idVolProm" id="idVolProm">
            <!-- Modal title -->
            <p class="mb-5 text-lg font-semibold text-gray-700 dark:text-gray-300">Ajout d'une promotion</p>
            <div id="infoDetaille" style="margin: 10px 0px;"></div>

            <label class="block mt-4 text-sm">
              <span class="text-gray-700 dark:text-gray-400">Type de siège :</span>
              <select name="idClasse" class="block w-full mt-1 text-sm dark:text-gray-300 dark:border-gray-600 dark:bg-gray-700 form-select focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray">
                <option value="1">Économique</option>
                <option value="2">Affaires</option>
                <option value="3">Première</option>
              </select>
            </label>

            <div class="mt-5 text-sm text-gray-700 dark:text-gray-400" style="margin-top:15px;">
              <div class="flex gap-4 w-full">
                <label class="block text-sm flex-1 pr-2">
                  <span class="text-gray-700 dark:text-gray-400">Nombre de siège :</span>
                  <input class="block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input" name="nbSiege" type="number" min="0" required/>
                </label>
                <label class="block text-sm flex-1 pl-2">
                  <span class="text-gray-700 dark:text-gray-400">Remise en % :</span>
                  <input class="block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input" name="remise" type="number" max="100" min="0" step="0.01" required/>
                </label>
              </div>
            </div>
            <div class="flex ">
              <p onclick="annuler()" id="annulBtn" class="mt-4 px-6 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-purple-400" style="margin-right: 15px;">Annuler</p>
              <button type="submit" id="ajoutBtn" class="mt-4 px-6 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-purple-400">Ajouter</button>
            </div>
          </form>
        </div>
      </div>



      <div class="flex flex-col flex-1 w-full">
        <header class="z-10 py-4 bg-white shadow-md dark:bg-gray-800">
          <div class="container flex items-center justify-between h-full px-6 mx-auto text-purple-600 dark:text-purple-300">
          </div>
        </header>
        <main class="h-full overflow-y-auto">
          <div class="container px-6 mx-auto grid">
            <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Configuration promotion</h2>
            <div class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md dark:bg-gray-800">
              <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200" style="margin-left: 48px;">Liste des vols en cours de disponibilité :</h2>
              <div class="vol-cards-container" id="volResultCards"></div>
            </div>
          </div>
        </main>
      </div>
    </div>

    <script>
      document.getElementById("closeModalBtn").addEventListener("click", closeModal);

      function closeModal() {
        const modalBackdrop = document.getElementById("modalBackdrop");
        modalBackdrop.style.display = "none"; 
      }

      function annuler() {
        const modalBackdrop = document.getElementById("modalBackdrop");
        modalBackdrop.style.display = "none"; 
      }

      function ajout(vol){
        const modalBackdrop = document.getElementById("modalBackdrop");
        modalBackdrop.style.display = "flex";
        const container = document.getElementById("infoDetaille");
        const input = document.getElementById("idVolProm");
        input.value = vol.idVol;
        container.innerHTML = "";
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
          '</div>' +
          '<div class="vol-card-footer">' +
            '<span><strong>Promotion :</strong></span>' +
            promoHTML +
          '</div>';

        container.appendChild(card);
      }

      function afficherVolsEnCards(vols) {
        const container = document.getElementById("volResultCards");
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
              '<span><strong>Ajouter une promotion </strong></span>' +
              '<div class="flex space-x-2 crud-perso">'+
                '<a class="text-blue-500 hover:text-green-600" style="margin-right: 15px;padding-top: 5px;cursor:pointer;" onclick=\'ajout(' + JSON.stringify(vol) + ')\'>'+
                  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="25" height="25">'+
                    '<path d="M12 5v14M5 12h14" fill="none" stroke="#16a34a" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>'+
                  '</svg>'+
                '</a>'+
              '</div>' +
              promoHTML +
            '</div>';

          container.appendChild(card);
        });
      }


      const volsExemple = [
      <% 
        Vector<Vol> vols = (Vector<Vol>) request.getAttribute("listeVols");
        Vector<Vector<Promotion>> lesPromos = (Vector<Vector<Promotion>>) request.getAttribute("lesPromos");
        if (vols != null) {
          for (int i = 0; i < vols.size(); i++) {
            Vector<Promotion> tempsPromo = lesPromos.elementAt(i);
            Vol vol = vols.get(i);
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
      }<%= (i < vols.size() - 1) ? "," : "" %>
      <% 
          }
        } 
      %>
      ];
      afficherVolsEnCards(volsExemple);
    </script>
  </body>
</html>
