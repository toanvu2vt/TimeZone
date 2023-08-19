package com.poly.config;

import java.util.NoSuchElementException;
import java.util.stream.Collectors;

import javax.validation.Validator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;

import com.poly.entity.Account;
import com.poly.service.AccountService;

@SuppressWarnings("deprecation")
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{

	@Autowired
	AccountService accountService;
	
	@Autowired
	BCryptPasswordEncoder pe;
	@Bean
    public Validator validator() {
        return new LocalValidatorFactoryBean();
    }
	
	@Bean
	public BCryptPasswordEncoder getPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	@Bean
	public PasswordEncoder passwordEncoder() {
	      return new BCryptPasswordEncoder();
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(username ->{
			try {
				Account user = accountService.findById(username);
				String password = user.getPassword();
				String[] roles = user.getAuthorities().stream()
						.map(er -> er.getRole().getId())
						.collect(Collectors.toList()).toArray(new String[0]);
				return User.withUsername(username).password(password).roles(roles).build();
			} catch (NoSuchElementException e) {
				throw new UsernameNotFoundException(username + "NOT FOUND");
			}
		}).passwordEncoder(passwordEncoder());
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.csrf().disable();
		http.authorizeRequests()
		.antMatchers("/home/checkout/**").authenticated()
		.antMatchers("/home/account/**").authenticated()
		.antMatchers("/home/cart/**").authenticated()
		.antMatchers("/rest/account/**").authenticated()
		.antMatchers("/admin/index").hasAnyRole("STA","DIR")
		.antMatchers("/admin/statistical").hasAnyRole("STA","DIR")
		.antMatchers("/admin/orders").hasAnyRole("STA","DIR")
		.antMatchers("/admin/staff").hasRole("DIR")
		.antMatchers("/rest/authorities").hasRole("DIR")
		.anyRequest().permitAll();
		
		http.formLogin()
		.loginPage("/security/login/form")
		.loginProcessingUrl("/security/login")
		.defaultSuccessUrl("/security/login/success",false)
		.failureUrl("/security/login/error");
		
		http.rememberMe().tokenValiditySeconds(86400);
		
		http.exceptionHandling().accessDeniedPage("/security/login/unauthoried");
		
		http.logout().logoutUrl("/security/logoff").logoutSuccessUrl("/security/logoff/success");
		
	}

	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers(HttpMethod.OPTIONS,"/**");
	}
	
	
	
}
