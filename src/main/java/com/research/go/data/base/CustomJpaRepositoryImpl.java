package com.research.go.data.base;

import org.springframework.data.jpa.repository.support.SimpleJpaRepository;

import javax.persistence.EntityManager;
import java.io.Serializable;

public class CustomJpaRepositoryImpl<T, ID extends Serializable> extends SimpleJpaRepository<T, ID> implements CustomJpaRepository<T, ID> {

    private EntityManager entityManager;

    @Override
    public EntityManager getEntityManager() { return entityManager; }

    @Override
    public void setEntityManager(EntityManager entityManager) { this.entityManager = entityManager; }

    // There are two constructors to choose from, either can be used.
    public CustomJpaRepositoryImpl(Class<T> domainClass, EntityManager entityManager) {
        super(domainClass, entityManager);

        // This is the recommended method for accessing inherited class dependencies.
        this.entityManager = entityManager;
    }

    @Override
    public <S extends T> S save(S entity) {
        // Save and update should probably be handled through one method.
        entity = super.save(entity);
        //entityManager.persist(entity);  // Doing this will need update and create to be two separate methods and should be handled in the service layer based on the Entity.getId().
        return entity;
    }

    public <S extends T> S update(S entity) {
        entityManager.merge(entity);
        return entity;
    }
}

