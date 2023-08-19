package com.poly.dao;



import java.time.LocalDateTime;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import com.poly.entity.VerificationToken;

public interface VerificationTokenDAO extends JpaRepository<VerificationToken, Integer>{
	public VerificationToken findByToken(String token);
	
	@Transactional
	public void deleteByExpiryDateBefore(LocalDateTime now);


}
