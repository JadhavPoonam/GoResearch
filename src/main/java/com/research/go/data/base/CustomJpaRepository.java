package com.research.go.data.base;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.NoRepositoryBean;

import javax.persistence.EntityManager;
import java.io.Serializable;

@NoRepositoryBean
public interface CustomJpaRepository<T, ID extends Serializable> extends JpaRepository<T, ID> {

    @Override
    <S extends T> S save(S entity);

    <S extends T> S update(S entity);

    EntityManager getEntityManager();

    void setEntityManager(EntityManager entityManager);
}
