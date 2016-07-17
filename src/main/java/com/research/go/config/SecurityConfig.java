package com.research.go.config;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.*;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
@PropertySources(
        value = {@PropertySource(
                    value = "classpath:/goresearch.${spring.profiles.active}.properties",
                    ignoreResourceNotFound = true
        ),
                @PropertySource(
                        value = "classpath:/goresearch.omni.properties",
                        ignoreResourceNotFound = true
                )
        }
)
public class SecurityConfig {

    @Configuration
    @Qualifier(value="web")
	public static class WebSecurityConfigurationAdapter extends WebSecurityConfigurerAdapter {
    	@Override
        public void configure(WebSecurity web) throws Exception {
            web.ignoring().antMatchers(HttpMethod.GET, "/", "/resources/**", "/research-area/**");
            web.ignoring().antMatchers("/h2/**", "/signoff");
        }
	}

    @Configuration
	@ComponentScan(basePackages = {"com.research.go"}, excludeFilters = @ComponentScan.Filter(value = Configuration.class, type = FilterType.ANNOTATION))
    @Qualifier(value="api")
	@Order(1)
	public static class ApiSecurityConfigurationAdapter extends WebSecurityConfigurerAdapter {


        @Bean
        @Override
        public AuthenticationManager authenticationManagerBean() throws Exception {
            return new AuthenticationManager() {
                @Override
                public Authentication authenticate(Authentication authentication) throws AuthenticationException {
                    return null;
                }
            };
        }

    	@Override
        public void configure(WebSecurity web) throws Exception {
            web.ignoring().antMatchers(HttpMethod.GET, "/", "/resources/**", "/research-area/**");
            web.ignoring().antMatchers("/h2/**", "/signoff");
        }


	}


}