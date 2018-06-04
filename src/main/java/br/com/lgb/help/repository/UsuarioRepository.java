/**
 * 
 */
package br.com.lgb.help.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import br.com.lgb.help.model.Usuario;

/**
 * @author gilberto
 *
 */
public interface UsuarioRepository extends JpaRepository<Usuario, Long> {

	@Query("SELECT o FROM Usuario o WHERE o.nomeAcesso = ?1")
	Usuario findByNomeUsuario(String nomeAcesso);
	
}
