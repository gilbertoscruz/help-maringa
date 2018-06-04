/**
 * 
 */
package br.com.lgb.help.utils;

import java.sql.SQLException;
import java.util.Locale;
import java.util.TimeZone;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.support.RequestContextUtils;

import br.com.lgb.help.model.Usuario;

/**
 * @Project xfinder-people
 * @author gilberto - Gilberto Sanches Cruz
 * @date 19 de mar de 2018
 */
public class AppUtilsLocale {

	/**
	 * App Language
	 * @param user
	 * @param session
	 * @param response
	 * @param req
	 * @param curLang
	 * @return Locale
	 * @throws SQLException
	 */
	public static Locale switchUserLangAndTimeZone(Usuario user, HttpSession session, HttpServletResponse response,
			HttpServletRequest req, String curLang) throws SQLException {
		String timeZone = AppUtils.trim("");//user.getTimeZone());
		String usrLang = AppUtils.trim("");//user.getLanguage());
		
		/* retornar todas as chaves de linguas de locale corrente */
		Locale locale = (usrLang.isEmpty() && curLang.isEmpty()) ? new Locale("en") : new Locale(curLang);
		session.setAttribute("i18n", AppUtils.i18nKeys(locale));
		session.setAttribute("lg", locale.getLanguage());
		session.setAttribute("timeZone", timeZone);
		session.setAttribute("nameLang", AppUtils.flagName(locale.getLanguage()));
		/********************************************************/
		
		/* persistir lingua no usuario */
		//HubApp.getMySQL().updateLang(user.getId(), locale.getLanguage());
		//HubApp.getMySQL().updateTimeZone(user.getId(), timeZone);
		
		/********** modificar o locale no resolver do thymeleaf ******************/
		LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(req);
		localeResolver.setLocale(req, response, locale);
		response.addCookie(new Cookie("lg", locale.getLanguage()));
		
		/************************************************************************/
		LocaleContextHolder.setTimeZone(TimeZone.getTimeZone(timeZone));
		LocaleContextHolder.setLocale(locale);
		return locale;
	}

}
