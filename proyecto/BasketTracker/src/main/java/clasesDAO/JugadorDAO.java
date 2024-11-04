package clasesDAO;

import clasesVO.JugadorVO;
import utils.PoolConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JugadorDAO {

    public JugadorDAO() {
        // Constructor vacío
    }

    // Método para guardar un jugador
    public static void guardarJugador(JugadorVO jugador) {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = PoolConnectionManager.getConnection();

            // SQL para insertar un nuevo jugador en la base de datos
            String query = "INSERT INTO sisinf_db.jugador (nombre_usuario, nombre_jugador, equipo) VALUES (?, ?, ?)";

            ps = conn.prepareStatement(query);
            ps.setString(1, jugador.getNombreUsuario());  // Nombre de usuario
            ps.setString(2, jugador.getNombreJugador());  // Nombre del jugador
            ps.setInt(3, jugador.getEquipo());            // ID del equipo

            // Ejecutar la inserción
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            PoolConnectionManager.releaseConnection(conn);
        }
    }

    // Método para obtener un jugador por su nombre de usuario
    public static JugadorVO obtenerJugadorPorNombreUsuario(String nombreUsuario) {
        JugadorVO jugador = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = PoolConnectionManager.getConnection();
            String query = "SELECT * FROM sisinf_db.jugador WHERE nombre_usuario = ?";
            ps = conn.prepareStatement(query);
            ps.setString(1, nombreUsuario);
            rs = ps.executeQuery();

            if (rs.next()) {
                String nombreUsuarioDb = rs.getString("nombre_usuario");
                String nombreJugador = rs.getString("nombre_jugador");
                int equipo = rs.getInt("equipo");
                jugador = new JugadorVO(nombreUsuarioDb, nombreJugador, equipo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            PoolConnectionManager.releaseConnection(conn);
        }
        return jugador;
    }

    // Método para listar todos los jugadores
    public List<JugadorVO> listarJugadores() {
        List<JugadorVO> jugadores = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = PoolConnectionManager.getConnection();
            String query = "SELECT * FROM sisinf_db.jugador";
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                String nombreUsuario = rs.getString("nombre_usuario");
                String nombreJugador = rs.getString("nombre_jugador");
                int equipo = rs.getInt("equipo");
                jugadores.add(new JugadorVO(nombreUsuario, nombreJugador, equipo));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            PoolConnectionManager.releaseConnection(conn);
        }
        return jugadores;
    }

    // Método para actualizar un jugador
    public static void actualizarJugador(JugadorVO jugador) {
        Connection conn = null;
        PreparedStatement psCheck = null;
        PreparedStatement psUpdate = null;
        ResultSet rs = null;

        try {
            conn = PoolConnectionManager.getConnection();

            // Verificar si el jugador existe en la base de datos
            String checkQuery = "SELECT 1 FROM sisinf_db.jugador WHERE nombre_usuario = ?";
            psCheck = conn.prepareStatement(checkQuery);
            psCheck.setString(1, jugador.getNombreUsuario());
            rs = psCheck.executeQuery();

            if (rs.next()) {
                // Si el jugador existe, proceder con la actualización
                String updateQuery = "UPDATE sisinf_db.jugador SET nombre_jugador = ?, equipo = ? WHERE nombre_usuario = ?";
                psUpdate = conn.prepareStatement(updateQuery);
                psUpdate.setString(1, jugador.getNombreJugador());
                psUpdate.setInt(2, jugador.getEquipo());
                psUpdate.setString(3, jugador.getNombreUsuario());
                psUpdate.executeUpdate();
                System.out.println("Jugador actualizado correctamente.");
            } else {
                System.out.println("El jugador con nombre '" + jugador.getNombreUsuario() + "' no existe en la base de datos.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (psCheck != null) {
                try {
                    psCheck.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (psUpdate != null) {
                try {
                    psUpdate.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            PoolConnectionManager.releaseConnection(conn);
        }
    }

    // Método para eliminar un jugador por nombre de usuario
    public void eliminarJugador(String nombreUsuario) {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = PoolConnectionManager.getConnection();
            String query = "DELETE FROM sisinf_db.jugador WHERE nombre_usuario = ?";
            ps = conn.prepareStatement(query);
            ps.setString(1, nombreUsuario);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            PoolConnectionManager.releaseConnection(conn);
        }
    }
    
    // Método para listar todos los jugadores que juegan en una competición específica
    public static List<JugadorVO> listarJugadoresPorCompeticion(String nombreCompeticion) {
        List<JugadorVO> jugadores = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = PoolConnectionManager.getConnection();
            String query = "SELECT j.nombre_usuario, j.nombre_jugador, j.equipo " +
                           "FROM sisinf_db.JUGADOR j " +
                           "JOIN sisinf_db.EQUIPO e ON j.equipo = e.id_equipo " +
                           "WHERE e.competicion = ?";
            ps = conn.prepareStatement(query);
            ps.setString(1, nombreCompeticion);
            rs = ps.executeQuery();

            while (rs.next()) {
                String nombreUsuario = rs.getString("nombre_usuario");
                String nombreJugador = rs.getString("nombre_jugador");
                int equipoId = rs.getInt("equipo");
                jugadores.add(new JugadorVO(nombreUsuario, nombreJugador, equipoId));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            PoolConnectionManager.releaseConnection(conn);
        }
        return jugadores;
    }
    
 // Método para verificar si un jugador existe por su nombre de usuario
    public static boolean existeJugador(String nombreUsuario) {
        boolean existe = false;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = PoolConnectionManager.getConnection();
            String query = "SELECT 1 FROM sisinf_db.jugador WHERE nombre_usuario = ?";
            ps = conn.prepareStatement(query);
            ps.setString(1, nombreUsuario);
            rs = ps.executeQuery();

            // Si hay un resultado, el jugador existe
            existe = rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            PoolConnectionManager.releaseConnection(conn);
        }
        return existe;
    }

 // Método para verificar si existe un jugador por nombre y que pertenezca a un equipo con un ID dado
    public static boolean existeJugadorEnEquipo(String nombreJugador, int idEquipo) {
        boolean existe = false;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = PoolConnectionManager.getConnection();
            // Consulta SQL para verificar si existe el jugador con el nombre dado y en el equipo especificado
            String query = "SELECT 1 FROM sisinf_db.jugador WHERE nombre_jugador = ? AND equipo = ?";
            ps = conn.prepareStatement(query);
            ps.setString(1, nombreJugador);
            ps.setInt(2, idEquipo);
            rs = ps.executeQuery();

            // Si hay un resultado, el jugador existe en ese equipo
            existe = rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            PoolConnectionManager.releaseConnection(conn);
        }
        return existe;
    }
    
    public static List<JugadorVO> buscarJugadores(String searchTerm) throws SQLException {
        List<JugadorVO> jugadores = new ArrayList<>();
        String query = "SELECT * FROM sisinf_db.jugador WHERE nombre_usuario ILIKE ? OR nombre_jugador ILIKE ?";

        try (Connection conn = PoolConnectionManager.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
             
            stmt.setString(1, "%" + searchTerm + "%");
            stmt.setString(2, "%" + searchTerm + "%");

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String nombreUsuario = rs.getString("nombre_usuario");
                String nombreJugador = rs.getString("nombre_jugador");
                int equipo = rs.getInt("equipo");

                jugadores.add(new JugadorVO(nombreUsuario, nombreJugador, equipo));
            }
        }
        return jugadores;
    }

    // Método para buscar jugadores específicamente por nombre del jugador
    public static List<JugadorVO> buscarJugadoresPorNombre(String nombreJugador) {
        List<JugadorVO> jugadores = new ArrayList<>();
        String sql = "SELECT * FROM sisinf_db.jugador WHERE nombre_jugador ILIKE ?";

        try (Connection conn = PoolConnectionManager.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setString(1, "%" + nombreJugador + "%");

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String nombreUsuario = rs.getString("nombre_usuario");
                String nombreJugadorDb = rs.getString("nombre_jugador");
                int equipo = rs.getInt("equipo");

                jugadores.add(new JugadorVO(nombreUsuario, nombreJugadorDb, equipo));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return jugadores;
    }
    
}
