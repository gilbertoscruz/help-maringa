/**
 * 
 */
package br.com.lgb.help.controller;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.com.lgb.help.model.Usuario;
import br.com.lgb.help.repository.UsuarioRepository;
import br.com.lgb.help.utils.AppUtils;
import br.com.lgb.help.utils.AppUtilsLocale;

/**
 * @Project xfinder-people
 * @author gilberto - Gilberto Sanches Cruz
 * @date 16 de mar de 2018
 */

@Controller
@ControllerAdvice
public class HomeController {

	@Autowired
	UsuarioRepository repoUsuario;
	
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public ModelAndView homePage(HttpServletRequest req, @RequestParam String lg, @ModelAttribute("logged") Usuario user,
			HttpSession session, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("/home/app_home");

		try {
			//Long companyId = user.getCompanyId();
			
			/************************************************************************/
			Locale locale = AppUtilsLocale.switchUserLangAndTimeZone(user, session, response, req, lg);
			session.setAttribute("nameLang", AppUtils.flagName(locale.getLanguage()));
			session.setAttribute("i18n", AppUtils.i18nKeys(locale));
			session.setAttribute("lg", lg);
			/************************************************************************/
			
			//Optional<Company> company = repoCompany.findById(companyId);
			session.setAttribute("usuario", user);
			//session.setAttribute("companyGenEmail", company.get().getGenEmail());
			
			model.addObject("usuario", user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return model;
	}

}
