package br.com.lgb.help.config.custom;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import br.com.lgb.help.model.Usuario;
import br.com.lgb.help.repository.UsuarioRepository;

@Component
public class CustomSuccessHandler implements AuthenticationSuccessHandler {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private UsuarioRepository repoUser;
	
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		response.setStatus(HttpServletResponse.SC_OK);

		logger.debug("onAuthenticationSuccess starting...");
		
		Usuario user = repoUser.findByNomeUsuario(authentication.getName());
		String targetUrl = "/home?lg=en";
		
		/*if (user != null && !AppUtils.isEmpty(user.getLanguage())) {
			targetUrl = "/home?lg=" + user.getLanguage();
		}*/
		
		redirectStrategy.sendRedirect(request, response, targetUrl);
	}
	
	
}
