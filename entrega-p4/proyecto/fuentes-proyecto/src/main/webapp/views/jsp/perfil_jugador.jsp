<%@ page import="clasesDAO.*" %>
<%@ page import="clasesVO.*" %>
<%@ page import="java.util.List" %>
<%@ page session="true" %>

<%
    // Recuperar el objeto UsuarioVO de la sesi�n
    UsuarioVO usuario = (UsuarioVO) session.getAttribute("usuario");
    // Comprobar si el usuario est� autenticado
    if (usuario == null) {
        // Redirigir a la p�gina de login si no hay un usuario autenticado
        response.sendRedirect(request.getContextPath() + "/views/jsp/login.jsp");
        return;
    }
    
    JugadorVO jugadorVO = (JugadorVO) session.getAttribute("jugadorSeleccionado");

    if (jugadorVO == null) {
    	response.sendRedirect(request.getContextPath() + "/views/jsp/favoritos.jsp");
        return;
    }
    
    boolean esFavorito = JugadorDAO.existeJugador(usuario.getNombreUsuario());
    esFavorito = esFavorito && usuario.getNombreUsuario().equals(jugadorVO.getNombreUsuario());%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/views/stylesheets/stylesheet.css">
    <title><%= jugadorVO.getNombreJugador() %>| Basketracker</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<div class="thecontainer">
	<%@ include file="header-buscador.jsp" %>
	<div class="container-jugador">
		<div class="recuadro">
		    <div class="navbar">
		        <div class="navbar-item active" onClick="window.location.href='<%= request.getContextPath() %>/views/jsp/inicio.jsp'">
		        	<img src="https://img.icons8.com/?size=100&id=131&format=png&color=FFFFFF" alt="Buscar">
		            <span><b>Buscar</b></span>
		        </div>
		        <div class="navbar-item" onClick="window.location.href='<%= request.getContextPath() %>/views/jsp/favoritos.jsp'">
		            <img src="https://img.icons8.com/?size=100&id=84925&format=png&color=000000" alt="Favoritos">
		            <span>Favoritos</span>
		        </div>
		        <div class="navbar-item" onClick="window.location.href='<%= request.getContextPath() %>/views/jsp/mensajes.jsp'">
		            <img src="https://img.icons8.com/?size=100&id=87193&format=png&color=000000" alt="Mensajes">
		            <span>Mensajes</span>
		        </div>
		    </div>	    
	    </div>
	    <div class="info-perfiles">
		    <div class="proximos-partidos">
			    <div class="partido-container">
			        <div class="partido-proximos-partidos">
			            <h3>Pr�ximos Partidos</h3>
			            <%
			            List<PartidoVO> partidos =  PartidoDAO.obtenerProximosPartidosPorEquipo(jugadorVO.getEquipo());
			            Integer i = 0;
			            	for (PartidoVO partido : partidos) {
				            	if (partido != null && !partidos.isEmpty() && i != 4 ) {
				 					i++;
				 					if (partido != null) {
				            			EquipoVO equipolocal = EquipoDAO.obtenerEquipoPorId(partido.getEquipoLocal());

			            %>
			            <div class="partido-card" onclick="guardarPartido('<%= partido.getIdPartido() %>')">
					        <div class="partido-fecha">
					            <span><%= partido.formatFecha() %></span>
					        </div>
					        <div class="partido-info">
					            <p><strong><%= EquipoDAO.obtenerEquipoPorId(partido.getEquipoLocal()).getNombreEquipo() %> VS <%= EquipoDAO.obtenerEquipoPorId(partido.getEquipoVisitante()).getNombreEquipo() %></strong></p>
					            <p><%= partido.formatHora() %></p>
					            <p><%= equipolocal.getUbicacion() %></p>
					        </div>
					        <div class="partido-ubicacion">
					            <img src="https://img.icons8.com/?size=100&id=342&format=png&color=000000" alt="Ubicaci�n Icono">
					            <p>Ubicaci�n</p>
					        </div>
					    </div>
					    <% }}} %>
			        </div>
			    </div>
		    </div>
		   	<div class="datos-jugador">
		        <div class="profile-header">
			        <div class="banner">
			            <img src="<%= request.getContextPath() %>/views/images/banner.png" alt="Banner Image">
			            <% if (esFavorito) { %>
			            <button class="editar-perfil-btn <%= esFavorito ? "active" : "" %>"  onclick="window.location.href='<%= request.getContextPath() %>/views/jsp/editar_perfil.jsp'" >Editar Perfil</button> 
			        	<% } %>
			        </div>
			        <div class="profile-content">
			            <div class="profile-details">
			                <h1><%= jugadorVO.getNombreJugador() %></h1>
			                <p>@<%= jugadorVO.getNombreUsuario() %></p>
			            </div>
			            <div class="profile-picture">
			                <img src="https://img.icons8.com/?size=100&id=11795&format=png&color=000000" alt="Profile Picture <%= jugadorVO.getNombreJugador() %>">
			            </div>
			            <div class="jugadores-seguidores">
			                 <button class="jugador-follow-btn" 
							        data-id="<%= jugadorVO.getNombreUsuario() %>"
							        data-tipo="jugador"
							        data-favorito="<%= JugadorFavDAO.esFavorito(usuario.getNombreUsuario(), jugadorVO.getNombreUsuario()) %>">
							    <i class="fa fa-star<%= JugadorFavDAO.esFavorito(usuario.getNombreUsuario(), jugadorVO.getNombreUsuario()) ? "" : "-o" %>"></i><strong><%= JugadorFavDAO.esFavorito(usuario.getNombreUsuario(), jugadorVO.getNombreUsuario()) ? "Seguido" : "Seguir" %></strong>
							</button>
			                 <button class="jugador-seguidores-btn"><strong><%= JugadorFavDAO.contarSeguidores(jugadorVO.getNombreUsuario()) %> seguidores</strong></button>
			            </div>
			            <% EquipoVO equipoVO = EquipoDAO.obtenerEquipoPorId(jugadorVO.getEquipo()); %>
			            <div class="team" onclick="verMasEquipo('<%= equipoVO.getIdEquipo() %>')">
			            	<img src="https://img.icons8.com/?size=100&id=t7crGJINSAvv&format=png&color=000000" alt="Escudo <%= equipoVO.getNombreEquipo() %>" onclick="verMasEquipo('<%= equipoVO.getIdEquipo() %>')">
			                <h2><%= equipoVO.getNombreEquipo() %></h2>
			            </div>
			        </div>
			    </div>
		        <div class="jugador-stats-container">
		            <div class="jugador-last-game">
		                <h3>�ltimo Partido</h3>
						<div class="jugador-last-game-info">
							<%
			                PartidoVO partidoVO = PartidoDAO.obtenerUltimoPartidoPorJugador(jugadorVO);
								if (partidoVO != null) {
									PtsJugParVO ptsjugparVO = PtsJugParDAO.obtenerPtsJugPar(partidoVO.getIdPartido(), jugadorVO.getNombreUsuario());
									if (ptsjugparVO != null) {
							%>
			                <div class="jugador-game-info">
			                    <div class="jugador-score">
			                        <span class="jugador-points">PTS</span>
			                        <span class="jugador-score-value"><%= ptsjugparVO.getPtsAnt() %></span>
			                    </div>
			                    <div class="jugador-minutes">
			                        <span>MIN</span>
			                        <span class="jugador-minutes-value"><%= ptsjugparVO.getMntJd() %></span>
			                    </div>
			                </div>
			                <div class="jugador-date-loc">
				                <div class="jugador-date">
				                    <p class="jugador-fecha"><%= partidoVO.formatFecha() %></p>
				                    <p><%= partidoVO.formatHora() %></p>
				                </div>
				                <div class="jugador-loc">
				                    <img src="https://img.icons8.com/?size=100&id=342&format=png&color=000000" alt="Ubicaci�n Icono">
				                    <p>Ubicaci�n</p>
			                    </div>
			                </div>
			                <div class="jugador-location">
			                	
			                    <p><%= EquipoDAO.obtenerEquipoPorId(partidoVO.getEquipoLocal()).getNombreEquipo() %> VS <%= EquipoDAO.obtenerEquipoPorId(partidoVO.getEquipoVisitante()).getNombreEquipo() %></p>
			                    <div class="jugador-scoreboard">
			                    	<img src="https://img.icons8.com/?size=100&id=t7crGJINSAvv&format=png&color=000000" alt="Escudo <%= EquipoDAO.obtenerEquipoPorId(partidoVO.getEquipoLocal()).getNombreEquipo() %>">
			                        <span><%= partidoVO.getPtsC1Local() + partidoVO.getPtsC2Local() + partidoVO.getPtsC3Local() + partidoVO.getPtsC4Local()%></span> - 
			                        <span><%= partidoVO.getPtsC1Visit() + partidoVO.getPtsC2Visit() + partidoVO.getPtsC3Visit() + partidoVO.getPtsC4Visit()%></span>
			                    	<img src="https://img.icons8.com/?size=100&id=t7crGJINSAvv&format=png&color=000000" alt="Escudo <%= EquipoDAO.obtenerEquipoPorId(partidoVO.getEquipoVisitante()).getNombreEquipo() %>">
			                    </div>
			                </div>
			                <% }} %>
		                </div>
		            </div>		        
		            <div class="jugador-historical">
		                <h3>Hist�rico</h3>
		                <div class="jugador-stats-grid">
		                	<%
							List<PtsJugParVO> historicoJugador = PtsJugParDAO.obtenerHistoricoPorJugador(jugadorVO.getNombreUsuario());
							if (!historicoJugador.isEmpty()) {
								HistoricoVO historico = PtsJugParDAO.calcularEstadisticasHistorico(historicoJugador);
							%>
		                    <div class="jugador-stat">
		                        <p><strong>P/P</strong></p>
		                        <p><%= historico.getPuntosTotales()/historico.getPartidosJugados() %></p>
		                    </div>
		                    <div class="jugador-stat">
		                        <p><strong>MP</strong></p>
		                        <p><%= historico.getMinutosTotales()/historico.getPartidosJugados() %></p>
		                    </div>
		                    <div class="jugador-stat">
		                        <p><strong>PJ</strong></p>
		                        <p><%= historico.getPartidosJugados() %></p>
		                    </div>
		                    <div class="jugador-stat">
		                        <p><strong>TRP</strong></p>
		                        <p><%= historico.getTriplesTotales() %></p>
		                    </div>
		                    <div class="jugador-stat">
		                        <p><strong>TL</strong></p>
		                        <p><%= historico.getTirosLibresAnotados() %></p>
		                        <p><%= historico.getTirosLibresAnotados()/historico.getTirosLibresTotales()*100 %>%</p>
		                    </div>
		                    <div class="jugador-stat">
		                        <p><strong>F/P</strong></p>
		                        <p><%= historico.getFaltasTotales()/historico.getPartidosJugados() %></p>
		                    </div>
		                    <% } %>
		                </div>
		            </div>
		        </div>
			</div>
		    <div class="anuncio">
		    	<img src="<%= request.getContextPath() %>/views/images/anuncio.png" alt="Anuncio Bianco Zavani">
	    	</div>
		</div>
	</div>
	<%@ include file="footer.jsp" %>
