package br.com.lgb.help;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationListener;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.core.io.ResourceLoader;
import org.springframework.scheduling.annotation.EnableScheduling;

@ComponentScan
@Configuration
@EnableAutoConfiguration
@EnableConfigurationProperties
@SpringBootApplication
@EnableScheduling
@EnableCaching
@PropertySource(name = "help-maringa", value = "classpath:help-maringa.properties")
public class HelpMaringaApplication extends SpringBootServletInitializer
		implements ApplicationListener<ContextRefreshedEvent> {

	@Autowired
	private ApplicationContext appContext;

	@Autowired
	private MessageSource msgResource;

	@Autowired
	private ResourceLoader resource;

	private static ApplicationContext context;
	private static MessageSource i18n;
	private static ResourceLoader loader;

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(HelpMaringaApplication.class);
	}

	public static void main(String[] args) {
		SpringApplication app = new SpringApplication(HelpMaringaApplication.class);
		app.run(args);
	}

	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		// System.setProperty("user.timezone", AppParams.DEFAULT_TIMEZONE);
		System.setProperty("file.encoding", "UTF-8");

		context = appContext;
		i18n = msgResource;
		loader = resource;
	}

	public static ApplicationContext getContext() {
		return context;
	}

	public static ResourceLoader getResourceLoader() {
		return loader;
	}

	public static MessageSource getMessageSource() {
		return i18n;
	}
}