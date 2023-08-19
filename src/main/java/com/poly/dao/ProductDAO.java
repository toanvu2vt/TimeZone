package com.poly.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.poly.entity.Product;

public interface ProductDAO extends JpaRepository<Product, Integer> {
	@Query("SELECT p from Product p where p.name like ?1")
	List<Product> findByName(String name);

	@Query("SELECT p FROM Product p where category.id=?1")
	List<Product> findByCategoryID(String cid);
}