</div>
<script>
document.addEventListener('DOMContentLoaded', () => {
    const followButtons = document.querySelectorAll('.jugador-follow-btn');

    followButtons.forEach(button => {
        button.addEventListener('click', () => {
            const favoritoId = button.getAttribute('data-id');
            const esFavorito = button.getAttribute('data-favorito') === 'true';
            const tipoFavorito = button.getAttribute('data-tipo');
            const nombreUsuario = '<%= usuario.getNombreUsuario() %>';

            fetch('<%= request.getContextPath() %>/ActualizarFavoritoServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({
                    id: favoritoId,
                    esFavorito: esFavorito,
                    tipo: tipoFavorito,
                    nombreUsuario: nombreUsuario
                })
            })
            .then(response => {
                if (!response.ok) {
                    return response.text().then(text => {
                        throw new Error(`Error en la red: ${response.status} - ${text}`);
                    });
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    // Cambia el estado visual del bot�n y el atributo data-favorito
                    button.setAttribute('data-favorito', (!esFavorito).toString());
                    button.querySelector('strong').textContent = !esFavorito ? 'Seguido' : 'Seguir';
                    button.querySelector('.fa').classList.toggle('fa-star');
                    button.querySelector('.fa').classList.toggle('fa-star-o');
                } else {
                    alert(data.message || 'No se pudo actualizar el estado del favorito.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Ocurri� un error al intentar actualizar el favorito: ' + error.message);
            });
        });
    });
});

function guardarPartido(idPartido) {
    const xhr = new XMLHttpRequest();
    xhr.open("POST", "<%= request.getContextPath() %>/GuardarPartidoServlet", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                // Redirigir a la p�gina del perfil del partido
                window.location.href = "<%= request.getContextPath() %>/views/jsp/perfil_partido.jsp";
            } else {
                alert("Error al guardar el partido.");
            }
        }
    };
    xhr.send("idPartido=" + encodeURIComponent(idPartido));
}

function verMasEquipo(idEquipo) {
    const xhr = new XMLHttpRequest();
    xhr.open("POST", "<%= request.getContextPath() %>/GuardarEquipoServlet", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                // Redirigir a la p�gina del perfil del equipo
                window.location.href = "<%= request.getContextPath() %>/views/jsp/perfil_equipo.jsp";
            } else {
                alert("Error al guardar el equipo.");
            }
        }
    };
    xhr.send("idEquipo=" + encodeURIComponent(idEquipo));
}
</script>
