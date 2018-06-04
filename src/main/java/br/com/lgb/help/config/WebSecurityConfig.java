package br.com.lgb.help.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.security.SecurityProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.security.web.authentication.RememberMeServices;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenBasedRememberMeServices;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import br.com.lgb.help.config.custom.CustomSuccessHandler;


/**
 * Class containing all security methods and beans.
 *
 */
@Configuration
@EnableWebSecurity
@Order(Ordered.HIGHEST_PRECEDENCE)
public class WebSecurityConfig {

	private static final String[] UNSECURED_RESOURCE_LIST = new String[] { 
			"/resources/**", 
			"/assets/**",
			"/cache/**", 
			"/css/**", 
			"/icons/**", 
			"/images/**", 
			"/js/**", 
			"/unauthorized", 
			"/error*", 
			"/users*",
			"/ws/**", 
			"/test/**"
	};

	@Autowired
	@Qualifier("userDetailsService")
	UserDetailsService userDetailsService;

	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		PasswordEncoder encoder = new BCryptPasswordEncoder();		
		return encoder;
	}

	@Configuration
	protected static class JdbcPersistentTokenRememberMeSetup {
		@Value("${rememberMeToken}")
		private String rememberMeToken;

		@Value("${rememberMeParameter}")
		private String rememberMeParameter;

		@Autowired
		private DataSource dataSource;

		@Bean
		public RememberMeServices getRememberMeServices() {
			JdbcUserDetailsManager jdbuserDetailsManager = new JdbcUserDetailsManager();
			jdbuserDetailsManager.setDataSource(dataSource);

			JdbcTokenRepositoryImpl jdbcTokenRepositoryImpl = new JdbcTokenRepositoryImpl();
			jdbcTokenRepositoryImpl.setDataSource(dataSource);

			PersistentTokenBasedRememberMeServices services = new PersistentTokenBasedRememberMeServices(
					rememberMeToken, jdbuserDetailsManager, jdbcTokenRepositoryImpl);
			services.setParameter(rememberMeParameter);
			return services;
		}
	}

	@Configuration
	@Order(SecurityProperties.BASIC_AUTH_ORDER - 10)
	public static class FormLoginWebSecurityConfigurerAdapter extends WebSecurityConfigurerAdapter {
		@Value("${rememberMeToken}")
		private String rememberMeToken;

		@Autowired
		RememberMeServices rememberMeServices;

		@Override
		public void configure(WebSecurity web) throws Exception {
			web.ignoring().antMatchers(UNSECURED_RESOURCE_LIST);
		}
		
		@Autowired
		CustomSuccessHandler customSuccessHandler;
		
		@Autowired
		PasswordEncoder passwordEncoder;
		
		/*@Autowired
		private DataSource dataSource;
		
		@Value("${spring.queries.users-query}")
		private String usersQuery;
		
		@Value("${spring.queries.roles-query}")
		private String rolesQuery;*/

		/*@Override
		protected void configure(AuthenticationManagerBuilder auth)
				throws Exception {
			auth.
				jdbcAuthentication()
					.usersByUsernameQuery(usersQuery)
					.authoritiesByUsernameQuery(rolesQuery)
					.dataSource(dataSource)
					.passwordEncoder(passwordEncoder);
		}*/
		
		@Override
		protected void configure(HttpSecurity http) throws Exception {
			http.headers().frameOptions().sameOrigin().httpStrictTransportSecurity().disable();
			
			http.csrf().disable();
			
			http.authorizeRequests().anyRequest().authenticated()
	        	.and().headers().cacheControl().disable()
	            .and()
	            	.formLogin()
	            		.loginPage("/login")
	            		.successHandler(customSuccessHandler)
	            		.failureUrl("/login?error")
	            		.permitAll()
	            		
	            /*.and()
	            	.rememberMe()
	            		.tokenValiditySeconds(60 * 60 * 24 * 10)
	            		.rememberMeServices(rememberMeServices)
	            		.key(rememberMeToken)*/
	            		
	            .and()
	            	.logout().
	            		logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
	            		.logoutSuccessUrl("/?logout")
	            		.invalidateHttpSession(true)
	            		.permitAll()
	            		
	            .and()
	            	.sessionManagement()
	            		.maximumSessions(100)
	            		.maxSessionsPreventsLogin(false)
	            		.sessionRegistry(sessionRegistry())
	            		.expiredUrl("/login?expired");
			
			http.exceptionHandling().accessDeniedPage("/error/403");
		}

		@Bean
		public SessionRegistry sessionRegistry() {
			SessionRegistry sessionRegistry = new SessionRegistryImpl();
			return sessionRegistry;
		}
	}
}
