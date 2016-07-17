package edu.ucop.its.radsafety.config;

import edu.ucop.erms.its.security.hmac.service.AuthenticationSecurityEntryPoint;
import edu.ucop.erms.its.security.hmac.service.AuthenticationSecurityFilter;
import edu.ucop.erms.its.security.hmac.service.AuthenticationSecurityProvider;
import edu.ucop.erms.its.security.hmac.service.provider.UserService;
import edu.ucop.its.authentication.security.ShibEntryPoint;
import edu.ucop.its.authentication.security.ShibNoOpAuthenticationManager;
import edu.ucop.its.authentication.security.ShibTokenAuthenticationFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.cache.ehcache.EhCacheCacheManager;
import org.springframework.cache.ehcache.EhCacheManagerFactoryBean;
import org.springframework.context.annotation.*;
import org.springframework.core.annotation.Order;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
@PropertySources(
        value = {@PropertySource(
                    value = "classpath:/radsafety.${spring.profiles.active}.properties",
                    ignoreResourceNotFound = true
        ),
                @PropertySource(
                        value = "classpath:/radsafety.omni.properties",
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
            web.ignoring().antMatchers(HttpMethod.GET, "/", "/resources/**", "/healthMonitor**", "/devtool/**", "/api/waste/tag/**", "/api/pdf/**");
            web.ignoring().antMatchers("/h2/**", "/signoff");
        }
	}

    @Configuration
	@ComponentScan(basePackages = {"edu.ucop.its.radsafety", "edu.ucop.erms.its.security.hmac"}, excludeFilters = @ComponentScan.Filter(value = Configuration.class, type = FilterType.ANNOTATION))
    @Qualifier(value="api")
	@Order(1)
	public static class ApiSecurityConfigurationAdapter extends WebSecurityConfigurerAdapter {

    	@Autowired
	    private AuthenticationSecurityEntryPoint authenticationEntryPoint;

    	@Autowired
        private AuthenticationSecurityProvider authProvider;

    	@Autowired
    	private UserService userService;

		@Override
		@Order(1)
        protected void configure(AuthenticationManagerBuilder auth) throws Exception {
			authProvider.setService(userService);
            auth.authenticationProvider(authProvider);
        }

    	@Override
		protected void configure(HttpSecurity http) throws Exception {
    		http.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS).and()
            .exceptionHandling().authenticationEntryPoint(authenticationEntryPoint).and()
            .csrf().disable()
            .antMatcher("/public/api/**")
            .authorizeRequests()
            .anyRequest().authenticated();

            http
            .addFilterBefore(apiAuthenticationFilter(), BasicAuthenticationFilter.class).httpBasic();

		}

    	@Override
        public void configure(WebSecurity web) throws Exception {
            web.ignoring().antMatchers("/resources/**", "/healthMonitor**", "/devtool/**", "/api/attachment/**", "/api/waste/tag/**", "/api/pdf/**");
            web.ignoring().antMatchers("/h2/**", "/signoff");
        }

	    @Bean
	    public AuthenticationSecurityFilter apiAuthenticationFilter() throws Exception {
	    	AuthenticationSecurityFilter filter = new AuthenticationSecurityFilter("/public/api/**");
	    	filter.setAuthenticationManager(authenticationManager());
	    	filter.setRequiresAuthenticationRequestMatcher(new AntPathRequestMatcher("/public/api/**"));
	        return filter;
	    }
	}

	@Configuration
	@Qualifier(value="shib")
	@Order(2)
	public static class ShibAuthWebSecurityConfigurerAdapter extends WebSecurityConfigurerAdapter {

		@Override
		protected void configure(HttpSecurity http) throws Exception {
			http.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS).and()
            .exceptionHandling().authenticationEntryPoint(entryPoint()).and()
            .csrf().disable()
            .authorizeRequests()
            .anyRequest().authenticated()
            .and()
            .addFilterBefore(shibTokenAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class);
		}

		@Bean
	    @Override
	    public AuthenticationManager authenticationManagerBean() throws Exception {
	        return new ShibNoOpAuthenticationManager();
	    }

	    @Bean
	    public ShibTokenAuthenticationFilter shibTokenAuthenticationFilter() throws Exception {
	        ShibTokenAuthenticationFilter filter = new ShibTokenAuthenticationFilter("/**");
	        filter.setAuthenticationManager(authenticationManager());
	        return filter;
	    }

	    @Bean
	    public ShibEntryPoint entryPoint() {
	        return new ShibEntryPoint();
	    }

	    @Bean
	    public EhCacheCacheManager ehCacheCacheManager() {
	        return new EhCacheCacheManager(ehCacheManagerFactoryBean().getObject());
	    }

	    @Bean
	    public EhCacheManagerFactoryBean ehCacheManagerFactoryBean() {
	        EhCacheManagerFactoryBean cacheManagerFactoryBean = new EhCacheManagerFactoryBean();
	        cacheManagerFactoryBean.setConfigLocation(new ClassPathResource("cache.xml"));
	        cacheManagerFactoryBean.setShared(true);

	        return cacheManagerFactoryBean;
	    }
	}
}