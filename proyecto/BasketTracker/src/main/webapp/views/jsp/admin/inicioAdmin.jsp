<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/views/stylesheets/admin_styles.css">
    <title>Inicio Administrador | Basketracker</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<div class="thecontainer">
		<%@ include file="../headerAdmin.jsp" %>
		<div class="container-inicio">
		  <div class="recuadro">
		    <div class="navbar">
		        <div id="addCompe" class="navbar-item" onclick="showSection('addCompeSection')">
                	<i class="fa fa-plus-square"></i>
                    <span>A�adir Competici�n</span>
				</div>
                <div id="addTeam" class="navbar-item" onclick="showSection('addTeamSection')">
                    <i class="fa fa-plus-square"></i>
                    <span>A�adir Equipo</span>
                </div>
                <div id="home" class="navbar-item active" onclick="showSection('homeSection')">
                    <i class="fa fa-home" style="font-size: 19px;"></i>
                </div>
                <div id="addPlayer" class="navbar-item" onclick="showSection('addPlayerSection')">
                    <i class="fa fa-plus-square"></i>
                    <span>A�adir Jugador</span>
                </div>
                <div id="addMatch" class="navbar-item" onclick="showSection('addMatchSection')">
                    <i class="fa fa-plus-square"></i>
                    <span>A�adir Partido</span>
                </div>
		    </div>
	      </div>
	      
	      <!-- Contenedores de contenido para cada secci�n -->
          <div id="addCompeSection" class="content-section">
          <div class="container">
          	<div class="form-section">
	            <h2>A�adir Competici�n</h2>
				<form action="<%= request.getContextPath() %>/AddCompe" method="post">
	                <div class="form-group">
	                    <label for="competicion">Competici�n</label>
						<input type="text" id="competicion" name="competicion" placeholder="Nombre de la competici�n" required>
	                </div>
	                <div class="form-group save-button">
	                    <button type="submit">
	                    	<i class="fa fa-save"></i>
	                    	Guardar Competici�n
	                    </button>
	                </div>
	            </form>
	        </div>
          </div>
          </div>
          <div id="addTeamSection" class="content-section">
			<div class="container">
          	<div class="form-section">
	            <h2>A�adir Equipo</h2>
				<form action="<%= request.getContextPath() %>/AddTeam" method="post">
	                <div class="form-group">
	                    <label for="equipo">Nombre del equipo</label>
						<input type="text" id="nomTeam" name="nomTeam" placeholder="Nombre del equipo" required>
	                </div>
	                <div class="form-group">
	                    <label for="equipo">Ubicaci�n de los partidos </label>
						<input type="text" id="ubicacion" name="ubicacion" placeholder="Direcci�n" required>
	                </div>
	                 <div class="form-group">
                    	<label for="competicion">Competici�n</label>
                    	<input type="text" id="competicionEquipo" name="competicionEquipo" placeholder="Buscar competici�n" autocomplete="off" oninput="buscarCompeticion(this.value)">
                    	<div id="sugerencias" class="suggestions"> <!-- Contenedor para las sugerencias -->
                    	</div> 
                	</div>
	                <div class="form-group save-button">
	                    <button type="submit">
	                    	<i class="fa fa-save"></i>
	                    	Guardar Equipo
	                    </button>
	                </div>
	            </form>
	        </div>
          	</div>
          </div>
		  <div id="homeSection" class="content-section active">
			<h2>Inicio</h2>
			<p>Contenido de la p�gina principal...</p>
          </div>
		  <div id="addPlayerSection" class="content-section">
            <div class="container">
          	<div class="form-section">
				
				<h2>A�adir Jugador  <i id="infoButton" class="fa fa-info-circle" onclick="toggleInfoPanel(event)"></i></h2>
				
				
				<!-- Panel de informaci�n -->
				<div id="infoPanel" class="info-panel">
				    Al crear un jugador, tambi�n se a�ade un usuario nuevo asociado a este jugador. Su nombre de usuario se compone de su nombre de jugador sin espacios junto con un n�mero aleatorio entre el 1 y el 99.
				</div>

				<form action="<%= request.getContextPath() %>/AddPlayer" method="post">
	                <div class="form-group">
	                    <label for="jugador">Nombre del jugador</label>
						<input type="text" id="nomPlayer" name="nomPlayer" placeholder="Jugador" required>
	                </div>
	                 <div class="form-group">
                    	<label for="equipoJugador">Equipo</label>
                    	<input type="text" id="equipoJugador" name="equipoJugador" placeholder="Buscar equipo" autocomplete="off" oninput="buscarEquipo(this.value)">
                    	<div id="sugerenciasEquipo" class="suggestions"> <!-- Contenedor para las sugerencias -->
                    	</div> 
                	</div>
                	<div class="form-group" hidden="true">
                		<label for="idEquipoJugador">Id equipo</label>
                		<input type="number" id="idEquipoJugador" name="idEquipoJugador">
                	</div>
	                <div class="form-group save-button">
	                    <button type="submit">
	                    	<i class="fa fa-save"></i>
	                    	Guardar Jugador
	                    </button>
	                </div>
	            </form>
	        </div>
          	</div>
		  </div>
		  <div id="addMatchSection" class="content-section">
			<h2>A�adir Partido</h2>
			<p>Contenido para a�adir un partido...</p>
          </div>
	      
		</div>
	</div>
	
	<script>
        function showSection(sectionId) {
            // Ocultar todas las secciones de contenido
            var sections = document.querySelectorAll('.content-section');
            sections.forEach(function(section) {
                section.classList.remove('active');
            });

            // Mostrar la secci�n seleccionada
            document.getElementById(sectionId).classList.add('active');

            // Actualizar el estado activo en la barra de navegaci�n
            var navbarItems = document.querySelectorAll('.navbar-item');
            navbarItems.forEach(function(item) {
                item.classList.remove('active');
            });

            // Marcar como activa la secci�n seleccionada en el navbar
            var selectedNavItem = document.getElementById(sectionId.replace('Section', ''));
            selectedNavItem.classList.add('active');
        }
        
        // Obtener el valor del par�metro success de la URL
        const urlParams = new URLSearchParams(window.location.search);
        const event = urlParams.get('event');

        // Mostrar alerta si success no es null
        if (event) {
            alert(event);
        }
        
        function buscarCompeticion(termino) {
            if (termino.length === 0) {
                document.getElementById("sugerencias").innerHTML = "";
                return;
            }

            // Llamada AJAX para obtener sugerencias
            fetch('<%= request.getContextPath() %>/BuscarCompeticion?termino=' + encodeURIComponent(termino))
                .then(response => response.json())
                .then(data => {
                    var sugerenciasHTML = "";
                    data.forEach(competicion => {
                        if (competicion.nombre) {
                        	sugerenciasHTML += "<div class=\"suggestion-item\" onclick=\"seleccionarCompeticion('" + competicion.nombre + "')\">" + competicion.nombre + "</div>";

                        } else {
        					console.error('Nombre de la competici�n es nulo o indefinido', competicion);
    					}
                    });
                    document.getElementById("sugerencias").innerHTML = sugerenciasHTML;
                })
                .catch(error => console.error('Error:', error));
        }

        function seleccionarCompeticion(nombre) {
			document.getElementById("competicionEquipo").value = nombre;
			document.getElementById("sugerencias").innerHTML = "";
        }
        
        function buscarEquipo(termino) {
            if (termino.length === 0) {
                document.getElementById("sugerenciasEquipo").innerHTML = "";
                return;
            }

            // Llamada AJAX para obtener sugerencias
            fetch('<%= request.getContextPath() %>/BuscarEquipo?termino=' + encodeURIComponent(termino))
                .then(response => response.json())
                .then(data => {
                    var sugerenciasHTML = "";
                    //console.log(equipo)
                    data.forEach(equipo => {
                    	
                        if (equipo.nombreEquipo) {
                        	sugerenciasHTML += "<div class=\"suggestion-item\" onclick=\"seleccionarEquipo('" + equipo.nombreEquipo + "', '"  + equipo.idEquipo + "')\">" 
                        							+ equipo.nombreEquipo + 
                        							"<div class=\"suggestion-desc\">" +
                        								equipo.competicion + 
                        							"</div>" +
                        					   "</div>";

                        } else {
        					console.error('Nombre de la competici�n es nulo o indefinido', equipo);
    					}
                    });
                    document.getElementById("sugerenciasEquipo").innerHTML = sugerenciasHTML;
                })
                .catch(error => console.error('Error:', error));
        }
        
        function seleccionarEquipo(nombre, id) {
			document.getElementById("equipoJugador").value = nombre;
			document.getElementById("sugerenciasEquipo").innerHTML = "";
			document.getElementById("idEquipoJugador").value = id;
        }
        
        function toggleInfoPanel(event) {
            event.stopPropagation();

            var infoPanel = document.getElementById("infoPanel");
            if (infoPanel.classList.contains("open")) {
                infoPanel.classList.remove("open"); // Oculta el panel con la animaci�n
            } else {
                infoPanel.classList.add("open"); // Muestra el panel con la animaci�n
            }
        }


        
    </script>
	
</body>