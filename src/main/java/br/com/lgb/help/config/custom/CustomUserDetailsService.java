package br.com.lgb.help.config.custom;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import br.com.lgb.help.model.Usuario;
import br.com.lgb.help.repository.UsuarioRepository;

@Service("userDetailsService")
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private UsuarioRepository userRepository;

	@Override
	@Transactional(readOnly = true)
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Usuario user = userRepository.findByNomeUsuario(username);

		if (user == null) {
			return new User("user", "pwd", false, true, true, true, buildUserAuthority(Arrays.asList("USER")));
		} else {
			return new User(user.getNomeAcesso(), user.getSenhaAcesso(), user.isAtivo(), true, true, true,
					buildUserAuthority(Arrays.asList("ADMIN")));
		}
	}

	private List<GrantedAuthority> buildUserAuthority(Collection<String> userRoles) {
		Set<GrantedAuthority> setAuths = new HashSet<GrantedAuthority>();

		for (String userRole : userRoles) {
			setAuths.add(new SimpleGrantedAuthority(userRole));
		}

		return new ArrayList<GrantedAuthority>(setAuths);
	}
}
