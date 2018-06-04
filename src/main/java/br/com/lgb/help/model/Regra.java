/**
 * 
 */
package br.com.lgb.help.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFilter;

/**
 * @author gilberto
 *
 */
@Entity
@Table(name = "tab_regra")
@JsonFilter("regra")
@NamedQuery(name = "Regra.findAll", query = "SELECT u FROM Regra u")
public class Regra {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "reg_id")
	private Long id;

	@Column(name = "reg_regra")
	private String regra;

	/**
	 * 
	 */
	public Regra() {
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
	 * @return the regra
	 */
	public String getRegra() {
		return regra;
	}

	/**
	 * @param regra
	 *            the regra to set
	 */
	public void setRegra(String regra) {
		this.regra = regra;
	}

}
