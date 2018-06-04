/**
 * 
 */
package br.com.lgb.help.model;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFilter;

/**
 * @author gilberto
 *
 */
@Entity
@Table(name = "tab_usuario")
@JsonFilter("usuario")
@NamedQuery(name = "Usuario.findAll", query = "SELECT u FROM Usuario u")
public class Usuario implements Serializable {

	private static final long serialVersionUID = 9165154403224174430L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "usu_id")
	private Long id;

	@Column(name = "usu_nome_acesso")
	private String nomeAcesso;

	@Column(name = "usu_senha_acesso")
	private String senhaAcesso;

	@Column(name = "usu_nome_completo")
	private String nomeCompleto;

	@Column(name = "usu_email")
	private String email;

	@Column(name = "usu_avatar")
	private String avatar;

	@Column(name = "usu_ativo")
	private boolean ativo;

	@Column(name = "usu_administrador")
	private boolean administrador;

	@ManyToMany(cascade = CascadeType.ALL)
	@JoinTable(name = "tab_usuario_regra", joinColumns = @JoinColumn(name = "usu_id"), inverseJoinColumns = @JoinColumn(name = "reg_id"))
	private Set<Regra> roles;

	/**
	 * 
	 */
	public Usuario() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @return the id
	 */
	public Long getId() {
		return id;
	}

	/**
	 * @param id
	 *            the id to set
	 */
	public void setId(Long id) {
		this.id = id;
	}

	/**
	 * @return the nomeAcesso
	 */
	public String getNomeAcesso() {
		return nomeAcesso;
	}

	/**
	 * @param nomeAcesso
	 *            the nomeAcesso to set
	 */
	public void setNomeAcesso(String nomeAcesso) {
		this.nomeAcesso = nomeAcesso;
	}

	/**
	 * @return the senhaAcesso
	 */
	public String getSenhaAcesso() {
		return senhaAcesso;
	}

	/**
	 * @param senhaAcesso
	 *            the senhaAcesso to set
	 */
	public void setSenhaAcesso(String senhaAcesso) {
		this.senhaAcesso = senhaAcesso;
	}

	/**
	 * @return the nomeCompleto
	 */
	public String getNomeCompleto() {
		return nomeCompleto;
	}

	/**
	 * @param nomeCompleto
	 *            the nomeCompleto to set
	 */
	public void setNomeCompleto(String nomeCompleto) {
		this.nomeCompleto = nomeCompleto;
	}

	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * @param email
	 *            the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * @return the avatar
	 */
	public String getAvatar() {
		return avatar;
	}

	/**
	 * @param avatar
	 *            the avatar to set
	 */
	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	/**
	 * @return the ativo
	 */
	public boolean isAtivo() {
		return ativo;
	}

	/**
	 * @param ativo
	 *            the ativo to set
	 */
	public void setAtivo(boolean ativo) {
		this.ativo = ativo;
	}

	/**
	 * @return the administrador
	 */
	public boolean isAdministrador() {
		return administrador;
	}

	/**
	 * @param administrador
	 *            the administrador to set
	 */
	public void setAdministrador(boolean administrador) {
		this.administrador = administrador;
	}

	/**
	 * @return the roles
	 */
	public Set<Regra> getRoles() {
		return roles;
	}

	/**
	 * @param roles
	 *            the roles to set
	 */
	public void setRoles(Set<Regra> roles) {
		this.roles = roles;
	}

}
