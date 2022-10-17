package com.example.availability_service.security;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import static org.springframework.security.config.http.SessionCreationPolicy.STATELESS;

@Configuration
@RequiredArgsConstructor
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable();
        http.sessionManagement().sessionCreationPolicy(STATELESS);
        //http.authorizeRequests().antMatchers(HttpMethod.GET).hasAnyAuthority("ROLE_DOCTOR","ROLE_USER","ROLE_ADMIN");
        http.authorizeRequests().antMatchers(HttpMethod.POST).hasAuthority("ROLE_DOCTOR");
        http.authorizeRequests().antMatchers(HttpMethod.DELETE).hasAuthority("ROLE_DOCTOR");
        http.authorizeRequests().antMatchers(HttpMethod.PUT).hasAuthority("ROLE_DOCTOR");
        http.addFilterBefore(new AuthorisationFilter(), UsernamePasswordAuthenticationFilter.class);
        http.headers().frameOptions().disable();
    }
}
