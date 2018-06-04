/**
 * 
 */
package br.com.lgb.help.config;

import java.text.SimpleDateFormat;

import org.springframework.context.i18n.LocaleContextHolder;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.ser.impl.SimpleFilterProvider;
import com.fasterxml.jackson.datatype.joda.JodaModule;

import br.com.lgb.help.model.Usuario;

/**
 * @author gilberto
 *
 */
public class AppParams {

	public enum Mapper {
		INSTANCE;
		private final ObjectMapper mapper = new ObjectMapper();

		Mapper() {
			mapper.registerModule(new JodaModule());
			mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
			mapper.setFilterProvider(new SimpleFilterProvider().setFailOnUnknownId(false));
			mapper.configure(JsonGenerator.Feature.ESCAPE_NON_ASCII, true);
			// mapper.configure(JsonParser.Feature.ALLOW_UNQUOTED_FIELD_NAMES, true);
			mapper.configure(DeserializationFeature.ADJUST_DATES_TO_CONTEXT_TIME_ZONE, false);
			mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			mapper.configure(DeserializationFeature.FAIL_ON_NULL_FOR_PRIMITIVES, false);
			mapper.enable(DeserializationFeature.USE_BIG_DECIMAL_FOR_FLOATS);
			mapper.configure(SerializationFeature.FAIL_ON_SELF_REFERENCES, false);
			mapper.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false);
		}

		public ObjectMapper getObjectMapper() {
			return mapper;
		}
	}

	public static ObjectMapper objectMapper(Usuario user) {
		ObjectMapper mapper = Mapper.INSTANCE.getObjectMapper();
		mapper.setLocale(LocaleContextHolder.getLocale());
		mapper.setTimeZone(LocaleContextHolder.getTimeZone());
		mapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm"));
		return mapper;
	}
	
}
