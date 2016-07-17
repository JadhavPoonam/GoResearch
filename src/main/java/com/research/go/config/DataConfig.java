package com.research.go.config;

import com.research.go.data.base.CustomJpaRepositoryFactoryBean;
import org.flywaydb.core.Flyway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.EnvironmentAware;
import org.springframework.context.annotation.*;
import org.springframework.core.env.Environment;
import org.springframework.data.domain.AuditorAware;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.jdbc.datasource.lookup.JndiDataSourceLookup;
import org.springframework.orm.hibernate4.HibernateExceptionTranslator;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.sql.DataSource;
import java.util.Properties;

@Configuration
@EnableTransactionManagement
@EnableJpaRepositories(basePackages = {"com.research.go.data"}, repositoryFactoryBeanClass = CustomJpaRepositoryFactoryBean.class)
@EnableJpaAuditing(auditorAwareRef = "auditorAware")
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
public class DataConfig implements EnvironmentAware {

    private Environment environment;

    @Bean
    public AuditorAware auditorAware() {
        return new AuditorAware() {
            @Override
            public Object getCurrentAuditor() {
                return null;
            }
        };
    }

    @Override
    public void setEnvironment(final Environment environment) {
        this.environment = environment;
    }

    @Bean(initMethod = "migrate")
    Flyway flyway() {
        Flyway flyway = new Flyway();
        flyway.setBaselineOnMigrate(true);
        flyway.setLocations("classpath:/db/migration/");
        flyway.setDataSource(dataSource());
        // Clean schema and reload only in dev or local
        if (environment.getProperty("spring.profiles.active").compareToIgnoreCase("local") == 0) {
            //flyway.clean();
        }
        flyway.setSchemas(environment.getProperty("hibernate.default_schema").toUpperCase());
        return flyway;
    }

    @Bean
    public DataSource dataSource() {
        if (environment.getProperty("spring.profiles.active").compareToIgnoreCase("local") == 0 || environment.getProperty("spring.profiles.active").compareToIgnoreCase("ci") == 0 ) {
            DriverManagerDataSource dataSource = new DriverManagerDataSource();
            dataSource.setDriverClassName(environment.getProperty("jdbc.driver"));
            dataSource.setUrl(environment.getProperty("jdbc.url"));
            dataSource.setUsername(environment.getProperty("jdbc.user"));
            dataSource.setPassword(environment.getProperty("jdbc.password"));
            return dataSource;
        } else {
            JndiDataSourceLookup jndiDataSourceLookup = new JndiDataSourceLookup();
            jndiDataSourceLookup.setResourceRef(true);
            return jndiDataSourceLookup.getDataSource("jdbc/" + environment.getProperty("hibernate.default_schema"));
        }
    }

    @Bean
    @DependsOn("flyway")
    public EntityManagerFactory entityManagerFactory() {
        LocalContainerEntityManagerFactoryBean factory = new LocalContainerEntityManagerFactoryBean();
        factory.setDataSource(dataSource());
        factory.setPackagesToScan("edu.ucop.its");
        factory.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
        factory.setJpaProperties(new Properties() {
            {
                setProperty("hibernate.dialect", environment.getProperty("hibernate.dialect"));
                setProperty("hibernate.default_schema", environment.getProperty("hibernate.default_schema"));
                setProperty("hibernate.show_sql", environment.getProperty("hibernate.show_sql"));
                //setProperty("hibernate.hbm2ddl.auto", environment.getProperty("hibernate.hbm2ddl.auto"));

                setProperty("hibernate.cache.use_second_level_cache", "true");
                setProperty("hibernate.cache.use_query_cache", "true");
                setProperty("hibernate.cache.region.factory_class", "org.hibernate.cache.ehcache.EhCacheRegionFactory");

                setProperty("jadira.usertype.autoRegisterUserTypes", "true");
                setProperty("jadira.usertype.databaseZone", "America/Los_Angeles");
            }
        });

        factory.afterPropertiesSet();

        return factory.getObject();
    }

    @Bean
    public EntityManager entityManager(EntityManagerFactory entityManagerFactory) {
        return entityManagerFactory.createEntityManager();
    }

    @Bean
    public PlatformTransactionManager transactionManager() {
        JpaTransactionManager txManager = new JpaTransactionManager();
        txManager.setEntityManagerFactory(entityManagerFactory());
        return txManager;
    }

    @Bean
    public HibernateExceptionTranslator hibernateExceptionTranslator() {
        return new HibernateExceptionTranslator();
    }
}