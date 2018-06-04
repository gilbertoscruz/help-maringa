package br.com.lgb.help.config.custom;

import java.util.Locale;
import java.util.ResourceBundle;
import java.util.Set;

import org.springframework.context.support.ResourceBundleMessageSource;

public class CustomMessageSource extends ResourceBundleMessageSource {
	
	public Set<String> getKeys(Locale locale) {
		ResourceBundle bundle = getResourceBundle("i18n/messages", locale);
		return bundle.keySet();
	}
}
