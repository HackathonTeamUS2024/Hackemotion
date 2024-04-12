package com.example.emotion.db_access;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ResourceRepository extends JpaRepository<Resource,Long>{
    @Query(value = "SELECT * FROM resource WHERE type = :typ ORDER BY RAND() LIMIT 15", nativeQuery = true)
    List<Resource> findRandomResource(@Param("typ") String type);


}
