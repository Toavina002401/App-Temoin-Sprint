<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,dossiers.Modules.*,java.lang.Boolean" %>
<%
  String baseUrl = (String) request.getSession().getAttribute("baseUrl");
  Boolean authentifier = (Boolean) request.getSession().getAttribute("authUser");
  if (authentifier == null || !authentifier) {
    response.sendRedirect(request.getContextPath() + "/backOffice"); 
  }
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
<!DOCTYPE html>
<html :class="{ 'theme-dark': dark }" x-data="data()" lang="en" class="theme-dark">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="shortcut icon" type="image/x-icon" href="<%= baseUrl %>/assets/frontOffice/assets/img/favicon.ico">
    <title>Recherche multi critere d'un vol</title>
    <link rel="stylesheet" href="<%= baseUrl %>/assets/backOffice/public/assets/css/tailwind.output.css" />
    <script src="<%= baseUrl %>/assets/backOffice/public/assets/js/init-alpine.js"></script>
    <style>
      #styleDeconnexion{
        position: fixed;
        top: 95vh;
        left: 1vw;
      }
      
      .flex-perso{
        display: flex;
        justify-content: center;
        gap: 50px;
      }

      .flex-perso-btn{
        display: flex;
        justify-content: center;
        gap: 20px;
        margin-top: 20px;
        padding-bottom: 30px;
      }

      .flex-perso label{
        width: 45%;
      }

      .flex-perso-btn label , 
      .flex-perso-btn button{
        width: 30.3%;
      }

      .flex-perso-btn button{
        height: 53px;
        margin-top: 17px;
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
    </style>
  </head>
  <body>
    <div class="flex h-screen bg-gray-50 dark:bg-gray-900" :class="{ 'overflow-hidden': isSideMenuOpen }">
      <!-- Desktop sidebar -->
      <aside class="z-20 hidden w-64 overflow-y-auto bg-white dark:bg-gray-800 md:block flex-shrink-0">
        <div class="py-4 text-gray-500 dark:text-gray-400">
          <a class="ml-6 text-lg font-bold text-gray-800 dark:text-gray-200" href="<%= baseUrl %>/backOffice/home">Go Trip</a>
          <ul class="mt-6">
            <li class="relative px-6 py-3">
              <a
                class="inline-flex items-center w-full text-sm font-semibold text-gray-800 transition-colors duration-150 hover:text-gray-800 dark:hover:text-gray-200 dark:text-gray-100"
                href="<%= baseUrl %>/backOffice/home"
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
                    d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"
                  ></path>
                </svg>
                <span class="ml-4">Accueil</span>
              </a>
            </li>
          </ul>
          <ul> 
            <li class="relative px-6 py-3">
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
                <span
                class="absolute inset-y-0 left-0 w-1 bg-purple-600 rounded-tr-lg rounded-br-lg"
                aria-hidden="true"
                ></span>
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

      <div class="flex flex-col flex-1 w-full">
        <header class="z-10 py-4 bg-white shadow-md dark:bg-gray-800">
          <div class="container flex items-center justify-between h-full px-6 mx-auto text-purple-600 dark:text-purple-300"></div>
        </header>
        <main class="h-full overflow-y-auto">
          <div class="container px-6 mx-auto grid">
            <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Recherche multi-critère d'un vol</h2>
            <form class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md dark:bg-gray-800" method="post" action="<%= baseUrl %>/backOffice/recherche">
              <div class="flex-perso">
                <label class="block mt-4 text-sm">
                  <span class="text-gray-700 dark:text-gray-400">Aéroport de départ</span>
                  <select class="block w-full mt-1 text-sm dark:text-gray-300 dark:border-gray-600 dark:bg-gray-700 form-select focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray" name="aeroportDepart">
                    <option value="">Sélectionnez un aéroport</option>
                    <% for(int i=0;i<listeAeroport.size();i++) { %>
                      <option value="<%= listeAeroport.elementAt(i).getId() %>" <%= (selectedAeroportDepart != null && selectedAeroportDepart.equals(String.valueOf(listeAeroport.elementAt(i).getId()))) ? "selected" : "" %>>
                        <%= listeAeroport.elementAt(i).getVille() %> (<%= listeAeroport.elementAt(i).getCode_iata() %>)
                      </option>
                    <% } %>
                  </select>
                </label>

                <label class="block mt-4 text-sm">
                  <span class="text-gray-700 dark:text-gray-400">Aéroport d'arrivée</span>
                  <select class="block w-full mt-1 text-sm dark:text-gray-300 dark:border-gray-600 dark:bg-gray-700 form-select focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray" name="aeroportArrive">
                    <option value="">Sélectionnez un aéroport</option>
                    <% for(int i=0;i<listeAeroport.size();i++) { %>
                      <option value="<%= listeAeroport.elementAt(i).getId() %>" 
                        <%= (selectedAeroportArrive != null && selectedAeroportArrive.equals(String.valueOf(listeAeroport.elementAt(i).getId()))) ? "selected" : "" %>>
                        <%= listeAeroport.elementAt(i).getVille() %> (<%= listeAeroport.elementAt(i).getCode_iata() %>)
                      </option>
                    <% } %>
                  </select>
                </label>
              </div>

              <div class="flex-perso">
                <label class="block mt-4 text-sm">
                  <span class="text-gray-700 dark:text-gray-400">Avion</span>
                  <select class="block w-full mt-1 text-sm dark:text-gray-300 dark:border-gray-600 dark:bg-gray-700 form-select focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray" name="avion">
                    <option value="">Tous les avions</option>
                    <% for(int i=0;i<listeAvion.size();i++) { %>
                      <option value="<%= listeAvion.elementAt(i).getId() %>" 
                        <%= (selectedAvion != null && selectedAvion.equals(String.valueOf(listeAvion.elementAt(i).getId()))) ? "selected" : "" %>>
                        <%= listeAvion.elementAt(i).getModele() %> (<%= listeAvion.elementAt(i).getCode_avion() %>)
                      </option>
                    <% } %>
                  </select>
                </label>

                <label class="block mt-4 text-sm">
                  <span class="text-gray-700 dark:text-gray-400">Classe</span>
                  <select class="block w-full mt-1 text-sm dark:text-gray-300 dark:border-gray-600 dark:bg-gray-700 form-select focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray" name="classe">
                    <option value="">Toutes les classes</option>
                    <% for(int i=0;i<listeClasse.size();i++) { %>
                      <option value="<%= listeClasse.elementAt(i).getId() %>" 
                        <%= (selectedClasse != null && selectedClasse.equals(String.valueOf(listeClasse.elementAt(i).getId()))) ? "selected" : "" %>>
                        <%= listeClasse.elementAt(i).getNom() %>
                      </option>
                    <% } %>
                  </select>
                </label>
              </div>

              <div class="flex-perso-btn">
                <label class="block text-sm">
                  <span class="text-gray-700 dark:text-gray-400">Date de départ</span>
                  <input class="block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input" type="date" name="dateDepart" value="<%= (selectedDateDepart != null) ? selectedDateDepart : "" %>"/>
                </label>

                <button class="flex items-center justify-center w-full px-4 py-2 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple">
                  Rechercher des vols
                </button>

                <label class="block text-sm">
                  <span class="text-gray-700 dark:text-gray-400">Date d'arrivée</span>
                  <input class="block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input" type="date" name="dateArrive" value="<%= (selectedDateArrive != null) ? selectedDateArrive : "" %>"/>
                </label>
              </div>
            </form>
            <div class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md dark:bg-gray-800">
              <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200" style="margin-left: 48px;">Résultats des vols</h2>
                <div class="vol-cards-container" id="volResultCards">
                </div>
            </div>
          </div>
        </main>
      </div>
    </div>


    <script>
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
      }
    </script>
  </body>
</html>
