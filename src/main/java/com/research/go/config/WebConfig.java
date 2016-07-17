package edu.ucop.its.radsafety.config;

import org.springframework.context.annotation.*;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.ui.velocity.VelocityEngineFactoryBean;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.request.RequestContextListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;
import javax.servlet.annotation.WebListener;

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = {"edu.ucop.its.radsafety", "edu.ucop.its.authentication", "edu.ucop.erms.its.security.hmac"}, excludeFilters = @ComponentScan.Filter(value = Configuration.class, type = FilterType.ANNOTATION))
@WebListener
@PropertySources(
        value = {  @PropertySource(
                    value = "classpath:/radsafety.${spring.profiles.active}.properties",
                    ignoreResourceNotFound = true
        ),
                @PropertySource(
                        value = "classpath:/radsafety.omni.properties",
                        ignoreResourceNotFound = true
                )
        }
)
public class WebConfig extends WebMvcConfigurerAdapter implements WebApplicationInitializer {

    private static final Integer MaxUploadSize = 10 * 1024 * 1024; // 10 MB

    @Bean
    public static PropertySourcesPlaceholderConfigurer propertySourcesPlaceholderConfigurer() {
        // need to to wire up @value
        return new PropertySourcesPlaceholderConfigurer();
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resources/**").addResourceLocations("/resources/").setCachePeriod(0);
    }

    @Bean
    public InternalResourceViewResolver viewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/views/");
        resolver.setSuffix(".jsp");
        return resolver;
    }

    @Bean
    public MultipartResolver multipartResolver() {
        CommonsMultipartResolver resolver = new CommonsMultipartResolver();
        resolver.setMaxUploadSize(MaxUploadSize);
        return resolver;
    }

    @Bean
    public VelocityEngineFactoryBean velocityEngine(){
        VelocityEngineFactoryBean engineFactoryBean = new VelocityEngineFactoryBean();
        engineFactoryBean.setResourceLoaderPath("classpath:template/");
        return engineFactoryBean;
    }

    @Override
    public void onStartup(ServletContext container) throws ServletException {
        container.addListener(RequestContextListener.class);

        AnnotationConfigWebApplicationContext rootContext = new AnnotationConfigWebApplicationContext();
        String profile = rootContext.getEnvironment().getActiveProfiles()[0];

        if (profile.compareToIgnoreCase("local") == 0 || profile.compareToIgnoreCase("ci") == 0 || profile.compareToIgnoreCase("dev") == 0) {
            ServletRegistration.Dynamic h2Servlet = container.addServlet("h2console", new org.h2.server.web.WebServlet());
            h2Servlet.setInitParameter("webAllowOthers", "true");
            h2Servlet.setLoadOnStartup(1);
            h2Servlet.addMapping("/h2/*");
        }
    }

    /**
     * These two methods prevent truncation of URL path variables if they have a '.' character.
     */
    @Override
    public void configureContentNegotiation(ContentNegotiationConfigurer configurer) {
        configurer.favorPathExtension(false);
    }
    @Override
    public void configurePathMatch(PathMatchConfigurer configurer) {
        configurer.setUseSuffixPatternMatch(false);
    }
}
