/**
 * 
 */
package br.com.lgb.help.controller;

import java.security.Principal;
import java.util.Locale;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;

import br.com.lgb.help.model.Usuario;
import br.com.lgb.help.repository.UsuarioRepository;
import br.com.lgb.help.utils.AppUtils;

/**
 * @author gilberto
 *
 */
@Controller
@ControllerAdvice
public class LoginController {

	@Autowired
	private UsuarioRepository repoUser;
	
	@ModelAttribute("logged")
	public Usuario getUser(Principal security) {
		Usuario user = (security == null) ? null : repoUser.findByNomeUsuario(security.getName());
		
		/*if (user != null) {
			try {
				LocaleContextHolder.setTimeZone(TimeZone.getTimeZone(user.getTimeZone()));
				LocaleContextHolder.setLocale(new Locale(user.getLanguage()));
			} catch (Exception e) {
				//e.printStackTrace();
			}
		}*/
		
		return user;
	}

	@RequestMapping(value = "/login")
	public ModelAndView loginPage(HttpServletResponse response, HttpServletRequest req, HttpSession session,
			@CookieValue(value = "lg", required = false) String temp) {
		ModelAndView model = new ModelAndView("/app_login");

		try {
			String lg = StringUtils.trimAllWhitespace(temp);
			Locale locale = new Locale(lg == null ? "en" : lg);
			session.setAttribute("i18n", AppUtils.i18nKeys(locale));
			session.setAttribute("lg", locale.getLanguage());
			model.addObject("i18n", AppUtils.i18nKeys(locale));

			/********** modificar o locale no resolver do thymeleaf ******************/
			LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(req);
			localeResolver.setLocale(req, response, locale);
			response.addCookie(new Cookie("lg", locale.getLanguage()));
			/************************************************************************/
		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}
	
}
