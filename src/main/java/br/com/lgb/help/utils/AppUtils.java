/**
 * 
 */
package br.com.lgb.help.utils;

import java.util.HashMap;
import java.util.Locale;
import java.util.regex.Pattern;

import org.springframework.context.i18n.LocaleContextHolder;
import org.apache.commons.lang3.StringUtils;

import br.com.lgb.help.HelpMaringaApplication;
import br.com.lgb.help.config.custom.CustomMessageSource;

/**
 * @author gilberto
 *
 */
public class AppUtils {

	public static HashMap<String, String> i18nKeys(Locale locale) {
		HashMap<String, String> mapLang = new HashMap<>();
		new CustomMessageSource().getKeys(locale).forEach(key -> mapLang.put(key, getI18N(key)));
		return mapLang;
	}

	public static String getI18N(String msg) {
		try {
			return toUTF8(HelpMaringaApplication.getMessageSource().getMessage(msg, null, LocaleContextHolder.getLocale()));
		} catch (Exception e) {
			return msg;
		}
	}

	public static String toUTF8(String param) {
		try {
			if (!(isLatin(param) || isSpecialCharacter(param))) {
				param = new String(param.getBytes("UTF-8"), "ISO-8859-1");
			}
		} catch (java.io.UnsupportedEncodingException e) {
			return null;
		}
		return param;
	}

	public static String flagName(String lang) {
		String nameLang = "";
		if (lang.equals("en")) {
			lang = "us";
			nameLang = "US";
		} else if (lang.equals("pt")) {
			lang = "br";
			nameLang = "PT-BR";
		} else if (lang.equals("es")) {
			lang = "es";
			nameLang = "ES";
		} else {
			lang = "us";
			nameLang = "US";
		}
		return nameLang;
	}

	public static boolean isLatin(String param) {
		return param.matches("^[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ0-9 ]*$");
	}

	public static boolean isSpecialCharacter(String param) {
		return Pattern.compile("[\\\\!\"#$%&()*+,./:;<=>?@\\[\\]^_{|}~]+").matcher(param).find();
	}

	public static String trim(String value) {
		return StringUtils.trimToEmpty(value);
	}

	public static boolean isEmpty(String value) {
		return trim(value).isEmpty();
	}
}
